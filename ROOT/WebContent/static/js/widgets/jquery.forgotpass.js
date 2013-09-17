(function($){

	$.forgotpass = function() {};
	
	$.forgotpass.init = function() {
		$.log('start setup signin');
		if($.getUrlVar('goto') != null){
			$("#login").attr("href" ,"/register?goto=" + $.getUrlVar('goto'));
		}
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
    resetPass();
}

function resetPass(){
	var oper = $.payload.newOper(48);
	oper.addParams(({email:{value:$('#email').val()}}));
	var args = [];
	args.push(oper);
	$.ajaxCall(args, function(resp){
		$.log(resp);
		confirmMessage();
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
            errormsg = 'The Email is Required.';
            $('#' + this.id + 'label').css('color', 'red');
        }else{
            $('#' + this.id + 'label').css('color', 'black');
        }
    })
    if(errormsg.length > 0) {
        $('#errorMsg').text(errormsg);
        return false;
    }
    return true;
}
})(jQuery);
