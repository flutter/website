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
class WhyFlutterCodeSharedSection extends StatefulComponent {
  const WhyFlutterCodeSharedSection({required this.laptopSprite, super.key});

  /// Resolved URL of the Dash-at-laptop sprite sheet.
  final String laptopSprite;

  @override
  State<WhyFlutterCodeSharedSection> createState() => _WhyFlutterCodeSharedSectionState();
}

class _WhyFlutterCodeSharedSectionState extends State<WhyFlutterCodeSharedSection> {
  static const _sharedPercentage = 97;

  bool _isSpriteRunning = false;
  int _percentage = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    observeOnce('#why-flutter-code-shared', () {
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
    return section(id: 'code-shared', classes: 'module why-flutter-shared', [
      div(classes: 'why-flutter-row why-flutter-row-reverse container', [
        div(classes: 'why-flutter-shared-media', [
          div(id: 'why-flutter-code-shared', classes: 'why-flutter-shared-stat', [
            const p(classes: 'why-flutter-kicker', [.text('Code shared')]),
            span(classes: 'why-flutter-stat-number', [.text('$_percentage%')]),
          ]),
          div(
            classes: [
              'why-flutter-laptop-sprite',
              if (_isSpriteRunning) 'is-running',
            ].join(' '),
            styles: Styles(
              raw: {
                '--why-flutter-sprite': 'url(${component.laptopSprite})',
              },
            ),
            const [],
          ),
        ]),
        const div(classes: 'why-flutter-shared-copy', [
          h2([.text('One team, not three')]),
          p(classes: 'why-flutter-body', [
            .text(
              'One codebase. Lower costs. Eliminate the overhead of '
              'maintaining separate native development teams.',
            ),
          ]),
          a(
            href: '/showcase',
            classes: 'btn why-flutter-outline-btn',
            [.text('See success cases')],
          ),
        ]),
      ]),
    ]);
  }
}
