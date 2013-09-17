(function( $, undefined ) {
    // usage :   $("div p").debug();
    $.fn.debug = function() {
        return this.each(function(){
            if(window.console && console === undefined ) {
                console.debug(this);
            } else {
                alert(this);
            }
        });
    };
    /* usage :
    try {
        // do some error prone stuff
    } catch(exception) {
        $.log(exception);
    }
     */
    $.log = function(message) {       
        if(window.console && (($.browser.msie && !console === undefined) || (!$.browser.msie ))) {
            console.debug(message);
        } else {
    //alert(message);
    }
    };
    $.getNumberOfWeeksInMonth=function(/*Date*/ date) {
        var firstDayInMonth=new Date(date.getFullYear(),date.getMonth(), 1);
        var firstDayInNextMonth=(new Date (firstDayInMonth)).addMonths(1);
        var sundaysNum=1;

        while(firstDayInNextMonth.compareTo(firstDayInMonth)>0){
            if(firstDayInMonth.getDay() == 0){
                sundaysNum++;
            }
            firstDayInMonth = (new Date (firstDayInMonth)).addDays(1);
        }
        return sundaysNum;
    };
    $.renderTimeView=function( /* String */ parentNodeId){
        var n=24;
        for(var i = 0; i < n; i++){
            var id="calendar_day_time_"+i;
            $('#'+parentNodeId).append('<div id="'+id+'" class="calendar_day_time"></div>');
            var h=$.getCssNumber(id,'height');           
            dojo.marginBox($('#'+id).get(0),{
                t: (h+1) *i
            });
            h=(dojo.isIE)?h:h+1;
            $('#'+id).html($.time24To12(i)).css("top", h*i).attr('ind',i);
        }
        dojo.marginBox(dojo.byId(parentNodeId),{
            h:dojo.marginBox(dojo.byId('calendar_day_time_'+(n-1))).h*n
        });
    };

    $.time24To12=function(i/* number from 0 to 24*/){
        var time = "";
        if(i == 0)
            time = "12 AM";
        else if(i > 0 && i < 12)
            time = i + " AM";
        else if(i == 12)
            time = "12 PM";
        else if(i > 0 && i > 12)
            time = i - 12 + " PM";
        return time;
    };
    $.renderDayView=function(/* String */ parentNodeId){
        var off = ($.getCssNumber("calendar_day_time_1",'top')-$.getCssNumber("calendar_day_time_0",'top'))/2,diff=(dojo.isIE)?0.4*off-2:2;
        $('.calendar_day_time').each(function( ){
            var i=$('#'+this.id).attr('ind'),displayValue=$.time24To12(i), amPM=displayValue.substring(displayValue.length-2);
            $('#'+parentNodeId).append('<div id="calendar_hour_line_'+i+'" class="calendar_hour_line"></div>');
            var t=$.getCssNumber( this.id,'top');           
            $('#calendar_hour_line_'+i).css("top", (dojo.isIE)?t -16:t-diff).attr("displayValue", $.trim(displayValue.substring(0,displayValue.length-2))+':00 '+amPM).css('width','100%');
            $('#'+parentNodeId).append('<div id="calendar_half_hour_line_'+i+'" class="calendar_half_hour_line"></div>');
            $('#calendar_half_hour_line_'+i).css("top", (dojo.isIE)?t+diff:t+off).css("width", '100%').attr("displayValue",$.trim(displayValue.substring(0,displayValue.length-2))+':30 '+amPM);
        });
    };
    $.getTheClosestToCoord=function(/*array*/classnames, /* string 'y' or'x' */coordType, /*number*/coord, /*boolean*/before){
        /* return closest node from the classnames array to coord if  'before' is true the return node is before coord */
        $.log('util.Utils.getTheClosestToCoord');        
        var min=-1, closestNode= '';
        $.each(classnames,function (indexInArray, valueOfElement) {
            $(valueOfElement).each(function(){                
                var p=$('#'+this.id).position(), val=(coordType=='y')?p.top:p.left;
                // $.log(this.id +  '    '  +coord+'          '+val+'          '+(val-coord));
                var diff=Math.abs(coord-val);
                if((min==-1 || min>diff) && ( !before || ( before && coord>val)) ){
                    min=diff;
                    closestNode= this;
                }
            });
        });
        //$.log(closestNode.id);
        return closestNode.id;        
    };
    $.getCssNumber=function(/* String or query (with $ sign) */ query, /* String */property, /* String */dim){        
        if(typeof query == "string") query=$('#'+query);
        dim=(!dim) ?"px":dim; 
        var val=$.trim(query.css(property).split( dim )[0]);
        return parseFloat(val,10);
    };
    /*$.createProgressBar=function(count) {
        //$.log('util.Utils.createProgressBar');
        if( $("#progressbar").length==0)
            $("#apps").append('<div id="progressbar" style="position:absolute;left:20%;top:50%;width:50%;z-index:3500"></div>');
        count=(!count)?37:count;
        $("#progressbar").progressbar({
            value: count
        });
    };
    $.changeProgressBar=function(count) {
        if ($( "#progressbar" ).progressbar( "option", "value" )<100)
            $("#progressbar").progressbar({
                value: count
            });
    };
    $.closeProgressBar=function() {
        $("#progressbar").progressbar("destroy").remove();
    };*/
    $.sendXHR=function(url, data, dataType, successFunction) {
    	var pUrl = url;
    	$.log('pUrl: ' + pUrl);
        var args = {
            url: pUrl,
            data: data,
            dataType: dataType,
            timeout:  25000,
            type: 'POST',
            success: successFunction,
            error: function(xhr, textStatus, errorThrown){
                $.log('ajax error :'+textStatus);
                $.removeWaitAjax();
            }
        };
        try{
            $.log(url +' : '+ data);
            $.ajax(args);
        }catch(e){
            $.log(e);
        }
    };
    $.populateComboBoxTime=function(/* String*/nodeId,firstDisplayedValue){
        var collection=[
        '12:00 AM','12:30 AM','1:00 AM','1:30 AM','2:00 AM','2:30 AM','3:00 AM','3:30 AM','4:00 AM','4:30 AM','5:00 AM', '5:30 AM',
        '6:00 AM', '6:30 AM', '7:00 AM', '7:30 AM', '8:00 AM', '8:30 AM', '9:00 AM','9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
        '12:00 PM','12:30 PM','1:00 PM','1:30 PM','2:00 PM','2:30 PM','3:00 PM','3:30 PM','4:00 PM','4:30 PM','5:00 PM', '5:30 PM',
        '6:00 PM', '6:30 PM', '7:00 PM', '7:30 PM', '8:00 PM', '8:30 PM', '9:00 PM','9:30 PM', '10:00 PM', '10:30 PM', '11:00 PM', '11:30 PM'
        ];
        $.populateComboBoxData(nodeId,collection,firstDisplayedValue);
    };
    $.populateComboBoxWeekday=function(/* String*/nodeId,firstDisplayedValue){
        var collection=[
        'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
        ];
        $.populateComboBoxData(nodeId,collection,firstDisplayedValue);
    };
    $.populateComboBoxDuration=function(/* String*/nodeId,firstDisplayedValue){
        var collection=[
        '00:15','00:30','00:45','01:00','01:15','01:30','01:45','02:00','02:15','02:30','03:00'
        ];
        $.populateComboBoxData(nodeId,collection,firstDisplayedValue);
    };
    $.populateComboBoxStates=function(/* String*/nodeId, firstDisplayedValue){
        var str = "payload=[{'type':'TypeMeta','name':'state'}]";
        var respHandler=  function(response ) {
            $.populateComboBoxData(nodeId, response[0].values, firstDisplayedValue);
        }
        $.sendXHR('/metadata', str, 'post', 'json', respHandler, null);
    };

    $.selectComboBoxData=function(/* String*/nodeId,value){
        $.log("jquery.utils.selectComboBoxData  value"+value);
        if(typeof value!='undefined' && value!=null){
            $('#'+nodeId).each(function(item){
                if(item.text==value || item.value==value) item.selected=true;
            })
        }
    };
    $.populateComboBoxData=function(/* String */nodeId,collection,firstDisplayedValue){
        $.log("jquery.utils.populateComboBoxData nodeId="+nodeId+"   firstDisplayedValue="+firstDisplayedValue);
        /*  node is id of select object or domnode
         *  collection is array of strings or array of objects with the properties (name or displayLabel) and value
         *  firstDisplayedValue - null or string , e.g. 'Select' */
        
        if(firstDisplayedValue){
            $('#'+nodeId).get(0).options[0] = new Option(firstDisplayedValue,firstDisplayedValue);
        }
        $.each(collection,function(){
            if((this.name || this.label) && this.value)
                $('#'+nodeId).get(0).options[ $('#'+nodeId).get(0).options.length] = new Option((this.label)?this.label:this.name,this.value);
            else
                $('#'+nodeId).get(0).options[ $('#'+nodeId).get(0).options.length] = new Option(this,this);
        });
    };
    $.setCookie=function( name,value,expiredays){
        var expires = "";
        if (expiredays) {
            var date = new Date();
            date.setTime(date.getTime()+(expiredays*24*60*60*1000));
            expires = "; expires="+date.toGMTString();
        }
        document.cookie = name+"="+value+expires+"; path=/";
    };
    $.getCookie=function(name){
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
        }
        return null;
    };
    $.eraseCookie=function(name) {
        $.setCookie(name,"",null);
    };
    
    $.createMessageDialog=function(message,title,width, height){   	
        $("#messageDialog").dialog("destroy");
        $('body').append('<div id="messageDialog"></div>');
        $("#messageDialog").html('<p>'+message+'</p>').dialog({
            title:(title)?title:'',
            height: (height)?height:250,
            width:(width)?width:350,
            modal: true,
            close: function() {
                $('#messageDialog').remove();
            },
            buttons: {
                "Ok": function() {
                    $(this).dialog("close");
                }
            }
        });       
    };
    $.createAlertDialog=function(message,title,width, height){
    	$("#alertDialog").dialog("destroy");
        $('body').append('<div id="alertDialog"></div>');
        $("#alertDialog").html('<p>'+message+'</p>').dialog({
            title:(title)?title:'',
            height: (height)?height:130,
            width:(width)?width:220,
            close: function() {
                $('#alertDialog').remove();
            }
        });  
    };
    
  /*  $.onResizeWindow=function() {
        $(window).resize(function() {
            try{
                $('#container').css('width',($.getCssNumber($('body'),'width')<920) ?920:'100%');
                $('#containerTable' ).css('height',$('#container').height());
                //$('#appContent').height(Math.max(630, $('#apps').height()-$('#appsHeader').height()));
                //$('.bigCalendar').css('height','86%');
                $('#tabs').height($('.ui-tabs-nav').height()+$('.ui-tabs-panel').height()+3).css('background-color','white');
                if($('#calendar_navigation')) $('#calendar_body').width($('#calendar_navigation').width()).css('width',$('#calendar_navigation').css('width'));

                if(dojo.isIE){
                    $('#appsHeader').css('min-width',850);
                    $('#appsHeader').css('width',Math.max(850,$('#apps').width()));
                    $('#headLinks').css('width',300);
                    $('#timeCell').width(34).css('width','34px');
                    $('#calendar_body').css('width','99%');
                    $('#appContent').width($('#apps').width()).css('width',$('#apps').css('width'));
                    $('#calendar_cell_holder').width($('#gridCell').width());
                }
                else{
                    $('#appContent').height( $('#apps').height()-$('#appsHeader').height()-$('.companyinfo').height()-20);
                    $('.bigCalendar').css('height','86%');
                    $('.ui-tabs-panel').height($('.bigCalendar').height()-$('.ui-tabs-nav').height());
                    $('.ui-widget-content').css({
                        'border': '1px solid #aaaaaa',
                        'background': "#ffffff url('/res/css/smoothness/images/ui-bg_flat_75_ffffff_40x100.png') 50% 50% repeat-x",
                        'color': '#222222'
                    })
                }
                $('#tablebody').resize();
            }catch(e){
                $.log(e);
            }
               
        });
    };*/
     
    $.createWaitAjax=function() {
        $('body').append('<div id="ajaxwait" class="ui-corner-all"></div>');
        $('#ajaxwait').css('left',($('body').width()-$('#ajaxwait').width())/2).css('top',($('body').height()-$('#ajaxwait').height())/2);
        $('#ajaxwait').load('/res/html_templates/WaitDialog.html',function(){
            $('body').css('overflow-y','hidden');
        });
    };
    $.removeWaitAjax=function() {
        $( "#ajaxwait" ).remove();         
    };
    $.onAjaxEvent=function() {
        jQuery(document).ajaxStart(function(){
            $.createWaitAjax();
        });
        jQuery(document).ajaxStop(function(){
            $.removeWaitAjax();
        });
        jQuery(document).ajaxError(function() {
            $.removeWaitAjax();
        });
    };
    $.formatTimeForDateLib=function(/* String */time) {
        // $.log(time)
    	time=time.toUpperCase();
        if(time.indexOf('PM')>-1 && time.substring(0, 2)=='12')
            time='00'+time.substring(2);
        return time;
    };
    
    $.formatDate = function(/* String */date){
    	date=date.split(' ');
    	var dd = $.trim(date[0]);
    	return Date.parse(dd).toString("MM/dd/yyyy");
    };
    
    $.formatDateForDateLib=function(/* String */date) {
        date=date.split(' ');
        var time='', dd=$.trim(date[0]);
        if (date.length>=2){
        	time=$.trim(date[1]);
        }
        if (date.length==3){
        	time+=' '+$.trim(date[2]);
        	if(time.indexOf('.')>-1){
        		time=Date.parseExact(time.split('.')[0],'H:mm:ss').toString('h:mm tt');
        	}
        		
        }
        return Date.parse(dd).toString("MM/dd/yyyy")+' '+$.formatTimeForDateLib(time);
    };
    $.sortEventsByDateandTime=function (a, b){
        if(Date.parseExact(a.nodes.sd,'yyyy-MM-dd').compareTo(Date.parseExact(b.nodes.sd,'yyyy-MM-dd'))>0)
            return 1;
        if(Date.parse(a.nodes.sd,'yyyy-MM-dd').compareTo(Date.parse(b.nodes.sd,'yyyy-MM-dd'))<0)
            return -1;
        var ast=a.nodes.st, bst=b.nodes.st;
        if(Date.parseExact($.formatTimeForDateLib(ast),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(bst),'h:mm tt'))>0)
            return 1;
        if(Date.parseExact($.formatTimeForDateLib(ast),'h:mm tt').compareTo(Date.parseExact($.formatTimeForDateLib(bst),'h:mm tt'))<0)
            return -1;
        return 0;
    };
    
    $.ecapeString=function(/* String */str) {
        var regx = /\'/g;       
        str = str.replace(regx, "`");
        var _escapeable = /["\\\x00-\x1f\x7f-\x9f]/g;
        var _meta = {
            '\b': '\\b',
            '\t': '\\t',
            '\n': '\\n',
            '\f': '\\f',
            '\r': '\\r',
            '"' : '\\"',           
            '\\': '\\\\'
        };
        if (str.match(_escapeable)){            
            return   str.replace(_escapeable, function (a){
                var c = _meta[a];
                if (typeof c === 'string') return c;
                c = a.charCodeAt();
                return '\\u00' + Math.floor(c / 16).toString(16) + (c % 16).toString(16);
            })  ;
        }        
        return str;
    };
    $.endsWith = function(/* String */str,/* String */pattern) {
        return (str.match(pattern+"$")==pattern);
    };
    $.startsWith = function(/* String */str,/* String */pattern){
        return (str.match("^"+pattern)==pattern);
    };
    $.stripTags=function(/* String */str) {
        return str.replace(/<\/?[^>]+>/gi, '');
    };
    $.spaceString=function(/* String */str) {
        return (str==null || str=='')?' ':str;
    };
    $.printObject=function(object){
        var output = '';
        for (var property in object) {
            //alert(property);
            // if(property.substring('Y')>-1)
            output += property + ': ' + object[property]+'   |||   ';
        }
        alert(output);
    };
    $.countLines = function (textarea){
      var text = textarea.value.replace(/\s+$/g,"");
      return text.split("\n").length;
    };
 // getPageScroll() by quirksmode.com
    $.getPageScroll= function() {
        var xScroll, yScroll;
        if (self.pageYOffset) {
          yScroll = self.pageYOffset;
          xScroll = self.pageXOffset;
        } else if (document.documentElement && document.documentElement.scrollTop) {
          yScroll = document.documentElement.scrollTop;
          xScroll = document.documentElement.scrollLeft;
        } else if (document.body) {// all other Explorers
          yScroll = document.body.scrollTop;
          xScroll = document.body.scrollLeft;
        }
        return new Array(xScroll,yScroll);
    };

    

/* calculate time  var start = (new Date).getTime();  ...    var diff = (new Date).getTime() - start;  $.log(diff+'  msec = '+ diff/1000+'sec'); */

})(jQuery);