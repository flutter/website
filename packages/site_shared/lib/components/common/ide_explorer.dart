// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/file_icon.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../util.dart';
import 'material_icon.dart';


/// A custom markdown component that parses `<IdeExplorer>` and its
/// `<IdeRoot>`, `<IdeFolder>`, and `<IdePage>` children. Defers
/// building the IDE html to the [IdeExplorer] component.
class DashIdeExplorer extends CustomComponent {
  const DashIdeExplorer() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode ||
        !(node.tag == 'IdeExplorer' || node.tag == 'DashIdeExplorer')) {
      return null;
    }

    final rootElements = node.children
        ?.whereType<ElementNode>()
        .where((n) => n.tag == 'IdeRoot')
        .toList(growable: false);

    if (rootElements == null || rootElements.isEmpty) {
      print(
        '[ERROR] <IdeExplorer> requires at least one <IdeRoot> child element.',
      );
      return const Component.empty();
    }

    final customContents = <String, Component>{};
    final roots = [
      for (final (index, rootEl) in rootElements.indexed)
        IdeExplorerProjectRoot(
          id:
              rootEl.attributes['id'] ??
              (rootEl.attributes['label'] != null
                  ? slugify(rootEl.attributes['label']!)
                  : 'root-$index'),
          label: rootEl.attributes['label'] ?? '',
          children: _parseTreeNodes(
            rootEl.children,
            builder,
            customContents,
          ),
        ),
    ];

    return IdeExplorer(
      roots: roots,
      customContents: customContents,
    );
  }

  static List<IdeTreeNode> _parseTreeNodes(
    List<Node>? nodes,
    NodesBuilder builder,
    Map<String, Component> customContents,
  ) {
    if (nodes == null || nodes.isEmpty) return const [];

    final result = <IdeTreeNode>[];

    for (final (index, child) in nodes.whereType<ElementNode>().indexed) {
      if (child.tag != 'IdeFolder' && child.tag != 'IdePage') {
        continue;
      }

      final label = child.attributes['label'] ?? '';
      final id =
          child.attributes['id'] ??
          (label.isNotEmpty ? slugify(label) : 'node-$index');
      final isDefaultPage = child.attributes['is-default-page'] == 'true';
      final startsClosed = child.attributes['starts-closed'] != null
          ? child.attributes['starts-closed'] == 'true'
          : true;

      final badge = child.attributes['badge'];
      final badgeColorStr = child.attributes['badge-color'];
      final badgeColor = badgeColorStr != null
          ? IdeBadgeColor.fromString(badgeColorStr)
          : null;

      final subtitle = child.attributes['subtitle'];

      final nestedTreeNodes = _parseTreeNodes(
        child.children,
        builder,
        customContents,
      );

      final hasBody =
          child.children?.any((n) {
            if (n is ElementNode &&
                (n.tag == 'IdeFolder' || n.tag == 'IdePage')) {
              return false;
            }
            if (n is TextNode && n.text.trim().isEmpty) {
              return false;
            }
            return true;
          }) ??
          false;

      if (hasBody) {
        final contentNodes = child.children!
            .where((n) {
              if (n is ElementNode &&
                  (n.tag == 'IdeFolder' || n.tag == 'IdePage')) {
                return false;
              }
              return true;
            })
            .toList(growable: false);

        if (contentNodes.isNotEmpty) {
          customContents[id] = builder.build(contentNodes);
        }
      }

      result.add(
        IdeTreeNode(
          id: id,
          label: label,
          isDefaultPage: isDefaultPage,
          startsClosed: startsClosed,
          badge: badge,
          badgeColor: badgeColor,
          subtitle: subtitle,
          children: nestedTreeNodes,
        ),
      );
    }

    return result;
  }
}

