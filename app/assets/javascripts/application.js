// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

//for flash messages
var notice= '<%= flash[:notice] %>'
var success= '<%= flash[:success] %>'
var warning= '<%= flash[:warning] %>'
var error= '<%= flash[:error] %>'
if(notice)
	FlashNotice("notice", notice);
else if(success)
	FlashNotice("success", success);
else if(warning)
	FlashNotice("warning", warning);
else if(error)
	FlashNotice("notice", error);
