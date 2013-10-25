# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$('.show_hide').click ->
		post = $(this).data("post")
		$(".post_media[data-post=#{post}]").slideToggle(1000);
	$('.drop').click ->
		post = $(this).data("post")
		$(".post_media[data-post=#{post}]").slideToggle(1000);

$ ->
	$("#post_filter_list").change ->
		val = $(this).val()
		$('.form_video, .form_written, .form_image, .form_twitter, .form_audio').hide()
		$('.form_'+val).show(800)
