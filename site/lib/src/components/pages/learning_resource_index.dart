// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../models/learning_resource_model.dart';
import '../../util.dart';
import 'learning_resource_filters.dart';
import 'learning_resource_filters_sidebar.dart';

final class LearningResourceIndex extends StatelessComponent {
  LearningResourceIndex({super.key});

  @override
  Component build(BuildContext context) {
    final resourcesData =
        context.page.data['learning-resources-index'] as Map<String, Object?>?;

    final learningResources = <LearningResource>[];
    if (resourcesData != null) {
      for (final group in resourcesData.values) {
        for (final resource in group as List<Object?>) {
          learningResources.add(
            LearningResource.fromMap(resource as Map<String, Object?>),
          );
        }
      }
    }

    return div(id: 'resource-index-content', [
      div(classes: 'left-col', id: 'resource-index-main-content', [
        const LearningResourceFilters(),
        section(classes: 'card-grid', id: 'all-resources-grid', [
          for (final item in learningResources) _ResourceCard(item),
        ]),
      ]),
      const LearningResourceFiltersSidebar(),
    ]);
  }
}

final class _ResourceCard extends StatelessComponent {
  const _ResourceCard(this.resource);

  final LearningResource resource;

  @override
  Component build(BuildContext context) {
    return a(
      id: resource.name,
      classes: 'card outlined-card',
      href: resource.link?.url ?? '#',
      target: Target.blank,
      attributes: {
        'data-type': resource.type,
        'data-tags': resource.tags.join(', '),
        'data-description': resource.description,
      },
      [
        if (resource.imageUrl case final imageUrl?)
          div(classes: 'card-image-holder-material-3', [
            img(src: imageUrl, alt: ''),
          ]),
        div(classes: 'card-leading', [
          span(
            classes: [
              'pill-sm',
              switch (resource.type) {
                'codelab' || 'workshop' => 'flutter-blue',
                'quickstart' || 'demo' => 'purple',
                _ => 'teal',
              },
            ].toClasses,
            [
              text(
                resource.type.substring(0, 1).toUpperCase() +
                    resource.type.substring(1),
              ),
            ],
          ),
          _iconForLabel(resource.link?.label ?? ''),
        ]),
        div(classes: 'card-header', [
          span(classes: 'card-title', [
            text(resource.name),
          ]),
        ]),
        div(classes: 'card-content', [
          text(resource.description),
        ]),
      ],
    );
  }

  Component _iconForLabel(String label) => switch (label) {
    'Flutter GitHub' => svg(
      classes: 'monochrome-icon',
      width: 24.px,
      height: 24.px,
      [
        const Component.element(
          tag: 'use',
          attributes: {'href': '/assets/images/social/github.svg#github'},
        ),
      ],
    ),
    'Dart GitHub' || 'Dart docs' => img(
      src: '/assets/images/branding/dart/logo.svg',
      width: 24,
      alt: 'Dart logo',
    ),
    'Google Codelab' => svg(width: 24.px, height: 24.px, [
      const Component.element(
        tag: 'use',
        attributes: {
          'href':
              '/assets/images/social/google-developers.svg#google-developers',
        },
      ),
    ]),
    'YouTube' => svg(
      attributes: {'style': 'color: red'},
      width: 24.px,
      height: 24.px,
      [
        const Component.element(
          tag: 'use',
          attributes: {'href': '/assets/images/social/youtube.svg#youtube'},
        ),
      ],
    ),
    'Medium' => svg(classes: 'monochrome-icon', width: 24.px, height: 24.px, [
      const Component.element(
        tag: 'use',
        attributes: {'href': '/assets/images/social/medium.svg#medium'},
      ),
    ]),
    'Flutter docs' || _ => img(
      src: '/assets/images/branding/flutter/icon/1080.png',
      alt: 'Flutter logo',
      width: 24,
    ),
  };
}
