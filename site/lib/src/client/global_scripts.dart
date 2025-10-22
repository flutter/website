// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../util.dart';

/// Global scripts converted from JS.
///
/// These are temporary until they can be integrated with their
/// relevant Jaspr components.
@client
final class GlobalScripts extends StatefulComponent {
  @override
  State<StatefulComponent> createState() => _GlobalScriptsState();
}

final class _GlobalScriptsState extends State<GlobalScripts> {
  @override
  void initState() {
    if (kIsWeb) {
      // Run setup if DOM is loaded, otherwise do it after it has loaded.
      if (web.document.readyState == 'loading') {
        web.document.addEventListener('DOMContentLoaded', _setUpSite.toJS);
      } else {
        _setUpSite();
      }
    }

    super.initState();
  }

  @override
  Component build(BuildContext context) => const Component.empty();
}

void _setUpSite() {
  _setUpSidenav();
  _setUpSearchKeybindings();
  _setUpTabs();
  _setUpCollapsibleElements();
  _setUpPlatformKeys();
  _setUpToc();
}

void _setUpSidenav() {
  final sidenav = web.document.getElementById('sidenav');
  if (sidenav == null) return;
  final activeEntries = sidenav.querySelectorAll('a.nav-link.active');

  if (activeEntries.length > 0) {
    // Scroll the last active entry into view.
    // This is usually the most specific active entry.
    final lastActiveEntry = activeEntries.item(activeEntries.length - 1);
    if (lastActiveEntry case final web.HTMLElement lastActiveEntry) {
      sidenav.scrollTo(
        web.ScrollToOptions(
          top: lastActiveEntry.offsetTop - (web.window.innerHeight / 3),
        ),
      );
    }
  }
}

void _setUpSearchKeybindings() {
  web.document.addEventListener('keydown', _handleSearchShortcut.toJS);
}

void _handleSearchShortcut(web.Event event) {
  final keyboardEvent = event as web.KeyboardEvent;
  final activeElement = web.document.activeElement;

  // Don't intercept if typing in an input field or not pressing slash key.
  if (activeElement.isA<web.HTMLInputElement>() ||
      activeElement.isA<web.HTMLTextAreaElement>() ||
      keyboardEvent.code != 'Slash') {
    return;
  }

  final web.Element? parentElement;
  // If the sidebar is open, focus its search field.
  if (web.document.body!.classList.contains('open_menu')) {
    parentElement = web.document.getElementById('sidenav');
  } else {
    // If the page has a search field in the body, focus that.
    if (web.document.getElementById('in-content-search')
        case final bodySearch?) {
      parentElement = bodySearch;
    } else {
      // Otherwise, fallback to the top navbar search field.
      parentElement = web.document.getElementById('header-search');
    }
  }

  // If we found any search field, focus it.
  if (parentElement?.querySelector('.search-field')
      case final web.HTMLElement searchField) {
    searchField.focus();
    // Prevent the initial slash from showing up in the search field.
    event.preventDefault();
  }
}

// TODO(parlough): Migrate interactivity of tabs to the Jaspr components.
/// Set up interactivity of tabs created with
/// the `<Tabs>` and `<Tab>` custom components.
void _setUpTabs() {
  _updateTabsFromQueryParameters();

  final tabsWrappers = web.document.querySelectorAll('.tabs-wrapper');

  for (
    var wrapperIndex = 0;
    wrapperIndex < tabsWrappers.length;
    wrapperIndex++
  ) {
    final element = tabsWrappers.item(wrapperIndex) as web.HTMLElement;
    final saveKey = element.dataset['tabSaveKey'];
    final localStorageKey = saveKey.isNotEmpty ? 'tab-save-$saveKey' : null;
    final tabs = element.querySelectorAll(':scope > .nav-tabs a.nav-link');
    web.HTMLElement? tabToChangeTo;

    for (var tabIndex = 0; tabIndex < tabs.length; tabIndex++) {
      final tabElement = tabs.item(tabIndex) as web.HTMLElement;
      final saveId = tabElement.dataset['tabSaveId'];

      void handleClick(web.Event event) {
        event.preventDefault();
        final currentSaveKey = element.dataset['tabSaveKey'];
        final currentSaveId = tabElement.dataset['tabSaveId'];
        if (currentSaveKey.isNotEmpty && currentSaveId.isNotEmpty) {
          // If the tab wrapper and this tab have a save key and ID defined,
          // switch other tabs to the tab with the same ID.
          _findAndActivateTabsWithSaveId(currentSaveKey, currentSaveId);
          web.window.localStorage.setItem(
            'tab-save-$currentSaveKey',
            currentSaveId,
          );
        } else {
          _clearActiveTabs(tabs);
          _setActiveTab(tabElement);
        }
      }

      tabElement.addEventListener('click', handleClick.toJS);

      // If a tab was previously specified as selected in local storage,
      // save a reference to it that can be switched to later.
      if (saveId.isNotEmpty &&
          localStorageKey != null &&
          web.window.localStorage.getItem(localStorageKey) == saveId) {
        tabToChangeTo = tabElement;
      }
    }

    if (tabToChangeTo != null) {
      tabToChangeTo.click();
    } else if (saveKey == 'dev-os') {
      // If this tab wrapper is for the archive page,
      // and no tab was retrieved from local storage,
      // switch to the tab for the current OS.
      var currentOperatingSystem = getOS();
      if (currentOperatingSystem == null) {
        currentOperatingSystem = OperatingSystem.windows;
      } else if (currentOperatingSystem == OperatingSystem.chromeos) {
        // ChromeOS uses the Linux tab.
        currentOperatingSystem = OperatingSystem.linux;
      }

      _activateTabWithSaveId(element, currentOperatingSystem.name);
    }
  }
}

