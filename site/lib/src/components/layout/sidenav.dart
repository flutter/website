// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../models/sidenav_model.dart';
import '../../util.dart';
import '../common/material_icon.dart';

/// The site-wide side navigation menu,
/// with entries loaded from the `src/data/sidenav.yml` file.
final class DashSideNav extends StatelessComponent {
  const DashSideNav({
    super.key,
    required this.navEntries,
    required this.currentPageUrl,
  });

  final List<NavEntry> navEntries;

  /// The URL of the current page to mark as active, alongside its ancestors.
  final String currentPageUrl;

  @override
  Component build(BuildContext _) => div(id: 'sidenav', [
    nav([
      _SideNavLevel(
        entries: navEntries,
        parentId: 'sidenav',
        currentLevel: 0,
        possiblyActive: true,
        currentPageUrl: currentPageUrl,
        activePath: _ActiveNavigationPath.findActive(
          entries: navEntries,
          currentPageUrl: currentPageUrl,
        ),
      ),
    ]),
  ]);
}

class _SideNavLevel extends StatelessComponent {
  const _SideNavLevel({
    required this.entries,
    required this.parentId,
    required this.currentLevel,
    required this.possiblyActive,
    required this.currentPageUrl,
    required this.activePath,
    this.classes,
    this.id,
  });

  final List<NavEntry> entries;
  final String parentId;
  final int currentLevel;
  final bool possiblyActive;
  final String currentPageUrl;
  final _ActiveNavigationPath activePath;
  final String? classes;
  final String? id;

  @override
  Component build(BuildContext _) => ul(
    classes: classes,
    id: id,
    [
      for (var entryIndex = 0; entryIndex < entries.length; entryIndex++)
        _componentFromEntry(entryIndex),
    ],
  );

  /// Builds the component that corresponds to the entry at
  /// the specified [entryIndex] in [entries].
  Component _componentFromEntry(int entryIndex) {
    final entry = entries[entryIndex];

    late final isInActivePath =
        possiblyActive &&
        activePath.isIndexActiveAtLevel(entryIndex, currentLevel);

    return switch (entry) {
      NavDivider() => const _SideNavDivider(),
      NavHeader(:final title) => _SideNavHeader(title: title),
      NavSection() => _SideNavCollapsibleSection(
        section: entry,
        id: _generateChildId(entryIndex),
        isInActivePath: isInActivePath,
        currentLevel: currentLevel,
        currentPageUrl: currentPageUrl,
        activePath: activePath,
      ),
      NavLink() => _SideNavLink(
        entry,
        isActive: isInActivePath && activePath.isLeafAt(currentLevel),
      ),
    };
  }

  String _generateChildId(int entryIndex) => '$parentId-${entryIndex + 1}';
}

class _SideNavDivider extends StatelessComponent {
  const _SideNavDivider();

  @override
  Component build(BuildContext _) => li(
    attributes: {'aria-hidden': 'true'},
    [div(classes: 'sidenav-divider', [])],
  );
}

class _SideNavHeader extends StatelessComponent {
  const _SideNavHeader({required this.title});

  final String title;

  @override
  Component build(BuildContext _) => li(classes: 'nav-header', [text(title)]);
}

class _SideNavCollapsibleSection extends StatelessComponent {
  const _SideNavCollapsibleSection({
    required this.section,
    required this.id,
    required this.isInActivePath,
    required this.currentLevel,
    required this.currentPageUrl,
    required this.activePath,
  });

  final NavSection section;
  final String id;
  final bool isInActivePath;
  final int currentLevel;
  final String currentPageUrl;
  final _ActiveNavigationPath activePath;

  @override
  Component build(BuildContext _) {
    // Determine if children should be shown based on hiddenChildren setting.
    final shouldShowChildren = _shouldShowChildren();

    if (!shouldShowChildren) {
      // When hiddenChildren is true and path doesn't match,
      // render as a sidenav link if a permalink exists, otherwise as text.
      return section.permalink != null
          ? _SideNavLink(
              NavLink(section.title, section.permalink!),
              isActive: isInActivePath,
            )
          : li(classes: 'nav-item', [
              span(classes: 'nav-link', [text(section.title)]),
            ]);
    }

    final expanded = isInActivePath || section.expanded;
    return li(classes: 'nav-item', [
      button(
        classes: [
          'nav-link',
          if (isInActivePath) 'active',
          'collapsible',
          if (!expanded) 'collapsed',
        ].toClasses,
        attributes: {
          'data-toggle': 'collapse',
          'data-target': '#$id',
          'role': 'button',
          'aria-expanded': expanded.toString(),
          'aria-controls': id,
        },
        [
          span([text(section.title)]),
          const MaterialIcon('expand_more', classes: ['expander']),
        ],
      ),
      _SideNavLevel(
        entries: section.children,
        parentId: id,
        currentLevel: currentLevel + 1,
        possiblyActive: isInActivePath,
        currentPageUrl: currentPageUrl,
        activePath: activePath,
        classes: [
          'nav',
          'collapse',
          if (expanded) 'show',
        ].toClasses,
        id: id,
      ),
    ]);
  }

