// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

extension Stories on BuildContext {
  List<Page> stories({String? tag, String? excludeTag, bool sort = false}) {
    final stories = pages.where((page) {
      if (!page.url.startsWith('/showcase/')) return false;
      if (tag != null &&
          (page.data.page['tags'] is! List ||
              !(page.data.page['tags'] as List).contains(tag))) {
        return false;
      }
      if (excludeTag != null &&
          page.data.page['tags'] is List &&
          (page.data.page['tags'] as List).contains(excludeTag)) {
        return false;
      }
      return true;
    });
    if (sort) {
      return stories
          .sortedBy<DateTime>(
            (page) => DateTime.parse(page.data.page['publishDate'] as String),
          )
          .reversed
          .toList();
    } else {
      return stories.toList();
    }
  }
}
