// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/dom.dart' hide label;
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/file_icon.dart';

import '../../../util.dart';
import '../material_icon.dart';
import 'models.dart';

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
          path: root.label == null ? [] : [root.label!],
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
      if (node is IdeFolderNode) {
        result.addAll(
          _flatten(
            node.children,
            instanceId: instanceId,
            path: nodePath,
          ),
        );
      }
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

  /// The root projects or packages available in the explorer.
  final List<IdeExplorerProjectRoot> roots;

  /// The ID of the currently active project root.
  final String activeRootId;

  /// The unique instance ID for this IDE explorer.
  final String effectiveInstanceId;

  /// The DOM ID of the initially selected node, if any.
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

  /// The root projects or packages displayed as tabs.
  final List<IdeExplorerProjectRoot> roots;

  /// The ID of the currently active root tab.
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
            [.text(root.label ?? root.id)],
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

  /// The project root containing this directory tree.
  final IdeExplorerProjectRoot root;

  /// Whether this tree is currently visible and active.
  final bool isActive;

  /// The unique instance ID for this IDE explorer.
  final String effectiveInstanceId;

  /// The DOM ID of the currently selected tree node.
  final String? selectedNodeDomId;

  @override
  Component build(BuildContext context) {
    return div(
      classes: [
        'ide-tree',
        if (isActive) 'active',
      ].toClasses,
      attributes: {
        'data-ide-root': root.id,
        'aria-hidden': '${!isActive}',
      },
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

  /// The tree node model (either a file or folder).
  final IdeTreeNode node;

  /// The unique instance ID for this IDE explorer.
  final String instanceId;

  /// The DOM ID of the selected node.
  final String? selectedDomId;

  bool _hasSelectedChild(IdeFolderNode parent) {
    if (selectedDomId == null) return false;
    for (final child in parent.children) {
      if (_ideDomId(instanceId, child.id) == selectedDomId) return true;
      if (child is IdeFolderNode && _hasSelectedChild(child)) return true;
    }
    return false;
  }

  @override
  Component build(BuildContext context) {
    final domId = _ideDomId(instanceId, node.id);
    final isSelected = domId == selectedDomId;
    final row = _IdeNodeRow(node: node, domId: domId, isSelected: isSelected);

    return switch (node) {
      IdeFileNode() => li(classes: 'ide-node ide-node-file', [row]),
      final IdeFolderNode folderNode => () {
        final isOpen =
            !folderNode.startsClosed || _hasSelectedChild(folderNode);
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
                for (final child in folderNode.children)
                  _IdeTreeNode(
                    node: child,
                    instanceId: instanceId,
                    selectedDomId: selectedDomId,
                  ),
              ]),
            ],
          ),
        ]);
      }(),
    };
  }
}

/// The clickable button row for a file or folder node in the tree.
class _IdeNodeRow extends StatelessComponent {
  const _IdeNodeRow({
    required this.node,
    required this.domId,
    required this.isSelected,
  });

  /// The tree node represented by this row.
  final IdeTreeNode node;

  /// The DOM ID associated with this node.
  final String domId;

  /// Whether this node is currently selected.
  final bool isSelected;

  @override
  Component build(BuildContext context) {
    final icon = _getFileTreeIcon(node);
    final classesList = ['ide-node-row', if (isSelected) 'active'].toClasses;
    final attributesMap = {
      'data-ide-select': domId,
      if (isSelected) 'aria-current': 'true',
    };
    final childrenList = [
      icon,
      span(classes: 'ide-node-label', [.text(node.label)]),
      if (node.badge case final badge?)
        _IdeBadgeDot(
          badge: badge,
          color: node.badgeColor ?? IdeBadgeColor.neutral,
        ),
    ];

    if (node is IdeFolderNode) {
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

  /// The tooltip and accessibility label for the badge dot.
  final String badge;

  /// The color theme for the badge dot.
  final IdeBadgeColor color;

  @override
  Component build(BuildContext context) {
    return span(
      classes: [
        'ide-badge-dot',
        'ide-badge-color-${color.name}',
      ].toClasses,
      attributes: {
        'role': 'img',
        'aria-label': badge,
        'title': badge,
      },
      const [],
    );
  }
}

/// A flattened [IdeTreeNode] paired with the path of ancestor labels
/// leading to it, used to render the breadcrumb in its detail pane.
typedef _BreadcrumbNode = ({
  IdeTreeNode node,
  String domId,
  List<String> path,
});

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

  /// All flattened tree nodes with their breadcrumb path information.
  final List<_BreadcrumbNode> allFlatNodes;

  /// Map of node IDs to custom rendered markdown content components.
  final Map<String, Component> customContents;

  /// The unique instance ID for this IDE explorer.
  final String effectiveInstanceId;

  /// The DOM ID of the currently selected node.
  final String? selectedNodeDomId;

  @override
  Component build(BuildContext context) {
    return div(classes: 'ide-detail', [
      for (final flat in allFlatNodes)
        _IdeDetailPanel(
          breadcrumbNode: flat,
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
    required this.breadcrumbNode,
    required this.customBody,
    required this.instanceId,
    required this.isActive,
  });

  /// The node model along with its DOM ID and ancestor breadcrumb path.
  final _BreadcrumbNode breadcrumbNode;

  /// Optional custom component containing markdown body content.
  final Component? customBody;

  /// The unique instance ID for this IDE explorer.
  final String instanceId;

  /// Whether this detail panel is currently visible and active.
  final bool isActive;

  @override
  Component build(BuildContext context) {
    final node = breadcrumbNode.node;

    return div(
      classes: ['ide-detail-panel', if (isActive) 'active'].toClasses,
      attributes: {
        'data-ide-panel': breadcrumbNode.domId,
        'aria-hidden': '${!isActive}',
      },
      [
        if (breadcrumbNode.path.isNotEmpty)
          _IdeBreadcrumb(path: breadcrumbNode.path),
        _IdePageHeader(node: node),
        if (customBody != null) _IdePageBody(child: customBody!),
        if (node is IdeFolderNode && node.children.isNotEmpty)
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

  /// The list of ancestor directory/root labels leading to this node.
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

  /// The node represented by this detail header.
  final IdeTreeNode node;

  @override
  Component build(BuildContext context) {
    final icon = _getFileTreeIcon(node);

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

  /// The custom markdown body component to display.
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

  /// The child nodes contained within this directory.
  final List<IdeTreeNode> children;

  /// The unique instance ID for this IDE explorer.
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

  /// The child node linked by this item.
  final IdeTreeNode child;

  /// The unique instance ID for this IDE explorer.
  final String instanceId;

  @override
  Component build(BuildContext context) {
    final icon = _getFileTreeIcon(child);

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

Component _getFileTreeIcon(IdeTreeNode node) => switch (node) {
  IdeFolderNode() => FileIcon.folderIcon,
  IdeFileNode() => FileIcon.forFile(node.label),
};

/// Generates a unique DOM id for an IDE tree node.
String _ideDomId(String instanceId, String nodeId) => 'ide-$instanceId-$nodeId';
