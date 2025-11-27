// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../markdown/markdown_parser.dart';
import '../../models/tutorial_model.dart';

class TutorialOutline extends CustomComponentBase {
  const TutorialOutline();

  @override
  Pattern get pattern => 'TutorialOutline';

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    return Builder(
      builder: (context) {
        final model = switch (context.page.data['tutorial']) {
          final Map<Object?, Object?>? tutorialData when tutorialData != null =>
            TutorialModel.fromMap(tutorialData),
          _ => throw Exception('No tutorial data found.'),
        };

        return div(classes: 'tutorial-outline', [
          ol([
            for (final unit in model.units)
              li([
                text(unit.title),
                ol([
                  for (final chapter in unit.chapters)
                    li([
                      a(href: chapter.url, [
                        DashMarkdown(content: chapter.title, inline: true),
                      ]),
                    ]),
                ]),
              ]),
          ]),
        ]);
      },
    );
  }
}
