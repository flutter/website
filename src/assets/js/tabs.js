function setupTabs(container, storageName, defaultTabGetter) {
  const tabs = $(container).find('li a');

  function getTabIdFromQuery(query) {
    const match = query.match(/(#|\btab=)([\w-]+)/);
    return match ? match[2] : '';
  }

  function clickHandler(e) {
    e.preventDefault();
    $(this).tab('show');
    const id = getTabIdFromQuery($(this).attr('href'));

    if (storageName && window.localStorage) {
      window.localStorage.setItem(storageName, id);
    }

    updateUrlQuery(id);
  }

  function updateUrlQuery(id) {
    const loc = window.location;
    const query = '?tab=' + id;
    if (id && loc.search !== query) {
      const url = loc.protocol + '//' + loc.host + loc.pathname + query + loc.hash;
      history.replaceState(undefined, undefined, url);
    }
  }

  function selectTab(id) {
    const tab = tabs.filter('[href="#' + id + '"]');
    tab.click();
  }

  function getSelectedTab() {
    let selectedTab = getTabIdFromQuery(location.search);
    if (!selectedTab && storageName && window.localStorage) {
      selectedTab = window.localStorage.getItem(storageName);
    }

    if (selectedTab) {
      return selectedTab;
    }

    if (defaultTabGetter) {
      return defaultTabGetter();
    }

    return null;
  }

  function initializeTabs() {
    tabs.click(clickHandler);
    const selectedTab = getSelectedTab();
    selectTab(selectedTab);
  }

  initializeTabs();
}
