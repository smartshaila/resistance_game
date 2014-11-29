function page_swipe_left() {
  $('.row-offcanvas').removeClass('active');
}

function page_swipe_right() {
  $('.row-offcanvas').addClass('active');
}

$('html').swipeleft(page_swipe_left);
$('html').swiperight(page_swipe_right);