/// Apply force overrides from query parameters to saved tabs.
void _updateTabsFromQueryParameters() {
  final currentUrl = Uri.parse(web.window.location.href);
  final originalQueryParameters = currentUrl.queryParameters;
  final updatedQueryParameters = {...originalQueryParameters};

  for (final MapEntry(:key, :value) in originalQueryParameters.entries) {
    if (key.startsWith('tab-save-')) {
      web.window.localStorage.setItem(key, value);
      updatedQueryParameters.remove(key);
    }
  }

  if (originalQueryParameters.length != updatedQueryParameters.length) {
    // If the query parameters were updated, update the user's URL.
    web.window.history.replaceState(
      null,
      '',
      currentUrl.replace(queryParameters: updatedQueryParameters).toString(),
    );
  }
}

void _clearActiveTabs(web.NodeList tabs) {
  for (var tabIndex = 0; tabIndex < tabs.length; tabIndex++) {
    final tabElement = tabs.item(tabIndex) as web.HTMLElement;
    tabElement.classList.remove('active');
    tabElement.ariaSelected = 'false';
    final panelId = '${tabElement.id}-panel';
    final panel = web.document.getElementById(panelId);
    panel?.classList.remove('active');
  }
}

void _setActiveTab(web.HTMLElement tab) {
  tab.classList.add('active');
  tab.ariaSelected = 'true';
  final panelId = '${tab.id}-panel';
  final panel = web.document.getElementById(panelId);
  panel?.classList.add('active');
}

void _findAndActivateTabsWithSaveId(String saveKey, String saveId) {
  final tabsWrappers = web.document.querySelectorAll(
    '.tabs-wrapper[data-tab-save-key="$saveKey"]',
  );

  for (
    var wrapperIndex = 0;
    wrapperIndex < tabsWrappers.length;
    wrapperIndex++
  ) {
    final wrapper = tabsWrappers.item(wrapperIndex) as web.HTMLElement;

    _activateTabWithSaveId(wrapper, saveId);
  }
}

void _activateTabWithSaveId(web.HTMLElement tabWrapper, String saveId) {
  final tabsNav = tabWrapper.querySelector(':scope > .nav-tabs');
  if (tabsNav == null) return;

  if (tabsNav.querySelector('a.nav-link[data-tab-save-id="$saveId"]')
      case final web.HTMLElement tabToActivate) {
    final tabs = tabsNav.querySelectorAll('a.nav-link');
    _clearActiveTabs(tabs);
    _setActiveTab(tabToActivate);
  }
}

void _setUpCollapsibleElements() {
  final toggles = web.document.querySelectorAll('[data-toggle="collapse"]');
  for (var toggleIndex = 0; toggleIndex < toggles.length; toggleIndex += 1) {
    final toggle = toggles.item(toggleIndex) as web.Element;

    final targetSelector = toggle.getAttribute('data-target');
    if (targetSelector == null) return;
    final target = web.document.querySelector(targetSelector);
    if (target == null) return;

    void handleClick(web.Event e) {
      if (toggle.classList.contains('collapsed')) {
        toggle.classList.remove('collapsed');
        toggle.ariaExpanded = 'true';

        target.classList.add('show');
      } else {
        toggle.classList.add('collapsed');
        toggle.ariaExpanded = 'false';

        target.classList.remove('show');
      }

      e.preventDefault();
    }

    toggle.addEventListener('click', handleClick.toJS);
  }
}

