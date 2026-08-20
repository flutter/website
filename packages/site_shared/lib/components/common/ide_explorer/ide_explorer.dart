// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/file_icon.dart';

import '../../../util.dart';
import '../material_icon.dart';

/// A single top-level file tree shown by an [IdeExplorer], which may
/// have multiple roots to represent multiple packages
/// (e.g. "Project" and "Shared").
///
/// When multiple roots are provided, they are rendered as tabs that can be
/// switched between.
class IdeExplorerProjectRoot {
  const IdeExplorerProjectRoot({
    required this.id,
    this.label = '',
    this.children = const [],
  });

  final String id;
  final String label;
  final List<IdeTreeNode> children;
}

/// A single file or folder entry in an [IdeExplorer] tree.
class IdeTreeNode {
  const IdeTreeNode({
    required this.id,
    required this.label,
    this.isDefaultPage = false,
    this.startsClosed = true,
    this.badge,
    this.badgeColor,
    this.subtitle,
    this.title,
    this.children = const [],
  });

  final String id;
  final String label;
  final bool isDefaultPage;
  final bool startsClosed;
  final String? badge;
  final IdeBadgeColor? badgeColor;
  final String? title;
  final String? subtitle;
  final List<IdeTreeNode> children;

  bool get isFolder => children.isNotEmpty || label.endsWith('/');
}

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

/// A flattened [IdeTreeNode] paired with the path of ancestor labels
/// leading to it, used to render the breadcrumb in its detail pane.
typedef _BreadcrumbNode = ({
  IdeTreeNode node,
  String domId,
  List<String> path,
});

/// Generates a unique DOM id for an IDE tree node.
String _ideDomId(String instanceId, String nodeId) => 'ide-$instanceId-$nodeId';

// ---------------------------------------------------------------------------
// Main Explorer Component
// ---------------------------------------------------------------------------

/// An interactive file-tree explorer, similar to an IDE's sidebar.
///
/// Renders a clickable directory tree next to a detail pane that shows
/// per-file/folder documentation. Clicking an entry in the tree swaps which
/// detail pane is shown.
class IdeExplorer extends StatelessComponent {
  const IdeExplorer({
    super.key,
    required this.roots,
    this.instanceId,
    this.customContents = const {},
  });

  static int _nextInstanceId = 0;

  final List<IdeExplorerProjectRoot> roots;
  final String? instanceId;
  final Map<String, Component> customContents;

  @override
  Component build(BuildContext context) {
    if (roots.isEmpty) {
      return const Component.empty();
    }

    final effectiveInstanceId = instanceId ?? '${_nextInstanceId++}';

    final flatNodesByRoot = _buildFlatNodesByRoot(effectiveInstanceId);
    final allFlatNodes = flatNodesByRoot.values
        .expand((nodes) => nodes)
        .toList(growable: false);

    final defaultFlatNode = _findDefaultNode(allFlatNodes);
    final activeRootId = _determineActiveRoot(
      defaultFlatNode,
      flatNodesByRoot,
    );
    final selectedNodeDomId = _determineSelectedNode(
      defaultFlatNode,
      flatNodesByRoot,
      activeRootId,
    );

    return div(classes: 'ide-explorer not-content', [
      _IdeSidebar(
        roots: roots,
        activeRootId: activeRootId,
        effectiveInstanceId: effectiveInstanceId,
        selectedNodeDomId: selectedNodeDomId,
      ),
      _IdeDetailPane(
        allFlatNodes: allFlatNodes,
        customContents: customContents,
        effectiveInstanceId: effectiveInstanceId,
        selectedNodeDomId: selectedNodeDomId,
      ),
    ]);
  }

  /// Builds a map of flattened nodes organized by root ID.
  Map<String, List<_BreadcrumbNode>> _buildFlatNodesByRoot(
    String effectiveInstanceId,
  ) {
    return {
      for (final root in roots)
        root.id: _flatten(
          root.children,
          instanceId: effectiveInstanceId,
          path: root.label.isEmpty ? [] : [root.label],
        ),
    };
  }

  /// Finds the first node marked as the default page.
  _BreadcrumbNode? _findDefaultNode(List<_BreadcrumbNode> allFlatNodes) {
    return allFlatNodes.firstWhereOrNull(
      (flat) => flat.node.isDefaultPage,
    );
  }

