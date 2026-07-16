// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/blog.dart';
import 'package:site_shared/components/blog/blog_next_posts.dart';
import 'package:site_shared/components/blog/post_info.dart';
import 'package:site_shared/components/common/breadcrumbs.dart';
import 'package:site_shared/util.dart';

import '../utils/scroll_spy.dart';
import 'default_layout.dart';

/// The Jaspr Content layout to use for blog pages,
/// adding elements such as breadcrumbs.
class BlogLayout extends DefaultLayout {
  BlogLayout();

  @override
  String get name => 'blog';

  @override
  List<String> get defaultBodyTags => ['interior', 'blog'];

  @override
  Component buildLayout(Page page, Component child) {
    final pageData = page.data.page;
    final pageTitle = pageData['title'] as String? ?? 'Untitled';

    final isPost = page.url.startsWith('/blog/');
    if (isPost && page.data.page['titleBase'] == null) {
      page.apply(
        data: {
          'page': {'titleBase': 'The Flutter Blog'},
        },
      );
    }

    final categories = page.blogCategories;
    final post = isPost
        ? Post.parse(pageData, categories: categories, source: page.url)
        : null;
    final pageCategory = post == null
        ? null
        : categories.firstWhereOrNull(
            (category) => category.slug == post.category,
          );

    return super.buildLayout(
      page,
      main_([
        article(classes: 'content', [
          div(
            classes: 'content ${isPost ? 'post-content' : ''}',
            attributes: scroll.spyContent,
            [
              div(id: 'site-content-title', [
                if (isPost)
                  PageBreadcrumbs(
                    crumbs: [
                      const BreadcrumbItem(
                        title: 'The Flutter Blog',
                        url: '/blog',
                      ),
                      if (pageCategory != null) ...[
                        BreadcrumbItem(
                          title: pageCategory.label,
                          url: '/blog?category=${pageCategory.slug}',
                        ),
                      ],
                      BreadcrumbItem(
                        title: pageTitle.split(':').first,
                        url: page.url,
                      ),
                    ],
                  ),
                h1(id: 'document-title', [
                  if (pageData['underscore_breaker_titles'] == true)
                    ...splitByUnderscore(pageTitle)
                  else
                    .text(pageTitle),
                ]),
                if (pageData['description'] != null)
                  p(classes: 'blog-subtitle', [
                    .text(pageData['description'] as String),
                  ]),
              ]),
              if (post != null) PostInfo(post: post, url: page.url),
              child,
              if (isPost)
                BlogNextPosts(currentPage: page, category: pageCategory),
            ],
          ),
        ]),
      ]),
    );
  }
}
