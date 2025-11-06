// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../util.dart';

/// A tabs component where children tabs can be switched between by the user.
class DashTabs extends CustomComponent {
  static int _currentTabWrapperId = 0;
  static int _currentTabId = 0;

  const DashTabs() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode || node.tag != 'Tabs') {
      return null;
    }

    final tabs = node.children
        ?.whereType<ElementNode>()
        .where((n) => n.tag == 'Tab')
        .toList(growable: false);
    if (tabs == null || tabs.length < 2) {
      print('[ERROR] The <Tabs> element requires at least 2 <Tab> children!');
      return null;
    }

    final wrapperId = '${_currentTabWrapperId++}';

    return _DashTabsWrapper(
      id: wrapperId,
      saveKey: node.attributes['key'],
      wrapped: node.attributes['wrapped'] == 'true',
      tabs: [
        for (final (tabIndex, tab) in tabs.indexed)
          _DashTabPane(
            tabName: tab.attributes['name']!,
            baseId: '${_currentTabId++}',
            isActive: tabIndex == 0,
            wrapperId: wrapperId,
            child: builder.build(tab.children),
            saveId: tab.attributes['id'],
          ),
      ],
    );
  }
}

class _DashTabsWrapper extends StatelessComponent {
  const _DashTabsWrapper({
    required this.id,
    required this.tabs,
    this.saveKey,
    this.wrapped = false,
  });

  final String id;
  final String? saveKey;
  final bool wrapped;
  final List<_DashTabPane> tabs;

  @override
  Component build(BuildContext context) {
    return div(
      id: id,
      classes: ['tabs-wrapper', if (wrapped) 'wrapped'].toClasses,
      attributes: {
        'data-tab-save-key': ?saveKey,
      },
      [
        ul(
          classes: 'nav-tabs',
          attributes: {
            'role': 'tablist',
          },
          [
            for (final tab in tabs)
              li(classes: 'nav-item', [
                a(
                  id: tab.tabId,
                  href: '#${tab.panelId}',
                  classes: [
                    'nav-link',
                    if (tab.isActive) 'active',
                  ].toClasses,
                  attributes: {
                    'tabindex': '0',
                    'data-tab-save-id': tab.saveId,
                    'role': 'tab',
                    'aria-controls': tab.panelId,
                    'aria-selected': '${tab.isActive}',
                  },
                  [text(tab.tabName)],
                ),
              ]),
          ],
        ),
        div(
          classes: 'tab-content',
          tabs,
        ),
      ],
    );
  }
}

/// An individual pane in a collection of tabs.
class _DashTabPane extends StatelessComponent {
  _DashTabPane({
    required this.tabName,
    required String baseId,
    required this.isActive,
    required this.wrapperId,
    required this.child,
    String? saveId,
  }) : tabId = '$baseId-tab',
       panelId = '$baseId-tab-panel',
       saveId = saveId ?? slugify(tabName);

  final String tabName;
  final String tabId;
  final String panelId;
  final String saveId;
  final bool isActive;
  final String wrapperId;
  final Component child;

  @override
  Component build(BuildContext context) {
    return div(
      id: panelId,
      classes: ['tab-pane', if (isActive) 'active'].toClasses,
      attributes: {
        'role': 'tabpanel',
        'aria-labelledby': tabId,
        'data-tab-id': tabId,
        'data-tab-wrapper-id': wrapperId,
      },
      [child],
    );
  }
}
