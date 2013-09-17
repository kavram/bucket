(function($){
	
	var pickupZipGeo = [];
	
	var submitHandler = new Object();
	var itemsRowHtml;
	
	$.newoffer = function(){};

	$.newoffer.init = function(){
		initHtml();
		if(offer.length > 0)
			initUpdateOffer();
		else
			initNewOffer();
	};
	
	initNewOffer = function(){
		$('#offerdate').datepicker(new Date());
		$('#fromdate, #todate').datepicker(new Date());
		$('#merchantname').val(biz.nodes.name);
		$('#merchantphone').val(biz.nodes.phone);
		$('#locName').val(biz.nodes.locations[0].name);
		$('#locAddress').val(biz.nodes.locations[0].street);
		$('#locCity').val(biz.nodes.locations[0].city);
		$('#locState').val(biz.nodes.locations[0].state);
		$('#locZipcode').val(biz.nodes.locations[0].zipcode);
		$.extend(submitHandler, {submit : function(){submitNewOffer();}}); 
	};
	
	initHtml = function() {
		$('.submitButton').click(function() {
			processSubmit();
		});

		$('.plus').click(function() {
			addRow($(this));
		});
		$('.minus').click(function() {
			removeRow($(this));
		});
		
		$("#offertime").position({
			of: $("#offerdescr" ),
			my:"right top",
			at:"right bottom",
			collision:"none"
		});	
		
		$("#offerdate").position({
			of: $("#offerdescr" ),
			my:"left top",
			at:"left bottom",
			collision:"none"
		});	
		$("#offertime,#offerdate").css('margin-top','3px');
		
		$('.hideContent').css('display','none');
		$('input[type="radio"]').attr('checked', false).click(function() {	
				$(this).closest('.conRow').find('.hideContent').css('display','none');
				//$.log($('#'+$(this).attr('id')+'Con'));
				$('#'+$(this).attr('id')+'Con').css('display','table');		
		});
		$('input[name="radio"]:first, input[name="radioDel"]:first, input[name="radioTime"]:first').trigger('click');
//		$('#offerdate').datepicker(new Date());
//		$('#offerdate, #fromdate, #todate').datepicker(new Date());
		$('#offertime, #fromtime, #totime,#fromtimeWeekday,#totimeWeekday').timepicker({
			ampm: true,
			addSliderAccess: true,
			sliderAccessArgs: { touchonly: false },
			hourGrid: 4,
			minuteGrid: 15,
			hourMin: 8
		});
		
		$('#weekdaysSet').buttonset();
		$('#weekdaysSet>label').removeClass('ui-state-active');
		$('#weekdaysSet, #fromtimeWeekday, #totimeWeekday').click(function(){
			$('#recurring').find('.gridContent').find('.cell:first').text('').removeClass('errorMsg');		
		});
		
		
		$('#weekdayPlus').click(function(){	
			$('#recurring').show();
			if($('#weekdaysSet>label.ui-state-active').length==0 || $('#fromtimeWeekday').val().trim()=='' || $('#totimeWeekday').val().trim()=='') {				
				$('#recurring').find('.gridContent').find('.cell:first').text('Please select weekday and time').addClass('errorMsg');			
			}
			else{	
				$('#recurring').find('.gridContent').find('.cell:first').text('').removeClass('errorMsg');		
				var htmlStr='';
				$('#weekdaysSet>label.ui-state-active').each(function(){
					var fromtimeWeekday=$('#fromtimeWeekday').val();
					var totimeWeekday=$('#totimeWeekday').val();
					var weekday=$(this).find('span').text();
					var addRow=true;
					
					$('#recurring').find('.gridContent').find('.row').each(function(){
						 if($(this).find('.cell:first').text()==weekday){
							   var start=(($(this).find('.time').text().split('-'))[0]).trim();
							   var end=(($(this).find('.time').text().split('-'))[1]).trim();
							  
							   if(Date.parseExact($.formatTimeForDateLib(fromtimeWeekday),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(start),'h:mm tt'))>0  &&
								   Date.parseExact($.formatTimeForDateLib(fromtimeWeekday),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(end),'h:mm tt'))<=0 &&	   
								   Date.parseExact($.formatTimeForDateLib(totimeWeekday),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(end),'h:mm tt'))>0
							    ){
								    $(this).find('.time').text(start+'-'+totimeWeekday);
								    addRow=false;
							   }
							   else if(Date.parseExact($.formatTimeForDateLib(fromtimeWeekday),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(start),'h:mm tt'))<0  &&
									     Date.parseExact($.formatTimeForDateLib(start),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(totimeWeekday),'h:mm tt'))<=0 &&	   
									    Date.parseExact($.formatTimeForDateLib(totimeWeekday),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(end),'h:mm tt'))<0
									   ){
								   $(this).find('.time').text(fromtimeWeekday+'-'+end);
								   addRow=false;
							   }
							   else if(Date.parseExact($.formatTimeForDateLib(fromtimeWeekday),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(start),'h:mm tt'))<=0  &&
									     Date.parseExact($.formatTimeForDateLib(end),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(totimeWeekday),'h:mm tt'))<=0 
										   ){
									   $(this).find('.time').text(fromtimeWeekday+'-'+totimeWeekday);
									   addRow=false;
							   }
							   else if(Date.parseExact($.formatTimeForDateLib(fromtimeWeekday),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(start),'h:mm tt'))>=0  &&
									     Date.parseExact($.formatTimeForDateLib(end),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(totimeWeekday),'h:mm tt'))>=0 
										   ){
									   addRow=false;
							   }
						 }
					});
					if(addRow){
						htmlStr+=createWeekDayRow(weekday,fromtimeWeekday,totimeWeekday);
						/*'<div class="row info"><div class="cell" style="width:45px;">'+weekday+'</div><div class="cell time">'+fromtimeWeekday+'-'+totimeWeekday+
			               '</div><div class="cell"><span class="ui-state-default ui-corner-all ui-icon ui-icon-minusthick weekdayMinus"></span></div></div>';*/
					}					
					$(this).removeClass('ui-state-active');
				});
				$('#recurring').find('.gridContent').find('.row:last').after(htmlStr);
				setMinusRowEvent();
			}		
		});
		setMinusRowEvent();
		$('#recurring').hide();
				
		populateUnit("unit");
		$('#cancelButton').click(function() {
			window.location="/myoffers";
		});
		itemsRowHtml = $('#regItemsTbl').find('.row.iteminfo').html();
		$.log(itemsRowHtml);
	};
	
	setMinusRowEvent = function(){
		setTimeout(function(){
			$('.weekdayMinus').unbind().click(function(){
				removeRow($(this));
				if($('#recurring').find('.gridContent').find('.row').length==1) $('#recurring').hide();
			});
		},300);
	};
	
	
	initUpdateOffer = function(){
		$('title').text('Edit Offer');
		$('#offerLgnd').text('Edit Offer');
		$('#offername').val(offer[0].nodes.name);
		if(offer[0].nodes.description != null)
			$('#offerdescr').val(offer[0].nodes.description);
		var cdate = $.formatDate(offer[0].nodes.close_date);
		$('#offerdate').val(cdate);
		$('#offerdate').datepicker();
		$('#merchantname').val(offer[0].nodes.biz_name.name);
		$('#merchantphone').val(offer[0].nodes.biz_name.phone);
		if(offer[0].nodes.di_type == 1){
			$('#radio1').attr('checked', true);
			$('#d0').val(offer[0].nodes.discounts.d0);
			$('#d100').val(offer[0].nodes.discounts.d100);
		}else{
			$('#radio2').attr('checked', true);
			$('#radio2').parents('.conRow').find('.hideContent').css('display','none');
			$('#radio2Con').css('display','table');
			$('#m0').val(offer[0].nodes.discounts.d0);
			$('#m25').val(offer[0].nodes.discounts.d25);
			$('#m50').val(offer[0].nodes.discounts.d50);
			$('#m75').val(offer[0].nodes.discounts.d75);
			$('#m100').val(offer[0].nodes.discounts.d100);
		}
		initUpdatePickup(offer[0].nodes.pickup);
		var i = 0;
		$.each(offer[0].nodes.offer_items, function(){
			var table = $('#regItemsTbl');
			if(i > 0)
				table.find('.row:last').after('<div class="row iteminfo">' + itemsRowHtml + '</div>');
			
			var lastRow = table.find('.row:last');
			lastRow.attr('id', this.id)
			            .find('#item').val(this.name).end()
			            .find('#price').val(offer[0].nodes.offer_items[i].price).end()
			            .find('#qty').val(offer[0].nodes.offer_items[i].total).end()
			            .find('#unit').val(offer[0].nodes.offer_items[i].unit);
			if(offer[0].nodes.offer_items[i].description != null)
				lastRow.find('#itemdescr').val(offer[0].nodes.offer_items[i].description);
			table.find('.minus:last').click(function() {removeRow($(this));});
			i++;
		});
		$.extend(submitHandler, {submit : function(){submitUpdatedOffer();}}); 
		
	};
	createWeekDayRow= function(day, from, to){
		var ret = '';
		days = day.split(',');
		for(i = 0; i < days.length; i++)
			ret += '<div class="row info"><div class="cell" style="width:45px;">'+days[i]+'</div><div class="cell time">' + from + '-' + to +
            '</div><div class="cell"><span class="ui-state-default ui-corner-all ui-icon ui-icon-minusthick weekdayMinus"></span></div></div>';
		
		return ret;
	};
	
	initUpdatePickup = function(pickup){
		$('#locName').val(pickup.name);
		$('#locAddress').val(pickup.address);
		$('#locCity').val(pickup.city);
		$('#locState').val(pickup.state);
		$('#locZipcode').val(pickup.zipcode);
		$('#custNote').val(pickup.note);
		if(pickup.dates.type == 'wd'){
			$('#radio6').trigger('click');		
			$.each(pickup.dates.dates, function(){
					$('#recurring').find('.gridContent').find('.row:last').after(createWeekDayRow(this.day,this.from,this.to));
			});
			$('#recurring').show();
		}else{
			$('#fromdate').val($.formatDate(pickup.dates.date.f));
			$('#fromdate').datepicker();
			$('#todate').val($.formatDate(pickup.dates.date.t));
			$('#todate').datepicker();
			$('#fromtime').val(pickup.dates.time.f);
			$('#totime').val(pickup.dates.time.t);
		}
	};
	
	populateUnit= function(nodeId) {
		var options=['lb','ounce','bottle','box','bunch','piece','can'];
		var defaultVal='lb';
		$.populateComboBoxData(nodeId, options);
		$('#'+nodeId).val(defaultVal);
	};
	
	addRow = function(elm) {
		var table = $(elm).parents('#regItemsTbl');
		table.find('.row:last').after('<div class="row iteminfo">' + itemsRowHtml + '</div>');
		table.find('.minus:last').click(function() {removeRow($(this));});
		//populateUnit('unit'+rowNum);
		//$('#price'+rowNum).val('$');
	};

	removeRow = function(elm) {
		//$(elm).closest('.iteminfo').remove();
		//$(elm).closest('.row').remove();
		var time=1200, row=$(elm).closest('.row');
		row.hide(time);
		setTimeout(function(){
			row.remove();
		   },time);	
	};
	
	processSubmit = function() {
		$.log('processSubmit');
		if(!validate())
			return;
		//if ($('input[name="radioDel"]:checked').attr('id') != 'radio3')
		//	submitHandler.submit();
		//else
		getZipcodeGeoLocation();
	};
	
	validate = function() {
		$.log('validate');
		var requiredFields=['offername','offerdate'];
		if ($('input[name="radio"]:checked').attr('id')=='radio1'){
			requiredFields.push('d0');
			requiredFields.push('d100');
		}
		else {
			requiredFields.push('m0');
			requiredFields.push('m25');
			requiredFields.push('m50');
			requiredFields.push('m75');
			requiredFields.push('m100');
		}
		if ($('input[name="radioDel"]:checked').attr('id')=='radio3'){
			requiredFields.push('locName');
			requiredFields.push('locAddress');
			requiredFields.push('locCity');
			requiredFields.push('locState');
			requiredFields.push('locZipcode');
			requiredFields.push('date');
		}
		var ret = true;
		$.each(requiredFields, function(){
			if(!required($('#' + this.toString())))
				ret = false;
		});
		if(!validateTableEntry())
			ret = false;
		return ret;
	};
	
	required= function(elm) {
		var reqText='Required';
		if(elm.val() && elm.val().length>0 && elm.val() != reqText){
			return true;
		}
		else{
			showError(elm,reqText);
			return false;
		}			
	};
	
	getZipcodeGeoLocation = function() {
		var oper = $.payload.newOper(28);
		oper.addParams(({zipcode:{value:$('#locZipcode').val()}}));
		var args = [];
		args.push(oper);
		$.ajaxCall(args, function(resp){
			$.log(resp);
			$.each(resp, function(){
				pickupZipGeo.push({zipcode:this.nodes.zipcode, longitude:this.nodes.longitude, latitude:this.nodes.latitude});
			});
			setTimeout(function(){
				submitHandler.submit();
			}, 100);	
		});		
	};
	
	validateTableEntry= function() {
		var ret = true;
		$('#regItemsTbl').find('.row.iteminfo').each(function(){		
			//var unit=$(this).find('select[name="unit"]');
			var errors=[];
			if(!required($(this).find('input[name="item"]')))
				 errors.push('Required');
			if(!required($(this).find('input[name="price"]'))) 
				errors.push('Required');
			if(! required($(this).find('input[name="qty"]'))) 
				errors.push('Required');
				
			if (errors.length > 0){
				ret = false;
				 if(!isNonblank($(this).find('input[name="item"]').val()) ){
					 errors.push('Invalid item');
					 showError($(this).find('input[name="item"]'),'Invalid item');
				 }				 
				 if(!isWhole($(this).find('input[name="qty"]').val())){
					 errors.push('Invalid qty');
					 showError($(this).find('input[name="qty"]'),'Invalid qty');
				 }		 
				// if(!isCurrency(price.val())  ){
				//	 errors.push('Invalid price');
				//	 showError(price.attr('id'),'Invalid price');
				// }
					 
			}
			$.log(errors);		
		});
		return ret;
	};

	showError= function(elm, msg) {
		elm.stop()
        .effect('highlight',{}, 7000, function(){$(this).removeClass('required');})
        .val(msg)
		.addClass('required')
		.focus(function() {
			 $(this).val('');
		 });  
	};

	
	getDiscounts = function(){
		var discounts;
		if ($('input[name="radio"]:checked').attr('id')=='radio1'){
			$.log('d100: ' + $('#d100').val());
			$.log('d0: ' + $('#d0').val());
			var quater = new Number(($('#d100').val() - $('#d0').val()) / 4).toFixed(2);
			discounts = {d0:Number($('#d0').val()),d25:Number($('#d0').val()) + Number(quater), 
			d50:Number($('#d0').val()) + Number(quater * 2), d75:Number($('#d0').val()) + Number(quater * 3), 
			d100:Number($('#d100').val())};
		} else {
			discounts = {d0:Number($('#m0').val()),d25:Number($('#m25').val()),d50:Number($('#m50').val()),
					d75:Number($('#m75').val()),d100:Number($('#m100').val())};
		}
		return discounts;
	};
	
	getPickup = function(){
		var pickup;
		pickup = {dates:getPickupDate(),name:$('#locName').val(),address:$('#locAddress').val(),
		city:$('#locCity').val(),state:	$('#locState').val(),zipcode:$('#locZipcode').val()};
		if($('#custNote').val().length > 0)
			$.extend(pickup, {note:$('#custNote').val()});
		return pickup;

	};
	
	getLocation = function(){
		var location = [];
		location.push({location_type:0,name:$('#locName').val(),address:$('#locAddress').val(),
		city:$('#locCity').val(),state:$('#locState').val(),zip:$('#locZipcode').val(),
		latitude:pickupZipGeo[0].latitude,longitude:pickupZipGeo[0].longitude});
		if($('#custNote').val().length > 0)
			$.extend(location, {note:$('#custNote').val()});
		return location;
	};
	
	getPickupDate = function(){
		var pd;
		if($('input[name="radioTime"]:checked').attr('id') == 'radio6' ){
			var days = [];
			$('#recurring').find('.gridContent').find('.row.info').each(function(){
				var weekday = $(this).find('.cell:first').text();
				var start = (($(this).find('.time').text().split('-'))[0]).trim();
				var end = (($(this).find('.time').text().split('-'))[1]).trim();
				start = start.replace(/0*/, '').replace(':00', '');
				end = end.replace(/0*/, '').replace(':00', '');
				var wd = null;
				$.each(days, function(){
					if(this.from == start && this.to == end){
						wd = this;
						return false;
					}
				});
				if(wd == null){
					wd = {day:weekday, from:start, to:end};
					days.push(wd);
				}else{
					wd.day = wd.day + ',' + weekday;
				}
			});
			pd = {type:'wd', dates:days};
		}else{
			var ft = $('#fromtime').val().trim().replace(/0*/, '').replace(':00', '');
			var tt = $('#totime').val().trim().replace(/0*/, '').replace(':00', '');
			//var fd = Date.parse($.formatDateForDateLib($('#fromdate').val().trim())).toString("MMM d");
			//var td = Date.parse($.formatDateForDateLib($('#todate').val().trim())).toString("MMM d");
			
			var fd = Date.parse($.formatDateForDateLib($('#fromdate').val().trim()));
			var td = Date.parse($.formatDateForDateLib($('#todate').val().trim()));
			var frmDates = '';
			if(fd.month == td.month && fd.year == td.year){
				frmDates = fd.toString('MMM') + ' ' + fd.toString('d') + ' - ' + td.toString('d') + " '" + fd.toString('yy');
			}else if(fd.month != td.month && fd.year == td.year)
				frmDates = fd.toString('MMM') + ' ' + fd.toString('d') + ' - ' + td.toString('MMM') + ' ' + td.toString('d') + ' ' + fd.toString('yy');
				
			pd = {type:'fd', ft:ft + ' - ' + tt + ', ' + frmDates, time:{f:$('#fromtime').val().trim(), t:$('#totime').val().trim()}, 
				date:{f:$('#fromdate').val().trim(), t:$('#todate').val().trim()}};
		}
		return pd;
	};
	
	getBiz = function(){
		return {name:$('#merchantname').val(),phone:$('#merchantphone').val(),logo:biz.nodes.logo};
	};
	
	submitNewOffer = function(){
		$.log('submitNewOffer');
		var newOp = $.payload.newOper(1);
		var args = [];
		var itemTotal = 0;
		var newOffer = {name:$("#offername").val(),close_date:$("#offerdate").val() + ' 12:00 pm',
		di_type: $('input[name="radio"]:checked').attr('id')=='radio1'?1:2,discounts:getDiscounts(),
		pickup_type:1,pickup:getPickup(),biz_name:getBiz(),biz_id:biz.nodes.id,ol:getLocation()};
    	if($("#offerdescr").val().length > 0)
    		$.extend(newOffer, {description:$("#offerdescr").val()});
    	var items = [];
    	$('#regItemsTbl').find('.row.iteminfo').each(function(){
    		var item = {name:$(this).find('input[name="item"]').val(),price:$(this).find('input[name="price"]').val(),
    		unit:$(this).find('select[name="unit"]').val(),total:$(this).find('input[name="qty"]').val()};
    		if($(this).find('input[name="itemdescr"]').val().length > 0)
    			$.extend(item, {description:$(this).find('input[name="itemdescr"]').val()});
    		items.push(item);
    		itemTotal += Number($(this).find('input[name="qty"]').val());
    	});
    	$.extend(newOffer, {offer_items:items});
    	$.extend(newOffer, {total:Number(itemTotal)});
    	newOp.addFieldsAsJSONArray([newOffer]);
		args.push(newOp);
		$.ajaxCall(args, 'html', function(resp){
			confirmOffer(resp);
		});
		//}, 100);
	};
	
	submitUpdatedOffer = function(){
		$.log('submitUpdatedOffer');
		var newOp = $.payload.newOper(25);
		var args = [];
		var itemTotal = 0;
		var offitems = [];
		newOp.addParams({id:{value:offer[0].nodes.id}});
    	newOp.addFields({name:$("#offername").val()},
        {close_date:$("#offerdate").val() + ' 12:00 pm'},{di_type: $('input[name="radio"]:checked').attr('id')=='radio1'?1:2},
        {discounts:getDiscounts()},{pickup_type:$('input[name="radioDel"]:checked').attr('id')=='radio3'?1:2},
        {pickup:getPickup()},{biz_name:getBiz()},{biz_id:biz.nodes.id});
    	if($("#offerdescr").val().length > 0)
    		newOp.addFields({description:$("#offerdescr").val()});
    	//new items
    	$('#regItemsTbl').find('.row.iteminfo').not('[id]').each(function(){
			offitems.push({name:$(this).find('input[name="item"]').val(),price:$(this).find('input[name="price"]').val(),
			unit:$(this).find('select[name="unit"]').val(),total:$(this).find('input[name="qty"]').val(), description:
			$(this).find('input[name="itemdescr"]').val().length > 0 ? $(this).find('input[name="itemdescr"]').val() : ''});
			itemTotal += Number($(this).find('input[name="qty"]').val());
		});
    	//existing items
		$.each(offer[0].nodes.offer_items, function(){
			var item = $('#regItemsTbl').find('#' + this.id); 
			if(item !== undefined && $(item).find('input[name="item"]').val() !== undefined){
				offitems.push({id:Number(this.id),name:$(item).find('input[name="item"]').val(),
					price:$(item).find('input[name="price"]').val(),total:$(item).find('input[name="qty"]').val(),
					unit:this.unit,description:
					$(item).find('input[name="itemdescr"]').val().length > 0 ? $(item).find('input[name="itemdescr"]').val() : ''
				});
				itemTotal += Number($(item).find('input[name="qty"]').val());
			}else
				//deleted item
				offitems.push({id:Number(this.id),total:0});
		});
		newOp.addFields({total:Number(itemTotal)},{items:offitems});
		args.push(newOp);
		$.ajaxCall(args, 'html', function(r){
			confirmOffer(r);
		});
	};
	
	confirmOffer = function(r){
		$('body').append('<div id="dialog" title="New Offer Review"><div id="offersCtn" style="width:600px;height:350px;"></div</div');
		$('#offersCtn').append(r);
		$.each(offrs, function(ind){
			this.discounts = $.offer.getDiscounts(1, this.discounts, this.total);
			$('#oid_'+ this.id).upmileOffer({
				offer:this,
				buttons:[{id:"submitOrder", click:submitOrder, disabled:'true'}],
				type:'offer'
             });	
		});
		
		$("#dialog" ).dialog({
			title:'Offer Review',
			height: 400,
			width:800,
			modal: true,
			close: function() {
					//$('#dialog').remove();
					//$.offer.display.offers();
			},
			buttons: {
					"Edit Offer": function() {
						 window.location = '/edit-offer?oid=' + offrs[0].id;
					},
					"OK": function() {
						 window.location = '/myoffers';
					}
			}
	});
		
	};
	
})(jQuery);