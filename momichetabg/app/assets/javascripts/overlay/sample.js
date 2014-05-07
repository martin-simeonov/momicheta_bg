jQuery(document).ready(function($) {
	$('.vote-photo').hover(function() {
		$(this).find('.overlay').stop( true, true ).fadeIn();
	}, function() {
		$(this).find('.overlay').stop( true, true ).fadeOut();
	});
});