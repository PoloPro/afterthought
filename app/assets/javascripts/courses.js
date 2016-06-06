
$(function() {
  autocompleteSearch()
  autocompleteEnter()
  autocompleteClick()
  enableCourseClick()
});

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
  $('#find-course').html(`
  <div class="panel panel-primary">
    <div class="panel-heading">Search Result</div>
    <div class="panel-body">
    <table class="table table-hover table-responsive">
    <th>Course ID</th>
    <th>Title</th>
    <th>Description</th>
    <th>Add Course</th>

      <tr>
        <td id=course-id class="table-row-link" data-url="${data.coursePath}">${data.courseId}</td>
        <td class="table-row-link" data-url="${data.coursePath}">${data.title}</td>
        <td class="table-row-link" data-url="${data.coursePath}">${data.description}</td>
        <td><button class='btn btn-success btn-sm' id="add-course">Add Course </button></td>
      </tr>

  </table> </div>`)
  enableTableLinks()
  enableCourseClick()
}

var enableCourseClick = function() {
  $('#add-course').click(function(e){
    var courseId = $('#course-id').text()
    $.ajax({
      method: "POST",
      url: "/add_course",
      data: {course_id: courseId},
      success: function(data) {
        debugger
        // alert that course successfully added
        // add course to top course listings table
      }
    })
  })
}
