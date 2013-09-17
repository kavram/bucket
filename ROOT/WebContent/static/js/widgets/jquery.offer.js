
(function($){
	$.offer = function(){};

	$.offer.padValue = function(val){
		var res = "";
		var pads = ["000000", "00000", "0000", "000", "00", "0"];
		res = pads[val.toString().length - 1] + val.toString();
		return res;
	};

	$.offer.getLeftValue = function(id, lefts){
		lefts = lefts.split('^');
		for(var i = 0; i < lefts.length; i++){
			var splt = lefts[i].split('|');
			if(splt[0].replace(/0*/, '') == id)
				return splt[1].replace(/0*/, '');
		}
	};
	
	$.offer.unPadStr = function(str){
		var ret = [];
		str = str.split('^');
		for(var i = 0; i < str.length; i++){
			var splt = str[i].split('|');
			ret.push({id:splt[0].replace(/0*/, ''), value:splt[1].replace(/0*/, '')});
		}
		return ret;
	};
	
	$.offer.getDiscounts = function(type, discounts, itotal){
		//var dis = discounts.split('|');
		var quater = Math.round(itotal / 4);
		var count = 0;
		var disc = {di:discounts,
				items:{i0:0,i25:count += quater,i50:count += quater,i75:count += quater,i100:itotal}};
		return disc;
	};
	
	$.offer.getDiscount = function(offr){
		return $.offer.calcDiscount(offr.discounts, offr.total_ordered);
	};

	$.offer.calcDiscount = function(ofdisc, ord){
		var dis = parseFloat(ofdisc.di.d0,10);
		if(ord >= 0 && ord <= ofdisc.items.i25){
			dis=parseFloat(ofdisc.di.d0,10)+(ord*(ofdisc.di.d25-ofdisc.di.d0)/(ofdisc.items.i25 - ofdisc.items.i0));
		}else if(ord > ofdisc.items.i25 && ord <= ofdisc.items.i50){
			dis=parseFloat(ofdisc.di.d25)+((ord-ofdisc.items.i25)*(ofdisc.di.d50-ofdisc.di.d25)/(ofdisc.items.i50 - ofdisc.items.i25));
		}else if(ord > ofdisc.items.i50 && ord <= ofdisc.items.i75){
			dis=parseFloat(ofdisc.di.d50)+((ord-ofdisc.items.i50)*(ofdisc.di.d75-ofdisc.di.d50)/(ofdisc.items.i75 - ofdisc.items.i50));
		}else if(ord > ofdisc.items.i75 && ord <= ofdisc.items.i100){
			dis=parseFloat(ofdisc.di.d75)+((ord-ofdisc.items.i75)*(ofdisc.di.d100-ofdisc.di.d75)/(ofdisc.items.i100 - ofdisc.items.i75));
		}
		$.log('dis: ' + dis);
		return new Number(dis).toFixed(2);
	};
	
	
})(jQuery);

