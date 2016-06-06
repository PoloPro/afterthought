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

  // Hide the form or feedback on page load
  if ($('#review-boolean').attr('data-has-review') === "true") {
    $('#feedback-form').hide();
  } else if ($('#review-boolean').attr('data-has-review') == "false") {
    $('#feedback-completed').hide();
  } else {}

  // Submit feedback via AJAX on click
  $('#feedback-submit').on('click',function(event) {
    event.preventDefault();
    submitFeedback();
  })

  // Delete feedback and show form on click
  $('#delete-feedback').on('click',function(event) {
    event.preventDefault();
    deleteFeedback();
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
  var username = $('#review-data').attr('data-username');
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
      hideForm(response.id);
    },
    error: function(response) {
      console.log("error " + JSON.stringify(response));
    }
  })
}

// Submit feedback via Ajax
var deleteFeedback = function() {

  var reviewID = $('#review-data').attr('data-review-id');

  $.ajax({
    url: '/reviews/' + reviewID,
    type: 'DELETE',
    success: function(response) {
      showForm();
    },
    error: function(response) {
      console.log("error " + JSON.stringify(response));
    }
  })
}


// Show and hide feedback form depending on submission
var hideForm = function(reviewID) {
  $('#feedback-form').hide();
  $('#review-content').text($('#feedback-text').val()) 
  $('#review-data').attr('data-review-id', reviewID);
  $('#feedback-completed').show();
}

var showForm = function() {
  $('#feedback-completed').hide();
  $('#feedback-form').show();
}

