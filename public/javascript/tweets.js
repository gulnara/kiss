$('.tweets').on('click', 'button', function(){
	$(this).closest('.tweets').find('.tweet').slideDown();
});