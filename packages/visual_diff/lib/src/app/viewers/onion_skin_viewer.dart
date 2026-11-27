// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../models/diff_entry.dart';

/// Onion skin viewer with cross-fade opacity slider between Baseline
/// and Current.
class OnionSkinViewer extends StatefulComponent {
  final DiffEntry entry;

  const OnionSkinViewer({required this.entry, super.key});

  @override
  State<OnionSkinViewer> createState() => _OnionSkinViewerState();
}

class _OnionSkinViewerState extends State<OnionSkinViewer> {
  double opacity = 0.5;

  @override
  Component build(BuildContext context) {
    final entry = component.entry;
    final baselineSrc = entry.baselineRelativePath != null
        ? '/${entry.baselineRelativePath}'
        : null;
    final currentSrc = entry.currentRelativePath != null
        ? '/${entry.currentRelativePath}'
        : null;

    if (baselineSrc == null || currentSrc == null) {
      return const div(
        attributes: {
          'style':
              'padding: 80px 40px; text-align: center; '
              'color: var(--vd-text-muted); font-size: 13px;',
        },
        [
          .text(
            'Onion skin requires both baseline and current snapshots.',
          ),
        ],
      );
    }

    final pct = (opacity * 100).round();

    return div(
      attributes: const {
        'style':
            'display: flex; flex-direction: column; align-items: center; '
            'gap: 16px; width: 100%;',
      },
      [
        div(classes: 'vd-onion-wrapper', [
          img(
            classes: 'vd-onion-baseline',
            src: baselineSrc,
            alt: 'Baseline snapshot',
          ),
          img(
            classes: 'vd-onion-current',
            attributes: {'style': 'opacity: $opacity;'},
            src: currentSrc,
            alt: 'Current snapshot with opacity',
          ),
        ]),
        div(classes: 'vd-onion-bar', [
          span(
            attributes: const {
              'style':
                  'font-size: 12px; font-weight: 600; '
                  'color: var(--vd-text-secondary);',
            },
            [.text('Opacity: $pct%')],
          ),
          input(
            type: InputType.range,
            classes: 'vd-onion-slider',
            attributes: {
              'min': '0',
              'max': '100',
              'value': '$pct',
              'style': 'width: 180px; cursor: pointer;',
            },
            events: {
              'input': (e) {
                if (e.target case final web.HTMLInputElement inputEl) {
                  final val = int.tryParse(inputEl.value) ?? 50;
                  setState(() {
                    opacity = val / 100.0;
                  });
                }
              },
            },
          ),
          div(
            attributes: const {'style': 'display: flex; gap: 4px;'},
            [
              for (final preset in [0, 25, 50, 75, 100])
                button(
                  classes: 'vd-filter-pill',
                  attributes: const {
                    'style': 'padding: 2px 7px; font-size: 10px;',
                  },
                  events: {
                    'click': (_) => setState(() => opacity = preset / 100.0),
                  },
                  [.text('$preset%')],
                ),
            ],
          ),
        ]),
      ],
    );
  }
}
