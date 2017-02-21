$(document).ready(function() {



$('#show-more').on('click', function() {
  var remainingDescription = gon.remaining_description
  event.preventDefault();
  $('#ellipsis').hide();

  $('#remaining-description').show();
  $('#show-less').show();
  $(this).hide()
});
  $('#show-less').on('click', function() {
    var remainingDescription = gon.remaining_description
    event.preventDefault();
    $('#remaining-description').hide();
    $(this).hide()
    $('#show-more').show();
  });
});
