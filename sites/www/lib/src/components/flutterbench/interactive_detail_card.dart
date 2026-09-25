// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/util.dart';

import 'methodology_components.dart';

/// Interactive tabbed card used for Score Triage and Evaluation Matrix.
@client
class InteractiveDetailCard extends StatefulComponent {
  const InteractiveDetailCard({
    required this.title,
    required this.description,
    required this.tabs,
    this.classes = 'interactive-detail-card',
    super.key,
  });

  final String title;
  final String description;
  final List<Map<String, Object?>> tabs;
  final String classes;

  @override
  State<InteractiveDetailCard> createState() => _InteractiveDetailCardState();
}

class _InteractiveDetailCardState extends State<InteractiveDetailCard> {
  late String _activeTab = (component.tabs.firstOrNull?['id'] as String?) ?? '';

  @override
  Component build(BuildContext context) {
    return div(classes: component.classes, [
      div(classes: 'card-header-area triage-header', [
        h3([.text(component.title)]),
        p([.text(component.description)]),
      ]),
      div(classes: 'card-tabs-grid triage-tiers-grid', [
        for (final tab in component.tabs)
          button(
            classes: [
              'card-tab-btn',
              'triage-tier-btn',
              'variant-${tab['variant'] as String? ?? 'blue'}',
              'tier-${tab['variant'] as String? ?? 'blue'}',
              if (tab['id'] == _activeTab) 'active',
            ].toClasses,
            events: {
              'click': (_) {
                setState(() {
                  _activeTab = tab['id'] as String? ?? '';
                });
              },
            },
            [
              div(
                classes: 'tab-primary-label tier-score',
                [.text(tab['primary_label'] as String? ?? '')],
              ),
              div(
                classes: 'tab-secondary-label tier-name',
                [.text(tab['secondary_label'] as String? ?? '')],
              ),
            ],
          ),
      ]),
      div(classes: 'card-panels-container triage-detail-card', [
        for (final tab in component.tabs)
          div(
            classes: [
              'card-panel',
              'triage-panel',
              if (tab['id'] == _activeTab) 'active',
            ].toClasses,
            [
              div(classes: 'panel-heading', [
                h4([.text(tab['heading'] as String? ?? '')]),
                if (tab['badge'] case final String badge)
                  span(
                    classes:
                        'panel-badge badge-${tab['variant'] as String? ?? 'blue'}',
                    [.text(badge)],
                  ),
              ]),
              p(
                classes: 'panel-overview criteria-text',
                [renderDescriptionWithCode(tab['overview'] as String? ?? '')],
              ),
              if (tab['items'] case final List<Object?> itemsList)
                if (itemsList.isNotEmpty)
                  div(classes: 'panel-items-section actions-section', [
                    if (tab['items_label'] case final String label)
                      div(classes: 'items-label actions-label', [.text(label)]),
                    ul([
                      for (final item
                          in itemsList.whereType<Map<String, Object?>>())
                        li([
                          strong([
                            .text('${item['label'] as String? ?? ''}: '),
                          ]),
                          renderDescriptionWithCode(
                            item['detail'] as String? ?? '',
                          ),
                        ]),
                    ]),
                  ]),
              if (tab['footer_text'] case final String footer)
                if (footer.isNotEmpty)
                  p(
                    classes: 'panel-footer-text',
                    [renderDescriptionWithCode(footer)],
                  ),
            ],
          ),
      ]),
    ]);
  }
}
