// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

@client
class Tabs extends StatefulComponent {
  const Tabs({
    this.title,
    this.header,
    required this.labels,
    required this.tabs,
    this.noSpy = false,
    super.key,
  });

  final Component? title;
  final Component? header;
  final List<String> labels;
  final List<Component> tabs;
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
            for (final (index, _) in component.tabs.indexed)
              li(
                classes: 'btn ${index == _activeTab ? 'active' : ''}',
                events: events(
                  onClick: () {
                    setState(() => _activeTab = index);
                  },
                ),
                [.text(component.labels[index])],
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
            [tab],
          ),
      ]),
    ]);
  }
}