  /// Determines which root should be active based on the default node.
  String _determineActiveRoot(
    _BreadcrumbNode? defaultFlatNode,
    Map<String, List<_BreadcrumbNode>> flatNodesByRoot,
  ) {
    if (defaultFlatNode == null) {
      return roots.first.id;
    }

    final rootWithDefault = roots.firstWhereOrNull(
      (r) =>
          flatNodesByRoot[r.id]?.any(
            (n) => n.domId == defaultFlatNode.domId,
          ) ??
          false,
    );

    return rootWithDefault?.id ?? roots.first.id;
  }

  /// Determines which node should be selected initially.
  String? _determineSelectedNode(
    _BreadcrumbNode? defaultFlatNode,
    Map<String, List<_BreadcrumbNode>> flatNodesByRoot,
    String activeRootId,
  ) {
    return defaultFlatNode?.domId ??
        flatNodesByRoot[activeRootId]?.firstOrNull?.domId;
  }

  List<_BreadcrumbNode> _flatten(
    List<IdeTreeNode> nodes, {
    required String instanceId,
    required List<String> path,
  }) {
    final result = <_BreadcrumbNode>[];
    for (final node in nodes) {
      final nodePath = [...path, node.label];
      result.add((
        node: node,
        domId: _ideDomId(instanceId, node.id),
        path: path,
      ));
      result.addAll(
        _flatten(
          node.children,
          instanceId: instanceId,
          path: nodePath,
        ),
      );
    }
    return result;
  }
}

// ---------------------------------------------------------------------------
// Sidebar Components
// ---------------------------------------------------------------------------

/// The left sidebar containing the root switcher tabs and directory trees.
class _IdeSidebar extends StatelessComponent {
  const _IdeSidebar({
    required this.roots,
    required this.activeRootId,
    required this.effectiveInstanceId,
    required this.selectedNodeDomId,
  });

  final List<IdeExplorerProjectRoot> roots;
  final String activeRootId;
  final String effectiveInstanceId;
  final String? selectedNodeDomId;

  @override
  Component build(BuildContext context) {
    return div(classes: 'ide-sidebar', [
      if (roots.length > 1)
        _IdeRootTabs(roots: roots, activeRootId: activeRootId)
      else
        const div(classes: 'ide-root-tabs ide-root-tabs-single', [
          _IdeToggleAllButton(),
        ]),
      for (final root in roots)
        _IdeTree(
          root: root,
          isActive: root.id == activeRootId,
          effectiveInstanceId: effectiveInstanceId,
          selectedNodeDomId: selectedNodeDomId,
        ),
    ]);
  }
}

/// The tab list for switching between project roots, plus toggle-all button.
class _IdeRootTabs extends StatelessComponent {
  const _IdeRootTabs({
    required this.roots,
    required this.activeRootId,
  });

  final List<IdeExplorerProjectRoot> roots;
  final String activeRootId;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'ide-root-tabs',
      attributes: {'role': 'tablist'},
      [
        for (final root in roots)
          button(
            classes: [
              'ide-root-tab',
              if (root.id == activeRootId) 'active',
            ].toClasses,
            attributes: {
              'data-ide-root': root.id,
              'role': 'tab',
              'aria-selected': '${root.id == activeRootId}',
            },
            [.text(root.label.isEmpty ? root.id : root.label)],
          ),
        const _IdeToggleAllButton(),
      ],
    );
  }
}

/// A button that expands or collapses all folders in the active tree.
class _IdeToggleAllButton extends StatelessComponent {
  const _IdeToggleAllButton();

  @override
  Component build(BuildContext context) {
    return const button(
      classes: 'ide-toggle-all',
      type: ButtonType.button,
      attributes: {
        'data-ide-toggle-all': '',
        'title': 'Expand or collapse all folders',
        'aria-label': 'Expand or collapse all folders',
      },
      [
        MaterialIcon('unfold_more', label: 'Expand or collapse all folders'),
      ],
    );
  }
}

/// A single root file tree in the sidebar.
class _IdeTree extends StatelessComponent {
  const _IdeTree({
    required this.root,
    required this.isActive,
    required this.effectiveInstanceId,
    required this.selectedNodeDomId,
  });

  final IdeExplorerProjectRoot root;
  final bool isActive;
  final String effectiveInstanceId;
  final String? selectedNodeDomId;

  @override
  Component build(BuildContext context) {
    return div(
      classes: [
        'ide-tree',
        if (isActive) 'active',
      ].toClasses,
      attributes: {'data-ide-root': root.id},
      [
        ul([
          for (final node in root.children)
            _IdeTreeNode(
              node: node,
              instanceId: effectiveInstanceId,
              selectedDomId: selectedNodeDomId,
            ),
        ]),
      ],
    );
  }
}

