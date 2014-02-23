var VIPBiteWeb = VIPBiteWeb || {};

VIPBiteWeb = function($, window, document)
{
	function saveMenuLocation()
	{
		var base = window.location.origin + '/';

		if(base === window.location.href)
		{
			localStorage.setItem("whoWeAre", ($("#whoWeAre").offset().top - 130));
			localStorage.setItem("contactUs", ($("#contactUs").offset().top - 130));
		}
	}

	function scrollToTag(tags)
	{
		var base = window.location.origin + '/';

		if(base != window.location.href)
		{
			localStorage.setItem("scrollTo", tags);
			window.location.replace("/");
		}
		else
		{
			$('html, body').animate({ scrollTop: localStorage.getItem(tags) }, 500);
			localStorage.removeItem("scrollTo");
		}

		return false;
	};

	return {
		ScrollToTag : scrollToTag,
		SaveMenuLocation : saveMenuLocation
	}
}(jQuery, window, document);