
$(function() {
	
	$('.check_email #user_password').closest('div').hide();
	$('.check_email #user_name').closest('div').hide();
	
	$('.check_email #user_email').keyup(function() {
		
		if(keyup_mutex)
			window.clearTimeout(keyup_mutex);
		
		email = $(this).val();
		
		keyup_mutex = window.setTimeout(check_email, 500);
	});
	
	$('.check_email #user_email').delay(2000).keyup();
});

var email;
var keyup_mutex;

function check_email() {
	if(!email) {
		$('.check_email #user_name').closest('div').fadeOut();
		$('.check_email #user_password').closest('div').fadeOut();
		return;
	}
	
	$.getJSON( "/profiles/check", { email: email },
		function(data) {
			var d = $.parseJSON(data);
			if(d === true) {
				$('.check_email #user_name').closest('div').hide();
				$('.check_email #user_password').closest('div').fadeIn().focus();
			} else {
				$('.check_email #user_password').closest('div').hide();
				$('.check_email #user_name').closest('div').fadeIn().focus();
			}
		}
	);
}