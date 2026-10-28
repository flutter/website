// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';
import 'package:site_shared/util.dart';

import '../content/content_validation.dart';

part 'nav_content.mapper.dart';

/// A top-level navigation entry in the site header.
///
/// Expected data format:
///
/// - `label`: non-empty display text.
/// - `href`: non-empty URL or root-relative path.
/// - `items`: optional list of [NavLink] dropdown entries.
/// - `secondColumn`: optional second list of [NavLink] for
///   double-column dropdowns.
@MappableClass()
class NavItem with NavItemMappable {
  NavItem({
    required this.label,
    required this.href,
    this.items = const [],
    this.secondColumn,
  }) {
    checkFormat(isNotBlank(label), 'label must be a non-empty string.');
    checkFormat(isNotBlank(href), 'href must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(href),
      'href must be an absolute http(s) URL or a root-relative path.',
    );
    checkFormat(
      items.isNotEmpty || (secondColumn?.isEmpty ?? true),
      'secondColumn must be empty if items is empty.',
    );
  }

  /// Display text shown in the navigation bar.
  final String label;

  /// Destination URL or path for the top-level entry.
  final String href;

  /// Dropdown links shown when this entry is expanded.
  final List<NavLink> items;

  /// Optional second column of dropdown links.
  final List<NavLink>? secondColumn;

  /// Whether this entry has a dropdown menu.
  bool get hasDropdown => items.isNotEmpty;

  /// Identifier of this navigation item.
  String get id => slugify(label);

  /// Parses a nav item from YAML/JSON data.
  static NavItem fromJson(Map<String, Object?> json) =>
      NavItemMapper.fromMap(json);
}

/// A link within a navigation dropdown menu.
///
/// Expected data format:
///
/// - `label`: non-empty display text.
/// - `href`: non-empty URL or root-relative path.
/// - `subItems`: optional list of nested [NavLink] entries.
@MappableClass()
class NavLink with NavLinkMappable {
  NavLink({
    required this.label,
    required this.href,
    this.subItems = const [],
  }) {
    checkFormat(isNotBlank(label), 'label must be a non-empty string.');
    checkFormat(isNotBlank(href), 'href must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(href),
      'href must be an absolute http(s) URL or a root-relative path.',
    );
  }

  /// Display text for this link.
  final String label;

  /// Destination URL or path.
  final String href;

  /// Nested sub-menu links.
  final List<NavLink> subItems;

  /// Whether the [href] points to an external site.
  bool get isExternal => href.startsWith('http');

  /// Parses a nav link from YAML/JSON data.
  static NavLink fromJson(Map<String, Object?> json) =>
      NavLinkMapper.fromMap(json);
}
