// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

import '../extensions/header_extractor.dart';

extension GetPageNavigationData on Page {
  PageNavigationData? get navigationData {
    final pageData = data.page;
    final showToc = pageData['showToc'] as bool? ?? true;

    // If 'showToc' was explicitly set to false, hide the toc.
    if (!showToc) return null;

    final tocData = _getTocData(
      data['contentHeaders'] as List<ContentHeader>? ?? const [],
      minLevel: pageData['minTocDepth'] as int? ?? 2,
      maxLevel: pageData['maxTocDepth'] as int? ?? 3,
    );

    final parentTitle = pageData['navigationCollectionTitle'] as String?;

    final pageEntries = <PageNavigationEntry>[];
    if (pageData['navigationEntries'] case final List<Object?> entries) {
      for (final entry in entries) {
        if (PageNavigationEntry.fromData(entry) case final entry?) {
          pageEntries.add(entry);
        }
      }
    }

    // If there are less than 2 top-level entries, hide the toc.
    if (tocData.topLevelEntries.length < 2) {
      return PageNavigationData(null, pageEntries, parentTitle);
    }

    return PageNavigationData(tocData, pageEntries, parentTitle);
  }

  TocNavigationData _getTocData(
    List<ContentHeader> headers, {
    required int minLevel,
    required int maxLevel,
  }) {
    final rootEntries = <TocNavigationEntry>[];
    final levelMap = <int, TocNavigationEntry>{};

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

      final entry = TocNavigationEntry(
        id: id,
        text: header.text,
        children: <TocNavigationEntry>[],
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

    return TocNavigationData(rootEntries);
  }
}

final class PageNavigationData {
  PageNavigationData(this.toc, this.pageEntries, this.parentTitle);

  final TocNavigationData? toc;
  final List<PageNavigationEntry> pageEntries;
  final String? parentTitle;
}

final class TocNavigationData {
  TocNavigationData(this.topLevelEntries);

  final List<TocNavigationEntry> topLevelEntries;
}

final class TocNavigationEntry {
  const TocNavigationEntry({
    required this.id,
    required this.text,
    this.children = const [],
  });

  final String id;
  final String text;
  final List<TocNavigationEntry> children;
}

final class PageNavigationEntry {
  const PageNavigationEntry({
    required this.title,
    required this.url,
  }) : isDivider = false;

  const PageNavigationEntry.divider({
    required this.title,
  }) : url = '',
       isDivider = true;

  static PageNavigationEntry? fromData(Object? data) {
    if (data case {
      'type': 'divider',
      'title': final String title,
    }) {
      return PageNavigationEntry.divider(title: title);
    }

    if (data case {
      'title': final String title,
      'path': final String path,
    }) {
      return PageNavigationEntry(title: title, url: path);
    }

    return null;
  }

  final String title;
  final String url;
  final bool isDivider;
}
