// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'ide_explorer.dart';
library;

/// A single top-level file tree shown by an [IdeExplorer],
/// which might have multiple roots to represent multiple packages,
/// such as "Project" and "Shared".
///
/// When multiple roots are provided, they are
/// rendered as tabs that can be switched between.
class const IdeExplorerProjectRoot({
  /// The unique identifier for this project root.
  required final String id,

  /// The display label used for this root's tab.
  final String? label,

  /// The top-level tree nodes contained in this project root.
  required final List<IdeTreeNode> children,
});

/// A single entry in an [IdeExplorer] tree.
///
/// Subclasses:
/// - [IdeFileNode] for file / document entries.
/// - [IdeFolderNode] for directory entries that can contain nested children.
sealed class const IdeTreeNode({
  /// The unique identifier for this tree node.
  required final String id,

  /// The display label or file name for this node in the tree.
  required final String label,

  /// Whether this node is selected and displayed by default.
  final bool isDefaultPage = false,

  /// An optional badge label displayed next to this node in the tree.
  final String? badge,

  /// The color theme for this node's [badge].
  final IdeBadgeColor? badgeColor,

  /// The title displayed in the detail header, or [label] if omitted.
  final String? title,

  /// An optional subtitle or description shown in the detail header.
  final String? subtitle,
});

/// A file entry in an [IdeExplorer] tree.
class const IdeFileNode({
  required super.id,
  required super.label,
  super.isDefaultPage,
  super.badge,
  super.badgeColor,
  super.title,
  super.subtitle,
}) extends IdeTreeNode;

/// A directory entry in an [IdeExplorer] tree that can contain nested children.
class const IdeFolderNode({
  required super.id,
  required super.label,
  super.isDefaultPage,

  /// Whether this directory starts in a collapsed state.
  final bool startsClosed = true,

  /// The child nodes contained within this directory.
  final List<IdeTreeNode> children = const [],

  super.badge,
  super.badgeColor,
  super.title,
  super.subtitle,
}) extends IdeTreeNode;

/// Corresponds to colors used for badges on an [IdeTreeNode].
enum IdeBadgeColor {
  /// A neutral, gray badge.
  neutral,

  /// An informational, blue badge.
  info,

  /// A tip or recommendation, green badge.
  tip,

  /// An important, purple badge.
  important,

  /// A warning, amber badge.
  warning,

  /// An error, red badge.
  error;

  /// Returns the [IdeBadgeColor] matching [data], or [neutral] if unmatched.
  static IdeBadgeColor fromString(String data) {
    return switch (data.toLowerCase()) {
      'info' => IdeBadgeColor.info,
      'tip' => IdeBadgeColor.tip,
      'important' => IdeBadgeColor.important,
      'warning' => IdeBadgeColor.warning,
      'error' => IdeBadgeColor.error,
      _ => IdeBadgeColor.neutral,
    };
  }
}
