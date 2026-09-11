// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/util.dart';

import 'methodology_components.dart';

/// Interactive filterable Grader Matrix showing evaluation graders in a carousel.
@client
class GraderMatrix extends StatefulComponent {
  const GraderMatrix({
    required this.title,
    required this.description,
    required this.filters,
    required this.graders,
    super.key,
  });

  final String title;
  final String description;
  final List<Map<String, Object?>> filters;
  final List<Map<String, Object?>> graders;

  @override
  State<GraderMatrix> createState() => _GraderMatrixState();
}

class _GraderMatrixState extends State<GraderMatrix> {
  String _activeFilter = 'all';

  @override
  Component build(BuildContext context) {
    final filteredGraders = component.graders.where((g) {
      if (_activeFilter == 'all') return true;
      final cat = g['category'] as String? ?? '';
      return cat.toLowerCase() == _activeFilter.toLowerCase();
    }).toList();

    return div(classes: 'grader-matrix', [
      div(classes: 'matrix-header', [
        div(classes: 'matrix-title-area', [
          h3([.text(component.title)]),
          p([renderDescriptionWithCode(component.description)]),
        ]),
        if (component.filters.isNotEmpty)
          div(classes: 'matrix-filters', [
            for (final filter in component.filters)
              button(
                classes: filter['id'] == _activeFilter
                    ? 'filter-btn active'
                    : 'filter-btn',
                events: {
                  'click': (_) {
                    setState(() {
                      _activeFilter = filter['id'] as String? ?? 'all';
                    });
                  },
                },
                [.text(filter['label'] as String? ?? '')],
              ),
          ]),
      ]),
      div(classes: 'grader-carousel-wrapper', [
        div(classes: 'grader-cards-track', [
          for (final grader in filteredGraders)
            div(
              classes: [
                'grader-card',
                'cat-${grader['category'] as String? ?? ''}',
                'cat-${grader['type'] as String? ?? ''}',
              ].toClasses,
              [
                div(classes: 'grader-header', [
                  span(
                    classes: 'grader-cat ${grader['category'] as String? ?? ''}',
                    [.text(grader['category_label'] as String? ?? '')],
                  ),
                  span(
                    classes: 'badge grader-badge badge-${grader['type'] as String? ?? ''}',
                    [.text(grader['type_label'] as String? ?? '')],
                  ),
                ]),
                h4([.text(grader['name'] as String? ?? '')]),
                p([renderDescriptionWithCode(grader['description'] as String? ?? '')]),
              ],
            ),
        ]),
      ]),
    ]);
  }
}
