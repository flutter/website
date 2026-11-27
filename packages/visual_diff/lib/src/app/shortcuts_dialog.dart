// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Modal dialog showing keyboard navigation shortcuts.
class ShortcutsDialog extends StatelessComponent {
  final VoidCallback onClose;

  const ShortcutsDialog({required this.onClose, super.key});

  @override
  Component build(BuildContext context) {
    const shortcuts = [
      ('Previous screenshot', '↑ or K'),
      ('Next screenshot', '↓ or J'),
      ('Toggle Baseline / Current', 'Space'),
      ('Side-by-Side review mode', '1'),
      ('Swipe Slider review mode', '2'),
      ('Onion Skin review mode', '3'),
      ('Diff Mask review mode', '4'),
      ('Toggle Flicker review mode', '5'),
      ('Metadata & SEO review mode', '6'),
      ('Focus search bar', '/'),
      ('Switch Viewport (Desktop / Mobile)', 'V'),
      ('Toggle Dark / Light theme', 'T'),
      ('Close this dialog', 'Esc or ?'),
    ];

    return div(
      classes: 'vd-modal-backdrop',
      events: {'click': (_) => onClose()},
      [
        div(
          classes: 'vd-modal',
          events: {'click': (e) => e.stopPropagation()},
          [
            div(classes: 'vd-modal-header', [
              const span([.text('Keyboard Shortcuts')]),
              button(
                classes: 'vd-icon-btn',
                attributes: const {'style': 'border: none;'},
                events: {'click': (_) => onClose()},
                const [.text('✕')],
              ),
            ]),
            div(classes: 'vd-modal-body', [
              for (final (label, kbd) in shortcuts)
                div(classes: 'vd-shortcut-row', [
                  span([.text(label)]),
                  span(classes: 'vd-kbd', [.text(kbd)]),
                ]),
            ]),
          ],
        ),
      ],
    );
  }
}
