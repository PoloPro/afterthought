// var remaining;

// $(document).ready(function() {

//   remaining = Number($("#progressbar").attr('timeRemainingPercent'))

//   if (remaining > 0) {
//     $("#progressbar").progressbar({
//       value: remaining
//     });
//   }

//   setInterval(function() {

//     var lectureID = $('#lecture-data').attr('data-lecture-id');
//     getTimeRemaining(lectureID);

//     if (remaining > 0) {
//       $("#progressbar").progressbar({
//         value: remaining
//       })
//     } else {
//       $("#progressbar").progressbar({
//         value: 0
//       })
//     }

//   }, 15000);

// });


// var getTimeRemaining = function(lectureID) {

//   $.ajax({
//     url: '/lectures/get_remaining_time',
//     type: 'GET',
//     data: { id: lectureID },
//     success: function(response) {
//       remaining = response.lecture_timer.time_remaining_percent;
//     },
//     error: function(response) {
//       console.log("error " + JSON.stringify(response));
//     }
//   })
// }