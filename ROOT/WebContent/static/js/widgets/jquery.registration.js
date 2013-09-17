(function($) {
	$.registration = function() {
	};

})(jQuery);

(function($, registration) {

	$.registration.load = function() {
		
		$('#home').click(function() {
			window.location = "testDisplayOfferandSubmitOrder.html";
		});
		$('.plus').click(function() {
			addRow($(this));
		});
		$('.minus').click(function() {
			removeRow($(this));
		});
		$('.submitButton').click(function() {
			submitItem();
		});
		$('.hideContent').css('display','none');
		$('input[type="text"]').val('');
		$('#item').focus();
		$('input[type="radio"]').attr('checked', false).click(function() {
			$(this).parents('.conRow').find('.hideContent').css('display','none');
			$.log($('#'+$(this).attr('id')+'Con'));
			$('#'+$(this).attr('id')+'Con').css('display','table');
		});
		$('input[name="radio"]:first, input[name="radioDel"]:first').trigger('click');

        $('#date, #offerdate, #homedateShip, #homedateMer').datepicker();		
		$('#offertime, #time, #hometimeShip, #hometimeMer').timepicker({
			ampm: true,
			addSliderAccess: true,
			sliderAccessArgs: { touchonly: false },
			hourGrid: 4,
			minuteGrid: 15,
			hourMin: 8
		});
		populatePer("per");
	};
	
	populatePer= function(nodeId) {
		var options=['bottle','box','bunch','pound','pounds'], defaultVal='pound';
		$.populateComboBoxData(nodeId, options);
		$('#'+nodeId).val(defaultVal);
	};
	
	addRow = function(elm) {
		var table = $(elm).parents('#regItemsTbl');
		var rowNum=$(table).find('.row.iteminfo').length;
		var itemStr = '<div class="row iteminfo">'
					+ '<div class="offerCell regForm"><input type="text" name="item" id="item'+rowNum+'" /></div>'
					+ '<div class="offerCell regForm">$<input type="text" name="price" id="price'+rowNum+'" /></div>'
					+ '<div class="offerCell regForm"><select  name="per" id="per'+rowNum+'"></select></div>'
					+ '<div class="offerCell regForm"><input type="text" name="qty" id="qty'+rowNum+'" /></div>'
					+ '<div class="offerCell buttons">'
					+ '<span class="ui-state-default ui-corner-all ui-icon ui-icon-minusthick minus"></span>'+
					'</div>' + 
				'</div>';
		
		table.find('.row:last').after(itemStr);
		table.find('.minus:last').click(function() {removeRow($(this));});
		populatePer('per'+rowNum);
	};

	removeRow = function(elm) {
		$(elm).parents('.iteminfo').remove();
	};
	
	submitItem = function() {
		$.log('submitItem');
		validate();		
	};
	
	validate = function() {
		$.log('validate');
		var requiredFields=['offername','offerdate','offertime'];
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
			//requiredFields.push('date');
			//requiredFields.push('time');
		}
		/*else if ($('input[name="radioDel"]:checked').attr('id')=='radio4'){
			requiredFields.push('homedateMer');
			requiredFields.push('hometimeMer');
		}
		else{
			requiredFields.push('homedateShip');
			requiredFields.push('hometimeShip');
		}*/
		
		$.each(requiredFields, function(){
			required(this.toString());
		});
		validateTableEntry();	
	};
	
	required= function(nodeId) {
		//$.log('required nodeId='+nodeId+'  val='+$('#'+nodeId).val());
		var reqText='Required', val=$('#'+nodeId).val();
		if(val && val.length>0 && val!=reqText){
			return true;
		}
		else{
			showError(nodeId,reqText);
			return false;
		}			
	};
	
	validateTableEntry= function() {
		$('#regItemsTbl').find('.row.iteminfo').each(function(){		
			var item=$(this).find('input[name="item"]');
			var price=$(this).find('input[name="price"]');
			var qty=$(this).find('input[name="qty"]');
			//var per=$(this).find('select[name="per"]');
			var errors=[];
			if(!required(item.attr('id')))
				 errors.push('Required');
			if(!required(price.attr('id')) ) 
				errors.push('Required');
			if(! required(qty.attr('id')) ) 
				errors.push('Required');
				
			if (errors.length<3){
				 if(!isNonblank(item.val()) ){
					 errors.push('Invalid item');
					 showError(item.attr('id'),'Invalid item');
				 }				 
				 if(!isWhole(qty.val())){
					 errors.push('Invalid qty');
					 showError(qty.attr('id'),'Invalid qty');
				 }		 
				 if(!isCurrency(price.val())  ){
					 errors.push('Invalid price');
					 showError(price.attr('id'),'Invalid price');
				 }
					 
			}
			$.log(errors);		
		});
	};

	showError= function(nodeId, msg) {
		$('#'+nodeId).stop()
        .effect('highlight',{}, 7000, function(){$(this).removeClass('required');})
        .val(msg)
		 .addClass('required')
		 .focus(function() {
			 $(this).val('');
		 });  
	};
	
	
})(jQuery, $.registration);