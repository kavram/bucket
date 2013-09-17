$.extend( {
    getUrlVars : function() {
        var vars = [], hash;
        var hashes = window.location.href.slice(
            window.location.href.indexOf('?') + 1).split('&');
        for ( var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            if (hash[1]) {
                var ind = hash[1].indexOf('#');
                vars[hash[0]] = (ind == -1) ? hash[1] : hash[1].substring(0,ind);
            }
            else
                vars[hash[0]] = hash[1];
        }
        return vars;
    },
    getUrlVar : function(name) {
    	if(name == 'goto'){
    		var ind = window.location.href.indexOf('goto');
    		//$.log('ind: ' + ind);
    		if(ind > 0){
    			var param = window.location.href.substring(ind + 5, window.location.href.length);
    			//$.log('goto param: ' + param);
    			return param;
    		}
    	}else
    		return $.getUrlVars()[name];
    },
    
    getArrayElementValue : function(array, name){
    	var value = '';
        $.each(array, function() {
            if(this.name = name){
            	value = this.value;
            }
        });
        return value;
    }
});

function getURL(){
	var spl = window.location.href.split("?");
	return spl[0];
}

