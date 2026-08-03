// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../../utils/visibility_observer.dart';

/// The "One team, not three" section, anchored by the 97% code-shared stat.
///
/// On scrolling into view the Dash-at-laptop sprite plays through once, and
/// the percentage begins counting up 1.5 seconds later.
@client
class WhyUsCodeSharedSection extends StatefulComponent {
  const WhyUsCodeSharedSection({required this.laptopSprite, super.key});

  /// Resolved URL of the Dash-at-laptop sprite sheet.
  final String laptopSprite;

  @override
  State<WhyUsCodeSharedSection> createState() => _WhyUsCodeSharedSectionState();
}

class _WhyUsCodeSharedSectionState extends State<WhyUsCodeSharedSection> {
  static const _sharedPercentage = 97;

  bool _isSpriteRunning = false;
  int _percentage = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    observeOnce('#why-us-code-shared', () {
      setState(() => _isSpriteRunning = true);

      Timer(const Duration(milliseconds: 1500), () {
        animateValue(
          duration: const Duration(milliseconds: 1600),
          onTick: (fraction) {
            setState(() {
              _percentage = (_sharedPercentage * fraction).round();
            });
          },
        );
      });
    });
  }

  @override
  Component build(BuildContext context) {
    return section(id: 'code-shared', classes: 'module why-us-shared', [
      div(classes: 'why-us-row why-us-row-reverse container', [
        div(classes: 'why-us-shared-media', [
          div(id: 'why-us-code-shared', classes: 'why-us-shared-stat', [
            const p(classes: 'why-us-kicker', [.text('Code shared')]),
            span(classes: 'why-us-stat-number', [.text('$_percentage%')]),
          ]),
          div(
            classes: [
              'why-us-laptop-sprite',
              if (_isSpriteRunning) 'is-running',
            ].join(' '),
            styles: Styles(
              raw: {
                '--why-us-sprite': 'url(${component.laptopSprite})',
              },
            ),
            const [],
          ),
        ]),
        const div(classes: 'why-us-shared-copy', [
          h2([.text('One team, not three')]),
          p(classes: 'why-us-body', [
            .text(
              'One codebase. Lower costs. Eliminate the overhead of '
              'maintaining separate native development teams.',
            ),
          ]),
          a(
            href: '/showcase',
            classes: 'btn why-us-outline-btn',
            [.text('See success cases')],
          ),
        ]),
      ]),
    ]);
  }
}
