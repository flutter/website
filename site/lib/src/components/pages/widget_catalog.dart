// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

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
                .map(WidgetCatalogCategory.new)
                .sortedBy((c) => c.name),
          _ => throw Exception(
            'Catalog not found. Make sure the `data/catalog/index.yml` file exists.',
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
                href: '${context.page.url}/${category.name.toLowerCase()}',
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

extension type WidgetCatalogCategory(Map<String, Object?> _data) {
  String get name =>
      _data['name'] as String? ??
      (throw Exception('Missing name for widget catalog category. '));
  String get description =>
      _data['description'] as String? ??
      (throw Exception(
        'Missing description for widget catalog category "$name".',
      ));
}
