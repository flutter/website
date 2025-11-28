// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../markdown/markdown_parser.dart';
import '../../models/widget_catalog_model.dart';
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
                .map(WidgetCatalogCategory.new)
                .sortedBy((c) => c.name),
          _ => throw Exception(
            'Widget Catalog not found. '
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
                .map(WidgetCatalogWidget.new)
                .sortedBy((c) => c.name),
          _ => throw Exception(
            'Catalog not found. '
            'Make sure the `data/catalog/widgets.yml` file exists.',
          ),
        };

        return div(classes: 'card-grid', [
          for (final widget in widgets) WidgetCatalogCard(widget: widget),
        ]);
      },
    );
  }
}

class WidgetCatalogCard extends StatelessComponent {
  const WidgetCatalogCard({
    required this.widget,
    this.isMaterialCatalog = false,
    this.subcategory,
    super.key,
  });

  final WidgetCatalogWidget widget;
  final bool isMaterialCatalog;
  final WidgetCatalogSubcategory? subcategory;

  @override
  Component build(BuildContext context) {
    return a(href: widget.link, classes: 'card outlined-card', [
      _buildCardImageHolder(),
      div(classes: 'card-header', [
        span(classes: 'card-title', [text(widget.name)]),
      ]),
      div(classes: 'card-content', [
        p([
          DashMarkdown(
            inline: true,
            content: truncateWords(widget.description, 25),
          ),
        ]),
      ]),
    ]);
  }

  Component _buildCardImageHolder() {
    final holderClass = isMaterialCatalog
        ? 'card-image-holder-material-3'
        : 'card-image-holder';

    final imageAlt = isMaterialCatalog
        ? 'Rendered example of the ${widget.name} Material widget.'
        : 'Rendered image or visualization of the ${widget.name} widget.';

    final styleAttributes = isMaterialCatalog && subcategory?.color != null
        ? {'style': '--bg-color: ${subcategory?.color}'}
        : <String, String>{};

    final placeholder = img(
      alt:
          'Placeholder Flutter logo in place of '
          'missing widget image or visualization.',
      src: '/assets/images/docs/catalog-widget-placeholder.png',
      attributes: {'aria-hidden': 'true'},
    );

    return div(
      classes: holderClass,
      attributes: styleAttributes,
      [
        if (isMaterialCatalog) ...[
          // Material catalog always expects an image.
          if (widget.imageSrc case final imageSrc? when imageSrc.isNotEmpty)
            img(alt: imageAlt, src: imageSrc)
          else
            placeholder,
          if (widget.hoverBackgroundSrc case final hoverBackgroundSrc?
              when hoverBackgroundSrc.isNotEmpty)
            div(classes: 'card-image-material-3-hover', [
              img(
                alt:
                    'Decorated background for '
                    'Material widget visualizations.',
                src: hoverBackgroundSrc,
                attributes: {'aria-hidden': 'true'},
              ),
            ]),
        ] else ...[
          // Standard catalog prefers vector, then image, then placeholder.
          if (widget.vector case final vector? when vector.isNotEmpty)
            raw(vector)
          else if (widget.imageSrc case final imageSrc?
              when imageSrc.isNotEmpty)
            img(alt: imageAlt, src: imageSrc)
          else
            placeholder,
        ],
      ],
    );
  }
}
