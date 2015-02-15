
$(document).ready(function(){

	// hide #back-top first
	$("#back-top").hide();
	// $('#back-top').fadeIn();
	
	// fade in #back-top
	$(function () {
		$(window).scroll(function () {
			if ($(this).scrollTop() > 100) {
				$('#back-top').fadeIn();
			} else {
				$('#back-top').fadeOut();
			}
		});

		// scroll body to 0px on click
		$('#back-top').click(function () {
			$('body').animate({
				scrollTop: 0
			}, 800);
			return false;
			
		});
	});

});
