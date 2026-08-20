// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:site_shared/util.dart';
import 'package:site_shared/web_util.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

/// Global scripts converted from JS.
///
/// These are temporary until they can be integrated with their
/// relevant Jaspr components.
void setUpSite() {
  _setUpSearchKeybindings();
  _setUpTabs();
  _setUpCollapsibleElements();
  _setUpExpandableCards();
  _setUpPlatformKeys();
  _setUpToc();
  _setUpSteppers();
  _setUpIdeExplorers();
  _setUpGraderMatrix();
  _setUpInteractiveDetailCards();
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
          try {
            web.window.localStorage.setItem(
              'tab-save-$currentSaveKey',
              currentSaveId,
            );
          } catch (e) {
            if (kDebugMode) {
              print('Error accessing localStorage: $e');
            }
          }
        } else {
          _clearActiveTabs(tabs);
          _setActiveTab(tabElement);
        }
      }

      tabElement.addEventListener('click', handleClick.toJS);

      try {
        // If a tab was previously specified as selected in local storage,
        // save a reference to it that can be switched to later.
        final tabSaveKey = localStorageKey != null
            ? web.window.localStorage.getItem(localStorageKey)
            : null;
        if (saveId.isNotEmpty && tabSaveKey != null && tabSaveKey == saveId) {
          tabToChangeTo = tabElement;
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error accessing localStorage: $e');
        }
      }
    }

    if (tabToChangeTo != null) {
      tabToChangeTo.click();
    } else if (saveKey == 'dev-os') {
      // If this tab wrapper is for the archive page,
      // and no tab was retrieved from local storage,
      // switch to the tab for the current OS.
      var currentOperatingSystem = browserOperatingSystem;
      if (currentOperatingSystem == null) {
        currentOperatingSystem = .windows;
      } else if (currentOperatingSystem == .chromeOS) {
        // ChromeOS uses the Linux tab.
        currentOperatingSystem = .linux;
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
      try {
        web.window.localStorage.setItem(key, value);
        updatedQueryParameters.remove(key);
      } catch (e) {
        if (kDebugMode) {
          print('Error accessing localStorage: $e');
        }
      }
    }
  }

  if (originalQueryParameters.length != updatedQueryParameters.length) {
    // If the query parameters were updated, update the user's URL.
    web.window.history.replaceState(
      null,
      '',
      currentUrl.withQueryParameters(updatedQueryParameters).toString(),
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

void _setUpExpandableCards() {
  var currentFragment = web.window.location.hash.trim().toLowerCase();
  if (currentFragment.startsWith('#')) {
    // Remove the leading '#' from the fragment.
    currentFragment = currentFragment.substring(1);
  }
  final expandableCards = web.document.querySelectorAll('.expandable-card');
  web.Element? targetCard;

  for (var i = 0; i < expandableCards.length; i++) {
    final card = expandableCards.item(i) as web.Element;
    final expandButton = card.querySelector('.expand-button');
    if (expandButton == null) continue;

    expandButton.addEventListener(
      'click',
      ((web.Event e) {
        if (card.classList.contains('collapsed')) {
          card.classList.remove('collapsed');
          expandButton.ariaExpanded = 'true';
        } else {
          card.classList.add('collapsed');
          expandButton.ariaExpanded = 'false';
        }
        e.preventDefault();
      }).toJS,
    );

    // If the card is the currently specified fragment, expand it.
    if (card.id == currentFragment) {
      card.classList.remove('collapsed');
      expandButton.ariaExpanded = 'true';
      targetCard = card;
    }
  }

  if (targetCard != null) {
    // Scroll the expanded card into view.
    targetCard.scrollIntoView();
  }
}

void _setUpPlatformKeys() {
  final os = browserOperatingSystem;
  // Use Command key for macOS, Control key for other OS.
  final specialKey = switch (os) {
    .macOS => 'Command',
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
}

final ValueNotifier<bool> showPageTitle = ValueNotifier<bool>(true);
final ValueNotifier<String?> currentPageHeading = ValueNotifier<String?>(null);

void _setUpTocActiveObserver() {
  final headings = web.document.querySelectorAll(
    'article .header-wrapper, '
    'article .stepper .step-title, '
    '#site-content-title',
  );

  // No need to have toc scrollspy if there is only one non-title heading.
  if (headings.length < 2) return;

  final visibleAnchors = <String>{};

  final observer = web.IntersectionObserver(
    ((JSArray<web.IntersectionObserverEntry> entries) {
      for (var i = 0; i < entries.length; i++) {
        final entry = entries[i];
        final heading = entry.target.querySelector('h1, h2, h3');
        final headingId = heading?.id;
        if (headingId == null) continue;

        if (entry.isIntersecting) {
          visibleAnchors.add(headingId);
        } else {
          visibleAnchors.remove(headingId);
        }
      }

      // If the page title is visible, show it instead of the active heading.
      showPageTitle.value = visibleAnchors.contains('document-title');

      final tocLinks = web.document.querySelectorAll(
        '.toc-list .sidenav-item a',
      );
      if (tocLinks.length > 0) {
        var isFirst = true;
        for (var i = 0; i < tocLinks.length; i++) {
          final tocLink = tocLinks.item(i) as web.Element;
          final headingId = tocLink.getAttribute('href')?.substring(1);
          if (headingId == null) continue;

          final sidenavItem = tocLink.closest('.sidenav-item');
          if (sidenavItem == null) continue;

          if (visibleAnchors.contains(headingId)) {
            sidenavItem.classList.add('active');

            if (isFirst) {
              currentPageHeading.value = tocLink.textContent!;
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

void _setUpSteppers() {
  final steppers = web.document.querySelectorAll('.stepper');

  for (var i = 0; i < steppers.length; i++) {
    final stepper = steppers.item(i) as web.HTMLElement;

    final collapsible = !stepper.classList.contains('non-collapsible');

    final children = stepper.childNodes;
    final steps = [
      for (var j = 0; j < children.length; j++)
        if (children.item(j) case web.Element(
          nodeType: web.Node.ELEMENT_NODE,
          tagName: 'DETAILS',
        ))
          children.item(j) as web.HTMLDetailsElement,
    ];

    for (var j = 0; j < steps.length; j++) {
      final step = steps[j];
      final header = step.querySelector('summary h2, summary h3');

      if (collapsible) {
        if (header?.textContent case final title? when step.open) {
          currentPageHeading.value = title;
        }

        step.addEventListener(
          'toggle',
          ((web.Event e) {
            // Close all other steps when one is opened.
            if (step.open) {
              for (var k = 0; k < steps.length; k++) {
                final otherStep = steps[k];
                if (otherStep != step) {
                  otherStep.open = false;
                }
              }

              if (header?.textContent case final title?) {
                currentPageHeading.value = title;
              }
            }
          }).toJS,
        );
      }

      final nextButton = step.querySelector('.next-step-button');
      if (nextButton != null) {
        nextButton.addEventListener(
          'click',
          ((web.Event e) {
            e.preventDefault();
            if (collapsible) {
              step.open = false;
            }
            _scrollTo(step, smooth: false);
            if (j + 1 < steps.length) {
              final nextStep = steps[j + 1];
              nextStep.open = true;
              _scrollTo(nextStep, smooth: true);

              final nextHeader = nextStep.querySelector(
                'summary h2, summary h3',
              );
              if (nextHeader?.textContent case final title?) {
                currentPageHeading.value = title;
              }
            }
          }).toJS,
        );
      }
    }
  }
}

void _scrollTo(web.Element element, {required bool smooth}) {
  // Scroll the next step into view, accounting for the fixed header and toc.
  final headerOffset =
      web.document.getElementById('site-header')?.clientHeight ?? 0;
  final tocOffset = web.document.getElementById('pagenav')?.clientHeight ?? 0;
  final elementPosition = element.getBoundingClientRect().top;
  final offsetPosition =
      elementPosition + web.window.scrollY - headerOffset - tocOffset;

  web.window.scrollTo(
    web.ScrollToOptions(
      top: offsetPosition,
      behavior: smooth ? 'smooth' : 'auto',
    ),
  );
}

/// Set up interactivity of the file/detail explorer created with
/// the `<IdeExplorer>` custom component.
void _setUpIdeExplorers() {
  final explorers = web.document.querySelectorAll('.ide-explorer');
  for (var i = 0; i < explorers.length; i++) {
    _setUpIdeExplorer(explorers.item(i) as web.Element);
  }
}

void _setUpIdeExplorer(web.Element explorer) {
  void selectIdeNode(String domId) {
    final selectTargets = explorer.querySelectorAll('[data-ide-select]');
    web.Element? sidebarTarget;
    for (var i = 0; i < selectTargets.length; i++) {
      final target = selectTargets.item(i) as web.Element;
      final isMatch = target.getAttribute('data-ide-select') == domId;
      target.classList.toggle('active', isMatch);
      if (isMatch && target.closest('.ide-tree') != null) {
        sidebarTarget = target;
      }
    }

    final panels = explorer.querySelectorAll('[data-ide-panel]');
    for (var i = 0; i < panels.length; i++) {
      final panel = panels.item(i) as web.Element;
      panel.classList.toggle(
        'active',
        panel.getAttribute('data-ide-panel') == domId,
      );
    }

    // Expand every ancestor folder so the selected item stays visible.
    final ownDetails = sidebarTarget?.closest('details');
    final isFolderSelf =
        sidebarTarget?.parentElement?.tagName.toLowerCase() == 'summary';
    var current = isFolderSelf ? ownDetails?.parentElement : ownDetails;
    while (current != null) {
      final ancestorDetails = current.closest('details');
      if (ancestorDetails == null) break;
      (ancestorDetails as web.HTMLDetailsElement).open = true;
      current = ancestorDetails.parentElement;
    }
  }

  void switchIdeRoot(String rootId) {
    final tabs = explorer.querySelectorAll('.ide-root-tab');
    for (var i = 0; i < tabs.length; i++) {
      final tab = tabs.item(i) as web.Element;
      tab.classList.toggle(
        'active',
        tab.getAttribute('data-ide-root') == rootId,
      );
    }

    final trees = explorer.querySelectorAll('.ide-tree');
    web.Element? activeTree;
    for (var i = 0; i < trees.length; i++) {
      final tree = trees.item(i) as web.Element;
      final isMatch = tree.getAttribute('data-ide-root') == rootId;
      tree.classList.toggle('active', isMatch);
      if (isMatch) activeTree = tree;
    }

    final firstDomId = activeTree
        ?.querySelector('[data-ide-select]')
        ?.getAttribute('data-ide-select');
    if (firstDomId != null) {
      selectIdeNode(firstDomId);
    }
  }

  void toggleAllIdeFolders() {
    final activeTree =
        explorer.querySelector('.ide-tree.active') ??
        explorer.querySelector('.ide-tree');
    if (activeTree == null) return;

    final allDetails = activeTree.querySelectorAll('details');
    var anyClosed = false;
    for (var i = 0; i < allDetails.length; i++) {
      if (!(allDetails.item(i) as web.HTMLDetailsElement).open) {
        anyClosed = true;
        break;
      }
    }

    for (var i = 0; i < allDetails.length; i++) {
      (allDetails.item(i) as web.HTMLDetailsElement).open = anyClosed;
    }
  }

  void handleClick(web.Event event) {
    final target = event.target as web.Element?;
    if (target == null) return;

    final selectTarget = target.closest('[data-ide-select]');
    if (selectTarget != null) {
      final domId = selectTarget.getAttribute('data-ide-select');
      if (domId != null) selectIdeNode(domId);
      event.preventDefault();
      return;
    }

    final rootTab = target.closest('.ide-root-tab');
    if (rootTab != null) {
      final rootId = rootTab.getAttribute('data-ide-root');
      if (rootId != null) switchIdeRoot(rootId);
      return;
    }

    if (target.closest('[data-ide-toggle-all]') != null) {
      toggleAllIdeFolders();
    }
  }

  explorer.addEventListener('click', handleClick.toJS);
}

/// Set up interactivity for the FlutterBench grader matrix component.
void _setUpGraderMatrix() {
  final matrices = web.document.querySelectorAll('.grader-matrix');
  for (var i = 0; i < matrices.length; i++) {
    _setUpSingleGraderMatrix(matrices.item(i) as web.Element);
  }
}

void _setUpSingleGraderMatrix(web.Element matrix) {
  final buttons = matrix.querySelectorAll('.matrix-filters .filter-btn');
  final cards = matrix.querySelectorAll('.grader-cards-track .grader-card');
  final track = matrix.querySelector('.grader-cards-track') as web.HTMLElement?;
  final prevBtn =
      matrix.querySelector('.carousel-nav-btn.prev') as web.HTMLElement?;
  final nextBtn =
      matrix.querySelector('.carousel-nav-btn.next') as web.HTMLElement?;

  if (track == null) return;

  List<web.HTMLElement> getVisibleCards() {
    final list = <web.HTMLElement>[];
    for (var i = 0; i < cards.length; i++) {
      final card = cards.item(i) as web.HTMLElement;
      if (!card.classList.contains('hidden')) {
        list.add(card);
      }
    }
    return list;
  }

  void scrollNext() {
    final visibleCards = getVisibleCards();
    if (visibleCards.isEmpty) return;

    final maxScroll = track.scrollWidth - track.clientWidth;
    final currentScroll = track.scrollLeft;

    // Find the first visible card that starts after currentScroll + 10px.
    var scrolled = false;
    for (final card in visibleCards) {
      final cardOffset = card.offsetLeft - track.offsetLeft;
      if (cardOffset > currentScroll + 10) {
        track.scrollTo(
          web.ScrollToOptions(
            left: cardOffset.toDouble(),
            behavior: 'smooth',
          ),
        );
        scrolled = true;
        break;
      }
    }

    // If already at or near the end, rotate back to the start.
    if (!scrolled || currentScroll >= maxScroll - 10) {
      track.scrollTo(
        web.ScrollToOptions(
          left: 0,
          behavior: 'smooth',
        ),
      );
    }
  }

  void scrollPrev() {
    final visibleCards = getVisibleCards();
    if (visibleCards.isEmpty) return;

    final maxScroll = track.scrollWidth - track.clientWidth;
    final currentScroll = track.scrollLeft;

    // If at or near the beginning, rotate to the end.
    if (currentScroll <= 10) {
      track.scrollTo(
        web.ScrollToOptions(
          left: maxScroll.toDouble(),
          behavior: 'smooth',
        ),
      );
      return;
    }

    // Find the last visible card that starts before currentScroll - 10px.
    for (var i = visibleCards.length - 1; i >= 0; i--) {
      final card = visibleCards[i];
      final cardOffset = card.offsetLeft - track.offsetLeft;
      if (cardOffset < currentScroll - 10) {
        track.scrollTo(
          web.ScrollToOptions(
            left: cardOffset.toDouble(),
            behavior: 'smooth',
          ),
        );
        return;
      }
    }

    track.scrollTo(
      web.ScrollToOptions(
        left: 0,
        behavior: 'smooth',
      ),
    );
  }

  if (nextBtn != null) {
    nextBtn.addEventListener(
      'click',
      ((web.Event e) {
        e.preventDefault();
        scrollNext();
      }).toJS,
    );
  }

  if (prevBtn != null) {
    prevBtn.addEventListener(
      'click',
      ((web.Event e) {
        e.preventDefault();
        scrollPrev();
      }).toJS,
    );
  }

  for (var i = 0; i < buttons.length; i++) {
    final btn = buttons.item(i) as web.HTMLElement;
    final filter = btn.dataset['filter'];

    void handleClick(web.Event event) {
      event.preventDefault();
      for (var j = 0; j < buttons.length; j++) {
        (buttons.item(j) as web.Element).classList.remove('active');
      }
      btn.classList.add('active');

      for (var k = 0; k < cards.length; k++) {
        final card = cards.item(k) as web.HTMLElement;
        if (filter == 'all') {
          card.classList.remove('hidden');
        } else if (filter == 'llm') {
          card.classList.toggle('hidden', !card.classList.contains('cat-llm'));
        } else if (filter == 'deterministic') {
          card.classList.toggle(
            'hidden',
            !card.classList.contains('cat-deterministic'),
          );
        } else {
          card.classList.toggle(
            'hidden',
            !card.classList.contains('cat-$filter'),
          );
        }
      }

      // Reset scroll position to beginning on filter change.
      track.scrollTo(
        web.ScrollToOptions(
          left: 0,
          behavior: 'smooth',
        ),
      );
    }

    btn.addEventListener('click', handleClick.toJS);
  }
}

/// Set up interactivity for FlutterBench interactive detail cards
/// (e.g. ScoreTriage and EvaluationMatrix).
void _setUpInteractiveDetailCards() {
  final cards = web.document.querySelectorAll(
    '.interactive-detail-card, .score-triage',
  );
  for (var i = 0; i < cards.length; i++) {
    _setUpSingleInteractiveDetailCard(cards.item(i) as web.Element);
  }
}

void _setUpSingleInteractiveDetailCard(web.Element card) {
  final buttons = card.querySelectorAll(
    '.card-tabs-grid .card-tab-btn, .triage-tiers-grid .triage-tier-btn',
  );
  final panels = card.querySelectorAll(
    '.card-panels-container .card-panel, .triage-detail-card .triage-panel',
  );
  final detailCard = card.querySelector(
    '.card-panels-container, .triage-detail-card',
  ) as web.HTMLElement?;

  for (var i = 0; i < buttons.length; i++) {
    final btn = buttons.item(i) as web.HTMLElement;
    final tabAttr = btn.dataset['tab'];
    final tabId = tabAttr.isNotEmpty ? tabAttr : btn.dataset['tier'];

    void handleClick(web.Event event) {
      event.preventDefault();
      for (var j = 0; j < buttons.length; j++) {
        (buttons.item(j) as web.Element).classList.remove('active');
      }
      btn.classList.add('active');

      for (var k = 0; k < panels.length; k++) {
        final panel = panels.item(k) as web.HTMLElement;
        final panelTabAttr = panel.dataset['tab'];
        final panelId = panelTabAttr.isNotEmpty
            ? panelTabAttr
            : panel.dataset['tier'];
        panel.classList.toggle('active', panelId == tabId);
      }

      if (detailCard != null) {
        detailCard.scrollTop = 0;
      }
    }

    btn.addEventListener('click', handleClick.toJS);
  }
}