void _setUpPlatformKeys() {
  final os = getOS();
  final specialKey = switch (os) {
    OperatingSystem.macos => 'Command',
    _ => 'Control',
  };
  final keys = web.document.querySelectorAll('kbd.special-key');
  for (var i = 0; i < keys.length; i += 1) {
    final element = keys.item(i) as web.Element;
    element.textContent = specialKey;
  }
}

/// Adjusts the behavior of the table of contents (TOC) on the page.
///
/// This function enables a "scrollspy" feature on the TOC,
/// where the active link in the TOC is updated
/// based on the currently visible section in the page.
///
/// Enables a "back to top" button in the TOC header.
void _setUpToc() {
  _setUpTocActiveObserver();
  _setUpInlineTocDropdown();
}

void _setUpInlineTocDropdown() {
  final inlineToc = web.document.getElementById('toc-top');
  if (inlineToc == null) return;

  final dropdownButton = inlineToc.querySelector('.dropdown-button');
  final dropdownMenu = inlineToc.querySelector('.dropdown-content');
  if (dropdownButton == null || dropdownMenu == null) return;

  void closeMenu() {
    inlineToc.setAttribute('data-expanded', 'false');
    dropdownButton.ariaExpanded = 'false';
  }

  dropdownButton.addEventListener(
    'click',
    ((web.Event _) {
      print(inlineToc.getAttribute('data-expanded'));
      if (inlineToc.getAttribute('data-expanded') == 'true') {
        closeMenu();
      } else {
        inlineToc.setAttribute('data-expanded', 'true');
        dropdownButton.ariaExpanded = 'true';
      }
    }).toJS,
  );

  web.document.addEventListener(
    'keydown',
    ((web.KeyboardEvent event) {
      if (event.key == 'Escape') {
        closeMenu();
      }
    }).toJS,
  );

  // Close the dropdown if any link in the TOC is navigated to.
  final inlineTocLinks = inlineToc.querySelectorAll('a');
  for (var i = 0; i < inlineTocLinks.length; i++) {
    final tocLink = inlineTocLinks.item(i) as web.Element;
    tocLink.addEventListener(
      'click',
      ((web.Event _) {
        closeMenu();
      }).toJS,
    );
  }

  // Close the dropdown if anywhere not in the inline TOC is clicked.
  web.document.addEventListener(
    'click',
    ((web.Event event) {
      if ((event.target as web.Element).closest('#toc-top') != null) {
        return;
      }
      closeMenu();
    }).toJS,
  );
}

void _setUpTocActiveObserver() {
  final headings = web.document.querySelectorAll(
    'article .header-wrapper, #site-content-title',
  );
  final currentHeaderText = web.document.getElementById('current-header');

  // No need to have toc scrollspy if there is only one non-title heading.
  if (headings.length < 2 || currentHeaderText == null) return;

  final visibleAnchors = <String>{};
  final initialHeaderText = currentHeaderText.textContent;

  final observer = web.IntersectionObserver(
    ((JSArray<web.IntersectionObserverEntry> entries) {
      for (var i = 0; i < entries.length; i++) {
        final entry = entries[i];
        final headingId = entry.target.querySelector('h1, h2, h3')?.id;
        if (headingId == null) return;

        if (entry.isIntersecting) {
          visibleAnchors.add(headingId);
        } else {
          visibleAnchors.remove(headingId);
        }
      }

      if (visibleAnchors.isNotEmpty) {
        var isFirst = true;

        // If the page title is visible, set the current header to its contents.
        if (visibleAnchors.contains('document-title')) {
          currentHeaderText.textContent = initialHeaderText;
          isFirst = false;
        }

        final tocLinks = web.document.querySelectorAll(
          '.site-toc .sidenav-item a',
        );
        for (var i = 0; i < tocLinks.length; i++) {
          final tocLink = tocLinks.item(i) as web.Element;
          final headingId = tocLink.getAttribute('href')?.substring(1);
          if (headingId == null) continue;

          final sidenavItem = tocLink.closest('.sidenav-item');
          if (sidenavItem == null) continue;

          if (visibleAnchors.contains(headingId)) {
            sidenavItem.classList.add('active');

            if (isFirst) {
              currentHeaderText.textContent = tocLink.textContent;
              isFirst = false;
            }
          } else {
            sidenavItem.classList.remove('active');
          }
        }
      }
    }).toJS,
    web.IntersectionObserverInit(rootMargin: '-80px 0px -25% 0px'),
  );

  for (var i = 0; i < headings.length; i++) {
    observer.observe(headings.item(i) as web.Element);
  }
}
