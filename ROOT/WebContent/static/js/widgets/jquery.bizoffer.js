(function($){
	$.bizoffer = function(){};
	
})(jQuery);

(function($, $bizoffer){
	var itemStr='<div class="row iteminfo" id="irow"><div class="offerCell" id="iname"></div><div class="offerCell" id="iprice"></div>' +
	'<div class="offerCell" id="iqty"></div></div>';

	$bizoffer.initMyOffers = function(){
		$('#activeOffers').bind('click', function(){
			$.log('load active offers');
			$(this).addClass('active').removeClass('nonactive');
			$('#closedOffers').addClass('nonactive');
			getOffers(7);
		});
		$('#closedOffers').bind('click', function(){
			$.log('load closed offers');
			$('#activeOffers').addClass('nonactive');
			$(this).addClass('active').removeClass('nonactive');
			getOffers(36);
		});
		renderBizOffers();
	};
	
	getOffers = function(o){
		offrs = [];
		ordrs = [];
		var getOffers = $.payload.newOper(o);
		var args = [];
		args.push(getOffers);
		$.ajaxCall(args, 'html', function(r){
			$('#offersCtn').empty().append(r);
			renderBizOffers();
			setTimeout(function(){
				twttr.widgets.load();
				loadMap();
				FB.XFBML.parse();
			}, 500);		
		});
	};
	
	$bizoffer.getCustomerDetails = function(details){
		var ret = {id:details.id, phone: details.phone == undefined ? " " : details.phone,
				   name: details.name == undefined ? " " : details.name,
				   address: details.address == undefined ? " " : details.address}; // may be det doesn't have all the fields
		return ret;
	};
	
	getOrders = function(ofr){
		var orders = {pnd:[], cmpl:[]};
		$.each(ordrs, function(ind){
			if(this.oid == ofr.id){
				$.each(this.orders, function(i){
					if(this.nodes.status == 0 || this.nodes.status == 3)
						orders.pnd.push(getOrdr(this));
					else if(this.nodes.status == 4)
						orders.cmpl.push(getOrdr(this));
					
				});
			}
		});
		return orders;
	};

	getOrdr = function(or){
		return {id:or.nodes.id, items:$.order.getItems(or.nodes.items),
				customer:$.bizoffer.getCustomerDetails(or.nodes.user_details),
				status:or.nodes.status, date:or.nodes.dt};
	};

	
	renderBizOffers = function() {
		$.log('renderBizOffers');
		if(offrs.length == Number(0)){
			$('#offersCtn').html('<div>No Offers</div');
			return;
		}
		$.each(offrs, function(ind){
			this.discounts = $.offer.getDiscounts(1, this.discounts, this.total);
			var offer = this;
			var orders = getOrders(offer);
			var bttns = [
				         {id:'editOffer',text:'Edit Offer', click:function(){ window.location = '/edit-offer?oid=' + offer.id;}},
				         {id:'cancelOffer',text:'Cancel Offer', click:function(){cancelOffer(offer.id);}},
				         {id:'statusButton', text:(offer.status == 1)?'Unpublish':'Publish',click:function(){
				        	if(offer.status == 1){
				        		updateOfferStatus(offer.id, 31, function(resp){
										$.log('unpublish response');
										setPublishButton({offerId:offer.id});
								});					        		
				        	}else{
				        		updateOfferStatus(offer.id, 30, function(resp){	 							   	
										$.log('publish response');
										setUnPublishButton({offerId:offer.id});
							   });					        		
				        	}
				       }}
				]; 
			$('#oid_'+ this.id).upmileOffer({
				offer:this,
				buttons:bttns,
				type:'myoffer'
             });	
			$('#oid_' + offer.id).find('#pndOrds').bind('click', function(){
				$.log('show pending orders');				
				$('#oid_' + offer.id).find('#pndOrds').css('color', '#3B5278');
				$('#oid_' + offer.id).find('#cmplOrds').css('color', '#71A5B5');
				displayPndOrders({offer:offer, orders:orders});
			});
			$('#oid_' + offer.id).find('#cmplOrds').bind('click', function(){
				$.log('show complete orders');
				$('#oid_' + offer.id).find('#pndOrds').css('color', '#71A5B5');
				$('#oid_' + offer.id).find('#cmplOrds').css('color', '#3B5278');

				displayCmplOrders({offer:offer, orders:orders});
			});
			$('#oid_' + offer.id).find('#pndOrds').css('color', '#3B5278');
			$('#oid_' + offer.id).find('#cmplOrds').css('color', '#71A5B5');
			$('#oid_' + offer.id).append('<br>');
			displayPndOrders({offer:offer, orders:orders});
			
		});
		setTimeout(function() {
			loadMap();
		}, 400);

	};

	displayPndOrders = function(p){
		removeOfferOrders(p);
		if(p.orders.pnd.length == Number(0)){
			$('#oid_' + p.offer.id).find('#orderRow').before('<div id="orderRow0" class="row" style="display: table-row;">' +
			        '<div class="cell">No Pending Orders</div></div>');
			return;
		}
		$.each(p.orders.pnd, function(){
			var order = this, total = 0;
			var row = $('#oid_' + p.offer.id).find('#orderRow').clone();  
			row.attr('id','orderRow' + order.id).css('display','table-row').find('#custName').text(order.customer.name+'  '+order.customer.phone+'  '+order.customer.address);
			row.attr('id','orderRow' + order.id).css('display','table-row').find('#orderDate').text(Date.parse($.formatDateForDateLib(order.date)).toString("MM/dd HH:mm, yyyy"));
			row.attr('id','orderRow' + order.id).find('#controlOrderCell').append( '<button id="completeOrder">Complete Order</button><button id="cancelOrder">Cancel Order</button>');
			$('#oid_' + p.offer.id).find('#orderRow').before(row).before('<br id="br' + order.id + '">');
			row.find('#cancelOrder').bind('click', function(){
				cancelOrder({ofId:p.offer.id, order:order});
			});
			row.find('#completeOrder').bind('click', function(){
				completeOrder({offer:p.offer, order:order});
			});
			$.each(order.items, function(i){
				row.find('#offerCustFooter').before(itemStr);	
				var orderedId = this.id;
				var item = $.grep( p.offer.items, function(itm,iind){
					return itm.id == orderedId;
				})[0];
				if(item){
					$('#irow').attr('id', orderedId)
						.find('#iname').text(item.name).end()
						.find('#iprice').text('$'+new Number(item.price).toFixed(2)+' / '+item.unit).end()
						.find('#iqty').text(this.qty+' '+item.unit+'(s)');
						total += item.price*this.qty;
				}
			});
			var disc = $.offer.getDiscount(p.offer);
			$('#oid_' + p.offer.id).find('#custDiscount').text(disc).end()///???????
                                     .find('#custTotal').text(new Number(total*(100 - disc)/100).toFixed(2));
		});
	};

	
	removeOfferOrders = function(p){
		var offerDiv = $('#oid_' + p.offer.id);
		offerDiv.find('#orderRow0').remove();
		//if(noOrders != undefined)
		//	noOrders.remove();
		$.each(p.orders.cmpl, function(){
			var row = offerDiv.find("#orderRow" + this.id);
			if(row != undefined){
				row.remove();
				offerDiv.find('#br' + this.id).remove();
			}
		});
		$.each(p.orders.pnd, function(){
			var row = offerDiv.find("#orderRow" + this.id);
			if(row != undefined){
				offerDiv.find('#br' + this.id).remove();
				row.remove();
			}
		});
	};
	
	displayCmplOrders = function(p){
		removeOfferOrders(p);
		if(p.orders.cmpl.length == Number(0)){
			$('#oid_' + p.offer.id).find('#orderRow').before('<div id="orderRow0" class="row" style="display: table-row;">' +
	        '<div class="cell">No Completed Orders</div></div>');
			return;
		}
		$.each(p.orders.cmpl, function(){
			var order = this, total = 0;
			var row = $('#oid_' + p.offer.id).find('#orderRow').clone();  
			row.attr('id','orderRow' + order.id).css('display','table-row').find('#custName').text(order.customer.name+'  '+order.customer.phone+'  '+order.customer.address);
			row.attr('id','orderRow' + order.id).css('display','table-row').find('#orderDate').text(Date.parse($.formatDateForDateLib(order.date)).toString("MM/dd HH:mm, yyyy"));
			$('#oid_' + p.offer.id).find('#orderRow').before(row).before('<br id="br' + order.id + '">');
			$.each(order.items, function(i){
				row.find('#offerCustFooter').before(itemStr);	
				var orderedId = this.id;
				var item=$.grep( p.offer.items, function(itm,iind){
					return itm.id == orderedId;
				})[0];
				if(item){
					$('#irow').attr('id', orderedId)
						.find('#iname').text(item.name).end()
						.find('#iprice').text('$'+new Number(item.price).toFixed(2)+' / '+item.unit).end()
						.find('#iqty').text(this.qty+' '+item.unit+'(s)');
						total+=item.price*this.qty;
				}
			});
			var disc = $.offer.getDiscount(p.offer);
			$('#oid_' + p.offer.id).find('#custDiscount').text(disc).end()///???????
                                     .find('#custTotal').text(new Number(total*(100 - disc)/100).toFixed(2));
		});
	};
		
	
	
	completeOrder = function(params){
		args = [];
		var newOp = $.payload.newOper(35);
		newOp.addFields({closed_discount:$.offer.getDiscount(params.offer)});
		newOp.addParams({id:{value:params.order.id}});
		args.push(newOp);
		$.ajaxCall(args, function(res){
			setTimeout(function(){
				$.log('complete order response');
				getOffers(7);
			}, 100);
		});			
	};
	
	cancelOffer = function(oid){
		$('body').append('<div id="dialog" title="Dialog Title">Are you sure to cancel this offer?</div>');
		$('#dialog').dialog({
			resizable: false,
			height:140,
			modal: true,
			title: "Offer Cancellation",
			buttons: {
			        	  "Cancel Offer": function() {
			        		  var args = [];
			        		  $.log("offer id: " + oid);
		        			  var op = $.payload.newOper(29);
		        			  op.addParams({oid:oid});
		        			  args.push(op);
		        			  $.ajaxCall(args, function(res){
		        				  setTimeout(function(){
		        					  $.log('cancel offer response');
		        					  $('#dialog').dialog("close");
		        					  getOffers(7);
		        				  }, 100);
		        			  });			
			        	  },
			        	  Close: function() {
			        		  $(this).dialog( "close" ); 
			        	  }
			}			
		});
		
	};
	
	
	cancelOrder = function(params){
		$.log('order id: ' + params.order.id);
		$('body').append('<div id="dialog" title="Dialog Title">Are you sure to cancel this order?</div>');
		$('#dialog').dialog({
			resizable: false,
			height:140,
			modal: true,
			title: "Order Cancellation",
			buttons: {
			        	  "Cancel Order": function() {
			        		  	var offerId = params.ofId; 
			        		  	var itms = '';
								$.each(params.order.items, function(){
									if(itms.length > 0)
										itms += ',';
									itms += this.id + '|' + this.qty;
								});
								var args = [];
								var orderOp = $.payload.newOper(33);
								orderOp.addParams({oid:offerId},{ordr:itms},{ordrid:params.order.id});
								args.push(orderOp);
								$.ajaxCall(args, function(r){
									setTimeout(function(){
										$('#dialog').remove();
										getOffers(7);
									}, 100);	
								});			
			        	  },
			        	  Close: function() {
			        		  $(this).dialog( "close" ); 
			        	  }
			}			
		});
		
	};
	
	setPublishButton = function(params){
		var oid = params.offerId;
		$('#oid_' + oid).find('#statusButton').html('Publish')
								.unbind()
		 					   	.bind('click', function(){ updateOfferStatus(params.offerId, 30, function(resp){	 							   	
		 							   												$.log('publish response');
		 							   												setUnPublishButton({offerId:oid});
		 					   											   });
		 					   										});
	};

	setUnPublishButton = function(params){
		var oid = params.offerId;
		$('#oid_' + oid).find('#statusButton').html('Unpublish')
								.unbind()
			 					.bind('click', function(){ updateOfferStatus(params.offerId, 31, function(resp){
			 																		$.log('unpublish response');
			 																		setPublishButton({offerId:oid});
			 																});
			 														});
	};

	initStatusButton = function(params){
		$('#oid_' + offer.oid).find('#statusButton').html(params.buttonTxt)
		                                .bind('click', function(){
		                                				var offerId = $(this).parents('.offerid').attr('id').substring(4);
		                                				updateOfferStatus(offerId, params.operId, params.respHandler);
		                                });
	};
		
	updateOfferStatus = function(offerId, operId, respHandler) {
			var args = [];
			var oper = $.payload.newOper(operId);
			oper.addParams({id:{value:offerId}});
			args.push(oper);
			$.ajaxCall(args, respHandler);
	};
		
	
}) (jQuery, $.bizoffer);