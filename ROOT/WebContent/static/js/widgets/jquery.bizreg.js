(function($){
	$.bizreg = function(){};
})(jQuery);

(function($, $bizreg){
	$bizreg.init = function() {
		populateState();
		
	    $("#submitButton").click($.bizreg.submit);
	    $("#cancelButton").click(function() {
	    	window.location = "/";
	    }).button();
	};

	$bizreg.submit = function(){
	    //$.log('click submit but.');
	    if(!validate())
	        return;	
	    document.getElementById("formBizReg").submit();
	};
	populateState = function (){
		var options=['NH','MA','CA','WI','MI'];
		$.populateComboBoxData('state', options,'Select');
	};
	function confirmMessage(){
		$('#errorMsg').text('');
		$('#title').html('Your merchant account has been created. You can create your offers now!');
		$('#nameli, #descrli, #emailli, #phoneli, #streetli, #cityli, #stateli, #zipcodeli, #submitButton').hide();
		$('#cancelButton').text('OK');
	}

	function validate(){
	    //1. check if required fields are not empty
	    var errormsg = '';
	    $('#regform input[required= "true"]').each(function(){
	        if($(this).val().length == 0){
	            errormsg = 'The fields in red are required.';
	            $('#' + this.id + 'label').css('color', 'red');
	        }else{
	            $('#' + this.id + 'label').css('color', 'black');
	        }
	    });
	    if(errormsg.length > 0) {
	        $('#errorMsg').text(errormsg);
	        return false;
	    }
	    return true;
	}	
	
	
}) (jQuery, $.bizreg);	




