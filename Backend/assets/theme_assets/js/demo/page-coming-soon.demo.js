/*
Template Name: STUDIO - Responsive Bootstrap 4 Admin Template
Version: 1.3.0
Author: Sean Ngu
Website: http://www.seantheme.com/studio/
*/

var handleRenderCountdownTimer = function() {
	var newYear = new Date();
	newYear = new Date(newYear.getFullYear() + 1, 1 - 1, 1);
	$('#timer').countdown({until: newYear});
};


/* Controller
------------------------------------------------ */
$(document).ready(function() {
	handleRenderCountdownTimer();
});