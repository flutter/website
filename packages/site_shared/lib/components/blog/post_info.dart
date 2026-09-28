// Copyright (c) 2026, the Dart project authors. All rights reserved.
// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../src/blog/atom_feed.dart';
import '../../src/blog/models.dart';
import '../common/button.dart';
import 'client/share_button.dart';

class PostInfo extends StatelessComponent {
  const PostInfo({
    required this.post,
    required this.url,
    super.key,
  });

  final Post post;
  final String url;

  @override
  Component build(BuildContext context) {
    final authors = context.page.authorsByIds(post.authorIds);
    final siteUrl = context.page.data.site['url'];

    return div(classes: 'post-info', [
      div(classes: 'post-info-main', [
        _AuthorInfo(authors: authors),
        span(classes: 'post-info-meta', [
          Component.text('${post.formattedDate} · ${post.readingTime}'),
        ]),
      ]),
      div(classes: 'post-info-actions', [
        Button(
          icon: 'rss_feed',
          href: blogAtomFeedPath,
          title: context.page.blogAtomSubscribeTitle,
          attributes: {'type': blogAtomMimeType},
        ),
        ShareButton(url: '$siteUrl$url', title: post.title),
      ]),
    ]);
  }
}

class _AuthorInfo extends StatelessComponent {
  const _AuthorInfo({required this.authors});

  final List<Author> authors;

  @override
  Component build(BuildContext context) {
    return div(classes: 'post-info-author', [
      div(classes: 'post-info-avatars', [
        for (final author in authors)
          if (author.resolveImageUrl(context) case final imageUrl?)
            img(
              src: imageUrl,
              alt: author.name,
              width: 32,
              height: 32,
            ),
      ]),
      h3(classes: 'post-info-name', [
        for (final (index, author) in authors.indexed) ...[
          span(classes: 'post-info-author-name', [
            if (author.link case final linkUrl?)
              a(href: linkUrl, target: Target.blank, [.text(author.name)])
            else
              .text(author.name),
          ]),
          if (index < authors.length - 1)
            const span(classes: 'post-info-author-separator', [.text(', ')]),
        ],
      ]),
    ]);
  }
}
