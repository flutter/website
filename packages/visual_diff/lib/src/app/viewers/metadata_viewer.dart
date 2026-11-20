// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/diff_entry.dart';
import '../../models/header_metadata.dart';

/// Renders a dedicated metadata and SEO comparison view for a route,
/// displaying side-by-side or diffed `<title>`, `<link rel="canonical">`,
/// and `<meta>` tags.
class MetadataViewer extends StatelessComponent {
  final DiffEntry entry;

  const MetadataViewer({required this.entry, super.key});

  @override
  Component build(BuildContext context) {
    final bMeta = entry.baselineMetadata;
    final cMeta = entry.currentMetadata;
    final diff = entry.headerDiff ?? HeaderDiff.compare(bMeta, cMeta);

    final hasMeta = bMeta != null || cMeta != null;

    if (!hasMeta) {
      return const div(
        classes: 'vd-meta-empty',
        attributes: {
          'style':
              'display: flex; flex-direction: column; align-items: center; '
              'justify-content: center; padding: 48px; '
              'color: var(--vd-text-muted);',
        },
        [
          span(
            attributes: {'style': 'font-size: 32px; margin-bottom: 8px;'},
            [
              .text('🏷️'),
            ],
          ),
          span(
            attributes: {'style': 'font-size: 15px; font-weight: 500;'},
            [.text('No HTML header metadata recorded for this route.')],
          ),
        ],
      );
    }

    return div(
      classes: 'vd-metadata-viewer',
      attributes: const {
        'style':
            'max-width: 900px; margin: 0 auto; padding: 24px 16px; '
            'display: flex; flex-direction: column; gap: 20px;',
      },
      [
        // 1. Page Title Card
        _buildPropertyCard(
          title: 'Page Title (<title>)',
          isChanged: diff.titleChanged,
          baselineValue: bMeta?.title,
          currentValue: cMeta?.title,
        ),

        // 2. Canonical URL Card
        if (bMeta?.canonical != null || cMeta?.canonical != null)
          _buildPropertyCard(
            title: 'Canonical URL (<link rel="canonical">)',
            isChanged: diff.canonicalChanged,
            baselineValue: bMeta?.canonical,
            currentValue: cMeta?.canonical,
          ),

        // 3. Meta Tags Section
        _buildMetaTagsSection(bMeta: bMeta, cMeta: cMeta, diff: diff),
      ],
    );
  }

