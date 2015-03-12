
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


});
