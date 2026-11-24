// Copyright (c) 2026, the Dart project authors. All rights reserved.
// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/blog.dart';
import 'package:site_shared/components/blog/blog_next_posts.dart';
import 'package:site_shared/components/blog/blog_toc.dart';
import 'package:site_shared/components/blog/post_info.dart';
import 'package:site_shared/components/common/breadcrumbs.dart';
import 'package:site_shared/components/common/client/back_to_top_button.dart';
import 'package:site_shared/util.dart';

import '../components/common/content_image.dart';
import '../components/common/image_zoombox.dart';
import '../utils/scroll_spy.dart';
import 'default_layout.dart';

/// The blog's name, as shown in each post's page title and breadcrumbs.
const String _blogTitle = 'The Flutter Blog';

/// Shared styling and theme settings for the blog index and posts.
abstract class _BlogLayout extends DefaultLayout {
  @override
  List<String> get defaultBodyTags => const ['interior', 'blog'];

  @override
  bool get supportsDarkMode => true;

  @override
  List<String> get additionalFontUrls => const [
    'https://fonts.googleapis.com/css2?'
        'family=Roboto+Serif:ital,opsz,wght@'
        '0,8..72,400..700;1,8..72,400..700'
        '&display=swap',
  ];
}

/// The layout for the blog's list of posts.
class BlogIndexLayout extends _BlogLayout {
  @override
  String get name => 'blog-index';

  @override
  Component buildLayout(Page page, Component child) {
    return super.buildLayout(
      page,
      main_([
        article(classes: 'content', [
          div(classes: 'content', attributes: scroll.spyContent, [
            const _BlogHeading(),
            child,
          ]),
        ]),
      ]),
    );
  }
}

/// The layout for an individual blog post.
class BlogPostLayout extends _BlogLayout {
  // Anchored because layout names match as prefixes,
  // so a plain 'blog' would also claim the 'blog-index' layout.
  static final RegExp _name = .new(r'blog$');

  @override
  Pattern get name => _name;

  @override
  String get titleBase => _blogTitle;

  @override
  Component buildLayout(Page page, Component child) {
    final categories = page.blogCategories;
    final post = Post.parse(
      page.data.page,
      categories: categories,
      source: page.url,
    );
    final pageCategory = categories.firstWhere(
      (category) => category.slug == post.category,
    );

    return super.buildLayout(
      page,
      main_([
        article(classes: 'content', [
          div(
            classes: 'content post-content',
            attributes: scroll.spyContent,
            [
              _BlogHeading(
                breadcrumbs: PageBreadcrumbs(
                  crumbs: [
                    const BreadcrumbItem(title: _blogTitle, url: '/blog'),
                    BreadcrumbItem(
                      title: pageCategory.label,
                      url: '/blog?category=${pageCategory.slug}',
                    ),
                    BreadcrumbItem(
                      title: post.title.split(':').first,
                      url: page.url,
                    ),
                  ],
                ),
              ),
              PostInfo(post: post, url: page.url),
              if (post.coverImage case final coverImage?
                  when coverImage.showInPost)
                ContentImage(
                  src: coverImage.url,
                  alt: coverImage.alt ?? '',
                  caption: coverImage.caption,
                  isFigure: true,
                  figureClass: 'blog-cover-image',
                  isHighPriority: true,
                ),
              const BlogTableOfContents(),
              child,
              BlogNextPosts(currentPage: page, category: pageCategory),
            ],
          ),
        ]),
        const BackToTopButton(),
        ImageZoombox(key: ValueKey(page.url)),
      ]),
    );
  }
}

/// The title block shared by the blog index and individual posts.
class _BlogHeading extends StatelessComponent {
  const _BlogHeading({this.breadcrumbs});

  /// The breadcrumb trail for a post, or `null` for the blog index.
  final PageBreadcrumbs? breadcrumbs;

  @override
  Component build(BuildContext context) {
    final pageData = context.page.data.page;
    final title = pageData['title'] as String;
    return div(id: 'site-content-title', [
      ?breadcrumbs,
      h1(
        id: 'document-title',
        attributes: const {'tabindex': '-1'},
        [
          if (pageData['underscore_breaker_titles'] == true)
            ...splitByUnderscore(title)
          else
            .text(title),
        ],
      ),
      if (pageData['description'] case final String description)
        p(classes: 'blog-subtitle', [.text(description)]),
    ]);
  }
}
