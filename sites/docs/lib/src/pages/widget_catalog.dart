// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;
import 'package:site_shared/markdown.dart';
import 'package:site_shared/util.dart';

import '../components/pages/widget_catalog.dart';
import '../models/widget_catalog_model.dart';

List<MemoryPage> get widgetCatalogPages {
  final widgetCatalogIndexFile = File(
    path.join('src', 'data', 'catalog', 'index.yml'),
  );
  final catalogData = widgetCatalogIndexFile.readAsStringSync();
  final catalog =
      (DataLoader.parseData('index.yml', catalogData) as List<Object?>)
          .cast<Map<String, Object?>>()
          .map(WidgetCatalogCategory.new)
          .sortedBy((c) => c.name);

  return [
    for (final category in catalog)
      MemoryPage.builder(
        path: 'ui/widgets/${category.id}.md',
        initialData: {
          'page': {
            'title': category.title,
            'shortTitle': category.name,
            'description':
                'A catalog of Flutter\'s ${category.title.unCapitalize()}. '
                '${category.description}',
            'dateModifiedSources': [
              'src/data/catalog/index.yml',
              'src/data/catalog/widgets.yml',
            ],
          },
        },
        builder: (context) {
          final catalogWidgets = switch (context.page.data) {
            {'catalog': {'widgets': final List<Object?> widgets}} =>
              widgets
                  .cast<Map<String, Object?>>()
                  .map(WidgetCatalogWidget.new)
                  .toList(growable: false),
            _ => throw Exception(
              'Widget Catalog not found. '
              'Make sure the `data/catalog/widgets.yml` file exists.',
            ),
          };

          final widgetsInCategory = catalogWidgets
              .where((w) => w.categories.contains(category.name))
              .toList(growable: false);

          final isMaterialCatalog = category.name == 'Material components';

          return .fragment([
            if (_additionalCatalogContent[category.name] case final content?)
              DashMarkdown(content: content),
            // Only show description for non-material catalogs.
            if (!isMaterialCatalog)
              if (category.description case final String description
                  when description.isNotEmpty)
                DashMarkdown(content: description),

            // Only show main category widgets for non-material catalogs.
            if (!isMaterialCatalog && widgetsInCategory.isNotEmpty)
              WidgetCardGrid(
                widgets: widgetsInCategory,
                isMaterialCatalog: isMaterialCatalog,
              ),

            if (category.subcategories case final subcategories
                when subcategories.isNotEmpty) ...[
              for (final sub in subcategories)
                ..._buildSubcategorySection(
                  sub,
                  catalogWidgets,
                  isMaterialCatalog: isMaterialCatalog,
                ),
            ],

            const p([
              .text('Find more widgets in the '),
              a(href: '/ui/widgets', [.text('widget catalog')]),
              .text('.'),
            ]),
          ]);
        },
      ),
  ];
}

const _additionalCatalogContent = {
  'Material components': '''
Flutter provides a variety of visual, behavioral, and motion-rich widgets
that implement the [Material 3][] design specification.
Material enables you to design and build beautiful, usable apps
that can adapt to any platform.

Previously, Material was part of the core Flutter SDK, but it has been
decoupled from the framework. You can access Material from the
[`material_ui`][] package on pub.dev. For more information, visit
the [decoupling migration guide][].

[decoupling migration guide]: /release/breaking-changes/material-ui-and-cupertino-ui
[`material_ui`]: http://pub.dev/packages/material_ui
[Material 3]: https://m3.material.io/
[Material widget catalog]: /ui/widgets/material
''',
};

List<Component> _buildSubcategorySection(
  WidgetCatalogSubcategory subcategory,
  List<WidgetCatalogWidget> allWidgets, {
  required bool isMaterialCatalog,
}) {
  final subName = subcategory.name;
  if (subName.isEmpty) return const [];

  final widgets = allWidgets
      .where((w) => w.subcategories.contains(subName))
      .toList(growable: false);

  if (widgets.isEmpty) return const [];

  return [
    h2(id: slugify(subName), [.text(subName)]),
    WidgetCardGrid(
      widgets: widgets,
      isMaterialCatalog: isMaterialCatalog,
      subcategory: subcategory,
    ),
  ];
}
