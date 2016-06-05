$(document).ready(function() {

  $('.table-row-link').on('click', function() {
    window.document.location = $(this).data('url');
  })

})