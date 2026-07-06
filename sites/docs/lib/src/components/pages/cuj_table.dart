// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/spreadsheet_table.dart';
import 'package:site_shared/markdown.dart';

/// A table component that renders Critical User Journeys (CUJs) loaded from
/// build-time YAML data (which can be synced periodically from a Google Sheet).
class CujTable extends StatelessComponent {
  const CujTable({this.category, super.key});

  /// Creates a [CujTable] from markdown attributes (e.g. `<CujTable category="mobile" />`).
  factory CujTable.fromAttributes(Map<String, String> attributes) {
    return CujTable(category: attributes['category']);
  }

  final String? category;

  @override
  Component build(BuildContext context) {
    // jaspr_content automatically loads YAML files from sites/docs/src/data/
    // into context.page.data. A file named `cuj_table.yml` will be available
    // under `cuj_table` or `cujTable`.
    final rawData =
        context.page.data['cuj_table'] ?? context.page.data['cujTable'];
    if (rawData == null) {
      return const div(classes: 'callout warning', [
        p([
          .text(
            'CUJ data not found in context.page.data. Ensure cuj_table.yml exists in src/data/ and jaspr serve has reloaded.',
          ),
        ]),
      ]);
    }

    final items = (rawData as List<Object?>)
        .cast<Map<String, Object?>>()
        .map(CujItem._)
        .toList();

    final filteredItems = category != null
        ? items.where((item) => item.category == category).toList()
        : items;

    if (filteredItems.isEmpty) {
      return const Component.empty();
    }

    final columns = [
      const SpreadsheetColumn(label: 'Journey', width: '25%'),
      const SpreadsheetColumn(label: 'Description', width: '45%'),
      const SpreadsheetColumn(label: 'Persona', width: '15%'),
      const SpreadsheetColumn(label: 'Status', width: '15%'),
    ];

    final rows =
        filteredItems.map((item) {
          return SpreadsheetRow(
            cells: [
              SpreadsheetCell(
                content: [
                  if (item.url != null)
                    a(href: item.url!, target: Target.blank, [
                      .text(item.journey),
                    ])
                  else
                    strong([.text(item.journey)]),
                ],
              ),
              SpreadsheetCell(
                content: [
                  DashMarkdown(inline: true, content: item.description),
                ],
              ),
              SpreadsheetCell(
                content: [
                  span(classes: 'pill-sm teal', [.text(item.persona)]),
                ],
              ),
              SpreadsheetCell(content: [_buildStatusPill(item.status)]),
            ],
          );
        }).toList();

    return SpreadsheetTable(
      columns: columns,
      rows: rows,
      showRowNumbers: true,
      fullScreen: true,
    );
  }

  Component _buildStatusPill(String status) {
    final normalized = status.toLowerCase();
    final pillClass = switch (normalized) {
      'completed' || 'done' || 'supported' => 'success',
      'in progress' || 'active' => 'info',
      _ => '',
    };

    return div(
      classes: ['rrec-pill', if (pillClass.isNotEmpty) pillClass].join(' '),
      [.text(status)],
    );
  }
}

extension type CujItem._(Map<String, Object?> data) {
  String get journey =>
      (data['goal'] ?? data['journey'] ?? data['title'] ?? 'Unnamed Journey')
          as String;
  String get description =>
      (data['notes'] ?? data['description'] ?? '') as String;
  String get persona =>
      (data['persona'] ?? data['Persona'] ?? 'General') as String;
  String get status => (data['status'] ?? 'Supported') as String;
  String? get category => data['category'] as String?;
  String? get url => data['url'] as String?;
}
