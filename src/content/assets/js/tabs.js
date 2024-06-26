/**
 * Set up interactivity of tabs created with the `{% tabs %}` shortcode.
 */
function setupTabs() {
  const tabsWrappers = document.querySelectorAll('.tabs-wrapper');

  tabsWrappers.forEach(function (tabWrapper) {
    const saveKey = tabWrapper.dataset.tabSaveKey;
    const localStorageKey = `tab-save-${saveKey}`;
    const tabs = tabWrapper.querySelectorAll('a.nav-link');
    let tabToChangeTo;

    tabs.forEach(function (tab) {
      const saveId = tab.dataset.tabSaveId;

      tab.addEventListener('click', function (event) {
        event.preventDefault();
        if (saveKey && saveId) {
          // If the tab wrapper and this tab have a save key and ID defined,
          // switch other tabs to the tab with the same ID.
          _findAndActivateTabsWithSaveId(saveKey, saveId);
          localStorage.setItem(localStorageKey, saveId);
        } else {
          _clearActiveTabs(tabs);
          _setActiveTab(tab);
        }
      });

      // If a tab was previously specified as selected in local storage,
      // save a reference to it that can be switched to later.
      if (saveId && localStorage.getItem(localStorageKey) === saveId) {
        tabToChangeTo = tab;
      }
    });

    if (tabToChangeTo) {
      tabToChangeTo.click();
    } else if (saveKey === 'os-archive-tabs') {
      // If this tab wrapper is for the archive page,
      // and no tab was retrieved from local storage,
      // switch to the tab for the current OS.
      const currentOperatingSystem = _getOsForArchive();

      if (currentOperatingSystem) {
        _activateTabWithSaveId(tabWrapper, currentOperatingSystem);
      }
    }
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

function _findAndActivateTabsWithSaveId(saveKey, saveId) {
  const tabsWrappers = document.querySelectorAll(`.tabs-wrapper[data-tab-save-key="${saveKey}"]`);

  tabsWrappers.forEach((tabWrapper) =>
      _activateTabWithSaveId(tabWrapper, saveId));
}

function _activateTabWithSaveId(tabWrapper, saveId) {
  const tabToActivate = tabWrapper.querySelector(`a.nav-link[data-tab-save-id="${saveId}"]`);
  if (tabToActivate) {
    const tabs = tabWrapper.querySelectorAll('a.nav-link');
    _clearActiveTabs(tabs);
    _setActiveTab(tabToActivate);
  }
}

function _getOsForArchive() {
  const os = getOS();
  // The archive doesn't have chromeos, fall back to linux.
  if (os === 'chromeos') {
    return 'linux';
  }

  return os;
}
