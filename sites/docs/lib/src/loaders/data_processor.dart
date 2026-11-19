// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/seo.dart';

/// Adds Git modification dates and `noindex` sitemap exclusions to each page.
final class DataProcessor implements DataLoader {
  DataProcessor({GitLastModifiedIndex? index})
    : _index = index ?? GitLastModifiedIndex.defaultInstance;

  final GitLastModifiedIndex _index;

  @override
  Future<void> loadData(Page page) async {
    _index.applyToPage(page);
  }
}

/// Determines the newest Git modification time for [inputPaths].
DateTime? latestModifiedDateForPaths(Iterable<String> inputPaths) =>
    GitLastModifiedIndex.defaultInstance.latestModifiedDateForPaths(inputPaths);
