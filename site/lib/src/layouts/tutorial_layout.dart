// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../models/tutorial_model.dart';
import 'doc_layout.dart';

class TutorialLayout extends DocLayout {
  const TutorialLayout();

  @override
  String get name => 'tutorial';

  @override
  bool get allowBreadcrumbs => false;

  @override
  List<String> get defaultBodyClasses => [];

  @override
  Component buildBody(Page page, Component child) {
    final model = switch (page.data['tutorial']) {
      final Map<Object?, Object?>? tutorialData when tutorialData != null =>
        TutorialModel.fromMap(tutorialData),
      _ => throw Exception('No tutorial data found.'),
    };

    final navigationEntries = <Map<String, Object?>>[];

    for (final unit in model.units) {
      navigationEntries.add({'type': 'divider', 'title': unit.title});
      for (final chapter in unit.chapters) {
        navigationEntries.add({'title': chapter.title, 'path': chapter.url});
      }
    }

    return super.buildBody(
      page..apply(
        data: {
          'page': {
            'showBanner': false,
            'navigationCollectionTitle': model.title,
            'navigationCollectionUrl': model.url,
            'navigationEntries': navigationEntries,
          },
        },
      ),
      child,
    );
  }
}