/// An individual file or folder node in the directory tree.
class _IdeTreeNode extends StatelessComponent {
  const _IdeTreeNode({
    required this.node,
    required this.instanceId,
    required this.selectedDomId,
  });

  final IdeTreeNode node;
  final String instanceId;
  final String? selectedDomId;

  bool _hasSelectedChild(IdeTreeNode parent) {
    if (selectedDomId == null) return false;
    for (final child in parent.children) {
      if (_ideDomId(instanceId, child.id) == selectedDomId) return true;
      if (_hasSelectedChild(child)) return true;
    }
    return false;
  }

  @override
  Component build(BuildContext context) {
    final domId = _ideDomId(instanceId, node.id);
    final isSelected = domId == selectedDomId;
    final row = _IdeNodeRow(node: node, domId: domId, isSelected: isSelected);

    if (!node.isFolder) {
      return li(classes: 'ide-node ide-node-file', [row]);
    }

    final isOpen = !node.startsClosed || _hasSelectedChild(node);

    return li(classes: 'ide-node ide-node-folder', [
      details(
        open: isOpen,
        [
          summary(
            classes: 'ide-folder-summary',
            [
              const span(
                classes: 'ide-folder-arrow',
                attributes: {'aria-hidden': 'true'},
                [],
              ),
              row,
            ],
          ),
          ul([
            for (final child in node.children)
              _IdeTreeNode(
                node: child,
                instanceId: instanceId,
                selectedDomId: selectedDomId,
              ),
          ]),
        ],
      ),
    ]);
  }
}

/// The clickable button row for a file or folder node in the tree.
class _IdeNodeRow extends StatelessComponent {
  const _IdeNodeRow({
    required this.node,
    required this.domId,
    required this.isSelected,
  });

  final IdeTreeNode node;
  final String domId;
  final bool isSelected;

  @override
  Component build(BuildContext context) {
    final icon = node.isFolder
        ? FileIcon.folderIcon
        : FileIcon.forFile(node.label);
    final classesList = ['ide-node-row', if (isSelected) 'active'].toClasses;
    final attributesMap = {
      'data-ide-select': domId,
      if (isSelected) 'aria-current': 'true',
    };
    final childrenList = [
      icon,
      span(classes: 'ide-node-label', [.text(node.label)]),
      _IdeBadgeDot(
        badge: node.badge,
        color: node.badgeColor ?? IdeBadgeColor.neutral,
      ),
    ];

    if (node.isFolder) {
      return span(
        classes: classesList,
        attributes: attributesMap,
        childrenList,
      );
    }

    return button(
      classes: classesList,
      type: ButtonType.button,
      attributes: attributesMap,
      childrenList,
    );
  }
}

/// A colored indicator dot indicating status or category on a node row.
class _IdeBadgeDot extends StatelessComponent {
  const _IdeBadgeDot({
    required this.badge,
    this.color = IdeBadgeColor.neutral,
  });

  final String? badge;
  final IdeBadgeColor color;

  @override
  Component build(BuildContext context) {
    if (badge == null) return const Component.empty();

    return span(
      classes: [
        'ide-badge-dot',
        'ide-badge-color-${color.name}',
      ].toClasses,
      attributes: {
        'role': 'img',
        'aria-label': badge!,
        'title': badge!,
      },
      [],
    );
  }
}

// ---------------------------------------------------------------------------
// Detail Pane Components
// ---------------------------------------------------------------------------

/// The right-side container holding detail panels for all tree nodes.
class _IdeDetailPane extends StatelessComponent {
  const _IdeDetailPane({
    required this.allFlatNodes,
    required this.customContents,
    required this.effectiveInstanceId,
    required this.selectedNodeDomId,
  });

  final List<_BreadcrumbNode> allFlatNodes;
  final Map<String, Component> customContents;
  final String effectiveInstanceId;
  final String? selectedNodeDomId;

  @override
  Component build(BuildContext context) {
    return div(classes: 'ide-detail', [
      for (final flat in allFlatNodes)
        _IdeDetailPanel(
          flat: flat,
          customBody: customContents[flat.node.id],
          instanceId: effectiveInstanceId,
          isActive: flat.domId == selectedNodeDomId,
        ),
    ]);
  }
}

