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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require_tree .

document.addEventListener("turbolinks:load", function() {
    $('#openModal').click(function() {
        $('#modalArea').fadeIn();
    });
    $('#closeModal , #modalBg').click(function() {
        $('#modalArea').fadeOut();
    });
});


document.addEventListener("turbolinks:load", function() {
    $("#open").on("click", function(e) {
        e.preventDefault();
        $("#overlay, #modal").addClass("active");

        $("#close, #overlay").on("click", function() {
            $("#overlay, #modal").removeClass("active");
            return false;
        });
    });
});