(function($, $offer){
	
	$offer.display = function() {};

	var orderItems = [];
	var orderOfferId;
	
	$offer.getOfferById = function(offerId) {
		var offr;
		$.each(offrs, function(){ 
			if(this.id == offerId){
				offr = this;
				return false;
			}
		});
		return offr;
	};
	
	$offer.getOfferItemById = function(offerId, itemId) {
		var item;
		$.each($offer.getOfferById(offerId).items, function(){
			if(this.id == itemId){
				item = this;
				return false;
			}
		});
		return item;
	};

	$.offer.display.offers = function(){
		offrs = [];
		var getOper;
		if(user.length > 0){
			getOper = $.payload.newOper(17);
			getOper.addParams({"zip":user[0].nodes.zipcode});
		}else{
			getOper = $.payload.newOper(13);
			getOper.addParams({"zip":""});
		}
		var args = [];
		args.push(getOper);
		$.ajaxCall(args, 'html', function(r){
			$('#offersCtn').empty().append(r);
			$.offer.completeRendering();
			setTimeout(function(){
				twttr.widgets.load();
				loadMap();
				FB.XFBML.parse();
			}, 500);		
		});
	};

	$.offer.completeRendering = function() {
		$.each(offrs, function(ind){
			this.discounts = $.offer.getDiscounts(1, this.discounts, this.total);
			$('#oid_'+ this.id).upmileOffer({
				offer:this,
				buttons:[{id:"submitOrder", click:submitOrder, disabled:'false'}],
				type:'offer'
             });	
		
		});
	};
	
	getReturnOrdrItem = function(itemId, reOrdr){
		
	};
	
	processOrderSubmission = function(r){
		$.log('submit order response');
		var orderResp = r, lessQty = false;
		var dlgBtns = {"Close": function() {
			$('#orderDialog').remove();
			$.offer.display.offers();}
		}; 
		$('body').append('<div id="orderDialog"></div>');
		$('#orderDialog').load('/static/html_templates/orderSubmitResp.html', function(){
			var itemStr='<div class="row iteminfo" id="irow"><div class="offerCell" id="iname"></div>'+
			'<div class="offerCell" id="iprice"></div>'+
			'<div class="offerCell qtyColumn" id="qty"></div><div class="offerCell" id="itotal"></div></div>';	
			var retOp = undefined, offerId, totalOrdrPrice = 0, totalOrdr = 0;
			//check for error obj in response
			$.each(orderResp, function(){
				if(this.object == 'error'){
					retOp = this;
					return false;
				}
			});
			if(retOp != undefined){
				$('#orderDialog').find('.row').remove();
				$('#respText').append('<div>' + retOp.nodes.message + '</div>');
				return;
			}
			
			if(orderResp[0].nodes.items == undefined || orderResp[0].nodes.items.length == 0){
				$('#respText').append('<div>Sorry, all items in your order has been ordered by other customers</div>');
			}else{
				$.each(orderItems, function(ind, val){
					$('#orderDialog').find('#offerFooter').before(itemStr);
					var item = $.offer.getOfferItemById(orderOfferId, val.itemId);
					var retItemQty = $.offer.getLeftValue(val.itemId, orderResp[0].nodes.items);
					var irow = $('#oid_' + orderOfferId).find('#' + val.itemId);
					$('#irow').attr('id', val.itemId).find('#iname').text(irow.find('#iname').text()).end().find('#iprice').text(irow.find('#iprice').text()).end();
					if(retItemQty == undefined){
						$('#orderDialog').find('#' + val.itemId).find('#qty').text('Not Available');
						$('#orderDialog').find('#' + val.itemId).find('#itotal').text('$0.00');
					}else{
						totalOrdr += Number(retItemQty);
						totalOrdrPrice = new Number(parseFloat(totalOrdrPrice, 10) + Number(retItemQty) * parseFloat(item.price, 10)).toFixed(2);
						if(Number(retItemQty) < Number(val.itemQty))
							 lessQty = true;
						$('#orderDialog').find('#' + val.itemId).find('#qty').text(retItemQty + ' ' + item.unit + '(s)');
						$('#orderDialog').find('#' + val.itemId).find('#itotal').text('$' +	new Number(parseFloat(retItemQty,10)*parseFloat(item.price,10)).toFixed(2));
					}
				});
			}
			var disc = $.offer.calcDiscount($.offer.getOfferById(orderOfferId).discounts, orderResp[0].nodes.total_ordered);
			$('#orderDialog').find('#discount').text(new Number(disc).toFixed(2));
			$('#orderDialog').find('#grandtotal').text(totalOrdr == 0?'0.00':new Number(totalOrdrPrice*(100-disc)/100).toFixed(2));
			if(totalOrdr == 0){
				$('#respText').append('<div>Sorry, all items in your order has been ordered by other customers</div>');
			}else if(lessQty){
				$('#respText').append('<div>Sorry, some items were ordered by other customers ' + 
				'resulting in lower or not available item quantity for your order. Please click the Confirm Order button to keep this order.</div>');
				dlgBtns = {"Cancel Order": function(){
								var ordr = {oid: orderOfferId, ord: orderResp[0].nodes.ordr};
								var itms = '';
								$.each($.offer.unPadStr(ordr.ord), function(){
									if(itms.length > 0)
										itms += ',';
									itms += this.id + '|' + this.value;
								});
								var args = [];
								var orderOp = $.payload.newOper(22);
								orderOp.addParams({oid:ordr.oid},{ordr:itms});
								args.push(orderOp);
								$.ajaxCall(args, function(r){
									$('#orderDialog').remove();
									$.offer.display.offers();
								});			
							},
							"Confirm Order": function(){
								var confOp = $.payload.newOper(59);
								confOp.addParams({id:ordr.oid});
								args.push(confOp);
								$.ajaxCall(args, function(r){
									$('#orderDialog').remove();
									$.offer.display.offers();
								});			
							}
				};
			}else
				$('#respText').append('Thank you for your order. You can update or cancel your order on My Orders page.');
		});
		setTimeout(function(){
				$("#orderDialog" ).dialog({
						title:'New Order',
						height: 400,
						width:550,
						modal: true,
						close: function() {
								$('#orderDialog').remove();
								$.offer.display.offers();
						},
						buttons: dlgBtns
				});
		},100);
		
	};

	submitOrder = function(){
		ordr = '';
		if(user.length == 0){
			window.location = '/signin?goto=' + window.location;
				return;
		}
		var offerId = $(this).parents('.offerid').attr('id').substring(4);
		orderOfferId = offerId; 
		$.each($(this).parents('#itemsTbl').find('.iteminfo'), function(j){
			if($(this).find('#qty').val().trim().length > 0){
				if(ordr.length > 0)
					ordr += ',';
				ordr += $(this).attr('id') + '|' + $(this).find('#qty').val();
				orderItems.push({itemId:$(this).attr('id'),itemQty:$(this).find('#qty').val()});
			}
		});
		if(ordr.length > 0){
			var args = [];
			var newOrder = $.payload.newOper(5);
			newOrder.addParams({oid:offerId},{ordr:ordr});
			args.push(newOrder);
			$.ajaxCall(args, processOrderSubmission);
		}
	};
	
	fixOnScrollBar=function(/*Query (with $ sign) */ query){
		var hasScrollbar = $('body').outerHeight() > $(window).height();
		if(hasScrollbar){
			query.find('.tick').each(function(){
				var left=$.getCssNumber( $(this),'left');  
				$(this).css('left',(left+2)+'px');
			});
		}		
	};
	
	 loadMap=function(){
		 $('span[id="pickup_address_map"]').click(function(){
				var addr=$(this).closest().find('#pickup_address').text();
				//$.log(addr);
				($('#map') && $('#map').length==1)?$('#map').html(''):$('body').append('<div id="map"></div>');
				$( "#map" ).dialog({ height: 300, width:500 });
				var geocoder = new google.maps.Geocoder();
				var myOptions = {
				          center: new google.maps.LatLng(37.75, 122.68), //37.77, -121.42 
				          zoom: 15,
				          mapTypeId: google.maps.MapTypeId.ROADMAP
				        };
				var map=new google.maps.Map(document.getElementById("map"),myOptions);
				geocoder.geocode( { 'address': addr}, function(results, status) {
				      if (status == google.maps.GeocoderStatus.OK) {
				    	  map.setCenter(results[0].geometry.location);
				    	  new google.maps.Marker({map: map, position: results[0].geometry.location});
				      } else {
				        $.log("Geocode was not successful for the following reason: " + status);
				      }
				    });
			});
	 };
})(jQuery, $.offer);