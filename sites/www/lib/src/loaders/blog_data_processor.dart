// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// Adds derived data to each filesystem-backed blog post.
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

    page.apply(
      data: {
        'page': {'readingTime': '$readingTime min read'},
      },
    );
  }
}
