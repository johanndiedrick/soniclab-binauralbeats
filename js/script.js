
$("document").ready(function(){

	$('a#hello_link').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#me").offset().top
		}, 2000);
		return false;	
	});

	
	$('a#me_link').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#overview").offset().top
		}, 2000);
		return false;	
	});
	
	$('a#overview-link').click(function(){
		
		$('html, body').animate({
			scrollTop: $("div#binaural-beats").offset().top
		}, 2000);
		return false;
	});

	$('a#binaural-beats-link').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#youtube-explaination").offset().top
		}, 2000);
		return false;	
	});

	
	$('a#youtube-explaination-link').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#question").offset().top
		}, 2000);
		return false;	
	});
	
	$('a#question-link').click(function(){
		
		$('html, body').animate({
			scrollTop: $("div#programming").offset().top
		}, 2000);
		return false;
	});
	$('a#programming-link').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#coreaudio").offset().top
		}, 2000);
		return false;	
	});

	
	$('a#coreaudio-link').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#audiounits").offset().top
		}, 2000);
		return false;	
	});
	
	$('a#audiounits-link').click(function(){
		
		$('html, body').animate({
			scrollTop: $("div#start").offset().top
		}, 2000);
		return false;
	});

	$('a#start-link').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#references").offset().top
		}, 2000);
		return false;	
	});

	
	$('a#references-link').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#thank-you").offset().top
		}, 2000);
		return false;	
	});
	
});
