// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/diff_entry.dart';

/// Diff Mask viewer highlighting changed pixels in neon magenta.
class DiffMaskViewer extends StatelessComponent {
  final DiffEntry entry;

  const DiffMaskViewer({required this.entry, super.key});

  @override
  Component build(BuildContext context) {
    if (entry.diffRelativePath == null) {
      return div(
        attributes: const {
          'style':
              'padding: 80px 40px; text-align: center; '
              'color: var(--vd-text-muted); font-size: 13px;',
        },
        [
          .text(
            entry.status == DiffStatus.unchanged
                ? 'No diff mask available because snapshots are '
                      '100% identical.'
                : 'No diff mask available for ${entry.status.name} routes.',
          ),
        ],
      );
    }

    return div(classes: 'vd-diff-wrapper', [
      img(
        classes: 'vd-diff-img',
        src: '/${entry.diffRelativePath}',
        alt: 'Diff mask of ${entry.route}',
      ),
    ]);
  }
}
