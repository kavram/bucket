(function($){

	$.signin = function(){
		$('#submitButton').bind('click', $.submit);
		$("#cancelButton").bind('click', function() {
			window.location = "/";
		});
		$('body').css('overflow-x','hidden');
    };


	$.submit = function(){   
    //$.log('click submit but.');
		if(!validate())
			return;
		submitUser();
	};

	submitUser = function (){
    var respHandler = function(response){
        if(response && response.length>0){
            $.log('user_id: ' + response[0].nodes.id);
            if(response[0].nodes.id != null){
                if(response[0].nodes.status == 4){
                	if($.getUrlVar('goto') != null)
                		window.location = '/reset-password?goto=' + $.getUrlVar('goto');
                	else
                		window.location = '/reset-password';
                }else{
                    if($.getUrlVar('goto') != null)
                        window.location = decodeURIComponent($.getUrlVar('goto'));
                    else
                        window.location = "/";
                }
            }
        }else{
            $('#errorMsg').text('User not found. Please try again.');
        }
        
    };
    var args = [];
	var usr = $.payload.newOper(10);
	usr.addParams({password:{value:$('#pass').val()}},{email:{value:$('#email').val()}});
	args.push(usr);
	$.ajaxCall(args, respHandler);
};

function validate(){	
    var errormsg = '';
    $('#regform input[required= "true"]').each(function(){    
        if($(this).val().length == 0){
            errormsg = 'The fields in Red are Required.';
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
})(jQuery);