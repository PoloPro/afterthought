$(function() {
  lectureDisplayEnable()
  autocompleteStudentSearch()
  autocompleteStudentEnter()
  autocompleteStudentClick()
  clickStudentRemoveListener()
});


lectureDisplayEnable = function() {
  $('#lecture-display').click(function(){
    $('.lecture-list').show(250)
    $('.student-list').hide(250)
  })
  $('#student-display').click(function(){
    $('.student-list').show(250)
    $('.lecture-list').hide(250)
  })
}


var autocompleteStudentSearch = function (){
  var urlLocation = window.location.href.match(/\bcourses\/\b\d+/)
  var uiWidgetText = $(".ui-widget").text()
  if(urlLocation !== null && urlLocation[0] && uiWidgetText !== "") {
    $.widget( "custom.catcomplete", $.ui.autocomplete, {
      _create: function() {
        this._super();
        this.widget().menu( "option", "items", "> :not(.ui-autocomplete-student-category)" );
      },
      _renderMenu: function( ul, items ) {
        var that = this,
          currentCategory = "";
        $.each( items, function( index, item ) {
          var li;
          if ( item.category != currentCategory ) {
            ul.append( "<li class='ui-autocomplete-student-category'>" + "<b>" + item.category + "<b>" + "</li>" );
            currentCategory = item.category;
          }
          li = that._renderItemData( ul, item );
          if ( item.category ) {
            li.attr( "aria-label", item.category + " : " + item.label );
          }
        });
      }
    });
  getStudentData()
  }
}

var getStudentData = function() {
  $.ajax({
    method: "GET",
    url: "/student_autocomplete",
    success: function(data){
          $( "#student-search" ).catcomplete({
      delay: 0,
      source: data.data
    });
    }
  });
}


var autocompleteStudentEnter = function() {
  $('#student-search').keypress(function(e){
      if(e.keyCode==13)
      $('#autocomplete-student-search').click();
    });
}

var autocompleteStudentClick = function() {
  $("#autocomplete-student-search").click(function(){
    var searchTerm = $('#student-search').val()
    var courseId = $('h1').attr('course-id')
    var confirmEmail = confirm("Are you sure you want to invite " + searchTerm + "?")
    if (confirmEmail) {
      $.ajax({
        method: "POST",
        data: {student_term: searchTerm, course_id: courseId},
        url: "/enrollments",
        success: function(data){
          if (data.success === true) {
            addEmailSuccessText(data)
          } else {
            addStudentFailText(data)
          }
          $('#student-search').val("")
        }
      });
    }
  })
}

var addEmailSuccessText = function(data) {
  var courseAlert = "<div class='alert alert-success'>" +
    "<strong>Success! </strong>" + data.data +
  "</div>"
  $('#add-student-alerts').html(courseAlert)
}

var addStudentFailText = function(data) {
  var courseAlert = "<div class='alert alert-danger'>" +
    "<strong>Oops! </strong>" + data.data +
  "</div>"
  $('#add-student-alerts').html(courseAlert)
}


var clickStudentRemoveListener = function() {
  $("a[action='remove-student']").click(function(e) {
    e.stopPropagation()
    e.preventDefault()
    var studentName = $(this).attr('name')
    var courseId = $(this).attr('course')
    var studentId = $(this).attr('student-id')
    var confirmDelete = confirm("Are you sure you want to remove " + studentName + " from this course?")
    if (confirmDelete) {
      $.ajax({
        method: "POST",
        url: "/remove_student",
        data: {student_id: studentId, course_id: courseId},
        success: function(data){
          studentId = "#" + data.stringifyName
          $(studentId).remove()
          var studentRemoveAlert = "<div class='alert alert-info'>" +
          "You have removed " + data.name + " from " + data.courseTitle +
          "</div>"
          $('#add-student-alerts').html(studentRemoveAlert)
        }
      })
    }
  })
}
