// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';

import 'methodology_components.dart';

/// Collapsible specification panels with tables.
@client
class TaskSpecifications extends StatefulComponent {
  const TaskSpecifications({required this.specs, super.key});

  final List<Map<String, Object?>> specs;

  @override
  State<TaskSpecifications> createState() => _TaskSpecificationsState();
}

class _TaskSpecificationsState extends State<TaskSpecifications> {
  late final Set<String> _expandedPanels = {
    for (final s in component.specs)
      if (s['expanded'] == true) s['id'] as String? ?? '',
  };

  void _toggle(String id) {
    setState(() {
      if (_expandedPanels.contains(id)) {
        _expandedPanels.remove(id);
      } else {
        _expandedPanels.add(id);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'task-specs-list', [
      for (final spec in component.specs) ...[
        () {
          final id = spec['id'] as String? ?? '';
          final isExpanded = _expandedPanels.contains(id);
          final badgeVariant = spec['badge_variant'] as String? ?? 'blue';
          final tables = (spec['tables'] as List<Object?>? ?? const [])
              .whereType<Map<String, Object?>>()
              .toList();

          return div(classes: 'task-spec-panel', [
            a(
              classes: [
                'collapsible',
                if (!isExpanded) 'collapsed',
              ].toClasses,
              href: '#task-spec-$id',
              events: {
                'click': (e) {
                  e.preventDefault();
                  _toggle(id);
                },
              },
              [
                div(classes: 'panel-header-left', [
                  div(
                    classes: [
                      'panel-icon-wrap',
                      'variant-$badgeVariant',
                    ].toClasses,
                    [MaterialIcon(spec['icon'] as String? ?? 'info')],
                  ),
                  div(classes: 'panel-header-content', [
                    div(classes: 'panel-title-row', [
                      h4([.text(spec['title'] as String? ?? '')]),
                      if (spec['badge'] case final String badge)
                        if (badge.isNotEmpty)
                          span(
                            classes: 'badge badge-$badgeVariant',
                            [.text(badge)],
                          ),
                    ]),
                    if (spec['description'] case final String desc)
                      p(classes: 'panel-description', [renderDescriptionWithCode(desc)]),
                  ]),
                ]),
              ],
            ),
            div(
              classes: [
                'task-spec-body',
                if (isExpanded) 'show',
              ].toClasses,
              [
                if (spec['lead_text'] case final String lead)
                  p(classes: 'lead-text', [renderDescriptionWithCode(lead)]),
                for (final tbl in tables) ...[
                  if (tbl['title'] case final String tTitle)
                    if (tTitle.isNotEmpty)
                      div(classes: 'table-subheading', [.text(tTitle)]),
                  div(classes: 'table-wrapper', [
                    table(classes: 'spec-table', [
                      if (tbl['headers'] case final List<Object?> headers)
                        if (headers.isNotEmpty)
                          thead([
                            tr([
                              for (final h in headers)
                                th([.text(h.toString())]),
                            ]),
                          ]),
                      tbody([
                        for (final row in (tbl['rows'] as List<Object?>? ?? const []).whereType<Map<String, Object?>>())
                          tr([
                            td([strong([.text(row['label'] as String? ?? '')])]),
                            td([renderDescriptionWithCode(row['description'] as String? ?? '')]),
                          ]),
                      ]),
                    ]),
                  ]),
                ],
                if (spec['footer_text'] case final String footer)
                  if (footer.isNotEmpty)
                    p(classes: 'footer-text', [renderDescriptionWithCode(footer)]),
              ],
            ),
          ]);
        }(),
      ],
    ]);
  }
}
