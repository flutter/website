// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../markdown/markdown_parser.dart';
import '../util.dart';
import 'doc_layout.dart';

/// Used as the layout for the widget catalog pages.
// TODO: This is directly converted from the original Liquid logic.
//  We should either completely replace it with a new widget catalog
//  or clean it up.
final class CatalogPageLayout extends DocLayout {
  static const String _placeholderImagePath =
      '/assets/images/docs/catalog-widget-placeholder.png';

  const CatalogPageLayout();

  @override
  String get name => 'widget-catalog-page';

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final widgetCategory = pageData['widgetCategory'] as String;
    final isMaterialCatalog = pageData['materialCatalog'] == true;

    final catalogData = page.data['catalog'] as Map<String, Object?>;
    final catalogIndex = (catalogData['index'] as List<Object?>)
        .cast<Map<String, Object?>>();
    final category = _CategoryInfo(
      catalogIndex.firstWhere(
        (c) => c['name'] == widgetCategory,
        orElse: () => const <String, Object?>{},
      ),
    );

    final catalogWidgets = (catalogData['widgets'] as List<Object?>)
        .cast<Map<String, Object?>>();

    final widgetsInCategory = catalogWidgets
        .map(_WidgetInfo.new)
        .where((w) => w.categories.contains(widgetCategory))
        .toList(growable: false);

    final subcategories = category.subcategories;

    return super.buildBody(
      page,
      Component.fragment([
        child,
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

        if (subcategories.isNotEmpty) ...[
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
      ]),
    );
  }

  List<Component> _buildSubcategorySection(
    _SubcategoryInfo subcategory,
    List<Map<String, Object?>> allWidgets, {
    required bool isMaterialCatalog,
  }) {
    final subName = subcategory.name;
    if (subName.isEmpty) return const [];

    final widgets = allWidgets
        .map(_WidgetInfo.new)
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
    List<_WidgetInfo> widgets, {
    required bool isMaterialCatalog,
    _SubcategoryInfo? subcategory,
  }) {
    final gridClasses = isMaterialCatalog
        ? 'card-grid material-cards'
        : 'card-grid';

    return div(
      classes: gridClasses,
      [
        for (final widget in widgets)
          _buildWidgetCard(
            widget,
            isMaterialCatalog: isMaterialCatalog,
            subcategory: subcategory,
          ),
      ],
    );
  }

  Component _buildWidgetCard(
    _WidgetInfo widget, {
    required bool isMaterialCatalog,
    _SubcategoryInfo? subcategory,
  }) {
    return a(
      classes: 'card outlined-card',
      href: widget.link,
      [
        _buildCardImageHolder(
          name: widget.name,
          vector: widget.vector,
          imageSrc: widget.imageSrc,
          hoverBackgroundSrc: widget.hoverBackgroundSrc,
          isMaterialCatalog: isMaterialCatalog,
          subcategoryColor: subcategory?.color,
        ),
        div(
          classes: 'card-header',
          [
            header(
              classes: 'card-title',
              [text(widget.name)],
            ),
          ],
        ),
        div(
          classes: 'card-content',
          [
            DashMarkdown(
              content: truncateWords(widget.description, 25),
            ),
          ],
        ),
      ],
    );
  }

  Component _buildCardImageHolder({
    required String name,
    required String? vector,
    required String? imageSrc,
    required String? hoverBackgroundSrc,
    required bool isMaterialCatalog,
    required String? subcategoryColor,
  }) {
    final holderClass = isMaterialCatalog
        ? 'card-image-holder-material-3'
        : 'card-image-holder';

    final imageAlt = isMaterialCatalog
        ? 'Rendered example of the $name Material widget.'
        : 'Rendered image or visualization of the $name widget.';

    const placeholderAlt =
        'Placeholder Flutter logo in place of '
        'missing widget image or visualization.';

    final styleAttributes = isMaterialCatalog && subcategoryColor != null
        ? {'style': '--bg-color: $subcategoryColor'}
        : <String, String>{};

    return div(
      classes: holderClass,
      attributes: styleAttributes,
      [
        if (isMaterialCatalog) ...[
          // Material catalog always expects an image.
          if (imageSrc != null && imageSrc.isNotEmpty)
            img(alt: imageAlt, src: imageSrc)
          else
            img(
              alt: placeholderAlt,
              src: _placeholderImagePath,
              attributes: {'aria-hidden': 'true'},
            ),
          if (hoverBackgroundSrc != null && hoverBackgroundSrc.isNotEmpty)
            div(
              classes: 'card-image-material-3-hover',
              [
                img(
                  alt:
                      'Decorated background for '
                      'Material widget visualizations.',
                  src: hoverBackgroundSrc,
                  attributes: {'aria-hidden': 'true'},
                ),
              ],
            ),
        ] else ...[
          // Standard catalog prefers vector, then image, then placeholder.
          if (vector != null && vector.isNotEmpty)
            raw(vector)
          else if (imageSrc != null && imageSrc.isNotEmpty)
            img(alt: imageAlt, src: imageSrc)
          else
            img(
              alt: placeholderAlt,
              src: _placeholderImagePath,
              attributes: {'aria-hidden': 'true'},
            ),
        ],
      ],
    );
  }
}

extension type _WidgetInfo(Map<String, Object?> _data) {
  String get name => _data['name'] as String;
  String get link => _data['link'] as String;
  String get description => _data['description'] as String? ?? '';
  String? get vector => _data['vector'] as String?;
  Map<String, Object?>? get image => _data['image'] as Map<String, Object?>?;
  String? get imageSrc => image?['src'] as String?;
  Map<String, Object?>? get hoverBackground =>
      _data['hoverBackground'] as Map<String, Object?>?;
  String? get hoverBackgroundSrc => hoverBackground?['src'] as String?;

  List<String> get categories {
    final value = _data['categories'];
    if (value is List<Object?>) {
      return value.cast<String>();
    }
    return const [];
  }

  List<String> get subcategories {
    final value = _data['subcategories'];
    if (value is List<Object?>) {
      return value.cast<String>();
    }
    return const [];
  }
}

extension type _CategoryInfo(Map<String, Object?> _data) {
  String get name => _data['name'] as String? ?? '';
  String get description => _data['description'] as String? ?? '';
  List<_SubcategoryInfo> get subcategories {
    final value = _data['subcategories'] as List<Object?>?;
    if (value == null) return const [];
    return value
        .cast<Map<String, Object?>>()
        .map(_SubcategoryInfo.new)
        .toList(growable: false);
  }
}

extension type _SubcategoryInfo(Map<String, Object?> _data) {
  String get name => _data['name'] as String? ?? '';
  String? get color => _data['color'] as String?;
}
