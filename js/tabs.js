function setupToolsTabs() {
  var tabs = $('.tabs__top-bar li');
  var tabContents = $('.tabs__content');

  function clearTabsCurrent() {
    tabs.removeClass('current');
    tabContents.removeClass('current');
  }

  tabs.click(function () {
    clearTabsCurrent();

    var tab_id = $(this).attr('data-tab');

    $(this).addClass('current');
    $("#" + tab_id).addClass('current');
  });
}

$(document).ready(function () {
  setupToolsTabs();
});