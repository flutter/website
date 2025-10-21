// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../models/learning_resource_model.dart';
import '../../util.dart';
import '../client/learning_resource_filters.dart';
import '../client/learning_resource_filters_sidebar.dart';

final class LearningResourceIndex extends StatelessComponent {
  LearningResourceIndex(this.resources);

  final List<LearningResource> resources;

  @override
  Component build(BuildContext _) {
    return div(id: 'resource-index-content', [
      div(classes: 'left-col', id: 'resource-index-main-content', [
        const LearningResourceFilters(),
        section(classes: 'card-grid', id: 'all-resources-grid', [
          for (final item in resources) _ResourceCard(item),
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
      href: resource.link.url,
      target: Target.blank,
      attributes: {
        'data-type': resource.type.id,
        'data-tags': resource.tags.map((tag) => tag.id).join(', '),
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
                LearningResourceType.recipe => 'teal',
                LearningResourceType.sample => 'purple',
                LearningResourceType.tutorial => 'flutter-blue',
                LearningResourceType.workshop => 'flutter-blue',
              },
            ].toClasses,
            [text(resource.type.formattedName)],
          ),
          _iconForSource(resource.link.source),
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

  Component _iconForSource(LearningResourceSource source) => switch (source) {
    LearningResourceSource.gitHub => svg(
      classes: 'monochrome-icon',
      width: 24.px,
      height: 24.px,
      [
        const Component.element(
          tag: 'use',
          attributes: {
            'href': '/assets/images/social/github.svg#github',
          },
        ),
      ],
    ),
    LearningResourceSource.dartDocs => img(
      src: '/assets/images/branding/dart/logo.svg',
      width: 24,
      alt: 'Dart logo',
    ),
    LearningResourceSource.flutterDocs => img(
      src: '/assets/images/branding/flutter/icon/1080.png',
      alt: 'Flutter logo',
      width: 24,
    ),
    LearningResourceSource.googleCodelab => svg(
      width: 24.px,
      height: 24.px,
      [
        const Component.element(
          tag: 'use',
          attributes: {
            'href':
                '/assets/images/social/google-developers.svg#google-developers',
          },
        ),
      ],
    ),
    LearningResourceSource.youTube => svg(
      attributes: {'style': 'color: red'},
      width: 24.px,
      height: 24.px,
      [
        const Component.element(
          tag: 'use',
          attributes: {
            'href': '/assets/images/social/youtube.svg#youtube',
          },
        ),
      ],
    ),
    LearningResourceSource.medium => svg(
      classes: 'monochrome-icon',
      width: 24.px,
      height: 24.px,
      [
        const Component.element(
          tag: 'use',
          attributes: {
            'href': '/assets/images/social/medium.svg#medium',
          },
        ),
      ],
    ),
  };
}
