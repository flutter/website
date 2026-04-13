// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../blog.dart';
import '../../util.dart';

class BlogCard extends StatelessComponent {
  const BlogCard({
    required this.post,
    required this.url,
    this.className,
    this.priority = BlogCardPriority.normal,
    super.key,
  });

  final Post post;
  final String url;
  final String? className;
  final BlogCardPriority priority;

  @override
  Component build(BuildContext context) {
    final authors = context.page.authorsByIds(post.authorIds);
    return a(
      href: url,
      classes: ['blog-card', ?className].toClasses,
      attributes: {'data-category': post.category ?? 'other'},
      [
        if (post.image case final postImage?)
          div(classes: 'blog-card-image', [
            img(
              src: postImage,
              alt: post.title,
              loading: switch (priority) {
                .featured => MediaLoading.eager,
                .high => null,
                .normal => MediaLoading.lazy,
              },
              attributes: {
                if (priority == .featured)
                  'fetchpriority': 'high'
                else if (priority == .normal)
                  'decoding': 'async',
              },
            ),
          ]),
        div(classes: 'blog-card-content', [
          h3(classes: 'blog-card-title', [
            .text(post.title),
          ]),
          p(classes: 'blog-card-description', [
            .text(post.description),
          ]),
          const span(classes: 'blog-card-spacer', []),
          div(classes: 'blog-card-meta', [
            div(classes: 'blog-card-authors', [
              for (final author in authors)
                if (author.image case final authorImage?)
                  img(
                    src: context.resolveAsset('/blog/authors/$authorImage'),
                    alt: author.name,
                    classes: 'blog-card-avatar',
                  )
                else if (author.github?.avatarUrl case final avatarUrl?)
                  img(
                    src: avatarUrl,
                    alt: author.name,
                    classes: 'blog-card-avatar',
                  ),
              span(classes: 'author', [
                for (final (index, author) in authors.indexed) ...[
                  span(classes: 'author-name', [
                    .text(author.name),
                  ]),
                  if (index < authors.length - 1)
                    const span(classes: 'author-separator', [.text(', ')]),
                ],
              ]),
            ]),
            div([
              span(classes: 'date', [
                .text(post.formattedDate),
              ]),
              const span(classes: 'separator', [.text(' · ')]),
              span(classes: 'reading-time', [
                .text(post.readingTime),
              ]),
            ]),
          ]),
        ]),
      ],
    );
  }
}

/// Priority levels for blog cards.
///
/// Used to configure loading behavior of their content, particularly images.
enum BlogCardPriority {
  /// A featured blog card.
  featured,

  /// A high-priority blog card.
  ///
  /// Often the first 5 or so cards.
  high,

  /// A normal-priority blog card.
  normal,
}
