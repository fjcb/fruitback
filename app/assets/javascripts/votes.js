
$("#vote").on("click", "button", function(){
	$this = $(this);
	$.ajax({
		type: "post",
		dataType: "json",
		url: $this.parent().data("uri"), 
		success: function(data) {
			$("#score").html(data.score);
			$this.parent().children().toggle();
		}
	});
});
