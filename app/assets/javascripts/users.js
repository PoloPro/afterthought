$(document).ready(function() {
  userStart()
  userToggle()
})

var userStart = function() {
  if($('#session_instructor').is(':checked')) {
    $("#student-signin").css("display","none")
    $("#instructor-signin").css("display", "");
  }else{
    $("#instructor-signin").css("display","none")
    $("#student-signin").css("display", "");
  }
}


var userToggle = function() {
  $("#user-toggle").change(function() {
    if($('#session_instructor').is(':checked')) {
      $("#student-signin").css("display","none")
      $("#instructor-signin").css("display", "");
    }else{
      $("#instructor-signin").css("display","none")
      $("#student-signin").css("display", "");
    }
  })
}
