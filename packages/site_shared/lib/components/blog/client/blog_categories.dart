// Copyright (c) 2026, the Dart project authors. All rights reserved.
// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../../util.dart';
import '../blog_card_layout.dart';

class BlogCategory {
  const BlogCategory({
    required this.slug,
    required this.label,
    required this.description,
    required this.showFeatured,
  });

  final String slug;
  final String label;
  final String description;
  final bool showFeatured;

  @decoder
  factory BlogCategory.fromMap(Map<String, Object?> data) {
    return BlogCategory(
      slug: data['slug'] as String,
      label: data['label'] as String,
      description: data['description'] as String,
      showFeatured: data['showFeatured'] == true,
    );
  }

  @encoder
  Map<String, Object?> toMap() => {
    'slug': slug,
    'label': label,
    'description': description,
    'showFeatured': showFeatured,
  };
}

@client
class BlogCategories extends StatefulComponent {
  const BlogCategories({required this.categories, super.key});

  final List<BlogCategory> categories;

  @override
  State<BlogCategories> createState() => _BlogCategoriesState();
}

class _BlogCategoriesState extends State<BlogCategories> {
  BlogCategory? selectedCategory;
  StreamSubscription<web.PopStateEvent>? _popStateSubscription;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _updateCategoryFromUrl();
      _popStateSubscription = web.EventStreamProviders.popStateEvent
          .forTarget(web.window)
          .listen((_) => _updateCategoryFromUrl());
    }
  }

  @override
  void dispose() {
    unawaited(_popStateSubscription?.cancel());
    super.dispose();
  }

  void _updateCategoryFromUrl() {
    final uri = Uri.parse(web.window.location.href);
    final slug = uri.queryParameters['category'];
    final category = component.categories
        .where((c) => c.slug == slug)
        .firstOrNull;

    // The cards already have the layout for the selected category,
    // including the server-rendered layout when no category is selected.
    if (category == selectedCategory) return;

    setState(() {
      selectedCategory = category;
    });
    _applyLayout(category);
  }

  void _selectCategory(BlogCategory? category) {
    if (category == selectedCategory) return;

    setState(() {
      selectedCategory = category;
    });

    final uri = Uri.parse(web.window.location.href);
    final newUri = uri.replace(
      queryParameters: category == null ? {} : {'category': category.slug},
    );
    web.window.history.pushState(null, '', newUri.toString());

    _applyLayout(category);
  }

  void _applyLayout(BlogCategory? category) {
    final container = web.document.getElementById('blog-container');
    if (container == null) return;

    container.setAttribute('data-selected', category?.slug ?? 'all');

    final cards = container.querySelectorAll('.blog-card');
    final showFeatured = category?.showFeatured ?? true;
    var visibleCount = showFeatured ? 0 : 1;

    for (var cardIndex = 0; cardIndex < cards.length; cardIndex += 1) {
      final card = cards.item(cardIndex) as web.Element;
      final cardCategory = card.getAttribute('data-category');

      final isVisible = category == null || cardCategory == category.slug;
      final targetLayout = isVisible
          ? BlogCardLayout.forIndex(visibleCount++)
          : null;

      for (final layout in BlogCardLayout.values) {
        card.classList.toggle(layout.className, layout == targetLayout);
      }
    }
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'blog-categories', [
      div(
        classes: [
          'blog-category-chip',
          if (selectedCategory == null) 'active',
        ].toClasses,
        [
          button(
            onClick: () => _selectCategory(null),
            const [.text('All')],
          ),
        ],
      ),
      const span(classes: 'category-separator', []),
      for (final category in component.categories)
        div(
          classes: [
            'blog-category-chip',
            if (category == selectedCategory) 'active',
          ].toClasses,
          [
            button(
              onClick: () => _selectCategory(category),
              [.text(category.label)],
            ),
          ],
        ),
    ]);
  }
}
