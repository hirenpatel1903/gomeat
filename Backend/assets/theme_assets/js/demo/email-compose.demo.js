/*
Template Name: STUDIO - Responsive Bootstrap 4 Admin Template
Version: 1.3.0
Author: Sean Ngu
Website: http://www.seantheme.com/studio/
*/

var handleRenderSummernote = function() {
	var totalHeight = ($(window).width() >= 767) ? $(window).height() - $('.summernote').offset().top - 63 : 400;
	$('.summernote').summernote({
		height: totalHeight
	});
};


/* Controller
------------------------------------------------ */
$(document).ready(function() {
	handleRenderSummernote();
});