// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/button.dart';
import 'package:site_shared/components/common/card.dart';

import '../../models/cuj_model.dart';
import 'cuj_filters.dart';
import 'cuj_filters_sidebar.dart';

final class CujIndex extends StatelessComponent {
  const CujIndex({super.key});

  @override
  Component build(BuildContext context) {
    final cujData = context.page.data['cujs'] as List<Object?>?;

    final cujs = <Cuj>[
      for (final cuj in cujData ?? const [])
        Cuj.fromMap(cuj as Map<String, Object?>),
    ];

    return div(classes: 'filterable-index', [
      div(classes: 'left-col', [
        const CujFilters(),
        div(classes: 'card-list', id: 'all-cujs-list', [
          for (final cuj in cujs) _CujCard(cuj),
        ]),
      ]),
      const CujFiltersSidebar(),
    ]);
  }
}

final class _CujCard extends StatelessComponent {
  const _CujCard(this.cuj);

  final Cuj cuj;

  @override
  Component build(BuildContext context) {
    final cardId = cuj.elementId;
    final taskCount = cuj.tasks.length;

    // Expanding and collapsing is handled for every `.expandable-card`
    // by the `_setUpExpandableCards` global script.
    return Card.expandable(
      id: cardId,
      outlined: true,
      additionalClasses: 'cuj-card',
      initiallyExpanded: false,
      attributes: {
        'data-persona': cuj.persona?.name ?? '',
        'data-goal': cuj.goal,
        'data-tasks': cuj.taskData,
      },
      header: [
        div(classes: 'cuj-card-heading', [
          if (cuj.persona case final persona?)
            span(classes: 'pill-sm ${persona.pillClass}', [
              .text(persona.label),
            ]),
          h2(classes: 'card-title', [.text(cuj.goal)]),
        ]),
        div(classes: 'card-header-buttons', [
          Button(
            href: '#$cardId',
            icon: 'tag',
            classes: const ['share-button'],
            title: 'Link to journey',
            attributes: {
              'aria-label': 'Link to the "${cuj.goal}" journey',
            },
          ),
          Button(
            icon: 'keyboard_arrow_up',
            classes: const ['expand-button'],
            title: 'Expand or collapse tasks',
            attributes: {
              'aria-expanded': 'false',
              'aria-controls': '$cardId-content',
              'aria-label': 'Expand or collapse the tasks for "${cuj.goal}"',
            },
          ),
        ]),
      ],
      collapsedContent: [
        p(classes: 'cuj-task-count', [
          .text(taskCount == 1 ? '1 task' : '$taskCount tasks'),
        ]),
      ],
      expandedContent: [
        ul(classes: 'cuj-task-list', [
          for (final task in cuj.tasks) li([.text(task.task)]),
        ]),
      ],
    );
  }
}
