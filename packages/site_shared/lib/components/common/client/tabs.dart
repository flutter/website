// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../../util.dart';
import '../../../web_util.dart';

@client
class InteractiveDashTabs extends StatefulComponent {
  const InteractiveDashTabs({
    required this.id,
    required this.tabs,
    required this.tabContents,
    this.saveKey,
    this.wrapped = false,
  }) : assert(
         tabs.length == tabContents.length,
         'tabs and tabContents must have the same length!',
       );

  final String id;
  final String? saveKey;
  final bool wrapped;
  final List<DashTab> tabs;
  final List<Component> tabContents;

  @override
  State<InteractiveDashTabs> createState() => InteractiveDashTabsState();
}

class InteractiveDashTabsState extends State<InteractiveDashTabs> {
  static final Map<String, Set<InteractiveDashTabsState>> tabStates = {};

  int activeTabIndex = 0;
  String get saveKey => component.saveKey ?? '';

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _initSaveState();

      if (saveKey.isNotEmpty) {
        tabStates.putIfAbsent(saveKey, () => {});
        tabStates[saveKey]!.add(this);

        // If a tab was previously specified as selected in local storage,
        // save a reference to it that can be switched to later.

        var savedTabId = '';
        try {
          savedTabId =
              web.window.localStorage.getItem('tab-save-$saveKey') ?? '';
        } catch (e) {
          if (kDebugMode) {
            print('Error accessing localStorage: $e');
          }
        }

        if (savedTabId.isNotEmpty) {
          _activateTabWithSaveId(savedTabId);
        } else if (saveKey == 'dev-os') {
          // If this tab wrapper is for the archive page,
          // and no tab was retrieved from local storage,
          // switch to the tab for the current OS.
          var currentOperatingSystem = browserOperatingSystem ?? .windows;
          if (currentOperatingSystem == .chromeOS) {
            // ChromeOS uses the Linux tab.
            currentOperatingSystem = .linux;
          }

          _activateTabWithSaveId(currentOperatingSystem.name.toLowerCase());
        }
      }
    }
  }

  @override
  void dispose() {
    tabStates[saveKey]?.remove(this);
    super.dispose();
  }

  static bool _didInitSaveState = false;
  static void _initSaveState() {
    if (_didInitSaveState) return;
    _didInitSaveState = true;

    // Apply force overrides from query parameters to saved tabs.
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

  void _selectTab(int index, DashTab tab) {
    if (saveKey.isNotEmpty && tab.tabSaveId.isNotEmpty) {
      // If the tab wrapper and this tab have a save key and ID defined,
      // switch other tabs to the tab with the same ID.

      final syncedTabStates = tabStates[saveKey] ?? {};
      for (final state in syncedTabStates) {
        state._activateTabWithSaveId(tab.tabSaveId);
      }

      try {
        web.window.localStorage.setItem('tab-save-$saveKey', tab.tabSaveId);
      } catch (e) {
        if (kDebugMode) {
          print('Error accessing localStorage: $e');
        }
      }
    } else {
      setState(() {
        activeTabIndex = index;
      });
    }
  }

  void _activateTabWithSaveId(String saveId) {
    final index = component.tabs.indexWhere((tab) => tab.tabSaveId == saveId);
    if (index != -1) {
      setState(() => activeTabIndex = index);
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      id: component.id,
      classes: ['tabs-wrapper', if (component.wrapped) 'wrapped'].toClasses,
      [
        ul(
          classes: 'nav-tabs',
          attributes: {'role': 'tablist'},
          [
            for (final (index, tab) in component.tabs.indexed)
              li(classes: 'nav-item', [
                a(
                  id: tab.tabId,
                  href: '#${tab.panelId}',
                  classes: [
                    'nav-link',
                    if (index == activeTabIndex) 'active',
                  ].toClasses,
                  attributes: {
                    'tabindex': '0',
                    'role': 'tab',
                    'aria-controls': tab.panelId,
                    'aria-selected': '${index == activeTabIndex}',
                  },
                  onClick: () {
                    _selectTab(index, tab);
                  },
                  [.text(tab.tabName)],
                ),
              ]),
          ],
        ),
        div(classes: 'tab-content', [
          for (final (index, tab) in component.tabs.indexed)
            div(
              id: tab.panelId,
              classes: [
                'tab-pane',
                if (index == activeTabIndex) 'active',
              ].toClasses,
              attributes: {
                'role': 'tabpanel',
                'aria-labelledby': tab.tabId,
              },
              [component.tabContents[index]],
            ),
        ]),
      ],
    );
  }
}

class DashTab {
  const DashTab({
    required this.tabName,
    required this.baseId,
    this.saveId,
  });

  final String tabName;
  final String baseId;
  final String? saveId;

  String get tabId => '$baseId-tab';
  String get panelId => '$baseId-tab-panel';
  String get tabSaveId => saveId ?? slugify(tabName);

  @decoder
  static DashTab decode(Map<String, Object?> map) {
    return DashTab(
      tabName: map['tabName'] as String,
      baseId: map['baseId'] as String,
      saveId: map['saveId'] as String?,
    );
  }

  @encoder
  Map<String, Object?> encode() {
    return {
      'tabName': tabName,
      'baseId': baseId,
      'saveId': saveId,
    };
  }
}
