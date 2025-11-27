// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../util.dart';

class WidgetCatalogCategories extends CustomComponentBase {
  const WidgetCatalogCategories();

  @override
  Pattern get pattern => 'WidgetCatalogCategories';

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    return Builder(
      builder: (context) {
        final categories = switch (context.page.data) {
          {'catalog': {'index': final List<Object?> index}} =>
            index
                .cast<Map<String, Object?>>()
                .map(_WidgetCatalogCategory.new)
                .sortedBy((c) => c.name),
          _ => throw Exception(
            'Catalog not found. '
            'Make sure the `data/catalog/index.yml` file exists.',
          ),
        };

        const excludedCategories = {
          'Cupertino',
          'Material components',
          'Material 2 components',
        };

        return div(classes: 'card-grid', [
          for (final category in categories)
            if (!excludedCategories.contains(category.name))
              a(
                href: '${context.page.url}/${category.id}',
                classes: 'card outlined-card',
                [
                  div(classes: 'card-header', [
                    span(classes: 'card-title', [text(category.name)]),
                  ]),
                  div(classes: 'card-content', [
                    p([text(category.description)]),
                  ]),
                ],
              ),
        ]);
      },
    );
  }
}

class WidgetCatalogGrid extends CustomComponentBase {
  const WidgetCatalogGrid();

  @override
  Pattern get pattern => 'WidgetCatalogGrid';

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    return Builder(
      builder: (context) {
        final widgets = switch (context.page.data) {
          {'catalog': {'widgets': final List<Object?> widgets}} =>
            widgets
                .cast<Map<String, Object?>>()
                .map(_WidgetCatalogWidget.new)
                .sortedBy((c) => c.name),
          _ => throw Exception(
            'Catalog not found. '
            'Make sure the `data/catalog/widgets.yml` file exists.',
          ),
        };

        return div(classes: 'card-grid', [
          for (final widget in widgets)
            a(href: widget.link, classes: 'card outlined-card', [
              div(classes: 'card-image-holder', [
                if (widget.vector case final vector?)
                  raw(vector)
                else if (widget.imageSrc case final imageSrc?)
                  img(
                    alt:
                        'Rendered image or visualization of '
                        'the ${widget.name} widget.',
                    src: imageSrc,
                  )
                else
                  img(
                    alt: 'Flutter logo for widget missing visualization image.',
                    src: '/assets/images/docs/catalog-widget-placeholder.png',
                    attributes: {'aria-hidden': 'true'},
                  ),
              ]),
              div(classes: 'card-header', [
                span(classes: 'card-title', [text(widget.name)]),
              ]),
              div(classes: 'card-content', [
                p(classes: 'card-text', [
                  text(truncateWords(widget.description, 25)),
                ]),
              ]),
            ]),
        ]);
      },
    );
  }
}

extension type _WidgetCatalogCategory(Map<String, Object?> _data) {
  String get id =>
      _data['id'] as String? ??
      (throw Exception('Missing id for widget catalog category. '));
  String get name =>
      _data['name'] as String? ??
      (throw Exception('Missing name for widget catalog category. '));
  String get description =>
      _data['description'] as String? ??
      (throw Exception(
        'Missing description for widget catalog category "$name".',
      ));
}

extension type _WidgetCatalogWidget(Map<String, Object?> _data) {
  String get name =>
      _data['name'] as String? ??
      (throw Exception('Missing name for widget catalog widget. '));
  String get description =>
      _data['description'] as String? ??
      (throw Exception(
        'Missing description for widget catalog widget "$name".',
      ));
  String get link =>
      _data['link'] as String? ??
      (throw Exception('Missing link for widget catalog widget "$name".'));
  String? get vector => _data['vector'] as String?;
  String? get imageSrc => switch (_data['image']) {
    {'src': final String src} => src,
    _ => null,
  };
}
