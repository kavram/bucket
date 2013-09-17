var content;
(function($, undefined) {

	$.widget("ui.upmileTooltip", {  
		// default configuration properties
		options : {	
			xOffset: 10,		
			yOffset: 25,
			tooltipId: 'upmileTooltip',
			clickRemove: false,
			content: '',
			titleHeader:'',
			useElement: '',
			imageUrl:null
		},
		_create : function() {
			var self=this;
			var title = $(self.element).attr("title");				
			$(self.element).hover(function(e){											 							   
					content = (self.options.content != "") ? self.options.content : title;
					content = (self.options.useElement != "") ? $('#' + self.options.useElement).html() : content;
					$(self.element).attr("title","");									  				
					if (content != "" && content != undefined){	
						var image=(self.options.imageUrl && self.options.imageUrl .length>0) ?'<img src="'+self.options.imageUrl+'"/>':'';
						//$('body').append('<div id="'+ self.options.tooltipId +'"> <h3></h3><img src="/static/images/test2.png"/><p>'+ content +'</p></div>');		
						$('body').append('<div id="'+ self.options.tooltipId +'"><h3>'+self.options.titleHeader+'</h3>'+image+'<p class="ui-icon-info">'+ content +'</p></div>');		
						$('#' + self.options.tooltipId)
							.css("position","absolute")
							.css("top",(e.pageY - self.options.yOffset) + "px")
							.css("left",(e.pageX + self.options.xOffset) + "px")						
							.css("display","none")
							.fadeIn("fast");
					}
				},
				function(){	
					$('#' + self.options.tooltipId).remove();
					$(self.element).attr("title",title);
				});	
				$(self.element).mousemove(function(e){
					$('#' + self.options.tooltipId)
						.css("top",(e.pageY - self.options.yOffset) + "px")
						.css("left",(e.pageX + self.options.xOffset) + "px")	;				
				});	
				if(self.options.clickRemove){
					$(self.element).mousedown(function(e){
						$('#' + self.options.tooltipId).remove();
						$(self.element).attr("title",title);
					});				
				}
		},
		
		_init : function() {
			//$.log("widgets.upmileTooltip  _init");
		},
		destroy : function() {
			//$.log("widgets.upmileTooltip  destroy");
			$.Widget.prototype.destroy.apply(this, arguments);
		}
});

	$.extend($.ui.upmileOffer, {
		version : "1.1.0"
	});

})(jQuery);