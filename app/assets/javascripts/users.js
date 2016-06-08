$(document).ready(function() {
  userStart()
  userToggle()
})

var userStart = function() {
  if($('#session_instructor').prop('checked')) {
    $("#student-signin").hide()
    $("#instructor-signin").show();
  }else{
    $("#instructor-signin").hide()
    $("#student-signin").show();
  }
}


var userToggle = function() {
  $("#user-toggle").change(function() {
    if($('#session_instructor').prop('checked')) {
      $("#student-signin").hide()
      $("#instructor-signin").show();
    }else{
      $("#instructor-signin").hide()
      $("#student-signin").show();
    }
  })
}
