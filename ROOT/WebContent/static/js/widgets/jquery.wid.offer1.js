(function($, undefined) {

	$.widget("ui.upmileOffer", {
		options : {
			type:'offer',
			offer:null,
			offerDiv:null,
			orderedItems:null,
			buttons:[],//{id:.., click}
	        scale:true,
	        shareLink:true,
	        email:true,
	        editQty:true,
	        init:null
		},

		_create : function() {
			$.log("widgets.upmileOffer _create");
			var self = this;
			this.options.offerDiv = $('#oid_' + this.options.offer.id).find('.offerGridWrap');
			this._buildButtons();
			if(this.options.type != 'myoffer'){
				$.each(this.options.offer.items, function(i){			
					$.log('iname: ' + this.name);
					if(self.options.editQty) 
						self._createEntryField($('#' + this.id).find('#qty'),i);
				});
			}
			if(self.options.scale) self._createScale(true); 
			if(self.options.editQty) self._calculateTotalAndDiscount();
			this._buildShareButton();
			this._loadMap();
		},
		
		_init : function() {
			$.log("widgets.upmileOffer  _init");
		},
		
		
		_buildButtons :function(){
			//$.log("widgets.upmileOffer  _buildButtons");
			var self = this, offerDiv=self.options.offerDiv;
			$.each(self.options.buttons, function(ind){
				offerDiv.find('#' + this.id).bind('click',this.click);
				if(this.disabled == 'true')
					offerDiv.find('#' + this.id).attr('disabled', 'disabled'); //this.disabled
			});
		},
		_buildShareButton : function(){
			var self = this,  offerDiv=self.options.offerDiv;
			if(self.options.shareLink){
				$.log(offerDiv.find("#fbDiv").length);
				offerDiv.find( "#share").removeAttr('disabled');	
				offerDiv.find( ".share").position({
								of: offerDiv.find("#fbDiv"),
								my:"left bottom",
								at:"left bottom",
								collision:"none"
							})		
							.css('visibility','visible')
							.css('margin-top','8px')			
							.css('margin-left','-20px')		
							.click(function(){
								$('#shareDialog').dialog("destroy").remove();
								 $('body').append('<div id="shareDialog"></div>');
								 $("#shareDialog").html(					        		
							        		'<div class="tblItemsDlg"><div class="row"><div class="cell">Share through email or IM</div></div><div class="row"><div class="cell">' +
										 	'<input type="text" name="shareText" id="shareText"></input></div></div>'+
							        		'<div class="row"><div class="cell">&nbsp;&nbsp;&nbsp;<button id="closeBtn" class="smallButton">Close</button></div></div>'+
							        		'</div>').dialog({				                     					                       
							            title:'Link to this offer',
							            height:160,
							            width:360,
							            modal: false,
							            open: function(event, ui) {
							            		$("#shareDialog").closest('.ui-dialog').position({
													of: offerDiv.find( ".share" ),
													my:"center top",
													at:"center bottom",
													collision:"none"
												});
							            		var domain = new String(window.location);
							            		var pos = domain.indexOf('/', 7);
							            		domain = pos == -1 ? domain : domain.substring(0, pos);
							            		$("#shareDialog").find("#shareText").val(domain + '/offer/' + self.options.offer.id);
							            		$("#shareDialog").find("#closeBtn").click(function(){ $('#shareDialog').dialog("destroy").remove();});

							            },
							            close: function() {
							                $('#shareDialog').dialog("destroy").remove();
							            }
							        });
								 
							});
			}
			if(self.options.email){
				offerDiv.find( "#email").removeAttr('disabled');	
				offerDiv.find( ".email").position({
					of: offerDiv.find("#fbDiv"),
					my:"left bottom",
					at:"left bottom",
					collision:"none"
				})		
				.css('visibility','visible')
				.css('margin-top','8px')			
				.css('margin-left','10px')		
				.click(function(){
					$('#emailDialog').dialog("destroy").remove();
					 $('body').append('<div id="emailDialog"></div>');
					 $("#emailDialog").html(					        		
				        		'<div class="tblItemsDlg">'+
							    '<div class="row"><div class="cell"><input type="text" name="emailFrom" id="emailFrom"></input></div></div>'+
				        		'<div class="row"><div class="cell"><input type="text" name="emailTo" id="emailTo"></input></div></div>'+
				        		'<div class="row"><div class="cell"><textarea name="message" id="message"></textarea></div></div>'+
				        		'<div class="row"><div class="cell"><button id="sendEmail" class="smallButton">Send</button>&nbsp;&nbsp;&nbsp;<button id="cancelEmail" class="smallButton">Cancel</button></div></div>'+
				        		'<div class="row"><div class="cell"><label id="error"></label></div></div>' +
				        		'</div>').dialog({				                     					                       
				            title:'Email to a friend',
				            height:260,
				            width:360,
				            modal: false,
				            open: function(event, ui) {
				            		$("#emailDialog").closest('.ui-dialog').position({
										of: offerDiv.find( ".email" ),
										my:"center top",
										at:"center bottom",
										collision:"none"
									});	
				            		$("#emailDialog").find("#emailFrom").focus(function(){$(this).val('');}).blur(function(){if(!$(this).val())  $(this).val('Your email');}).trigger('blur').val('Your email');
				            		$("#emailDialog").find("#emailTo").focus(function(){$(this).val('');}).blur(function(){if(!$(this).val())  $(this).val('Friend\'s email');}).val('Friend\'s email');
				            		$("#emailDialog").find("#message").focus(function(){$(this).val('');}).blur(function(){if(!$(this).val())  $(this).val('Message(optional)');}).val('Message(optional)');
				            		$("#emailDialog").find("#cancelEmail").click(function(){ $('#emailDialog').dialog("destroy").remove();});
				            		$('#sendEmail').click(function(){
				            			$.log('#sendEmail click.');
				            			var valid = true;
				            			if($('#emailFrom').val() == 'Your email' || $('#emailFrom').val().length == 0){
				            				$('#emailFrom').css('border', '2pt solid #8C1717');
				            				valid = false;
				            			}
				            			if($('#emailTo').val() == 'Friend\'s email' || $('#emailTo').val().length == 0){
				            				$('#emailTo').css('border', '2pt solid #8C1717');
				            				valid = false;
				            			}
				            			if(!valid){
				            				$('#error').html('Please enter correct email addresses.');
				            				return;
				            			}
				            			var op = $.payload.newOper(57);
				            			var ms = {offer_id:self.options.offer.id,from:$('#emailFrom').val(),to:$('#emailTo').val()};
				            			if($('#message').val() != 'Message(optional)' && $('#message').val().length > 0)
				            				$.extend(ms, {message:$('#message').val()});
				            			
										op.addFieldsAsJSONArray([ms]);
										$.ajaxCall([op], function(response){
											$.log('offer email wsent');
										});
										$('#emailDialog').dialog("destroy").remove();
				            		});
				            },
				            close: function() {
				                $('#emailDialog').dialog("destroy").remove();
				            }
				        });
					 
				});
			}
			
		},
		
		_createEntryField :function(elm,i){
			//$.log("widgets.upmileOffer  _createEntryField");
			var self = this, offer=self.options.offer, curRow=$(elm).parent().parent();
			var orderedQty = 0;
			if (self.options.type == 'myorder'){
				  var ordered = $.grep( self.options.orderedItems, function(item,ind){
					  return item.id == curRow.attr('id');
				  });
				  if(ordered && ordered[0]) 
					  orderedQty = ordered[0].qty;
				  else if(parseFloat(offer.items[i].lft, 10) == 0)
					  $(elm).attr('disabled','true');
			}else if(parseFloat(offer.items[i].lft, 10) == 0) 
				$(elm).attr('disabled','true');
				
			elm.bind("keyup", function(event){		
				//$.log(offer); 
	            var newQty = $(this).val(); 
	            if(newQty.length == 0)
	            	newQty = 0;
	            valid = true;
	            if(newQty == 0 || $.isNumeric(newQty)){  
	            	//var enough = (parseFloat(ileft,10)==0 )?parseFloat(offer.items[i].total,10)-SSparseFloat(order,10):parseFloat(ileft,10)-parseFloat(order,10);
	            	var res = parseFloat(offer.items[i].lft, 10) + parseFloat(orderedQty, 10) - parseFloat(newQty, 10);
	            	if(newQty > 0 && newQty.indexOf('.') > -1) 
	            		res = parseFloat(new Number(res).toFixed(2),10);
	            	if(res >= 0){
	            		curRow.find('#ileft>span').text(res).end()
	            		.find('#itotal').text('$' + new Number(parseFloat(newQty,10) * parseFloat(offer.items[i].price,10)).toFixed(2));
	            		offer.items[i].lft = res;
	            		offer.total_ordered = new Number(offer.total_ordered) - new Number(orderedQty) + new Number(newQty);
	            		orderedQty = newQty;
	            		self._calculateTotalAndDiscount();
	            	}else{
	            		$.log('ileft<order val=' + newQty);
	            		valid = false;
	            	}           					               																								
	            }else{
	            	$.log('change:  else val=' + newQty);	
	            	if(newQty == 0) 
	            		curRow.find('#ileft>span').text(offer.items[i].lft);
	            	valid = false;
	            }	
	           
	            if(!valid) 
	            	$(this).val(newQty.substring(0, newQty.length-1));
	            var submitBtn = $(elm).closest('.offerid').find('#submitOrder');
	            //if(newQty == 0)
	            //	submitBtn.attr('disabled','true');
	            //else
	            //	submitBtn.removeAttr('disabled');
	        });
		},
		
		_calculateTotalAndDiscount :function(){
			//$.log("widgets.upmileOffer  _calculateTotalAndDiscount");
			var  self = this, offer = self.options.offer, offerGridWrap = self.options.offerDiv, total = 0;//, totalOrdered=0; 
			offerGridWrap.find('.iteminfo').each(function(){
				var itemId = $(this).attr('id');
				var price = $.grep( offer.items, function(item,ind){
					return item.id==itemId;
				})[0].price;
				if($.isNumeric($(this).find('#qty').val())){
					total += price * $(this).find('#qty').val();
				}
			});  
			var disc = $.offer.getDiscount(offer);     
			if(self.options.scale) 
				self._setBarValue(offer.total_ordered, disc);
 			offerGridWrap.find('#discount').text(new Number(disc).toFixed(2)).end()
 			                      .find('#grandtotal').text(new Number(total * (100 - disc) / 100).toFixed(2));
		},
		
		_setBarValue:function(ordered,discountVal){
			//$.log("widgets.upmileOffer  _setBarValue");
			var  self = this, offer=self.options.offer, time=600, left = 0,width = self.options.offerDiv.find('.prBar').get(0).offsetWidth-1;
			
			if(ordered >0 && ordered <= offer.discounts.items.i25)
				left=(25*ordered/offer.discounts.items.i25)*width/100-1.75;
			else if(ordered > offer.discounts.items.i25 && ordered <= offer.discounts.items.i50)
				left=(50*ordered/offer.discounts.items.i50)*width/100-2;
			else if(ordered > offer.discounts.items.i50 && ordered <= offer.discounts.items.i75)
				left=(75*ordered/offer.discounts.items.i75)*width/100-2;
			else if(ordered > offer.discounts.items.i75 && ordered <= offer.discounts.items.i100)
				left=(100*ordered/offer.discounts.items.i100)*width/100-3;
			
			self.options.offerDiv.find( ".prBarVal").position({
				of: self.options.offerDiv.find( ".prBar" ),
				my:"center bottom",
				at:"left top",
				collision:"none"
			}).css('left',left+'px');
			
			self.options.offerDiv.find('.prBarVal').animate({
								left:left+'px'
							}, 
							{
								duration:time,
								step: function() {
									self._drawValNum(/*ordered,*/discountVal);
								}
							});	
			},
			
			_drawValNum:function(/*ordered,*/discountVal){
				discountVal = discountVal.replace(/[0]+$/, '').replace(/[.]+$/, '');
				var  self = this,  offer=self.options.offer, offerDiv=self.options.offerDiv;
				offerDiv.find('#up'+offer.id).remove();
				offerDiv.find('#progBarWrapper').append('<div class="positionableVal" id="up'+offer.id+'">'+discountVal+'%</div>');
				offerDiv.find( "#up" +offer.id).position({
							of: offerDiv.find( ".prBarVal" ),
							my:"center bottom",
							at:"right top",
							collision:"none"
						});
			},
			 
			_createScale:function(actualDiscount){
				var  self = this,  offer=self.options.offer, offerDiv=self.options.offerDiv;
				self._drawTicks(actualDiscount);
				self._setBarValue(offer.total_ordered, $.offer.getDiscount(offer));
				offerDiv.find('#progBarWrapper').css('height','60px').attr('title','Current Offer Discount ' + $.offer.getDiscount(offer) + '%');	
				 if ( $.browser.msie  ||  $.browser.webkit) 
						offerDiv.find('.discountHeader, .prBarHeader').css('vertical-align', 'bottom').css('height', '23px');
				},
							
			_drawTicks:function(actualDiscount){
				var  self = this,  offerDiv=self.options.offerDiv;
				var height=5,width = offerDiv.find('.prBar').get(0).offsetWidth-1, totalTicks = 5, tickWidth=width/(totalTicks-1);    
				
				for (var count = 0; count < totalTicks; count++) {
					//var left=(/*$.browser.mozilla || */$.browser.msie)?tickWidth*count-1:tickWidth*count;  
					var left=tickWidth*count;  
					//var tick= $('<div class="tick" id="tickDown'+count+'">|</div>');
					var tick= $('<div class="tick" id="tickDown'+count+'">&nbsp;</div>');
					tick.css('left', left+'px').css('top',offerDiv.find('.prBar').position().top + offerDiv.find('.prBar').height() +'px').css('height',height+'px');//.css('margin-left','-6px');
					//if(count==totalTicks-1) tick.removeClass('tick').addClass('tickRight');
					offerDiv.find('#progBarWrapper').append(tick).append('<div class="positionable posDown" id="posDown' + count + '">' +
							eval("self.options.offer.discounts.di.d"+(25*count))+'%</div>').end()                                                               
								 .find( "#posDown" + count ).position({
			                        		of: 	offerDiv.find( "#tickDown"+count ),
			                        		at:"left bottom",
			                        		my:(count==0)?"right top":(count==totalTicks-1)?"left top":"center top",
			                				collision:"none"
			                        		});
					offerDiv.find('.posDown').css('margin-top','3px').css('margin-left','4px');	
				}
				/*if ($.browser.webkit || $.browser.opera) {
					offerDiv.find('#tickDown0').css('left',    ($.getCssNumber(offerDiv.find('#tickDown0'),'left')-2)  +'px' );
					offerDiv.find('#tickDown'+(totalTicks-1)).css('left',    ($.getCssNumber(offerDiv.find('#tickDown'+(totalTicks-1)),'left')-2)  +'px' );					
				}
				if ($.browser.mozilla ) {
					offerDiv.find('#tickDown'+(totalTicks-1)).css('left',    ($.getCssNumber(offerDiv.find('#tickDown'+(totalTicks-1)),'left')+1)  +'px' );					
				}*/
				
				offerDiv.find('#tickDown'+(totalTicks-1)).css('left',    ($.getCssNumber(offerDiv.find('.prBar'),'width')+2)  +'px' );		
				
				offerDiv.find('#progBarWrapper').css('width',($.getCssNumber(offerDiv.find('#progBarWrapper'),'width')+1)  +'px').css('border-right-color','transparent');
				
			},
			 _loadMap:function(){
				 var  self = this, offerDiv=self.options.offerDiv;
				 offerDiv.find('#pickup_address_map').click(function(){
						var addr=$.ecapeString(offerDiv.find('#pickup_address').text());
						$.log(addr);
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
			 },
			
			destroy : function() {
				$.log("widgets.upmileOffer  destroy");
				$.Widget.prototype.destroy.apply(this, arguments);
			}
	});

	$.extend($.ui.upmileOffer, {
		version : "1.1.0"
	});

})(jQuery);
