(function( $ ){

	var headHtml = {
		signin : '<a href="/signin">Sign In</a><a href="/register">Register</a>',
		myaccount : '<a href="/myaccount">Welcome, user</a>',
		myorders : '<a href="/myorders">My Orders</a>',
		bizreg : '<a href="/biz-register">Merchant?Register</a>',
		myoffers : '<a href="/myoffers">My Offers</a>',
		newoffer : '<a href="/new-offer">New Offer</a>',
		signout : '<a id="signout" href="/signout">Sign Out</a>'
	};
	
	$.header = function() {};
	
	$.header.init = function(items) {
		for(var i = 0; i < items.length; i++){
			if(items[i] == 'myaccount' && user.length > 0)
				$('.account').append(headHtml.myaccount.replace('user', user[0].nodes.first_name));
			else if(items[i] == 'myaccount' && user.length == 0)
				$('.account').append(headHtml.signin);
			else if(items[i] == 'myorders' && user.length > 0)
				$('.account').append(headHtml.myorders);
			else if(items[i] == 'bizreg' && user.length > 0 && user[0].nodes.biz_owner == 1)
				$('.account').append(headHtml.bizreg);
			else if(items[i] == 'myoffers' && user.length > 0 && user[0].nodes.biz_owner == 2)
				$('.account').append(headHtml.myoffers);
			else if(items[i] == 'newoffer' && user.length > 0 && user[0].nodes.biz_owner == 2)
				$('.account').append(headHtml.newoffer);
			else if(items[i] == 'signout' && user.length > 0)
				$('.account').append(headHtml.signout);

		}
		$('.header_icon').click(function(){window.location = "/";}); 
	};
	
})(jQuery);
