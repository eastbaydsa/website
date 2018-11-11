$(document).ready(function() {
  $("a.show-past").click(function(event) {
    event.preventDefault();
    $(".past-events").show();
    $("a.show-past").hide();
  });

  $("form#calendar-filter input").on("change", function(event) {
    $("form#calendar-filter").submit();
  });
});
