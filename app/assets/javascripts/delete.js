
$('.delete').click(function() {
	$this = $(this);
	
	if($this.val() == "Delete") {
		// reset other buttons
		$('.delete')
			.val("Delete")
			.removeClass('btn-primary')
			.addClass('btn-danger');
		
		$this
			.val("Are you sure?")
			.removeClass('btn-danger')
			.addClass('btn-primary');
		
	} else {
		if(!$this.hasClass('ajax'))
			return true
		
		$this.val("Deleting...")
		
		$.ajax({
			type: "delete",
			dataType: 'json',
			url: $this.closest('form').attr('action'),
			success: function(data) {
				if(data.success) {
					$this.closest('.posting').fadeOut();
				}
			},
			error: function() {
				$this.val("Sorry, an error occured.")
			}
		});
	}
	
	return false;
});
