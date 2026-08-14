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

  // Tag name constants
  static const String _tagIdeExplorer = 'IdeExplorer';
  static const String _tagDashIdeExplorer = 'DashIdeExplorer';
  static const String _tagIdeRoot = 'IdeRoot';
  static const String _tagIdeFolder = 'IdeFolder';
  static const String _tagIdePage = 'IdePage';

  // Attribute name constants
  static const String _attrId = 'id';
  static const String _attrLabel = 'label';
  static const String _attrIsDefaultPage = 'is-default-page';
  static const String _attrStartsClosed = 'starts-closed';
  static const String _attrBadge = 'badge';
  static const String _attrBadgeColor = 'badge-color';
  static const String _attrSubtitle = 'subtitle';

  // Default values
  static const String _defaultRootPrefix = 'root';
  static const String _defaultNodePrefix = 'node';
  static const String _defaultTrue = 'true';

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode ||
        !(node.tag == _tagIdeExplorer || node.tag == _tagDashIdeExplorer)) {
      return null;
    }

    final rootElements = node.children
        ?.whereType<ElementNode>()
        .where((n) => n.tag == _tagIdeRoot)
        .toList(growable: false);

    if (rootElements == null || rootElements.isEmpty) {
      print(
        '[ERROR] <$_tagIdeExplorer> requires at least one <$_tagIdeRoot> child element.',
      );
      return const Component.empty();
    }

    final customContents = <String, Component>{};
    final roots = [
      for (final (index, rootEl) in rootElements.indexed)
        IdeExplorerProjectRoot(
          id: _generateNodeId(
            rootEl.attributes,
            _defaultRootPrefix,
            index,
          ),
          label: rootEl.attributes[_attrLabel] ?? '',
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

  /// Generates a node ID from attributes or creates a default one.
  static String _generateNodeId(
    Map<String, String> attributes,
    String prefix,
    int index,
  ) {
    if (attributes[_attrId] != null) {
      return attributes[_attrId]!;
    }
    final label = attributes[_attrLabel];
    if (label != null && label.isNotEmpty) {
      return slugify(label);
    }
    return '$prefix-$index';
  }

  /// Parses a boolean attribute value, returning [defaultValue] if not present.
  static bool _getBoolAttribute(
    Map<String, String> attributes,
    String key, {
    required bool defaultValue,
  }) {
    final value = attributes[key];
    return value != null ? value == _defaultTrue : defaultValue;
  }

  /// Checks if a node represents body content (not a folder/page structure).
  static bool _isBodyContent(Node node) {
    if (node is ElementNode &&
        (node.tag == _tagIdeFolder || node.tag == _tagIdePage)) {
      return false;
    }
    if (node is TextNode && node.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  /// Checks if a node has custom body content.
  static bool _hasCustomBodyContent(List<Node>? children) {
    return children?.any(_isBodyContent) ?? false;
  }

  /// Extracts non-structural content nodes from children.
  static List<Node> _extractContentNodes(List<Node> children) {
    return children
        .where((n) {
          if (n is ElementNode &&
              (n.tag == _tagIdeFolder || n.tag == _tagIdePage)) {
            return false;
          }
          return true;
        })
        .toList(growable: false);
  }

  static List<IdeTreeNode> _parseTreeNodes(
    List<Node>? nodes,
    NodesBuilder builder,
    Map<String, Component> customContents,
  ) {
    if (nodes == null || nodes.isEmpty) return const [];

    final result = <IdeTreeNode>[];

    for (final (index, child) in nodes.whereType<ElementNode>().indexed) {
      if (child.tag != _tagIdeFolder && child.tag != _tagIdePage) {
        continue;
      }

      final treeNode = _buildTreeNodeFromElement(
        child,
        index,
        builder,
        customContents,
      );

      result.add(treeNode);
    }

    return result;
  }

  /// Builds a single [IdeTreeNode] from an [ElementNode].
  static IdeTreeNode _buildTreeNodeFromElement(
    ElementNode element,
    int index,
    NodesBuilder builder,
    Map<String, Component> customContents,
  ) {
    final attributes = element.attributes;
    final label = attributes[_attrLabel] ?? '';
    final id = _generateNodeId(attributes, _defaultNodePrefix, index);

    // Parse boolean attributes
    final isDefaultPage = _getBoolAttribute(
      attributes,
      _attrIsDefaultPage,
      defaultValue: false,
    );
    final startsClosed = _getBoolAttribute(
      attributes,
      _attrStartsClosed,
      defaultValue: true,
    );

    // Parse badge attributes
    final badge = attributes[_attrBadge];
    final badgeColor = attributes[_attrBadgeColor] != null
        ? IdeBadgeColor.fromString(attributes[_attrBadgeColor])
        : null;

    final subtitle = attributes[_attrSubtitle];

    // Recursively parse children
    final nestedTreeNodes = _parseTreeNodes(
      element.children,
      builder,
      customContents,
    );

    // Extract and store custom body content if present
    _storeCustomContentIfPresent(
      element.children,
      id,
      builder,
      customContents,
    );

    return IdeTreeNode(
      id: id,
      label: label,
      isDefaultPage: isDefaultPage,
      startsClosed: startsClosed,
      badge: badge,
      badgeColor: badgeColor,
      subtitle: subtitle,
      children: nestedTreeNodes,
    );
  }

  /// Stores custom body content for a node if it exists.
  static void _storeCustomContentIfPresent(
    List<Node>? children,
    String nodeId,
    NodesBuilder builder,
    Map<String, Component> customContents,
  ) {
    if (!_hasCustomBodyContent(children)) {
      return;
    }

    final contentNodes = _extractContentNodes(children!);
    if (contentNodes.isNotEmpty) {
      customContents[nodeId] = builder.build(contentNodes);
    }
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

  // CSS class constants
  static const String _cssIdeExplorer = 'ide-explorer';
  static const String _cssNotContent = 'not-content';
  static const String _cssIdeSidebar = 'ide-sidebar';
  static const String _cssIdeDetail = 'ide-detail';
  static const String _cssIdeDetailPanel = 'ide-detail-panel';
  static const String _cssActive = 'active';
  static const String _cssIdePath = 'ide-path';
  static const String _cssIdePathSep = 'ide-path-sep';
  static const String _cssIdeDetailHeader = 'ide-detail-header';
  static const String _cssIdeDetailHeading = 'ide-detail-heading';
  static const String _cssIdeDetailTitleRow = 'ide-detail-title-row';
  static const String _cssIdeDetailTitle = 'ide-detail-title';
  static const String _cssIdeDetailSubtitle = 'ide-detail-subtitle';
  static const String _cssIdeBadge = 'ide-badge';
  static const String _cssIdeCustomBody = 'ide-custom-body';
  static const String _cssIdeContents = 'ide-contents';
  static const String _cssIdeContentsTitle = 'ide-contents-title';
  static const String _cssIdeContentsList = 'ide-contents-list';
  static const String _cssIdeContentLink = 'ide-content-link';
  static const String _cssIdeNodeLabel = 'ide-node-label';
  static const String _cssIdeContentOneLiner = 'ide-content-one-liner';

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

    return div(classes: '$_cssIdeExplorer $_cssNotContent', [
      _buildSidebar(
        activeRootId: activeRootId,
        effectiveInstanceId: effectiveInstanceId,
        selectedNodeDomId: selectedNodeDomId,
      ),
      _buildDetailPane(
        allFlatNodes: allFlatNodes,
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

    // Find which root contains the default node
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

  /// Builds the sidebar containing the file tree.
  Component _buildSidebar({
    required String activeRootId,
    required String effectiveInstanceId,
    required String? selectedNodeDomId,
  }) {
    return div(classes: _cssIdeSidebar, [
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
    ]);
  }

  /// Builds the detail pane showing node content.
  Component _buildDetailPane({
    required List<_BreadcrumbNode> allFlatNodes,
    required String effectiveInstanceId,
    required String? selectedNodeDomId,
  }) {
    return div(classes: _cssIdeDetail, [
      for (final flat in allFlatNodes)
        _buildDetailPanel(
          flat,
          instanceId: effectiveInstanceId,
          isActive: flat.domId == selectedNodeDomId,
        ),
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
      classes: [_cssIdeDetailPanel, if (isActive) _cssActive].toClasses,
      attributes: {'data-ide-panel': flat.domId},
      [
        if (flat.path.isNotEmpty) _buildBreadcrumb(flat.path),
        _buildDetailPanelHeader(node),
        if (customContents[node.id] case final customChild?)
          _buildCustomBody(customChild),
        if (node.children.isNotEmpty)
          _buildContentsSection(node.children, instanceId),
      ],
    );
  }

  /// Builds the breadcrumb path display.
  Component _buildBreadcrumb(List<String> path) {
    return div(
      classes: _cssIdePath,
      [
        for (final (i, segment) in path.indexed) ...[
          if (i > 0) const span(classes: _cssIdePathSep, [.text('/')]),
          span([.text(segment.replaceFirst(RegExp(r'/$'), ''))]),
        ],
      ],
    );
  }

  /// Builds the detail panel header with icon, title, and badge.
  Component _buildDetailPanelHeader(IdeTreeNode node) {
    return div(classes: _cssIdeDetailHeader, [
      node.isFolder ? FileIcon.folderIcon : FileIcon.forFile(node.label),
      div(classes: _cssIdeDetailHeading, [
        _buildTitleRow(node),
        if (node.subtitle case final subtitle?)
          div(classes: _cssIdeDetailSubtitle, [.text(subtitle)]),
      ]),
    ]);
  }

  /// Builds the title row with title text and optional badge.
  Component _buildTitleRow(IdeTreeNode node) {
    return div(classes: _cssIdeDetailTitleRow, [
      div(classes: _cssIdeDetailTitle, [
        .text(node.title ?? node.label),
      ]),
      if (node.badge case final badge?) _buildBadge(node, badge),
    ]);
  }

  /// Builds a badge component.
  Component _buildBadge(IdeTreeNode node, String badge) {
    return span(
      classes: [
        _cssIdeBadge,
        'ide-badge-color-${node.badgeColor?.name ?? 'neutral'}',
      ].toClasses,
      [
        .text(badge),
      ],
    );
  }

  /// Builds the custom body content wrapper.
  Component _buildCustomBody(Component customChild) {
    return div(classes: _cssIdeCustomBody, [customChild]);
  }

  /// Builds the contents section listing child nodes.
  Component _buildContentsSection(
    List<IdeTreeNode> children,
    String instanceId,
  ) {
    return div(classes: _cssIdeContents, [
      const div(classes: _cssIdeContentsTitle, [.text('Contents')]),
      div(classes: _cssIdeContentsList, [
        for (final child in children) _buildContentLink(child, instanceId),
      ]),
    ]);
  }

  /// Builds a single content link for a child node.
  Component _buildContentLink(IdeTreeNode child, String instanceId) {
    return button(
      classes: _cssIdeContentLink,
      type: ButtonType.button,
      attributes: {
        'data-ide-select': _domId(instanceId, child.id),
      },
      [
        child.isFolder ? FileIcon.folderIcon : FileIcon.forFile(child.label),
        span(classes: _cssIdeNodeLabel, [.text(child.label)]),
        if (child.subtitle case final subtitle?)
          span(
            classes: _cssIdeContentOneLiner,
            [.text(subtitle)],
          ),
      ],
    );
  }
}
