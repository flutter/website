// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../blog.dart';
import '../common/material_icon.dart';
import 'blog_card.dart';
import 'client/blog_categories.dart';

extension PostIndex on BuildContext {
  List<({String url, Post post})> get blogPosts {
    final posts = <({String url, Post post})>[
      for (final page in pages)
        if (page.url.startsWith('/blog/'))
          if (Post.tryParse(page.data.page) case final post?)
            (url: page.url, post: post),
    ];

    return posts
        .sortedBy((entry) => entry.post.dateObject)
        .reversed
        .toList(growable: false);
  }
}

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
          for (var i = 0; i < posts.length; i++)
            BlogCard(
              post: posts[i].post,
              url: posts[i].url,
              priority: switch (i) {
                0 => BlogCardPriority.featured,
                < 5 => BlogCardPriority.high,
                _ => BlogCardPriority.normal,
              },
              className: i == 0
                  ? 'layout-featured'
                  : (i < 5 ? 'layout-grid' : 'layout-list'),
            ),
        ],
      ),
    ]);
  }
}
