// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../blog.dart';
import 'blog_card.dart';
import 'blog_index.dart';
import 'client/blog_categories.dart';

class BlogNextPosts extends StatelessComponent {
  const BlogNextPosts({
    required this.currentPage,
    required this.category,
    super.key,
  });

  final Page currentPage;
  final BlogCategory? category;

  @override
  Component build(BuildContext context) {
    final nextPosts = context.blogPosts
        .where(
          (page) =>
              page.url != currentPage.url &&
              page.post.category == category?.slug,
        )
        .take(2)
        .toList();

    if (nextPosts.isEmpty) return const .fragment([]);

    final String nextPostsTitle;
    if (context.page.blogData case {'nextPostsTitle': final String title}) {
      nextPostsTitle = title;
    } else {
      throw Exception('Missing or invalid blog next posts title');
    }

    return section(classes: 'blog-next-posts', [
      h2([.text(nextPostsTitle)]),
      div(classes: 'blog-posts-grid', [
        for (final post in nextPosts)
          BlogCard(
            post: post.post,
            url: post.url,
            className: 'layout-grid',
          ),
      ]),
    ]);
  }
}
