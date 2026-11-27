// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../models/diff_manifest.dart';

/// The active diff review mode.
enum ReviewMode {
  sideBySide('Side-by-Side', '1'),
  swipe('Swipe', '2'),
  onionSkin('Onion Skin', '3'),
  diffMask('Diff Mask', '4'),
  toggle('Toggle', '5'),
  metadata('Metadata', '6');

  final String label;
  final String keyHint;

  const ReviewMode(this.label, this.keyHint);
}

/// The top navigation header containing site brand, changed route counters,
/// review mode selection pills, and theme/shortcut toggles.
class HeaderComponent extends StatelessComponent {
  final DiffManifest manifest;
  final int changedRoutesCount;
  final ReviewMode currentMode;
  final ValueChanged<ReviewMode> onModeChanged;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onOpenShortcuts;

  const HeaderComponent({
    required this.manifest,
    required this.changedRoutesCount,
    required this.currentMode,
    required this.onModeChanged,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onOpenShortcuts,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return header(classes: 'vd-header', [
      // Left: Logo & badges
      div(classes: 'vd-brand', [
        const span(
          attributes: {'style': 'font-size: 18px;'},
          [.text('📸')],
        ),
        const span([.text('Visual Diff')]),
        span(classes: 'vd-brand-badge', [.text(manifest.site.toUpperCase())]),
        if (changedRoutesCount > 0)
          span(
            classes: 'vd-badge vd-badge-changed',
            [.text('$changedRoutesCount changed')],
          )
        else
          const span(
            classes: 'vd-badge vd-badge-unchanged',
            [.text('All match')],
          ),
        if (manifest.metadataChangedCount > 0)
          span(
            classes: 'vd-badge',
            attributes: {
              'style':
                  'background: rgba(14, 165, 233, 0.15); color: #0284c7; '
                  'border: 1px solid rgba(14, 165, 233, 0.3); '
                  'font-weight: 600;',
              'title':
                  '${manifest.metadataChangedCount} routes have title '
                  'or meta tag changes',
            },
            [.text('${manifest.metadataChangedCount} meta')],
          ),
      ]),

      // Center: Review Mode selector pills
      div(classes: 'vd-header-center', [
        div(classes: 'vd-mode-pills', [
          for (final mode in ReviewMode.values)
            button(
              classes: [
                'vd-mode-btn',
                if (currentMode == mode) 'active',
              ].join(' '),
              events: {'click': (_) => onModeChanged(mode)},
              [
                .text(mode.label),
                span(classes: 'vd-mode-key', [.text(mode.keyHint)]),
              ],
            ),
        ]),
      ]),

      // Right: Actions (Theme & Shortcuts)
      div(classes: 'vd-header-actions', [
        // Dark / Light theme toggle
        button(
          classes: 'vd-icon-btn',
          attributes: const {'title': 'Toggle theme (T)'},
          events: {'click': (_) => onToggleTheme()},
          [
            .text(isDarkMode ? '☀️' : '🌙'),
          ],
        ),

        // Shortcuts dialog button
        button(
          classes: 'vd-icon-btn',
          attributes: const {'title': 'Keyboard shortcuts (?)'},
          events: {'click': (_) => onOpenShortcuts()},
          const [
            .text('?'),
          ],
        ),
      ]),
    ]);
  }
}
