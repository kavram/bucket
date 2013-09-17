(function($){
	$.reg = function(){};
})(jQuery);

(function($, $reg){
	$reg.init = function() {
	    //$.log('start setup reg');
		if($.getUrlVar('goto') != null){
			$("#login").attr("href" ,"/signin?goto=" + $.getUrlVar('goto'));
		}
	    $('#submitButton').click($.reg.submit);
	    $("#cancelButton").click(function() {
	    	if($.getUrlVar('goto') != null)
	    		window.location = decodeURIComponent($.getUrlVar('goto'));
	    	else
	    		window.location = "/";
	    });
	    $('body').css('overflow-x','hidden');
	    //adjustContainer();
	};

	$reg.submit = function(){
	    //$.log('click submit but.');
	    if(!validate())
	        return;	
	    checkEmail();
	};
	
	function submitUser(){
	    var gotoUrl = $.getUrlVar('goto');
	    $.log('goto: ' + gotoUrl);
	    var args = [];
	    var insUser = $.payload.newOper(8);
	    var newUser = {first_name:$('#fName').val(),last_name:$('#lName').val(),
		password:$('#pass').val(),email:$('#email').val(),zipcode:$('#zipcode').val()};
	    insUser.addFieldsAsJSONArray([newUser]);
		args.push(insUser);
		$.ajaxCall(args, function(response){
	        if(response){
	            $.log('user_id: ' + response[0].nodes.id);
	            if(response[0].nodes.id != null){
	            	$.log('user_id: ' + response[0].nodes.id);
	            	$('#title').text('Thank you!');
	            	$('#formcell').html('<div id="regconf"><br/>Your account has been created.<br/> <br/>We sent you an email to confirm you own ' + 
	            			'the email address that you entered. ' +
	            			'<br/><br/>Please click on the "Confirm" link in the email to complete registration.</div>');
	            	$('.gridContent').append('<div class="row"><div class="cell2 signinLeftContent"><button id="okButton" type="submit">OK</button></div><div class="cell">&nbsp;</div></div>')
	            	//$('#butcell').html('<button id="okButton" type="submit">OK</button>');
	            	$("#okButton").click(function(){
	            		if($.getUrlVar('goto') != null)
	            			window.location = decodeURIComponent($.getUrlVar('goto'));
	            		else
	            			window.location = "/";
	            	});
	            }
	        }
	    });
	};
	
	function checkEmail() {
	    var args = [];
	    var check = $.payload.newOper(12);
	    check.addParams({"email":{"value":$('#email').val()}});
		args.push(check);
		$.ajaxCall(args, function(response ) {
	        if(response){
	            //$.log('resp: ' + response.length);
	            if(response.length > 0){
	                $('#errorMsg').text("The Email address already exists.");
	                $('#emaillabel').css('color', 'red');
	                return false;
	            }else{
	                submitUser();
	            }
	        }
	    });    
	}

	
	
}) (jQuery, $.reg);	




function validate(){
    //1. check if required fields are not empty
    var errormsg = '';
    $('#formcell input[required= "true"]').each(function(){
        if($(this).val().length == 0){
            errormsg = 'The fields in Red are Required.';
            $('#' + this.id + 'label').css('color', 'red');
        }else{
            $('#' + this.id + 'label').css('color', 'black');
        }
    });
    //2. password validation
    if(!($('#pass').val() == $('#confpass').val())){
        if(errormsg.length == 0)
            errormsg = '"Password" and "Confirm Password" need to match.';
        $('#passlabel').css('color', 'red');
        $('#confpasslabel').css('color', 'red');
    }else{
        $('#passlabel').css('color', 'black');
        $('#confpasslabel').css('color', 'black');
    }

    if(!($('#pass').val().length >=6)){
        if(errormsg.length == 0)
            errormsg = 'Password length should be at least 6 characters.';
        $('#passlabel').css('color', 'red');
        $('#confpasslabel').css('color', 'red');
    }else{
        $('#passlabel').css('color', 'black');
        $('#confpasslabel').css('color', 'black');
    }

    if(errormsg.length > 0) {
        $('#errorMsg').text(errormsg);
        return false;
    }
    return true;
}