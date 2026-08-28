// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A single top-level file tree shown by an [IdeExplorer], which may
/// have multiple roots to represent multiple packages
/// (for example, "Project" and "Shared").
///
/// When multiple roots are provided, they are rendered as tabs that can be
/// switched between.
class const IdeExplorerProjectRoot({
  required final String id,
  final String? label,
  final List<IdeTreeNode> children = const [],
});

/// A single entry in an [IdeExplorer] tree.
///
/// Subclasses:
/// - [IdeFileNode] for file / document entries.
/// - [IdeFolderNode] for directory entries that can contain nested children.
sealed class const IdeTreeNode({
  required final String id,
  required final String label,
  final bool isDefaultPage = false,
  final String? badge,
  final IdeBadgeColor? badgeColor,
  final String? title,
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
  final bool startsClosed = true,
  final List<IdeTreeNode> children = const [],
  super.badge,
  super.badgeColor,
  super.title,
  super.subtitle,
}) extends IdeTreeNode;

/// Corresponds to colors used for badges on an [IdeTreeNode].
enum IdeBadgeColor {
  neutral,
  info,
  tip,
  important,
  warning,
  error;

  static IdeBadgeColor fromString(String? data) {
    if (data == null) return IdeBadgeColor.neutral;
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
