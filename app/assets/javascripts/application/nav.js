$(document).ready(function() {
  $('.hamburger').on('click', function() {
    var isExpanded = $(this).attr('aria-expanded') === 'true';
    $(this).attr('aria-expanded', !isExpanded);
    $('.header__menu').toggleClass('show');
  });
});
