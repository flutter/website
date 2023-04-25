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
