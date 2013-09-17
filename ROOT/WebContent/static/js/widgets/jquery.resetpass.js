(function($){

	$.resetpass = function() {};
	
	$.resetpass.init = function() {
		$('#submitButton').bind('click', function(){
			submit();
		});
		$('#cancelButton').bind('click', function(){
	    	if($.getUrlVar('goto') != null)
	    		window.location = decodeURIComponent($.getUrlVar('goto'));
	    	else
	    		window.location = "/";
		});
	};

	function submit(){
		$.log('click submit but.');
		if(!validate())
			return;
		updatePass();
	}

	function updatePass(){
		var oper = $.payload.newOper(49);
		oper.addParams({password:{value:$('#pass').val()}});
		oper.addFields({password:$('#newpass').val()});
		var args = [];
		args.push(oper);
		$.ajaxCall(args, function(resp){
			if(resp[0].object == 'error'){
				$('#errorMsg').text(resp[0].nodes.message);
			}else
				confirmMessage();
		});		
	}

	function confirmMessage(){
		$('#errorMsg').text('');
		$('#txt').html('Your password was updated.');
		$('#pass, #newpass, #confnewpass, #passlabel, #newpasslabel, #confnewpasslabel, #submitButton').hide();
		$('#cancelButton').text('OK');
	}

	function validate(){
		var errormsg = '';
		$('#regform input[required= "true"]').each(function(){
			if($(this).val().length == 0){
				errormsg = 'Please enter required fields.';
				$('#' + this.id + 'label').css('color', 'red');
			}else{
				$('#' + this.id + 'label').css('color', 'black');
			}
		});
		if(errormsg.length > 0) {
			$('#errorMsg').text(errormsg);
			return false;
		}
		$.each(['#newpass', '#confnewpass'], function(ind, value){
			if($(value).val().length < 6){
				errormsg = "Password should have at least 6 characters.";
				$(value + 'label').css('color', 'red');
			}else
				$(value + 'label').css('color', 'black');
		});
		if(errormsg.length > 0) {
			$('#errorMsg').text(errormsg);
			return false;
		}

		if($('#newpass').val() != $('#confnewpass').val()){
			$('#confnewpasslabel').css('color', 'red');
			$('#newpasslabel').css('color', 'red');
			$('#errorMsg').text("Passwords should match.");
			return false;
		}else{
			$('#confnewpasslabel').css('color', 'black');
			$('#newpasslabel').css('color', 'black');
			$('#errorMsg').text("");
		}
    	
		return true;
	}
})(jQuery);
