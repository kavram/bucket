function lp() {
    $.log('start setup signin');
	//if($.getUrlVar('goto') != null){
	//	$("#login").attr("href" ,"/register?goto=" + $.getUrlVar('goto'));
	//}
    var metaReq = "payload=[{'oper':'get','type':'ObjectMeta','name':'user'}]";
    $.sendXHR('/metadata', metaReq,'post','json',function(response ) {
        $('body').data('usermeta',response[0].nodes);
        $('body').css('overflow-x','hidden');
        adjustPage();
    });
}

function adjustPage() {
    var adj = function() {
        if ($.browser.msie) {
        	var contheight = $('#container').height();
        	contheight = contheight - 55;
        	$('#regformtd').css('height', contheight);
        }
        else{
            $('#containerTable').height($('#container').height());
            $('#containerTable').css('height',$('#container').css('height'));
            $('#containerTable').width($('#container').width());
            $('#containerTable').css('width',$('#container').css('width'));
        }            
        $('#containerTable').width($('#container').width());
        $('#containerTable').css('width',$('#container').css('width'));
        
    //    $('#containerTable td:first form').height($('#containerTable td:first').height())
    }
    adj();
    $(window).resize(function() {
        adj();
    })
}
