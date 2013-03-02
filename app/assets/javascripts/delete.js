
$('.delete').click(function(){
	
	if($(this).val() == "Delete") {
		// reset other buttons
		$('.delete')
			.val("Delete")
			.removeClass('btn-primary')
			.addClass('btn-danger');
		
		$(this)
			.val("Are you sure?")
			.removeClass('btn-danger')
			.addClass('btn-primary');
		
		return false;
	}
	
})