  /// Determines whether children should be shown for this section.
  ///
  /// If [NavSection.hiddenChildren] is true, children are only shown
  /// when the current page URL matches or is under the section's permalink.
  bool _shouldShowChildren() {
    if (!section.hiddenChildren) {
      return true;
    }

    final permalink = section.permalink;
    if (permalink == null) {
      // No permalink to match against, show children.
      return true;
    }

    // Normalize the permalink to ensure it starts with '/'.
    final normalizedPermalink = _normalizePermalink(permalink);

    // Show children if the current URL matches or is under this section.
    return currentPageUrl == normalizedPermalink ||
        currentPageUrl.startsWith('$normalizedPermalink/');
  }
}

class _SideNavLink extends StatelessComponent {
  const _SideNavLink(this.link, {this.isActive = false});

  final NavLink link;
  final bool isActive;

  @override
  Component build(BuildContext _) {
    final isExternal = link.permalink.contains('://');
    return li(classes: 'nav-item', [
      a(
        classes: ['nav-link', if (isActive) 'active'].toClasses,
        href: link.permalink,
        target: isExternal ? Target.blank : null,
        attributes: isExternal ? {'rel': 'noopener'} : null,
        [
          div([
            span([text(link.title)]),
            if (isExternal) const MaterialIcon('open_in_new'),
          ]),
        ],
      ),
    ]);
  }
}

/// Represents the active navigation path in the sidenav.
///
/// Encapsulates the logic for determining and checking
/// the active navigation path based on the current page URL.
final class _ActiveNavigationPath {
  /// The indices representing the path to the active navigation entry.
  final List<int> _indices;

  const _ActiveNavigationPath(this._indices);

  /// An empty navigation path (no active item).
  static const empty = _ActiveNavigationPath([]);

  /// Finds the active navigation path for the specified [currentPageUrl].
  factory _ActiveNavigationPath.findActive({
    required List<NavEntry> entries,
    required String currentPageUrl,
  }) {
    final permalinkPaths = _collectPermalinkPaths(entries);
    final bestMatch = _findBestMatchingPath(permalinkPaths, currentPageUrl);
    return bestMatch != null ? _ActiveNavigationPath(bestMatch) : empty;
  }

  /// Returns whether the given [index] is active at the specified [level].
  bool isIndexActiveAtLevel(int index, int level) {
    assert(level >= 0);
    return level < _indices.length && _indices[level] == index;
  }

  /// Returns whether the specified [level] represents the
  /// leaf element in the active path.
  bool isLeafAt(int level) =>
      _indices.isNotEmpty && level == _indices.length - 1;

  /// Collects all internal link permalinks and their navigation paths.
  static Map<String, List<int>> _collectPermalinkPaths(
    List<NavEntry> entries, [
    List<int> currentPath = const [],
  ]) {
    final results = <String, List<int>>{};

    for (var entryIndex = 0; entryIndex < entries.length; entryIndex++) {
      final entry = entries[entryIndex];
      final newPath = [...currentPath, entryIndex];

      if (entry case NavLink(
        :final permalink,
      ) when !_isExternalLink(permalink)) {
        final normalizedPermalink = _normalizePermalink(permalink);
        results[normalizedPermalink] = newPath;
      } else if (entry case NavSection(:final children)) {
        results.addAll(_collectPermalinkPaths(children, newPath));
      }
    }

    return results;
  }

  /// Finds the best matching navigation path for the given URL.
  static List<int>? _findBestMatchingPath(
    Map<String, List<int>> permalinkPaths,
    String targetUrl,
  ) {
    String? bestMatchingPermalink;
    List<int>? bestMatchingPath;

    for (final MapEntry(key: permalink, value: path)
        in permalinkPaths.entries) {
      if (_urlMatchesPermalink(targetUrl, permalink)) {
        // Keep the longest (most specific) matching permalink.
        if (bestMatchingPermalink == null ||
            permalink.length > bestMatchingPermalink.length) {
          bestMatchingPermalink = permalink;
          bestMatchingPath = path;
        }
      }
    }

    return bestMatchingPath;
  }

  /// Returns whether the specified [url] matches the specified [permalink],
  /// either exactly or as a parent path.
  static bool _urlMatchesPermalink(String url, String permalink) =>
      url == permalink || url.startsWith('$permalink/');

  /// Returns whether the specified [permalink] is an external link.
  static bool _isExternalLink(String permalink) => permalink.contains('://');
}

/// Normalizes a permalink to ensure it starts with '/'.
String _normalizePermalink(String permalink) =>
    permalink.startsWith('/') ? permalink : '/$permalink';
