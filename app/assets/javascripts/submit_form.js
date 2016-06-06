var status;

$(document).ready(function() {
  // Show and hide tips on click
  $('#tips').hide();
  status = "hidden";

  $('#show-tips').on('click', function(event) {
    toggleTips();
  })

  // Add or remove name (anonymous is default) on click
  $('#add-name').hide();

  $('#remove-name').on('click', function(event) {
    removeName();
  })

  $('#add-name').on('click', function(event) {
    addName();
  })

  // Submit feedback via AJAX on click
  $('#feedback-submit').on('click',function(event) {
    event.preventDefault();
    submitFeedback();
  })
})

// Tooltip show and hide
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


// Add and remove name depending on user preference
var removeName = function() {
  $('#signature').html('Anonymous');
  $('#remove-name').hide();
  $('#add-name').show();
}

var addName = function() {
  var username = $('#username').attr('data');
  $('#signature').html(username);
  $('#add-name').hide();
  $('#remove-name').show();
}

// Submit feedback via Ajax
var submitFeedback = function() {
  var content = $('#feedback-text').val();
  var studentID = $('#feedback-data').attr('data-student-id');
  var lectureID = $('#feedback-data').attr('data-lecture-id');

  $.ajax({
    url: '/reviews',
    type: 'POST',
    data: { 
      review: {
        student_id: studentID,
        lecture_id: lectureID,
        content: content
      } 
    },
    success: function(response) {
      console.log("success " + response)
    }
  })


}

// Show and hide feedback form depending on submission

