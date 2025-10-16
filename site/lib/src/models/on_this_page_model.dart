// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../extensions/header_extractor.dart';

class OnThisPageData {
  final List<OnThisPageEntry> topLevelEntries;

  OnThisPageData(this.topLevelEntries);

  factory OnThisPageData.fromContentHeaders(
    List<ContentHeader> headers, {
    required int minLevel,
    required int maxLevel,
  }) {
    final rootEntries = <OnThisPageEntry>[];
    final levelMap = <int, OnThisPageEntry>{};

    for (final header in headers) {
      // Clear entries at this level and below
      // so that they aren't tracked any more.
      for (
        var removeLevel = header.level;
        removeLevel <= maxLevel;
        removeLevel += 1
      ) {
        levelMap.remove(removeLevel);
      }

      final id = header.attributes['id'];
      final classes = header.attributes['class']?.split(' ') ?? [];

      // Check if header should be skipped.
      if (id == null ||
          classes.contains('no_toc') ||
          header.level < minLevel ||
          header.level > maxLevel) {
        continue;
      }

      final entry = OnThisPageEntry(
        id: id,
        text: header.text,
        children: <OnThisPageEntry>[],
      );

      // Check if this is a root level entry.
      if (header.level == minLevel) {
        rootEntries.add(entry);
        levelMap[header.level] = entry;
      } else {
        // Look for parent at exactly one level above.
        if (levelMap[header.level - 1] case final parent?) {
          parent.children.add(entry);
          levelMap[header.level] = entry;
        }
      }
    }

    return OnThisPageData(rootEntries);
  }
}

final class OnThisPageEntry {
  final String id;
  final String text;
  final List<OnThisPageEntry> children;

  const OnThisPageEntry({
    required this.id,
    required this.text,
    this.children = const [],
  });
}
