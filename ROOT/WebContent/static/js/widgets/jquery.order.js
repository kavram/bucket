(function($){
	$.order = function(){};
	
})(jQuery);

(function($, $order){
	$order.initMyOrders = function(){
		$('#pendingOrders').bind('click', function(){
			$.log('load pending orders');
			$('#pendingOrders').css('color', '#3B5278');
			$('#completedOrders').css('color', '#71A5B5');
			getOrders(6);
		});
		$('#completedOrders').bind('click', function(){
			$.log('load completed orders');
			$('#pendingOrders').css('color', '#71A5B5');
			$('#completedOrders').css('color', '#3B5278');
			getOrders(37);
		});
		$('#pendingOrders').css('color', '#3B5278');
		$('#completedOrders').css('color', '#71A5B5');
		renderOrders(true);
	};

	getOrders = function(o){
		var getOrders = $.payload.newOper(o);
		var args = [];
		args.push(getOrders);
		$.ajaxCall(args, 'html', function(r){
			$.log( r);
			ordrs = [];
			offrs = [];
			$('#offersCtn').empty().append(r);
			if(o == 6)
				renderOrders(true);
			else
				renderOrders(false);
			setTimeout(function(){
				twttr.widgets.load();
				loadMap();
				FB.XFBML.parse();
			}, 500);			
		});
	};
	
	$order.getItems = function(items){
		var ret = [];
		var splItems = items.split('^');
		for(var i = 0; i < splItems.length; i++){
			var splt = splItems[i].split('|');
			if(splt.length==2){
				var item = {"id":splt[0].replace(/0*/, ''),"qty":splt[1].replace(/0*/, '')};
				if(item.qty.length == 0)
					item.qty = '0';
				ret.push(item);
			}
			
		}
		return ret;
	};
	
	initOrdrItems = function(){
		for(var i = 0; i < ordrs.length; i++){
			ordrs[i].items = $order.getItems(ordrs[i].items);
		}
	};
	
	getOrdr = function(offerId){
		for(var i = 0; i < ordrs.length; i++){
			if(ordrs[i].oid == offerId)
				return ordrs[i];
		}
		return null;
	};
	
	renderOrders = function(pend){
		if(!window.offrs || window.offrs.length == 0){
			$('#offersCtn').html('You have no orders.');
			return;
		}
		initOrdrItems();
		var bttn = [{id:'cancelOrder',disabled:'false', click:cancelOrder}];
		if(pend)
			bttn.push({id:'updateOrder',disabled:'false', click:updateOrder});
		$.each(offrs, function(ind){
			this.discounts = $.offer.getDiscounts(1, this.discounts, this.total);
			$('#oid_'+ this.id).upmileOffer({
				offer:this,
				type:'myorder',
				buttons:bttn,
				orderedItems: getOrdr(this.id).items
             });	
		
		});
		setTimeout(function(){
			loadMap();
		},400);
	};

	getOldQty = function(offerId, itemId){
		for(var i = 0; i < ordrs.length; i++){
			var ordr = ordrs[i];
			if(Number(ordr.oid) == Number(offerId)){
				for(var j = 0; j < ordr.items.length; j++){
					if(Number(ordr.items[j].id) == Number(itemId))
						return ordr.items[j].qty;
				}
			}
		}
	};
	
	cancelOrder = function(e){
		 var odiv = $(this).parents('.offerid');
		 cancelOrderDlg(odiv);
	};
	
	cancelOrderDlg = function(offerDiv) {
		var oid = $(offerDiv).attr('id').substring(4);
		$(offerDiv).append('<div id="dialog" title="Dialog Title">Confirm to cancel your order</div>');
		$('#dialog').dialog({
			resizable: false,
			height:140,
			modal: true,
			title: "Confirm to cancel your order",
			buttons: {
			        	  "Cancel Order": function() {
			        		  var offerId = oid;
			        		  var args = [];
			        		  var itms = '';
			        		  $.log("offer id: " + offerId);
			        		  $.each($(offerDiv).find('.iteminfo'), function(j){
			        			  $.log('item id: ' + $(this).attr('id'));
			        			  if(getOldQty(offerId, $(this).attr('id')) > 0){
			        				  if(itms.length > 0)
			        					  itms += ',';
			        				  itms += $(this).attr('id') + '|' + getOldQty(offerId, $(this).attr('id'));
			        			  }
			        		  });
			        		  var newOp = $.payload.newOper(22);
			        		  newOp.addParams({oid:offerId},{ordr:itms},{ordrid:getOrdr(oid).id});
			        		  args.push(newOp);
		        			  $.ajaxCall(args, function(res){
		        				  setTimeout(function(){
		        					  $.log('cancel order response');
		        					  $('#dialog').remove();
		        					  getOrders(6);
		        				  }, 100);
		        			  });			
			        	  },
			        	  Close: function() {
			        		  $(this).dialog("close"); 
			        	  }
			}			
		});
	};

	deleteOrderDlg = function(orderId) {
		$('body').append('<div id="dialog" title="Dialog Title">Confirm to delete this order</div>');
		$('#dialog').dialog({
			resizable: false,
			height:140,
			modal: true,
			title: "Confirm to delete this order",
			buttons: {
			        	  "Delete Order": function() {
			        		  var args = [];
		        			  var op = $.payload.newOper(38);
		        			  op.addParams({id:{value:orderId}});
		        			  args.push(op);
		        			  $.ajaxCall(args, function(res){
		        				  setTimeout(function(){
		        					  $.log('delete order response');
			        				  $('#dialog').remove();
		        					  getOrders(37);
		        				  }, 100);
		        			  });			
			        	  },
			        	  Close: function() {
			        		  $(this).dialog( "close" ); 
			        	  }
			}			
		});
	};
	
	
	updateOrder = function(){
		$.log('test submit');
		var offerId = $(this).parents('.offerid').attr('id').substring(4);
		var itms = '';
		$.log('offer id: ' + offerId);
		$.each($(this).parents('#itemsTbl').find('.iteminfo'), function(j){
			$.log('item id: ' + $(this).attr('id'));
			$.log('item value: ' + $(this).find('#qty').val());
			if($(this).find('#qty').val().trim().length>0 || getOldQty(offerId, $(this).attr('id')) > 0){
				if(itms.length > 0)
					itms += ',';
				var oqty = getOldQty(offerId, $(this).attr('id')) == undefined ? 0 : getOldQty(offerId, $(this).attr('id'));
				var nqty = $(this).find('#qty').val().trim().length == 0? 0 : $(this).find('#qty').val();
				itms += $(this).attr('id') + '|' + oqty + '|' +	nqty;
			}
		});
		var args = [];
		var newOp = $.payload.newOper(21);
		newOp.addParams({oid:offerId},{ordr:itms});
		args.push(newOp);
		$.ajaxCall(args, function(res){
			$('body').append('<div id="dialog" title="Order Update">Your Order has been updated.</div>');
			$('#dialog').dialog({
				resizable: false,
				height:140,
				modal: true,
				title: "Order Update",
				buttons: {
					"OK": function() {
				 		$('#dialog').dialog("close");
				 		getOrders(6);
					},
					Close: function() {
						$('#dialog').dialog("close");
						getOrders(6);
					}
				}			
			});
		});			
	};
	
	
}) (jQuery, $.order);