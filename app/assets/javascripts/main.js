function before_submit(){
	var url = document.getElementsByName('long_url')[0].value;

	if(url == "" || /^\W+$/.test(url)){
		$(".alert-box").css('display', 'none');
		$('#error-msg').css('display', 'block').addClass('alert-box');
		$('#error-msg')[0].innerHTML = 'Do you think that the given URL is valid? <a href="#" class="close">×</a>';
		return false;
	}		
	return true;	
};

function redirect() {
	location.href = '/links';
}

$(function(){

	var options = {
	  map: ".map_canvas",
	  location: $.cookie("location")
	};

	$("#location").geocomplete(options);

});


