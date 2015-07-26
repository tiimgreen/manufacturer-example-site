// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.btn-address-toggle').on('click', function(e) {
  e.preventDefault();

  $('.address').hide();
  $("#" + $(this).attr('data-target')).show();
});
