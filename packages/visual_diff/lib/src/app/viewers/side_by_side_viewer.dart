// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/diff_entry.dart';

/// 2-Up Side-by-Side viewer displaying Baseline and Current side by side.
class SideBySideViewer extends StatelessComponent {
  final DiffEntry entry;

  const SideBySideViewer({required this.entry, super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'vd-2up-wrapper', [
      div(classes: 'vd-2up-pane', [
        div(classes: 'vd-pane-header', [
          const span([.text('Baseline (Before)')]),
          if (entry.baselineRelativePath == null)
            const span([.text('Missing (New)')])
          else
            span([.text('${entry.width}x${entry.height}')]),
        ]),
        if (entry.baselineRelativePath != null)
          img(
            classes: 'vd-pane-img',
            src: '/${entry.baselineRelativePath}',
            alt: 'Baseline snapshot of ${entry.route}',
          )
        else
          const div(
            attributes: {
              'style':
                  'padding: 80px 40px; text-align: center; '
                  'color: var(--vd-text-muted); font-size: 13px;',
            },
            [.text('No baseline exists for this newly added route.')],
          ),
      ]),
      div(classes: 'vd-2up-pane', [
        div(classes: 'vd-pane-header', [
          const span([.text('Current (After)')]),
          if (entry.currentRelativePath == null)
            const span([.text('Deleted')])
          else
            span([.text('${entry.width}x${entry.height}')]),
        ]),
        if (entry.currentRelativePath != null)
          img(
            classes: 'vd-pane-img',
            src: '/${entry.currentRelativePath}',
            alt: 'Current snapshot of ${entry.route}',
          )
        else
          const div(
            attributes: {
              'style':
                  'padding: 80px 40px; text-align: center; '
                  'color: var(--vd-text-muted); font-size: 13px;',
            },
            [.text('This route was removed in the current branch.')],
          ),
      ]),
    ]);
  }
}
