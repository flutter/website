// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/blog.dart';
import 'package:site_shared/components/blog/blog_next_posts.dart';
import 'package:site_shared/components/blog/post_info.dart';
import 'package:site_shared/components/common/breadcrumbs.dart';
import 'package:site_shared/util.dart';

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
          'page': {'titleBase': 'The Dart Blog'},
        },
      );
    }

    final categorySlug = pageData['category'] as String?;
    final categories = page.blogCategories;
    final pageCategory = categories
        .where((c) => c.slug == categorySlug)
        .firstOrNull;

    return super.buildLayout(
      page,
      main_([
        article([
          div(classes: 'content ${isPost ? 'post-content' : ''}', [
            div(id: 'site-content-title', [
              if (isPost)
                PageBreadcrumbs(
                  crumbs: [
                    const BreadcrumbItem(
                      title: 'The Flutter Blog',
                      url: '/blog',
                    ),
                    if (pageCategory != null &&
                        pageCategory.slug != 'other') ...[
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
            if (isPost) PostInfo(post: Post(pageData), url: page.url),
            child,
            if (isPost)
              BlogNextPosts(currentPage: page, category: pageCategory),
          ]),
        ]),
      ]),
    );
  }
}