  Component _buildPropertyCard({
    required String title,
    required bool isChanged,
    required String? baselineValue,
    required String? currentValue,
  }) {
    return div(
      classes: 'vd-meta-card',
      attributes: const {
        'style':
            'background: var(--vd-surface); '
            'border: 1px solid var(--vd-border); '
            'border-radius: 8px; padding: 16px; '
            'box-shadow: 0 1px 3px rgba(0,0,0,0.05);',
      },
      [
        div(
          attributes: const {
            'style':
                'display: flex; align-items: center; '
                'justify-content: space-between; margin-bottom: 12px;',
          },
          [
            span(
              attributes: const {
                'style':
                    'font-size: 13px; font-weight: 600; '
                    'text-transform: uppercase; letter-spacing: 0.5px; '
                    'color: var(--vd-text-muted);',
              },
              [.text(title)],
            ),
            if (isChanged)
              const span(
                classes: 'vd-badge vd-badge-changed',
                attributes: {'style': 'font-size: 11px; padding: 2px 8px;'},
                [.text('CHANGED')],
              )
            else
              const span(
                classes: 'vd-badge vd-badge-unchanged',
                attributes: {'style': 'font-size: 11px; padding: 2px 8px;'},
                [.text('MATCH')],
              ),
          ],
        ),

        if (isChanged) ...[
          div(
            attributes: const {
              'style':
                  'display: flex; flex-direction: column; gap: 8px; '
                  'font-family: monospace; font-size: 13px;',
            },
            [
              if (baselineValue != null)
                div(
                  attributes: const {
                    'style':
                        'background: rgba(239, 68, 68, 0.1); color: #ef4444; '
                        'padding: 8px 12px; border-radius: 6px; '
                        'border-left: 3px solid #ef4444;',
                  },
                  [
                    const span(
                      attributes: {
                        'style': 'font-weight: 600; margin-right: 6px;',
                      },
                      [.text('− Baseline:')],
                    ),
                    span([
                      .text(baselineValue.isEmpty ? '(empty)' : baselineValue),
                    ]),
                  ],
                ),
              if (currentValue != null)
                div(
                  attributes: const {
                    'style':
                        'background: rgba(34, 197, 94, 0.1); color: #22c55e; '
                        'padding: 8px 12px; border-radius: 6px; '
                        'border-left: 3px solid #22c55e;',
                  },
                  [
                    const span(
                      attributes: {
                        'style': 'font-weight: 600; margin-right: 6px;',
                      },
                      [.text('+ Current:')],
                    ),
                    span([
                      .text(currentValue.isEmpty ? '(empty)' : currentValue),
                    ]),
                  ],
                ),
            ],
          ),
        ] else ...[
          div(
            attributes: const {
              'style':
                  'font-family: monospace; font-size: 13px; '
                  'color: var(--vd-text); background: var(--vd-bg); '
                  'padding: 8px 12px; border-radius: 6px;',
            },
            [
              .text(
                currentValue?.isNotEmpty == true
                    ? currentValue!
                    : (baselineValue ?? '(empty)'),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Component _buildMetaTagsSection({
    required HeaderMetadata? bMeta,
    required HeaderMetadata? cMeta,
    required HeaderDiff diff,
  }) {
    final allKeys = <String>{
      ...?bMeta?.meta.keys,
      ...?cMeta?.meta.keys,
    }.toList()..sort();

    return div(
      classes: 'vd-meta-card',
      attributes: const {
        'style':
            'background: var(--vd-surface); '
            'border: 1px solid var(--vd-border); '
            'border-radius: 8px; padding: 16px; '
            'box-shadow: 0 1px 3px rgba(0,0,0,0.05);',
      },
      [
        div(
          attributes: const {
            'style':
                'display: flex; align-items: center; '
                'justify-content: space-between; margin-bottom: 16px;',
          },
          [
            span(
              attributes: const {
                'style':
                    'font-size: 13px; font-weight: 600; '
                    'text-transform: uppercase; letter-spacing: 0.5px; '
                    'color: var(--vd-text-muted);',
              },
              [.text('Meta Tags (${allKeys.length})')],
            ),
            if (diff.metaChanges.isNotEmpty)
              span(
                classes: 'vd-badge vd-badge-changed',
                attributes: const {
                  'style': 'font-size: 11px; padding: 2px 8px;',
                },
                [.text('${diff.metaChanges.length} MODIFIED')],
              )
            else
              const span(
                classes: 'vd-badge vd-badge-unchanged',
                attributes: {'style': 'font-size: 11px; padding: 2px 8px;'},
                [.text('ALL MATCH')],
              ),
          ],
        ),

        if (allKeys.isEmpty)
          const div(
            attributes: {
              'style': 'color: var(--vd-text-muted); font-size: 13px;',
            },
            [.text('No <meta> tags detected.')],
          )
        else
          div(
            attributes: const {
              'style':
                  'display: flex; flex-direction: column; '
                  'gap: 8px; overflow-x: auto;',
            },
            [
              for (final key in allKeys)
                _buildMetaTagRow(
                  key: key,
                  change: diff.metaChanges[key],
                  baselineVal: bMeta?.meta[key],
                  currentVal: cMeta?.meta[key],
                ),
            ],
          ),
      ],
    );
  }

  Component _buildMetaTagRow({
    required String key,
    required HeaderPropertyDiff? change,
    required String? baselineVal,
    required String? currentVal,
  }) {
    final isChanged = change != null;

    final String badgeClass;
    final String badgeLabel;
    if (change == null) {
      badgeClass = 'vd-badge-unchanged';
      badgeLabel = 'MATCH';
    } else {
      switch (change.type) {
        case HeaderPropertyChangeType.added:
          badgeClass = 'vd-badge-added';
          badgeLabel = 'ADDED';
        case HeaderPropertyChangeType.removed:
          badgeClass = 'vd-badge-removed';
          badgeLabel = 'REMOVED';
        case HeaderPropertyChangeType.modified:
          badgeClass = 'vd-badge-changed';
          badgeLabel = 'MODIFIED';
      }
    }

    final accentColor = isChanged ? 'var(--vd-accent, #0284c7)' : 'transparent';

    return div(
      attributes: {
        'style':
            'background: var(--vd-bg); border-radius: 6px; '
            'padding: 10px 12px; display: flex; flex-direction: column; '
            'gap: 6px; border-left: 3px solid $accentColor;',
      },
      [
        div(
          attributes: const {
            'style':
                'display: flex; align-items: center; '
                'justify-content: space-between;',
          },
          [
            span(
              attributes: const {
                'style':
                    'font-family: monospace; font-size: 12px; '
                    'font-weight: 600; color: var(--vd-text);',
              },
              [.text(key)],
            ),
            span(
              classes: 'vd-badge $badgeClass',
              attributes: const {'style': 'font-size: 10px; padding: 1px 6px;'},
              [.text(badgeLabel)],
            ),
          ],
        ),

        if (change != null) ...[
          if (change.baseline != null)
            div(
              attributes: const {
                'style':
                    'font-family: monospace; font-size: 12px; color: #ef4444; '
                    'background: rgba(239, 68, 68, 0.08); padding: 4px 8px; '
                    'border-radius: 4px;',
              },
              [
                const span(
                  attributes: {
                    'style': 'font-weight: bold; margin-right: 4px;',
                  },
                  [.text('−')],
                ),
                span([.text(change.baseline!)]),
              ],
            ),
          if (change.current != null)
            div(
              attributes: const {
                'style':
                    'font-family: monospace; font-size: 12px; color: #22c55e; '
                    'background: rgba(34, 197, 94, 0.08); padding: 4px 8px; '
                    'border-radius: 4px;',
              },
              [
                const span(
                  attributes: {
                    'style': 'font-weight: bold; margin-right: 4px;',
                  },
                  [.text('+')],
                ),
                span([.text(change.current!)]),
              ],
            ),
        ] else ...[
          div(
            attributes: const {
              'style':
                  'font-family: monospace; font-size: 12px; '
                  'color: var(--vd-text-muted); word-break: break-all;',
            },
            [.text(currentVal ?? baselineVal ?? '')],
          ),
        ],
      ],
    );
  }
}
