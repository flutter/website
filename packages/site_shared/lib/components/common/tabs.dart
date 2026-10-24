// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'client/tabs.dart';

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

    return InteractiveDashTabs(
      id: '${_currentTabWrapperId++}',
      saveKey: node.attributes['key'],
      wrapped: node.attributes['wrapped'] == 'true',
      tabs: [
        for (final tab in tabs)
          DashTab(
            tabName: tab.attributes['name']!,
            baseId: '${_currentTabId++}',
            saveId: tab.attributes['id'],
          ),
      ],
      tabContents: [
        for (final tab in tabs) builder.build(tab.children),
      ],
    );
  }
}
