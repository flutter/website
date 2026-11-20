// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A tabbed container component that supports custom headers, labels,
/// and tab panes.
@client
class Tabs extends StatefulComponent {
  /// Creates a tab container with the given [tabs].
  const Tabs({
    this.title,
    this.header,
    required this.tabs,
    this.noSpy = false,
    super.key,
  });

  /// An optional title component displayed alongside the tabs.
  final Component? title;

  /// An optional header component rendered above the tabs menu.
  final Component? header;

  /// The list of tabs.
  final List<Tab> tabs;

  /// Whether scroll-spy behavior is disabled for these tabs.
  final bool noSpy;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _activeTab = 0;

  @override
  Component build(BuildContext context) {
    return div(classes: 'tabs container', [
      ?component.title,
      div(classes: 'tabs-header', [
        ?component.header,
        div(classes: 'tabs-menu', [
          ul(classes: 'tabs-wrapper', [
            for (final (index, tab) in component.tabs.indexed)
              li(
                classes: 'btn ${index == _activeTab ? 'active' : ''}',
                events: events(
                  onClick: () {
                    setState(() => _activeTab = index);
                  },
                ),
                [.text(tab.header)],
              ),
          ]),
        ]),
      ]),
      div(classes: 'tabs-content', [
        for (final (index, tab) in component.tabs.indexed)
          div(
            classes: [
              'tab-content',
              if (component.noSpy) 'no-spy',
              if (index == _activeTab) 'active',
            ].join(' '),
            [tab.content],
          ),
      ]),
    ]);
  }
}

/// Metadata describing a single tab in an [Tabs] component.
class Tab {
  const Tab({
    required this.header,
    required this.content,
  });

  /// The human-readable header.
  final String header;

  final Component content;

  /// Decodes a [Tab] from a serialized map.
  @decoder
  static Tab decode(Map<String, Object?> map, ComponentMount mount) {
    return Tab(
      header: map['header'] as String,
      content: mount(map['content'] as String),
    );
  }

  /// Encodes this [Tab] into a serializable map.
  @encoder
  Map<String, Object?> encode() {
    return {
      'header': header,
      'content': content,
    };
  }
}
