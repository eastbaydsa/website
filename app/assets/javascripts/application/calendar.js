$(document).ready(function() {
  $('form#calendar-filter input').on('change', function(event) {
    $('form#calendar-filter').submit();
  });
});
