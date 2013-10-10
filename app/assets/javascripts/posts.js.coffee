# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$('.show_hide').click ->
		post = $(this).data("post")
		$(".post_media[data-post=#{post}]").slideToggle(1000);
