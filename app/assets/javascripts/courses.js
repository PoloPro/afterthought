
$(function() {
  page_reset()
  clickDeleteListener()
  autocompleteStudentSearch()
});

var page_reset = function() {
  autocompleteSearch()
  autocompleteEnter()
  autocompleteClick()
}

var autocompleteSearch = function (){
  var urlLocation = window.location.href.match(/\bcourses\b$/)
  var uiWidgetText = $(".ui-widget").text()
  if(urlLocation !== null && urlLocation[0] === "courses" && uiWidgetText !== "") {
    $.widget( "custom.catcomplete", $.ui.autocomplete, {
      _create: function() {
        this._super();
        this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
      },
      _renderMenu: function( ul, items ) {
        var that = this,
          currentCategory = "";
        $.each( items, function( index, item ) {
          var li;
          if ( item.category != currentCategory ) {
            ul.append( "<li class='ui-autocomplete-category'>" + "<b>" + item.category + "<b>" + "</li>" );
            currentCategory = item.category;
          }
          li = that._renderItemData( ul, item );
          if ( item.category ) {
            li.attr( "aria-label", item.category + " : " + item.label );
          }
        });
      }
    });
  getData()
  }
}

var getData = function() {
  $.ajax({
    method: "GET",
    url: "/courses_autocomplete",
    success: function(data){
          $( "#search" ).catcomplete({
      delay: 0,
      source: data.data
    });
    }
  });
}

var autocompleteEnter = function() {
  $('#search').keypress(function(e){
      if(e.keyCode==13)
      $('#autocomplete-search').click();
    });
}

var autocompleteClick = function() {
  $("#autocomplete-search").click(function(){
    var searchTerm = $('#search').val()
    $.ajax({
      method: "POST",
      data: {data: searchTerm},
      url: "/display_joinable_courses",
      success: function(data){
        addCourseTable(data)
        $("#search").val("")
      }
    });
  })
}

var addCourseTable = function(data) {
  $('#find-course').html("<div class='panel panel-default'>" +
    "<div class='panel-heading'>Search Result</div>" +
    "<div class='panel-body'>" +
    "<table class='table table-hover table-responsive'>" +
    "<th>Course ID</th>" +
    "<th>Title</th>" +
    "<th>Description</th>" +
    addCourseHeader(data) +

      "<tr>" +
        "<td id=course-id class='table-row-link' data-url='" + data.coursePath + "'>" + data.courseId + "</td>" +
        "<td class='table-row-link' data-url='" + data.coursePath + "'>" + data.title + "</td>" +
        "<td class='table-row-link' data-url='" + data.coursePath + "'>" + data.description + "</td>" + addButton(data) +
      "</tr>" +

  "</table> </div>")
  enableTableLinks()
  checkAddPermissions()
}

var addCourseHeader = function(data) {
  if (data.userClass === "Instructor") {
    return "<th>Add Course</th>"
  } else {
    return ""
  }
}
var addButton = function(data) {
  if (data.userClass === "Instructor") {
    return "<td><button class='btn btn-search btn-sm' id='add-course'>Add Course </button></td>"
  } else {
    return ""
  }
}

var checkAddPermissions = function() {
  $('#add-course').click(function(e){
    var courseId = $('#course-id').text()
    $.ajax({
      method: "POST",
      url: "/check_course_permissions",
      data: {course_id: courseId},
      success: function(data){
        if (data.alert === undefined) {
         addPasswordPrompt(data)
         page_reset()
        } else {
         addFailText(data)
         page_reset()
        }
      }
    })
  })
}

var addPasswordPrompt = function(data) {
  if ($('.form-inline').val() === undefined) {
  var passPrompt = "<form class='form-inline' role='form' id='password_form'>" +
    "<div class='form-group'>" +
      "<label for='password'>" + data.prompt + "</label>" +
      "<input type='password' class='form-control password-form' id='password'>" +
    "</div>" +
    "<button type='submit' class='btn btn-search' id='permissions-submit'>Submit</button>" +
  "</form>"
  $("div.panel-body").append(passPrompt)
  enablePermissionsSubmit()
  page_reset()
 }
}

var addFailText = function(data) {
  var courseAlert = "<div class='alert alert-danger'>" +
    "<strong>Oops! </strong>" + data.alert +
  "</div>"
  $('#find-course').html(courseAlert)
}

var enablePermissionsSubmit = function() {
  $('button#permissions-submit').click(function(e) {
    e.stopPropagation()
    e.preventDefault()
    var password = $("#password").val()
    var courseId = $('#course-id').text()
    $.ajax({
      method: "POST",
      url: "/add_course",
      data: {
        password: password,
        course_id: courseId
      },
      success: function(data) {
        if (data.alert === undefined) {
          addSuccessText(data)
          page_reset()
        } else {
          addFailText(data)
          page_reset()
        }
      }
    })
  })
}

var addSuccessText = function(data) {
  var courseAlert = "<div class='alert alert-success'> <strong>Success!</strong> You have joined: " + data.title +
"</div>"
  var addCourseData = "<tr class='table-row-link' data-url='" + data.coursePath + "'>" +
    "<td>" + data.courseId + "</td>" +
    "<td>" + data.title + "</td>" +
    "<td>" + data.description + "</td>" +
    "<td>" + data.courseStudents + "</td>" +
    "<td><a src='#' action='course-delete' id='" + data.slugified_title + "' title='" + data.title + "'>Remove</a></td>" +
  "</tr>"
  $('#find-course').html(courseAlert)
  $('#course-data-table').append(addCourseData)
  $('#join-course-prompt').css("display","none")
  enableTableLinks()
  clickDeleteListener()
}

var clickDeleteListener = function() {
  $("a[action='course-delete']").click(function(e) {
    e.stopPropagation()
    e.preventDefault()
    var courseTitle = $(this).attr('title')
    var confirmDelete = confirm("Are you sure you want to remove " + courseTitle + " from your courses?")
    if (confirmDelete) {
      $.ajax({
        method: "POST",
        url: "/remove_course",
        data: {course_title: courseTitle},
        success: function(data){
          courseClass = "#" + data.stringifyTitle
          $(courseClass).parent().parent().remove()
          var courseAlert = "<div class='alert alert-warning'>" +
            "You have left: " + data.title +
          "</div>"
          $('#find-course').html(courseAlert)
        }
      })
    }
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
