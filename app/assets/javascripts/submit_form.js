var status;

$(document).ready(function() {
  $('#tips').hide();
  status = "hidden";

  $('#show-tips').on('click', function(event) {
    toggleTips();
  })
})

var showTips = function() {
  $('#tips').fadeIn(500);
  $('#show-tips').html('<small>Hide tips</small>');
}

var hideTips = function() {
  $('#tips').fadeOut(500);
  $('#show-tips').html('<small>Show tips</small>');
}

var toggleTips = function() {
  if (status == "hidden") {
    status = "shown";
    showTips();
  } else if (status == "shown") {
    status = "hidden";
    hideTips();
  } else {
    console.log("Error toggling tips. Status invalid: " + status)
  }
}

