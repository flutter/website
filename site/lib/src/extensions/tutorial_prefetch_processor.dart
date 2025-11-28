// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../models/tutorial_model.dart';

/// A page extension for Jaspr Content that adds page navigation and a
/// prefetch link for the next unit to the current tutorial page.
final class TutorialNavigationExtension implements PageExtension {
  const TutorialNavigationExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    if (!page.path.startsWith('tutorial/')) {
      return nodes;
    }

    final tutorial = switch (page.data['tutorial']) {
      final Map<Object?, Object?>? tutorialData when tutorialData != null =>
        TutorialModel.fromMap(tutorialData),
      _ => throw Exception('No tutorial data found.'),
    };

    final normalizedPageUrl = page.url.endsWith('/')
        ? page.url
        : '${page.url}/';

    final allChapters = [
      for (final unit in tutorial.units) ...unit.chapters,
    ];

    final currentChapterIndex = allChapters.indexWhere((chapter) {
      final normalizedUnitUrl = chapter.url.endsWith('/')
          ? chapter.url
          : '${chapter.url}/';
      return normalizedUnitUrl == normalizedPageUrl;
    });

    if (currentChapterIndex == -1) {
      return nodes;
    }

    final nextChapter = allChapters.length > currentChapterIndex + 1
        ? allChapters[currentChapterIndex + 1]
        : null;

    final prevChapter = currentChapterIndex > 0
        ? allChapters[currentChapterIndex - 1]
        : null;

    if (nextChapter == null && prevChapter == null) {
      return nodes;
    }

    page.apply(
      data: {
        'page': {
          if (nextChapter != null)
            'next': {'title': nextChapter.title, 'path': nextChapter.url},
          if (prevChapter != null)
            'prev': {'title': prevChapter.title, 'path': prevChapter.url},
        },
      },
    );

    if (nextChapter == null) {
      return nodes;
    }

    return [
      ComponentNode(
        Document.head(
          children: [
            link(rel: 'prefetch', href: nextChapter.url),
          ],
        ),
      ),
      ...nodes,
    ];
  }
}
