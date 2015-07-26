// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.shop-description-product ul li, .shop-long-description-product ul li').each(function() {
  var $this = $(this);

  $this.prepend('<i class="fa fa-check"></i> ');
});
