import 'dart:io';

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;

import '../components/pages/widget_catalog.dart';
import '../markdown/markdown_parser.dart';
import '../models/widget_catalog_model.dart';
import '../util.dart';

final _widgetCatalogIndexFile = File(
  path.join(siteSrcDirectoryPath, 'data', 'catalog', 'index.yml'),
);

List<MemoryPage> get widgetCatalogPages {
  final catalogData = _widgetCatalogIndexFile.readAsStringSync();
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

          return Component.fragment([
            if (_additionalCatalogContent[category.name] case final content?)
              DashMarkdown(content: content),
            // Only show description for non-material catalogs.
            if (!isMaterialCatalog)
              if (category.description case final String description
                  when description.isNotEmpty)
                DashMarkdown(content: description),

            // Only show main category widgets for non-material catalogs.
            if (!isMaterialCatalog && widgetsInCategory.isNotEmpty)
              _buildCardGrid(
                widgetsInCategory,
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

            if (isMaterialCatalog)
              p([
                text('Find more widgets in the '),
                a(href: '/ui/widgets/material2', [
                  text('Material 2 widget catalog'),
                ]),
                text(' and other categories of the '),
                a(href: '/ui/widgets', [text('widget catalog')]),
                text('.'),
              ])
            else
              p([
                text('Find more widgets in the '),
                a(href: '/ui/widgets', [text('widget catalog')]),
                text('.'),
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
Material 3 is the default design language of Flutter,
enabling you to design and build beautiful, usable apps
that can adapt to any platform.

:::secondary
The transition to Material 3 as the default was
completed in Flutter 3.16.

To learn more about this transition, how to complete it for your own widgets,
or how to temporarily opt-out, check out
the [Migrate to Material 3][] migration guide.
:::

To catch these and other widgets in action,
check out the [Material 3 demo][] web app.

[Material 3]: https://m3.material.io/get-started
[Migrate to Material 3]: /release/breaking-changes/material-3-migration
[Material 3 demo]: https://github.com/flutter/samples/tree/main/material_3_demo/
''',
  'Material 2 components': '''
Flutter provides a variety of widgets
that implement the [Material 2][] design guidelines,
enabling you to create intuitive and beautiful apps.

:::version-note
[Material 3][], the latest version of Material Design, is
Flutter's default design language as of Flutter 3.16.

Material 2 will eventually be deprecated.
To learn more about this transition, check out
the [Migrate to Material 3][] migration guide.

Also check out the [Material 3 widget catalog][].
:::

[Material 3]: https://m3.material.io/
[Material 2]: https://m2.material.io/design
[Migrate to Material 3]: /release/breaking-changes/material-3-migration
[Material 3 widget catalog]: /ui/widgets/material
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
    h2(id: slugify(subName), [text(subName)]),
    _buildCardGrid(
      widgets,
      isMaterialCatalog: isMaterialCatalog,
      subcategory: subcategory,
    ),
  ];
}

Component _buildCardGrid(
  List<WidgetCatalogWidget> widgets, {
  required bool isMaterialCatalog,
  WidgetCatalogSubcategory? subcategory,
}) {
  return div(
    classes: [
      'card-grid',
      if (isMaterialCatalog) 'material-cards',
    ].toClasses,
    [
      for (final widget in widgets)
        WidgetCatalogCard(
          widget: widget,
          isMaterialCatalog: isMaterialCatalog,
          subcategory: subcategory,
        ),
    ],
  );
}
