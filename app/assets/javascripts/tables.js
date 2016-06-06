$(document).ready(function() {
  enableTableLinks()
})

var enableTableLinks = function() {
  $('.table-row-link').on('click', function() {
    window.document.location = $(this).data('url');
  })
}

