// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Builds a navigation structure for the site sidenav from
/// a loaded YAML or JSON structure.
///
/// Expects data in the format used by `src/_data/sidenav.yml`.
List<NavEntry> navEntriesFromData(List<Object?> data) => [
  for (final item in data)
    switch (item) {
      'divider' => const NavEntry.divider(),
      Map<String, Object?>() => NavEntry._fromMap(item),
      _ => throw ArgumentError('Invalid nav entry format: $item'),
    },
];

/// An individual entry in the sidenav.
sealed class NavEntry {
  const NavEntry();

  const factory NavEntry.header(String title) = NavHeader;
  const factory NavEntry.divider() = NavDivider;
  const factory NavEntry.link(String title, String permalink) = NavLink;
  const factory NavEntry.section(
    String title,
    List<NavEntry> children, {
    String? permalink,
    bool expanded,
    bool hiddenChildren,
  }) = NavSection;

  factory NavEntry._fromMap(Map<String, Object?> item) {
    // Check for special entries that indicate a different entry type.
    if (item.containsKey('header')) {
      return NavEntry.header(item['header'] as String);
    }

    final title = item['title'] as String?;
    if (title == null) {
      throw ArgumentError(
        'Non-divider and non-header nav entries must '
        "have a 'title' specified.",
      );
    }

    final childrenData = item['children'] as List<Object?>?;

    if (childrenData != null) {
      // If specified, build children recursively.
      final children = navEntriesFromData(childrenData);
      if (children.isNotEmpty) {
        final permalink = item['permalink'] as String?;
        final expanded = item['expanded'] as bool? ?? false;
        final hiddenChildren = item['hiddenChildren'] as bool? ?? false;
        return NavEntry.section(
          title,
          children,
          permalink: permalink,
          expanded: expanded,
          hiddenChildren: hiddenChildren,
        );
      }
    } else {
      final permalink = item['permalink'] as String?;
      if (permalink != null) {
        return NavEntry.link(title, permalink);
      }
    }

    throw ArgumentError('Invalid nav entry format: $item');
  }
}

final class NavHeader extends NavEntry {
  final String title;

  const NavHeader(this.title);
}

final class NavDivider extends NavEntry {
  const NavDivider();
}

final class NavLink extends NavEntry {
  final String title;
  final String permalink;

  const NavLink(this.title, this.permalink);
}

final class NavSection extends NavEntry {
  final String title;
  final List<NavEntry> children;
  final String? permalink;
  final bool expanded;
  final bool hiddenChildren;

  const NavSection(
    this.title,
    this.children, {
    this.permalink,
    this.expanded = false,
    this.hiddenChildren = false,
  });
}
