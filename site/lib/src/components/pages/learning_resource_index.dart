// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../models/learning_resource_model.dart';
import '../../util.dart';
import '../material_icon.dart';

final class LearningResourceIndex extends StatelessComponent {
  LearningResourceIndex(this.resources);

  final List<LearningResource> resources;

  @override
  Component build(BuildContext _) => div(
    id: 'resource-index-content',
    [
      _buildMainContent(),
      _buildFilterSidebar(),
    ],
  );

  Component _buildMainContent() => div(
    classes: 'left-col',
    id: 'resource-index-main-content',
    [
      div(
        id: 'resource-search-group',
        classes: 'chip-filters-group',
        [
          div(
            classes: 'top-row',
            [
              div(
                classes: 'search-wrapper',
                id: 'resource-search',
                [
                  span(
                    classes: 'material-symbols leading-icon',
                    attributes: {
                      'aria-hidden': 'true',
                      'translate': 'no',
                    },
                    [text('search')],
                  ),
                  input(
                    type: InputType.search,
                    attributes: {
                      'placeholder': 'Try "button" or "networking"...',
                      'aria-label':
                          'Search learning resources by name and category',
                    },
                  ),
                ],
              ),
              button(
                classes: 'icon-button show-filters-button',
                [
                  span(
                    classes: 'material-symbols',
                    attributes: {
                      'aria-hidden': 'true',
                      'translate': 'no',
                    },
                    [text('filter_list')],
                  ),
                ],
              ),
            ],
          ),
          div(
            classes: 'label-row',
            [
              label(
                attributes: {'for': 'resource-search'},
                [
                  text('Showing '),
                  span(id: 'displayed-resource-card-count', [text('0')]),
                  text(' / '),
                  span(id: 'total-resource-card-count', [text('0')]),
                ],
              ),
              button(
                id: 'clear-resource-index-filters',
                attributes: {'disabled': 'true'},
                [
                  span(
                    classes: 'material-symbols',
                    attributes: {
                      'aria-hidden': 'true',
                      'translate': 'no',
                    },
                    [text('close_small')],
                  ),
                  span([text('Clear filters')]),
                ],
              ),
            ],
          ),
        ],
      ),
      section(
        classes: 'card-grid',
        id: 'all-resources-grid',
        [
          for (final item in resources) _ResourceCard(item),
        ],
      ),
    ],
  );

  Component _buildFilterSidebar() => div(
    classes: 'right-col',
    [
      input(
        type: InputType.checkbox,
        id: 'open-filter-toggle',
        attributes: {'hidden': 'true'},
      ),
      div(
        id: 'resource-filter-group-wrapper',
        [
          div(
            id: 'resource-filter-group',
            [
              div(
                classes: 'filter-header',
                [
                  label(
                    attributes: {
                      'for': 'open-filter-toggle',
                      'aria-hidden': 'true',
                    },
                    classes: 'close-icon',
                    [
                      const MaterialIcon('close'),
                    ],
                  ),
                ],
              ),
              div(
                classes: 'table-title',
                [text('Filter by')],
              ),
              div(
                classes: 'table-content',
                [
                  h4([text('Subject')]),
                  ul(
                    id: 'filters-tags',
                    classes: 'collapsed',
                    [
                      for (final tag in LearningResourceTag.values)
                        li(
                          classes: 'hidden',
                          [
                            input(
                              type: InputType.checkbox,
                              attributes: {
                                'role': 'checkbox',
                                'name': 'filter-${tag.id}',
                                'data-category': 'tags',
                              },
                              id: 'filter-${tag.id}',
                            ),
                            label(
                              attributes: {'for': 'filter-${tag.id}'},
                              [text(tag.formattedName)],
                            ),
                          ],
                        ),
                    ],
                  ),
                  button(
                    id: 'filters-tags-show-button',
                    [
                      span(
                        classes: 'label',
                        [text('More')],
                      ),
                      span(
                        classes: 'material-symbols',
                        attributes: {
                          'aria-hidden': 'true',
                          'translate': 'no',
                        },
                        [text('expand_more')],
                      ),
                    ],
                  ),
                  h4([text('Type')]),
                  ul(
                    id: 'filters-type',
                    [
                      for (final type in LearningResourceType.values)
                        li(
                          [
                            input(
                              type: InputType.checkbox,
                              attributes: {
                                'role': 'checkbox',
                                'data-category': 'type',
                                'name': 'filter-${type.id}',
                              },
                              id: 'filter-${type.id}',
                            ),
                            label(
                              attributes: {'for': 'filter-${type.id}'},
                              [text(type.formattedName)],
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
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
          div(
            classes: 'card-image-holder-material-3',
            [
              img(src: imageUrl, alt: ''),
            ],
          ),
        div(
          classes: 'card-leading',
          [
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
          ],
        ),
        div(
          classes: 'card-header',
          [
            span(
              classes: 'card-title',
              [text(resource.name)],
            ),
          ],
        ),
        div(
          classes: 'card-content',
          [text(resource.description)],
        ),
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
