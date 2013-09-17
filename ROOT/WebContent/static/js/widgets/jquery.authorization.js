(function($){
	$.auth = function(){};
	
	var html = {
			no : 'Thank you for your response.<br> Your email has been removed from the system.',
			yes : 'Thank you for your confirmation!<br> You account is active now. You can submit your orders, share offers you like with your friends, and enjoy great discounts.' 
	};
	
	$.auth.init = function(){
		$('#title').html(user.length == 0 ? html.no : html.yes);
	};

})(jQuery);	