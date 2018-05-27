$(document).ready(function() {
  var selectedFilter = $('#calendar-filter select').value;

  currentTag = getUrlVars()['tags'];
  $('#calendar-filter option[value="' + currentTag + '"]').prop(
    'selected',
    'selected'
  );

  $('#calendar-filter select').on('change', function(event) {
    var newSelected = event.target.value;
    if (selectedFilter != newSelected) {
      var params = {
        tags: newSelected
      };

      var startDate = getUrlVars()['start_date'];
      if (startDate) {
        params['start_date'] = startDate;
      }

      window.location.href =
        window.location.origin +
        window.location.pathname +
        '?' +
        $.param(params);
    }
  });
});

// Read a page's GET URL variables and return them as an associative array.
function getUrlVars() {
  var vars = [],
    hash;
  var hashes = window.location.href
    .slice(window.location.href.indexOf('?') + 1)
    .split('&');
  for (var i = 0; i < hashes.length; i++) {
    hash = hashes[i].split('=');
    vars.push(hash[0]);
    vars[hash[0]] = hash[1];
  }
  return vars;
}
