// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A top-level FlutterBench section.
enum FlutterBenchNavItem {
  leaderboard(label: 'Leaderboard', href: '/ai/flutterbench'),
  models(label: 'Models', href: '/ai/flutterbench/models'),
  tasks(label: 'Tasks & CUJs', href: '/ai/flutterbench/tasks'),
  methodology(label: 'Methodology', href: '/ai/flutterbench/methodology'),
  cujs(label: 'CUJs', href: '/ai/flutterbench/cujs');

  const FlutterBenchNavItem({required this.label, required this.href});

  final String label;
  final String href;
}

/// The sub-navigation shared by every FlutterBench page.
class FlutterBenchNav extends StatelessComponent {
  const FlutterBenchNav({required this.current, super.key});

  /// The section currently being viewed.
  final FlutterBenchNavItem current;

  @override
  Component build(BuildContext context) {
    return nav(classes: 'bench-tab-nav', [
      for (final item in FlutterBenchNavItem.values)
        a(
          href: item.href,
          classes: [
            'bench-nav-link',
            if (item == current) 'active',
          ].join(' '),
          attributes: {if (item == current) 'aria-current': 'page'},
          [.text(item.label)],
        ),
    ]);
  }
}
