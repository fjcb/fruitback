


$("#vote").on("click", "button", function(){
	$this = $(this);
	$.ajax({
		url: $this.parent().data("uri"), 
		dataType: "json",
		success: function(data) {
			$("#score").html(data.score);
			$this.parent().children().toggle();
		}
	});
});