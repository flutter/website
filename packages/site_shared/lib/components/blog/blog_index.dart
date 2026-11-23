// Copyright (c) 2026, the Dart project authors. All rights reserved.
// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../blog.dart';
import '../common/material_icon.dart';
import 'blog_card.dart';
import 'client/blog_categories.dart';

class BlogIndex extends StatelessComponent {
  const BlogIndex({super.key});

  @override
  Component build(BuildContext context) {
    final posts = context.blogPosts;
    final categories = context.page.blogCategories;

    return div(classes: 'blog-index', [
      div(classes: 'blog-index-toolbar', [
        BlogCategories(categories: categories),
        a(
          href: blogAtomFeedPath,
          classes: 'blog-feed-link',
          attributes: {
            'type': blogAtomMimeType,
            'title': context.page.blogAtomSubscribeTitle,
          },
          const [
            MaterialIcon('rss_feed'),
            span(classes: 'blog-feed-link-label', [.text('Subscribe')]),
          ],
        ),
      ]),
      div(
        id: 'blog-container',
        classes: 'blog-posts-grid',
        attributes: {'data-selected': 'all'},
        [
          for (final (i, (:post, :url)) in posts.indexed)
            BlogCard(
              post: post,
              url: url,
              layout: .forIndex(i),
            ),
        ],
      ),
    ]);
  }
}
