// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../src/markdown/markdown_parser.dart';
import 'models/tutorial_model.dart';

class TutorialOutline extends CustomComponentBase {
  const TutorialOutline({this.showUnitTitle = true});

  final bool showUnitTitle;

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
          ol([for (final unit in model.units) ..._buildUnit(unit)]),
        ]);
      },
    );
  }

  List<Component> _buildUnit(TutorialUnit unit) {
    final chapters = [
      for (final chapter in unit.chapters)
        li([
          a(href: chapter.url, [
            DashMarkdown(content: chapter.title, inline: true),
          ]),
        ]),
    ];

    if (showUnitTitle) {
      return [
        li([
          .text(unit.title),
          ol(chapters),
        ]),
      ];
    } else {
      return chapters;
    }
  }
}
