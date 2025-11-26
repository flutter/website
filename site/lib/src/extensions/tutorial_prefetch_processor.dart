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

    var chapterIndex = -1;
    var unitIndex = -1;

    final normalizedPageUrl = page.url.endsWith('/')
        ? page.url
        : '${page.url}/';

    outer:
    for (final (i, chapter) in tutorial.chapters.indexed) {
      for (final (j, unit) in chapter.units.indexed) {
        final normalizedUnitUrl = unit.url.endsWith('/')
            ? unit.url
            : '${unit.url}/';
        if (normalizedUnitUrl == normalizedPageUrl) {
          chapterIndex = i;
          unitIndex = j;
          break outer;
        }
      }
    }

    if (chapterIndex == -1 || unitIndex == -1) {
      return nodes;
    }

    final nextUnit =
        tutorial.chapters[chapterIndex].units.length > unitIndex + 1
        ? tutorial.chapters[chapterIndex].units[unitIndex + 1]
        : tutorial.chapters.length > chapterIndex + 1
        ? tutorial.chapters[chapterIndex + 1].units.first
        : null;

    final prevUnit = unitIndex > 0
        ? tutorial.chapters[chapterIndex].units[unitIndex - 1]
        : chapterIndex > 0
        ? tutorial.chapters[chapterIndex - 1].units.last
        : null;

    if (nextUnit == null && prevUnit == null) {
      return nodes;
    }

    page.apply(
      data: {
        'page': {
          if (nextUnit != null)
            'next': {'title': nextUnit.title, 'path': nextUnit.url},
          if (prevUnit != null)
            'prev': {'title': prevUnit.title, 'path': prevUnit.url},
        },
      },
    );

    if (nextUnit == null) {
      return nodes;
    }

    return [
      ComponentNode(
        Document.head(
          children: [
            link(rel: 'prefetch', href: nextUnit.url),
          ],
        ),
      ),
      ...nodes,
    ];
  }
}