/// A single top-level file tree shown by an [IdeExplorer], which may
/// have multiple roots to represent multiple packages
/// (e.g. "Project" and "Shared")
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

  String _domId(String effectiveInstanceId, String nodeId) =>
      'ide-$effectiveInstanceId-$nodeId';

  @override
  Component build(BuildContext context) {
    if (roots.isEmpty) {
      return const Component.empty();
    }

    final effectiveInstanceId = instanceId ?? '${_nextInstanceId++}';

    final flatNodesByRoot = {
      for (final root in roots)
        root.id: _flatten(
          root.children,
          instanceId: effectiveInstanceId,
          path: root.label.isEmpty ? [] : [root.label],
        ),
    };

    final allFlatNodes = flatNodesByRoot.values
        .expand((nodes) => nodes)
        .toList(growable: false);

    final defaultFlatNode = allFlatNodes.firstWhereOrNull(
      (flat) => flat.node.isDefaultPage,
    );

    final activeRootId = defaultFlatNode != null
        ? (roots
                  .firstWhereOrNull(
                    (r) =>
                        flatNodesByRoot[r.id]?.any(
                          (n) => n.domId == defaultFlatNode.domId,
                        ) ??
                        false,
                  )
                  ?.id ??
              roots.first.id)
        : roots.first.id;

    final selectedNodeDomId =
        defaultFlatNode?.domId ??
        flatNodesByRoot[activeRootId]?.firstOrNull?.domId;

    return div(classes: 'ide-explorer not-content', [
      div(classes: 'ide-sidebar', [
        if (roots.length > 1)
          _buildRootTabs(activeRootId: activeRootId)
        else
          div(classes: 'ide-root-tabs ide-root-tabs-single', [
            _buildToggleAllButton(),
          ]),
        for (final root in roots)
          _buildTree(
            root,
            activeRootId: activeRootId,
            effectiveInstanceId: effectiveInstanceId,
            selectedNodeDomId: selectedNodeDomId,
          ),
      ]),
      div(classes: 'ide-detail', [
        for (final flat in allFlatNodes)
          _buildDetailPanel(
            flat,
            instanceId: effectiveInstanceId,
            isActive: flat.domId == selectedNodeDomId,
          ),
      ]),
    ]);
  }

  Component _buildRootTabs({required String activeRootId}) {
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
        _buildToggleAllButton(),
      ],
    );
  }

  Component _buildTree(
    IdeExplorerProjectRoot root, {
    required String activeRootId,
    required String effectiveInstanceId,
    required String? selectedNodeDomId,
  }) {
    return div(
      classes: [
        'ide-tree',
        if (root.id == activeRootId) 'active',
      ].toClasses,
      attributes: {'data-ide-root': root.id},
      [
        ul([
          for (final node in root.children)
            _buildTreeNode(
              node,
              instanceId: effectiveInstanceId,
              selectedDomId: selectedNodeDomId,
            ),
        ]),
      ],
    );
  }

  Component _buildToggleAllButton() {
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
        domId: _domId(instanceId, node.id),
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

  bool _hasSelectedChild(
    IdeTreeNode node,
    String instanceId,
    String? selectedDomId,
  ) {
    if (selectedDomId == null) return false;
    for (final child in node.children) {
      if (_domId(instanceId, child.id) == selectedDomId) return true;
      if (_hasSelectedChild(child, instanceId, selectedDomId)) return true;
    }
    return false;
  }

  Component _buildTreeNode(
    IdeTreeNode node, {
    required String instanceId,
    required String? selectedDomId,
  }) {
    final domId = _domId(instanceId, node.id);
    final isSelected = domId == selectedDomId;
    final row = _buildNodeRow(node, domId: domId, isSelected: isSelected);

    if (!node.isFolder) {
      return li(classes: 'ide-node ide-node-file', [row]);
    }

    final isOpen =
        !node.startsClosed ||
        _hasSelectedChild(node, instanceId, selectedDomId);

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
              _buildTreeNode(
                child,
                instanceId: instanceId,
                selectedDomId: selectedDomId,
              ),
          ]),
        ],
      ),
    ]);
  }

  Component _buildNodeRow(
    IdeTreeNode node, {
    required String domId,
    required bool isSelected,
  }) {
    final icon = node.isFolder
        ? FileIcon.folderIcon
        : FileIcon.forFile(node.label);

    return button(
      classes: ['ide-node-row', if (isSelected) 'active'].toClasses,
      type: ButtonType.button,
      attributes: {
        'data-ide-select': domId,
        if (isSelected) 'aria-current': 'true',
      },
      [
        icon,
        span(classes: 'ide-node-label', [.text(node.label)]),
        _buildBadgeDot(
          node.badge,
          node.badgeColor ?? IdeBadgeColor.neutral,
        ),
      ],
    );
  }

  Component _buildBadgeDot(
    String? badge, [
    IdeBadgeColor color = IdeBadgeColor.neutral,
  ]) {
    if (badge == null) return const Component.empty();
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
      [],
    );
  }

  Component _buildDetailPanel(
    _BreadcrumbNode flat, {
    required String instanceId,
    required bool isActive,
  }) {
    final node = flat.node;

    return div(
      classes: ['ide-detail-panel', if (isActive) 'active'].toClasses,
      attributes: {'data-ide-panel': flat.domId},
      [
        if (flat.path.isNotEmpty)
          div(
            classes: 'ide-path',
            [
              for (final (i, segment) in flat.path.indexed) ...[
                if (i > 0) const span(classes: 'ide-path-sep', [.text('/')]),
                span([.text(segment.replaceFirst(RegExp(r'/$'), ''))]),
              ],
            ],
          ),
        div(classes: 'ide-detail-header', [
          node.isFolder ? FileIcon.folderIcon : FileIcon.forFile(node.label),
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
        ]),

        if (customContents[node.id] case final customChild?)
          div(classes: 'ide-custom-body', [customChild]),

        if (node.children.isNotEmpty)
          div(classes: 'ide-contents', [
            const div(classes: 'ide-contents-title', [.text('Contents')]),
            div(classes: 'ide-contents-list', [
              for (final child in node.children)
                button(
                  classes: 'ide-content-link',
                  type: ButtonType.button,
                  attributes: {
                    'data-ide-select': _domId(instanceId, child.id),
                  },
                  [
                    child.isFolder
                        ? FileIcon.folderIcon
                        : FileIcon.forFile(child.label),
                    span(classes: 'ide-node-label', [.text(child.label)]),
                    if (child.subtitle case final subtitle?)
                      span(
                        classes: 'ide-content-one-liner',
                        [.text(subtitle)],
                      ),
                  ],
                ),
            ]),
          ]),
      ],
    );
  }
}


