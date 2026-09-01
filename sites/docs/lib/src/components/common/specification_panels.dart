// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';

import '../../utils/inline_code.dart';

/// Data model for a single row within [SpecTableItem].
final class SpecTableRowItem {
  const SpecTableRowItem({
    required this.label,
    required this.description,
  });

  final String label;
  final String description;
}

/// Data model for a specification table with optional title and rows.
final class SpecTableItem {
  const SpecTableItem({
    this.title = '',
    this.headers = const [],
    this.rows = const [],
  });

  final String title;
  final List<String> headers;
  final List<SpecTableRowItem> rows;
}

/// Data model for an individual panel within [SpecificationPanels].
final class SpecPanelItem {
  const SpecPanelItem({
    required this.id,
    required this.title,
    this.badge = '',
    this.badgeVariant = 'blue',
    this.icon = 'info',
    this.expanded = false,
    this.description = '',
    this.leadText = '',
    this.footerText = '',
    this.tables = const [],
  });

  final String id;
  final String title;
  final String badge;
  final String badgeVariant;
  final String icon;
  final bool expanded;
  final String description;
  final String leadText;
  final String footerText;
  final List<SpecTableItem> tables;
}

/// A collapsible list of specification panels with embedded tables and details.
final class SpecificationPanels extends StatelessComponent {
  const SpecificationPanels({
    required this.panels,
    this.classes = 'task-specs-list',
    this.idPrefix = 'task-spec',
    super.key,
  });

  final List<SpecPanelItem> panels;
  final String classes;
  final String idPrefix;

  @override
  Component build(BuildContext context) {
    return div(classes: classes, [
      for (final spec in panels)
        div(classes: 'task-spec-panel', [
          a(
            classes: [
              'collapsible',
              if (!spec.expanded) 'collapsed',
            ].toClasses,
            href: '#$idPrefix-${spec.id}',
            attributes: {
              'data-toggle': 'collapse',
              'data-target': '#$idPrefix-${spec.id}',
              'role': 'button',
              'aria-expanded': spec.expanded ? 'true' : 'false',
              'aria-controls': '#$idPrefix-${spec.id}',
            },
            [
              div(classes: 'panel-header-left', [
                div(
                  classes: [
                    'panel-icon-wrap',
                    'variant-${spec.badgeVariant}',
                  ].toClasses,
                  [MaterialIcon(spec.icon)],
                ),
                div(classes: 'panel-header-content', [
                  div(classes: 'panel-title-row', [
                    h4([.text(spec.title)]),
                    if (spec.badge.isNotEmpty)
                      span(
                        classes: 'badge badge-${spec.badgeVariant}',
                        [.text(spec.badge)],
                      ),
                  ]),
                  if (spec.description.isNotEmpty)
                    p(classes: 'panel-description', [
                      .text(spec.description),
                    ]),
                ]),
              ]),
            ],
          ),
          div(
            id: '$idPrefix-${spec.id}',
            classes: [
              'task-spec-body collapse',
              if (spec.expanded) 'show',
            ].toClasses,
            [
              if (spec.leadText.isNotEmpty)
                p(classes: 'lead-text', [
                  renderDescriptionWithCode(spec.leadText),
                ]),
              for (final tableData in spec.tables) ...[
                if (tableData.title.isNotEmpty)
                  h5(classes: 'table-subheading', [.text(tableData.title)]),
                div(classes: 'table-wrapper', [
                  table(classes: 'spec-table', [
                    tbody([
                      for (final row in tableData.rows)
                        tr([
                          td([
                            strong([.text(row.label)]),
                          ]),
                          td([renderDescriptionWithCode(row.description)]),
                        ]),
                    ]),
                  ]),
                ]),
              ],
              if (spec.footerText.isNotEmpty)
                p(classes: 'footer-text', [
                  renderDescriptionWithCode(spec.footerText),
                ]),
            ],
          ),
        ]),
    ]);
  }
}
