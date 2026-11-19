// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../models/diff_entry.dart';

/// Interactive Swipe / Split-Slider viewer.
///
/// Uses CSS `clip-path` to layer the Current snapshot on top of the Baseline
/// snapshot with 100% pixel-perfect alignment and zero stretching.
/// Uses a full-surface native range slider input overlay for bulletproof,
/// zero-latency dragging across all platforms, trackpads, and touch devices.
class SwipeSliderViewer extends StatefulComponent {
  final DiffEntry entry;

  const SwipeSliderViewer({required this.entry, super.key});

  @override
  State<SwipeSliderViewer> createState() => _SwipeSliderViewerState();
}

class _SwipeSliderViewerState extends State<SwipeSliderViewer> {
  double sliderPosition = 50.0;

  void _updatePosition(double percentage) {
    final clamped = percentage.clamp(0.0, 100.0);
    final posStr = clamped.toStringAsFixed(2);

    if (kIsWeb) {
      final container = web.document.querySelector('.vd-swipe-wrapper');
      if (container != null) {
        final current = container.querySelector('.vd-swipe-current');
        final divider = container.querySelector('.vd-swipe-divider');
        final range = container.querySelector('.vd-swipe-range');
        if (current case final web.HTMLElement el) {
          el.style.clipPath = 'inset(0 0 0 $posStr%)';
        }
        if (divider case final web.HTMLElement el) {
          el.style.left = '$posStr%';
        }
        if (range case final web.HTMLInputElement inputEl) {
          if (inputEl.value != posStr) {
            inputEl.value = posStr;
          }
        }
      }
    }

    setState(() {
      sliderPosition = clamped;
    });
  }

  void _onPointerDrag(web.MouseEvent me) {
    if (!kIsWeb) return;
    final container = web.document.querySelector('.vd-swipe-wrapper');
    if (container == null) return;
    final rect = container.getBoundingClientRect();
    if (rect.width <= 0) return;
    final x = me.clientX - rect.left;
    final percentage = (x / rect.width * 100.0).clamp(0.0, 100.0);
    _updatePosition(percentage);
  }

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
            'Swipe slider requires both baseline and current snapshots.',
          ),
        ],
      );
    }

    final posStr = sliderPosition.toStringAsFixed(2);

    return div(
      classes: 'vd-swipe-wrapper',
      events: {
        'pointerdown': (e) {
          if (e case final web.MouseEvent me) {
            _onPointerDrag(me);
          }
        },
      },
      [
        // Baseline image (Underneath, establishes container aspect ratio)
        img(
          classes: 'vd-swipe-baseline',
          attributes: const {
            'draggable': 'false',
          },
          src: baselineSrc,
          alt: 'Baseline snapshot (Before)',
        ),

        // Current image (Overlay, perfectly aligned via clip-path)
        img(
          classes: 'vd-swipe-current',
          attributes: {
            'draggable': 'false',
            'style': 'clip-path: inset(0 0 0 $posStr%);',
          },
          src: currentSrc,
          alt: 'Current snapshot overlay (After)',
        ),

        // Swipe divider line & sticky handle
        div(
          classes: 'vd-swipe-divider',
          attributes: {'style': 'left: $posStr%;'},
          const [
            div(
              classes: 'vd-swipe-handle',
              [
                span(
                  attributes: {
                    'style':
                        'letter-spacing: -1px; '
                        'font-size: 10px; font-weight: 700; user-select: none;',
                  },
                  [.text('◀▶')],
                ),
              ],
            ),
          ],
        ),

        // Full-surface native range slider input
        input(
          classes: 'vd-swipe-range',
          type: InputType.range,
          attributes: {
            'min': '0',
            'max': '100',
            'step': '0.1',
            'value': posStr,
            'aria-label': 'Visual comparison swipe slider',
          },
          events: {
            'input': (e) {
              if (e.target case final web.HTMLInputElement inputEl) {
                final val = double.tryParse(inputEl.value);
                if (val != null) {
                  _updatePosition(val);
                }
              }
            },
            'change': (e) {
              if (e.target case final web.HTMLInputElement inputEl) {
                final val = double.tryParse(inputEl.value);
                if (val != null) {
                  _updatePosition(val);
                }
              }
            },
            'pointermove': (e) {
              if (e case final web.MouseEvent me) {
                if (me.buttons == 1) {
                  _onPointerDrag(me);
                }
              }
            },
          },
        ),

        // Corner indicator badges
        const div(
          classes: 'vd-swipe-badge before',
          [.text('BEFORE (BASELINE)')],
        ),
        const div(
          classes: 'vd-swipe-badge after',
          [.text('AFTER (CURRENT)')],
        ),
      ],
    );
  }
}
