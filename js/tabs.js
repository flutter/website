function setupToolsTabs() {
  var tabIdPrefix = "tab-install-";
  var tabs = $('.tabs__top-bar li');
  var tabContents = $('.tabs__content');

  function clearTabsCurrent() {
    tabs.removeClass('current');
    tabContents.removeClass('current');
  }

  // Searches for the tab for a tool by its ID and selects it
  // (used to pre-select a tool from url fragement/localStorage)
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

    var selectedTool = tab_id.replace(tabIdPrefix, '');

    // Add to the url for better reloading/copy/pasting
    if (history.replaceState)
      history.replaceState(undefined, undefined, '#' + selectedTool);

    // Persist in local storage so we can pre-select around the site
    if (window.localStorage)
      window.localStorage.setItem('selectedTool', selectedTool);
  });

  // If we have a tool in the url fragement, pre-select it
  if (location.hash && location.hash.length > 1)
    selectTool(location.hash.substr(1));
  else if (window.localStorage && window.localStorage.getItem('selectedTool'))
    selectTool(window.localStorage.getItem('selectedTool'));
}

$(document).ready(function () {
  setupToolsTabs();
});