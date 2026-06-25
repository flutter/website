// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

class Tab {
  Tab({required this.label, required this.content});

  final String label;
  final ComponentRef content;

  @decoder
  static Tab fromMap(Map<String, Object?> map) {
    return Tab(
      label: map['label'] as String,
      content: ComponentRef.fromId(map['content'] as String),
    );
  }

  @encoder
  Map<String, Object?> toMap() {
    return {'label': label, 'content': content.toId()};
  }
}

@client
class Tabs extends StatefulComponent {
  const Tabs({
    this.title,
    this.header,
    required this.tabs,
    this.noSpy = false,
    super.key,
  });

  final ComponentRef? title;
  final ComponentRef? header;
  final List<Tab> tabs;
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
                [.text(tab.label)],
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
