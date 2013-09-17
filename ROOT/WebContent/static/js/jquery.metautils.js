(function($){
	var meta;
	$.loadMeta = function(objects){
		var str = 'payload=[';
		$.each(objects, function(ind, item){
			if(ind >0)
				str += ',';
			str += '{"oper":"get","type":"object",' + '"on":"' + item.on + '","nodes":[' + item.nodes + ']}';
		});
		str += ']';
	    $.sendXHR('/metadata', str,  function(response) {
	    	meta = response;
	    });		
	};
	
	$.objMeta = function(obj, node, prop, pvalue){
		var ret = null;
		$.each(meta, function(ind, item){
			//$.log('name: ' + meta[ind].on);
			if(this.on == obj){
				ret = this.nodes;
				if(node != undefined){
					$.each(ret, function(ind, item){
						if(this.name == node){
							ret = this;
				//			$.log('node: ' + this.name);
							if(prop != undefined){
								$.each(ret.props, function(key, vl){
									if(key == prop){
					//					$.log('key: ' + key);
										ret = vl;
										if(pvalue != undefined){
											$.each(ret, function(key, vl){
						//						$.log('this.name: ' + this.name);
												if(this.name == pvalue){
													ret = this.value;
													return false;
												}
											});
										}
										return false;
									}
								});
							}
							return false;
						}
					});
				}
				return false;
			}
		});
		return ret;
	};
	
})(jQuery);