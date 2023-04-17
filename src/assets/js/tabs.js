function setupTabs(container, storageName, defaultTab) {
  const tabs = $('li a', container);

  // Return 'foo' from either '#foo' or '?tab=foo'
  function getTabIdFromQuery(query) {
    const match = query.match(/(#|\btab=)([\w-]+)/);
    return match ? match[2] : '';
  }

  function clickHandler(e) {
    e.preventDefault();
    $(this).tab('show');

    const id = getTabIdFromQuery($(this).attr('href'));

    // Persist to local storage, so we can pre-select around the site
    if (storageName && window.localStorage) {
      window.localStorage.setItem(storageName, id);
    }

    const loc = window.location;
    const query = '?tab=' + id;
    if (id && loc.search !== query) {
      const url = loc.protocol + '//' + loc.host +
          loc.pathname + query + loc.hash;
      history.replaceState(undefined, undefined, url);
    }
  }

  function selectTab(id) {
    const tab = tabs.filter('[href="#' + id + '"]');
    tab.click();
  }

  tabs.click(clickHandler);

  let selectedTab = getTabIdFromQuery(location.search);
  if (selectedTab) {
    selectTab(selectedTab);
  } else if (storageName && window.localStorage
    && (selectedTab = window.localStorage.getItem(storageName))) {
    selectTab(selectedTab);
  } else if (defaultTab) {
    selectTab(defaultTab);
  }
}

// TODO(chalin): Temporary until we convert all tabs to BS tabs
function setupToolsTabs(container, tabIdPrefix, storageName, defaultTab) {
  const tabs = $('.tabs__top-bar li', container);
  const tabContents = $('.tabs__content', container);

  function clearTabsCurrent() {
    tabs.removeClass('current');
    tabContents.removeClass('current');
  }

  // Searches for the tab for a tool by its ID and selects it
  // (used to pre-select a tool from url fragment/localStorage)
  function selectTool(id) {
    const escapedId = $.escapeSelector(id);
    const tab = tabs.filter("[data-tab='" + tabIdPrefix + escapedId + "']");
    tab.click();
  }

  tabs.click(function () {
    const tab_id = $(this).attr('data-tab');
    const tab_href = $(this).attr('data-tab-href');

    if (tab_href) {
      location.href = tab_href;
      return;
    }

    const tab = $("#" + tab_id);

    if (!tab.length) {
      return;
    }

    clearTabsCurrent();

    $(this).addClass('current');
    tab.addClass('current');

    const selectedTool = tab_id.replace(tabIdPrefix, '');

    // Add to the url for better reloading/copy/pasting
    if (history.replaceState) {
      history.replaceState(undefined, undefined, '#' + selectedTool);
    }

    // Persist in local storage, so we can pre-select around the site
    if (storageName && window.localStorage) {
      window.localStorage.setItem(storageName, selectedTool);
    }
  });

  // If we have a tool in the url fragment, pre-select it
  if (location.hash && location.hash.length > 1) {
    selectTool(location.hash.substring(1));
  } else if (storageName && window.localStorage && window.localStorage.getItem(storageName)) {
    selectTool(window.localStorage.getItem(storageName));
  } else if (defaultTab) {
    selectTool(defaultTab);
  }
}
