$(function() {
  lectureDisplayEnable()
});


lectureDisplayEnable = function() {
  $('#lecture-display').click(function(){
    $('.lecture-list').toggle(250)
    $('.student-list').toggle(250)
  })
  $('#student-display').click(function(){
    $('.student-list').toggle(250)
    $('.lecture-list').toggle(250)
  })
}
