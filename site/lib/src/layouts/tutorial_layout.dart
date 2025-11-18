// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'doc_layout.dart';

class TutorialLayout extends DocLayout {
  const TutorialLayout();

  @override
  String get name => 'tutorial';

  @override
  Component buildBody(Page page, Component child) {
    //TODO(schultek): Extract the real pages in some way.
    const navigationEntries = [
      {'type': 'divider', 'title': 'Introdution to Flutter UI'},
      {'title': 'Create a Flutter app', 'path': '/fwe0'},
      {'title': 'Widget fundamentals', 'path': '/fwe1'},
      {'title': 'Layout widgets on a screen', 'path': '/fwe2'},
      {'title': 'FWE Testing Page', 'path': '/fwe'},
      {'title': 'Devtools', 'path': '/fwe3'},
      {'title': 'Handle user input', 'path': '/fwe4'},
      {'type': 'divider', 'title': 'State in Flutter apps'},
      {'title': 'Set up a new project', 'path': '/fwe5'},
      {'title': 'Make Http Requests', 'path': '/fwe6'},
      {'title': 'Use ChangeNotifier to update app state', 'path': '/fwe7'},
      {'title': 'Use ListenableBuilder to update app UI', 'path': '/fwe8'},
      {'type': 'divider', 'title': 'Flutter UI 102'},
      {'title': 'Set up your project', 'path': '/fwe9'},
      {'title': 'LayoutBuilder and adaptive layouts', 'path': '/fwe10'},
      {'title': 'Scrolling and slivers', 'path': '/fwe11'},
      {'title': 'Stack based navigation', 'path': '/fwe12'},
    ];

    return super.buildBody(
      page..apply(
        data: {
          'page': {
            'showBanner': false,
            'navigationCollectionTitle': 'Flutter Fundamentals',
            'navigationEntries': navigationEntries,
          },
          'sidenav': null,
        },
      ),
      child,
    );
  }
}
