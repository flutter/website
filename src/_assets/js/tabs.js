function setupTabs(container, storageName, defaultTab) {
  var tabs = $('li a', container);

  // console.log('>> #tabs', tabs.length, storageName);

  tabs.click(function (e) {

    // console.log('>> click event for tab:', $(this));
    e.preventDefault();
    $(this).tab('show');

    var id = $(this).attr('href').substr(1);

    // Persist to local storage so we can pre-select around the site
    if (storageName && window.localStorage) {
      // console.log('>> setting localStorage', storageName, id);
      window.localStorage.setItem(storageName, id);
    }

    if (id) location.href = '#' + id;

    // // Add to the url for better reloading/copy/pasting
    // if (history.replaceState && id != location.hash) {
    //   history.replaceState(undefined, undefined, id);
    // }
  });

  function selectTab(id) {
    var tab = tabs.filter('[href="#' + id + '"]');
    tab.click();
  }

  // If we have a tool in the url fragement, pre-select it
  if (location.hash && location.hash.length > 1) {
    // console.log('>> setting tab from location:', location.hash)
    selectTab(location.hash.substr(1));
  } else if (storageName && window.localStorage && window.localStorage.getItem(storageName)) {
    // console.log('>> setting tab from localStorage: ', window.localStorage.getItem(storageName))
    selectTab(window.localStorage.getItem(storageName));
  } else if (defaultTab) {
    // console.log('>> setting tab from defaultTab')
    selectTab(defaultTab);
  } else {
    // console.log('>> not setting the tab - using page default')
  }
}

// TODO(chalin): Temporary until we convert all tabs to BS tabs
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
