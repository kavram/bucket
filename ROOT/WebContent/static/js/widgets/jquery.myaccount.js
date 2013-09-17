(function($){

	$.myaccount = function() {};
	
	$.myaccount.init = function() {
		$('#submitButton').bind('click', function(){
			initUpdateView();
		});
		$('#cancelButton').bind('click', function(){
			window.location = "/";
		});
		//if user biz_owner add button to update his biz account
		if(user[0].nodes.biz_owner == 2){
			$('#updatePassButton').after('&nbsp;<button type="updateBiz" id="updateBizButton">Update My Business Account</button>');
			$('#updateBizButton').bind('click', function(){
				window.location = "/mybizaccount";
			});
		}
		
		$('#updatePassButton').bind('click', function(){
			window.location = "/update-password?goto=myaccount";
		});
		
		$.each(user[0].nodes, function(ind, val){
			$('#' + ind).text(val);
		});
	};

	function initUpdateView(){
		$.each(user[0].nodes, function(ind, val){
			$('#' + ind).remove();
			$('#' + ind + 'li').append('<input required="true" type="text" maxlength="50" id="' + ind + '" name="' + ind + '" required="true" validation="required:true"/>');
			$('#' + ind).val(val);
			$('#' + ind + 'label').text($('#' + ind + 'label').text() + '*');
		});
		$('#submitButton').unbind().bind('click', function(){
			submit();
		});
		$('#submitButton').text('Submit');
		$('#updatePassButton').hide();
		$('#cancelButton').bind('click', function(){
			window.location = "/myaccount";
		});
	}
	
	function submit(){
		$.log('click submit but.');
		if(!validate())
			return;
		updateUser();
	}

function updateUser(){
	var oper = $.payload.newOper(52);
	oper.addFields({email:$('#email').val()},{first_name:$('#first_name').val()},{last_name:$('#last_name').val()},
			{zipcode:$('#zipcode').val()});
	var args = [];
	args.push(oper);
	$.ajaxCall(args, function(resp){
		if(resp[0].object == 'error'){
			$('#errorMsg').text(resp[0].nodes.message);
		}else
			window.location = "/myaccount";
	});		
}

function confirmMessage(){
	$('#errorMsg').text('');
	$('#title').text('Your request has been processed. You should receive an email with your new password.');
    $('#submitButton, #email, #emaillabel').hide();
    $('#cancelButton').text('OK');
}

	function validate(){
		var errormsg = '';
		$('#regform input[required= "true"]').each(function(){
			if($(this).val().length == 0){
				errormsg = 'Please enter required fields.';
				$('#' + this.id + 'label').css('color', 'red');
			}else
				$('#' + this.id + 'label').css('color', 'black');
		});
		if(errormsg.length > 0) {
			$('#errorMsg').text(errormsg);
			return false;
		}
		return true;
}
})(jQuery);
