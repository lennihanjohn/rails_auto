// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require sweetalert2
//= require jquery
//= require jquery_ujs
//= require popper
//= require material/bootstrap-material-design
//= require material/perfect-scrollbar.jquery.min
//= require material/chartist.min
//= require material/arrive.min
//= require material/bootstrap-notify
//= require material/material-dashboard
//= require material/demo
//= require cable
//= require jquery.timepicker.js


//Override the default confirm dialog by rails
$.rails.allowAction = function(link){
    if (link.data("confirm") == undefined){
      return true;
    }
    $.rails.showConfirmationDialog(link);
    return false;
  }
  
  //User click confirm button
  $.rails.confirmed = function(link){
    link.data("confirm", null);
    link.trigger("click.rails");
  }
  