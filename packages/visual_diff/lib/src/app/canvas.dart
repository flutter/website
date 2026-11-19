// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../models/diff_entry.dart';
import '../models/diff_route.dart';
import 'header.dart';
import 'viewers/diff_mask_viewer.dart';
import 'viewers/onion_skin_viewer.dart';
import 'viewers/side_by_side_viewer.dart';
import 'viewers/swipe_slider_viewer.dart';
import 'viewers/toggle_viewer.dart';

/// The central canvas displaying the active screenshot diff inspection mode
/// and the Viewport toggle switcher.
class CanvasComponent extends StatelessComponent {
  final DiffRoute? route;
  final DiffEntry? entry;
  final String activeViewport;
  final ValueChanged<String> onViewportChanged;
  final ReviewMode mode;
  final ValueChanged<DiffRoute>? onUpdateRouteBaseline;

  const CanvasComponent({
    required this.route,
    required this.entry,
    required this.activeViewport,
    required this.onViewportChanged,
    required this.mode,
    this.onUpdateRouteBaseline,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final activeRoute = route;
    final activeEntry = entry;

    if (activeRoute == null || activeEntry == null) {
      return const main_(classes: 'vd-canvas', [
        div(
          classes: 'vd-viewport-container',
          attributes: {
            'style':
                'display: flex; align-items: center; justify-content: center;',
          },
          [
            div(
              attributes: {
                'style':
                    'text-align: center; color: var(--vd-text-muted); '
                    'font-size: 14px;',
              },
              [
                span(
                  attributes: {
                    'style':
                        'font-size: 32px; display: block; margin-bottom: 8px;',
                  },
                  [.text('🔍')],
                ),
                .text(
                  'Select a route from the tree to inspect diffs.',
                ),
              ],
            ),
          ],
        ),
      ]);
    }

    return main_(classes: 'vd-canvas', [
      // Top bar for selected route and viewport toggle
      div(classes: 'vd-canvas-bar', [
        div(classes: 'vd-canvas-info', [
          span(classes: 'vd-canvas-route', [.text(activeRoute.route)]),
          span(
            classes: 'vd-badge vd-badge-${activeRoute.status.name}',
            [.text(activeRoute.status.name.toUpperCase())],
          ),
          span(
            classes: 'vd-canvas-dimensions',
            [.text('${activeEntry.width} × ${activeEntry.height} px')],
          ),
        ]),

        // Viewport Switcher Toggle (Desktop vs Mobile)
        div(classes: 'vd-viewport-switcher', [
          for (final vp in ['desktop', 'mobile'])
            () {
              final vpEntry = activeRoute.viewports[vp];
              final hasVp = vpEntry != null;
              final isVpActive = activeViewport == vp;
              final vpUpper = vp.toUpperCase();
              return button(
                classes: [
                  'vd-vp-btn',
                  if (isVpActive) 'active',
                  if (!hasVp) 'disabled',
                ].join(' '),
                attributes: {
                  if (!hasVp) 'disabled': 'true',
                  'title': hasVp
                      ? 'Switch to $vpUpper viewport (V)'
                      : 'No $vpUpper snapshot available for this route',
                },
                events: hasVp ? {'click': (_) => onViewportChanged(vp)} : null,
                [
                  span(
                    classes: 'vd-vp-icon',
                    [.text(vp == 'desktop' ? '🖥️' : '📱')],
                  ),
                  span(classes: 'vd-vp-label', [.text(vpUpper)]),
                  if (hasVp)
                    span(
                      classes: 'vd-status-dot ${vpEntry.status.name}',
                      attributes: const {
                        'style': 'margin-left: 2px; width: 7px; height: 7px;',
                      },
                      const [],
                    ),
                  if (hasVp && vpEntry.hasDiff)
                    span(
                      classes: 'vd-vp-diff-pill',
                      [.text('${vpEntry.diffPercentage.toStringAsFixed(1)}%')],
                    ),
                ],
              );
            }(),
        ]),

        // Metrics for active viewport snapshot
        div(classes: 'vd-canvas-metrics', [
          if (activeEntry.hasDiff) ...[
            span(
              attributes: const {
                'style':
                    'color: var(--vd-badge-changed-text); font-weight: 600;',
              },
              [
                .text(
                  'Diff: ${activeEntry.diffPercentage.toStringAsFixed(2)}% '
                  '(${activeEntry.diffPixels} px)',
                ),
              ],
            ),
          ] else ...[
            const span(
              attributes: {
                'style':
                    'color: var(--vd-badge-unchanged-text); font-weight: 500;',
              },
              [.text('No visual differences detected in this viewport')],
            ),
          ],
          if (activeRoute.hasDiff)
            button(
              classes: 'vd-btn-accept',
              attributes: const {
                'title':
                    'Accept current snapshots as new baseline for this route',
              },
              events: onUpdateRouteBaseline != null
                  ? {'click': (_) => onUpdateRouteBaseline!(activeRoute)}
                  : null,
              const [
                span([.text('✓')]),
                span([.text('Accept Route')]),
              ],
            ),
        ]),
      ]),

      // Scrollable viewport container
      div(classes: 'vd-viewport-container', [
        switch (mode) {
          ReviewMode.sideBySide => SideBySideViewer(entry: activeEntry),
          ReviewMode.swipe => SwipeSliderViewer(entry: activeEntry),
          ReviewMode.onionSkin => OnionSkinViewer(entry: activeEntry),
          ReviewMode.diffMask => DiffMaskViewer(entry: activeEntry),
          ReviewMode.toggle => ToggleViewer(entry: activeEntry),
        },
      ]),
    ]);
  }
}
