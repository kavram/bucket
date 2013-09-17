function resetpass() {
    //$.log('start setup resetpass');
    var metaReq = "payload=[{'oper':'get','type':'ObjectMeta','name':'user'}]";
    $.sendXHR('/metadata', metaReq, 'post', 'json', function(response ) {
        $('body').data('usermeta',response[0].nodes);
        $('#submitButton').click(submit).button();
        $("#cancelButton").click(function(){
        	if($.getUrlVar('goto') != null)
        		window.location = decodeURIComponent($.getUrlVar('goto'));
        	else
        		window.location = "/";
        }).button();
        $('body').css('overflow-x','hidden');
        adjustContainer();
    })
}

function submit(){
    //$.log('click submit but.');
    startValidate();
}

function continueValidate(){
    if(!validateNewPass())
        return;
    updatePass();
}

function validateNewPass(){
    var errormsg = '';
    if(!($('#newpass').val() == $('#confnewpass').val())){
        if(errormsg.length == 0)
            errormsg = '"Password" and "Confirm Password" need to match.';
        $('#newpasslabel').css('color', 'red');
        $('#confnewpasslabel').css('color', 'red');
    }else{
        $('#newpasslabel').css('color', 'black');
        $('#confnewpasslabel').css('color', 'black');
    }

    if(!($('#newpass').val().length >=6)){
        if(errormsg.length == 0)
            errormsg = 'Password length should be at least 6 characters.';
        $('#newpasslabel').css('color', 'red');
        $('#confnewpasslabel').css('color', 'red');
    }else{
        $('#newpasslabel').css('color', 'black');
        $('#confnewpasslabel').css('color', 'black');
    }
    if(errormsg.length > 0) {
        $('#errorMsg').text(errormsg);
        return false;
    }else
        return true;
}

function updatePass(){
    //$.log('updatePass');
    var str = "payload=[{'oper':'update','object':'user','nodes':" +
    "{'password':'" + $('#newpass').val() + "','status':'" +
    $('body').data('usermeta').status.values.confirmed +
    "'},'parameters':{'id':{'value':'" + $('#sys').attr('uid') + "','op':'='}}}]";
    //$.log('str: ' + str);
    $.sendXHR('/content', str, 'post', 'json', function(response ) {
        if(response.length > 0){
            confirmMessage();
        }
    });
}

function confirmMessage(){
    $('#formcell').replaceWith('<td>Your password has been reset.</td>');
    $('#butcell').replaceWith('<td id="butcell"><button id="okButton" type="submit"' + 
    ' class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" ' +
    ' role="button" aria-disabled="false"><span class="ui-button-text">OK</span></button></td>');
    $("#okButton").click(function(){
        var gotoUrl = $.getUrlVar('goto');
        if(gotoUrl != null)
            window.location = decodeURIComponent(gotoUrl);
        else
            window.location = "/home";
    });
}

function startValidate(){
    var errormsg = '';
    $('#errorMsg').text('');
    $('#regformtd input[required= "true"]').each(function(){
        if($(this).val().length == 0){
            errormsg = 'The fields in Red are Required.';
            $('#' + this.id + 'label').css('color', 'red');
        }else{
            $('#' + this.id + 'label').css('color', 'black');
        }
    })
    if(errormsg.length > 0) {
        $('#errorMsg').text(errormsg);
        return;
    }
    
    var passReq = "payload=[{'oper':'get','object':'user','nodes':['id']," +
    "'parameters':{'id':{'value':'" + $('#sys').attr('uid') + "','op':'='}," +
    "'password':{'value':'" + $('#oldpass').val() + "','op':'='}}}]";
    $.sendXHR('/content', passReq, 'post', 'json', function(response ) {
        if(response.length != 0){
            continueValidate();
        }else{
            $('#errorMsg').text('The Old Password is not correct.');
        }
    })    
}