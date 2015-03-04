
$("document").ready(function(){

	$('a#hello').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#me").offset().top
		}, 2000);
		return false;	
	});

	
	$('a#me').click(function(){
	
		$('html, body').animate({
			scrollTop: $("#overview").offset().top
		}, 2000);
		return false;	
	});
	
	$('a#overview').click(function(){
		
		$('html, body').animate({
			scrollTop: $("div#hello").offset().top
		}, 2000);
		return false;
	});


});
