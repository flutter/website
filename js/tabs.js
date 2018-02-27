function setupToolsTabs() {
  var tabIdPrefix = "tab-install-";
  var tabs = $('.tabs__top-bar li');
  var tabContents = $('.tabs__content');

  function clearTabsCurrent() {
    tabs.removeClass('current');
    tabContents.removeClass('current');
  }

  function selectTool(id) {
    var escapedId = $.escapeSelector(id);
    var tab = tabs.filter("[data-tab='" + tabIdPrefix + id + "']");
    tab.click();
  }

  tabs.click(function () {
    clearTabsCurrent();

    var tab_id = $(this).attr('data-tab');

    $(this).addClass('current');
    $("#" + tab_id).addClass('current');

    // Add to the url for better reloading/copy/pasting
    location.hash = '#' + tab_id.replace(tabIdPrefix, '');
  });

  // If we have a tool in the url fragement, pre-select it
  if (location.hash && location.hash.length > 1)
    selectTool(location.hash.substr(1));
}

$(document).ready(function () {
  setupToolsTabs();
});