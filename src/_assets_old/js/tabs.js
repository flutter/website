function setupToolsTabs(container, tabIdPrefix, storageName, defaultTab) {
  var tabs = $('.tabs__top-bar li', container);
  var tabContents = $('.tabs__content', container);

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
    var tab_id = $(this).attr('data-tab');
    var tab_href = $(this).attr('data-tab-href');

    if (tab_href) {
      location.href = tab_href;
      return;
    }

    if (!$("#" + tab_id).length) {
      return;
    }

    clearTabsCurrent();

    $(this).addClass('current');
    $("#" + tab_id).addClass('current');

    var selectedTool = tab_id.replace(tabIdPrefix, '');

    // Add to the url for better reloading/copy/pasting
    if (history.replaceState)
      history.replaceState(undefined, undefined, '#' + selectedTool);

    // Persist in local storage so we can pre-select around the site
    if (storageName && window.localStorage)
      window.localStorage.setItem(storageName, selectedTool);
  });

  // If we have a tool in the url fragement, pre-select it
  if (location.hash && location.hash.length > 1)
    selectTool(location.hash.substr(1));
  else if (storageName && window.localStorage && window.localStorage.getItem(storageName))
    selectTool(window.localStorage.getItem(storageName));
  else if (defaultTab)
    selectTool(defaultTab);
}

$(document).ready(function () {
  setupToolsTabs($("#tab-set-install"), "tab-install-", "selectedTool");
  setupToolsTabs($("#tab-set-os"), "tab-os-", null, getOS());
});

function getOS() {
  var ua = navigator.userAgent;
  if (ua.indexOf("Win") !== -1)
    return "windows";
  if (ua.indexOf("Mac") !== -1)
    return "macos";
  if (ua.indexOf("Linux") !== -1 || ua.indexOf("X11") !== -1)
    return "linux";
}
