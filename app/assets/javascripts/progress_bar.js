$(document).ready(function() {

  var remaining = Number($("#progressbar").attr('timeRemainingPercent'))

  if (remaining > 0) {
    $("#progressbar").progressbar({
      value: remaining
    });
  }
});