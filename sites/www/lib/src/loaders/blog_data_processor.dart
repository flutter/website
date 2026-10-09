// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// Validates and adds derived data to each filesystem-backed blog post.
///
/// Run before the asset data loader so invalid cover image metadata
/// is reported before the asset loader tries to resolve it.
final class BlogPostDataProcessor implements DataLoader {
  static final RegExp _wordPattern = RegExp(r'\w+');

  const BlogPostDataProcessor();

  @override
  Future<void> loadData(Page page) async {
    if (page.loader is! FilesystemLoader ||
        !page.url.startsWith('/blog/') ||
        page.data.page['publishDate'] is! String) {
      return;
    }

    final wordCount = _wordPattern.allMatches(page.content).length;
    final readingTime = (wordCount / 250).ceil();

    if (page.data.page['image'] != null) {
      throw ArgumentError(
        'Unsupported "image" metadata at "${page.url}". '
        'Use "coverImage" instead.',
      );
    }

    // Reject invalid URLs before the asset loader tries to read them.
    switch (page.data.page['coverImage']) {
      case null:
      case Map<Object?, Object?>(isEmpty: true):
      case {'url': final String url} when url.trim().isNotEmpty:
        break;
      default:
        throw ArgumentError(
          'Invalid "coverImage" metadata at "${page.url}". '
          'Must include a non-empty "url" string.',
        );
    }

    page.apply(
      data: {
        'page': {'readingTime': '$readingTime min read'},
      },
    );
  }
}
