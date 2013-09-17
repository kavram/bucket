(function($){
	$.payload = function(){};
	
	$.ajaxCall = function(){
		var str = "payload=" + JSON.stringify(arguments[0]) + '&datatype=';
		$.log('arguments.length: ' + arguments.length);
		if(arguments.length == 3){
			str += arguments[1];
			$.sendXHR('/content', str, arguments[1],  arguments[2]);
		}else{
			str += 'json';
			$.sendXHR('/content', str, 'json',  arguments[1]);
		}
	};
})(jQuery);

(function($, $pl){
	$pl.newOper = function(operId){
		var newOp = new Object();
		var payload = {id:operId, parameters:{},fields:{}};
		$.extend(newOp, $pl);
		$.extend(newOp, payload);
		return newOp;
	};
	$pl.addParams = function(){
		var thiz = this;
		for(var i = 0; i < arguments.length; i++){
			$.extend(thiz.parameters, arguments[i]);
		}
		return this;
	};
	$pl.addFields = function(flds){
		var thiz = this;
		$.each(arguments, function(){
			$.extend(thiz.fields, this);
		});
		return this;
	};
	$pl.addFieldsAsJSONArray = function(flds){
		this.fields = flds; 
		return this;
	};

})(jQuery, $.payload);



