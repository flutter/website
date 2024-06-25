function setupTabs() {
  const tabsWrappers = document.querySelectorAll('.tabs-wrapper');

  tabsWrappers.forEach(function (tabWrapper) {
    const saveKey = tabWrapper.dataset.tabSaveKey;
    const localStorageKey = `tab-save-${saveKey}`;
    const tabs = tabWrapper.querySelectorAll('a.nav-link');

    tabs.forEach(function (tab) {
      const saveId = tab.dataset.tabSaveId;

      tab.addEventListener('click', function (event) {
        event.preventDefault();
        if (saveKey && saveId) {
          _activateTabsWithSaveId(saveKey, saveId);
          localStorage.setItem(localStorageKey, saveId);
        } else {
          _clearActiveTabs(tabs);
          _setActiveTab(tab);
        }
      });

      if (saveId && localStorage.getItem(localStorageKey) === saveId) {
        tab.click();
      } else if (tabWrapper.id === 'os-archive-tabs') {
        // TODO(parlough): Add default selection for archive tabs.
      }
    });
  });
}

function _clearActiveTabs(tabs) {
  tabs.forEach(function (tab) {
    tab.classList.remove('active');
    tab.ariaSelected = 'false';
    document.getElementById(`${tab.id}-panel`)?.classList.remove('active');
  });
}

function _setActiveTab(tab) {
  tab.classList.add('active');
  tab.ariaSelected = 'true';
  document.getElementById(`${tab.id}-panel`)?.classList.add('active');
}

function _activateTabsWithSaveId(saveKey, saveId) {
  const tabsWrappers = document.querySelectorAll(`.tabs-wrapper[data-tab-save-key="${saveKey}"]`);

  tabsWrappers.forEach(function (tabWrapper) {
    const tabToActivate = tabWrapper.querySelector(`a.nav-link[data-tab-save-id="${saveId}"]`);
    if (tabToActivate) {
      const tabs = tabWrapper.querySelectorAll('a.nav-link');
      _clearActiveTabs(tabs);
      _setActiveTab(tabToActivate);
    }
  });
}

function _getOsForArchive() {
  const os = getOS();
  // The archive doesn't have chromeos, fall back to linux.
  if (os === 'chromeos') {
    return 'linux';
  }

  return os;
}