/// An individual documentation panel for a selected file or folder.
///
/// ```text
/// ┌──────────────────────────────────────────────────────────┐
/// │ [Path / Breadcrumbs]                                     │
/// │ [Icon] Title                           [Optional Badge]  │
/// │ Subtitle text...                                         │
/// ├──────────────────────────────────────────────────────────┤
/// │  _IdePageBody:                                           │
/// │  Custom markdown explanation and code blocks...          │
/// ├──────────────────────────────────────────────────────────┤
/// │  _IdeFolderContentsSection (if folder has children):     │
/// │  CONTENTS                                                │
/// │  [📁 lib/]           Application source code             │
/// │  [📁 test/]          Target directory for widget tests   │
/// │  [📄 pubspec.yaml]   Project manifest...                 │
/// └──────────────────────────────────────────────────────────┘
/// ```
class _IdeDetailPanel extends StatelessComponent {
  const _IdeDetailPanel({
    required this.flat,
    required this.customBody,
    required this.instanceId,
    required this.isActive,
  });

  final _BreadcrumbNode flat;
  final Component? customBody;
  final String instanceId;
  final bool isActive;

  @override
  Component build(BuildContext context) {
    final node = flat.node;

    return div(
      classes: ['ide-detail-panel', if (isActive) 'active'].toClasses,
      attributes: {'data-ide-panel': flat.domId},
      [
        if (flat.path.isNotEmpty) _IdeBreadcrumb(path: flat.path),
        _IdePageHeader(node: node),
        if (customBody != null) _IdePageBody(child: customBody!),
        if (node.isFolder && node.children.isNotEmpty)
          _IdeFolderContentsSection(
            children: node.children,
            instanceId: instanceId,
          ),
      ],
    );
  }
}

/// The breadcrumb path displayed above the detail header.
class _IdeBreadcrumb extends StatelessComponent {
  const _IdeBreadcrumb({required this.path});

  final List<String> path;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'ide-path',
      [
        for (final (i, segment) in path.indexed) ...[
          if (i > 0) const span(classes: 'ide-path-sep', [.text('/')]),
          span([.text(segment.replaceFirst(RegExp(r'/$'), ''))]),
        ],
      ],
    );
  }
}

/// The header of a detail panel showing the file/folder icon, title, badge,
/// and subtitle.
class _IdePageHeader extends StatelessComponent {
  const _IdePageHeader({required this.node});

  final IdeTreeNode node;

  @override
  Component build(BuildContext context) {
    final icon = node.isFolder
        ? FileIcon.folderIcon
        : FileIcon.forFile(node.label);

    return div(classes: 'ide-detail-header', [
      icon,
      div(classes: 'ide-detail-heading', [
        div(classes: 'ide-detail-title-row', [
          div(classes: 'ide-detail-title', [
            .text(node.title ?? node.label),
          ]),
          if (node.badge case final badge?)
            span(
              classes: [
                'ide-badge',
                'ide-badge-color-${node.badgeColor?.name ?? 'neutral'}',
              ].toClasses,
              [.text(badge)],
            ),
        ]),
        if (node.subtitle case final subtitle?)
          div(classes: 'ide-detail-subtitle', [.text(subtitle)]),
      ]),
    ]);
  }
}

/// Container for the custom markdown prose and code blocks of a page/folder.
class _IdePageBody extends StatelessComponent {
  const _IdePageBody({required this.child});

  final Component child;

  @override
  Component build(BuildContext context) {
    return div(classes: 'ide-custom-body', [child]);
  }
}

/// The automatic "Contents" section shown on folder detail panels, listing
/// clickable shortcut links to all child files and subfolders.
class _IdeFolderContentsSection extends StatelessComponent {
  const _IdeFolderContentsSection({
    required this.children,
    required this.instanceId,
  });

  final List<IdeTreeNode> children;
  final String instanceId;

  @override
  Component build(BuildContext context) {
    return div(classes: 'ide-contents', [
      const div(classes: 'ide-contents-title', [.text('Contents')]),
      div(classes: 'ide-contents-list', [
        for (final child in children)
          _IdeContentLink(child: child, instanceId: instanceId),
      ]),
    ]);
  }
}

/// A clickable link card within the folder "Contents" listing.
class _IdeContentLink extends StatelessComponent {
  const _IdeContentLink({
    required this.child,
    required this.instanceId,
  });

  final IdeTreeNode child;
  final String instanceId;

  @override
  Component build(BuildContext context) {
    final icon = child.isFolder
        ? FileIcon.folderIcon
        : FileIcon.forFile(child.label);

    return button(
      classes: 'ide-content-link',
      type: ButtonType.button,
      attributes: {
        'data-ide-select': _ideDomId(instanceId, child.id),
      },
      [
        icon,
        span(classes: 'ide-node-label', [.text(child.label)]),
        if (child.subtitle case final subtitle?)
          span(
            classes: 'ide-content-one-liner',
            [.text(subtitle)],
          ),
      ],
    );
  }
}
