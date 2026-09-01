// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/util.dart';

import '../../utils/inline_code.dart';

/// Model for a single tab and corresponding detail panel within
/// [InteractiveDetailCard].
final class InteractiveDetailTab {
  const InteractiveDetailTab({
    required this.id,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.heading,
    this.badge,
    this.variant = 'blue',
    required this.overview,
    this.itemsLabel,
    this.items = const [],
    this.footerText,
  });

  final String id;
  final String primaryLabel;
  final String secondaryLabel;
  final String heading;
  final String? badge;
  final String variant;
  final String overview;
  final String? itemsLabel;
  final List<InteractiveDetailItem> items;
  final String? footerText;
}

/// Key-value item displayed within [InteractiveDetailTab].
final class InteractiveDetailItem {
  const InteractiveDetailItem({
    required this.label,
    required this.detail,
  });

  final String label;
  final String detail;
}

/// A reusable interactive card featuring selectable tabs and responsive detail
/// panels.
final class InteractiveDetailCard extends StatelessComponent {
  const InteractiveDetailCard({
    required this.title,
    required this.description,
    required this.tabs,
    this.classes = 'interactive-detail-card',
    super.key,
  });

  final String title;
  final String description;
  final List<InteractiveDetailTab> tabs;
  final String classes;

  @override
  Component build(BuildContext context) {
    return div(classes: classes, [
      div(classes: 'card-header-area triage-header', [
        h3([.text(title)]),
        p([.text(description)]),
      ]),
      div(classes: 'card-tabs-grid triage-tiers-grid', [
        for (var i = 0; i < tabs.length; i++)
          button(
            classes: [
              'card-tab-btn',
              'triage-tier-btn',
              'variant-${tabs[i].variant}',
              'tier-${tabs[i].variant}',
              if (i == 0) 'active',
            ].toClasses,
            attributes: {'data-tab': tabs[i].id, 'data-tier': tabs[i].id},
            [
              div(
                classes: 'tab-primary-label tier-score',
                [.text(tabs[i].primaryLabel)],
              ),
              div(
                classes: 'tab-secondary-label tier-name',
                [.text(tabs[i].secondaryLabel)],
              ),
            ],
          ),
      ]),
      div(classes: 'card-panels-container triage-detail-card', [
        for (var i = 0; i < tabs.length; i++)
          div(
            classes: [
              'card-panel',
              'triage-panel',
              if (i == 0) 'active',
            ].toClasses,
            attributes: {'data-tab': tabs[i].id, 'data-tier': tabs[i].id},
            [
              div(classes: 'panel-heading', [
                h4([.text(tabs[i].heading)]),
                if (tabs[i].badge case final badge?)
                  span(
                    classes: 'panel-badge badge-${tabs[i].variant}',
                    [.text(badge)],
                  ),
              ]),
              p(
                classes: 'panel-overview criteria-text',
                [renderDescriptionWithCode(tabs[i].overview)],
              ),
              if (tabs[i].items.isNotEmpty)
                div(classes: 'panel-items-section actions-section', [
                  if (tabs[i].itemsLabel case final label?)
                    div(classes: 'items-label actions-label', [.text(label)]),
                  ul([
                    for (final item in tabs[i].items)
                      li([
                        strong([.text('${item.label}: ')]),
                        renderDescriptionWithCode(item.detail),
                      ]),
                  ]),
                ]),
              if (tabs[i].footerText case final footer?)
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
