import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../../util.dart';
import 'ide_explorer.dart';
import 'models.dart';

/// A custom markdown component that parses `<IdeExplorer>` and
/// its `<IdeProjectRoot>`, `<IdeFolder>`, and `<IdePage>` children.
/// Defers building the IDE html to the [IdeExplorer] component.
class IdeExplorerMarkdownComponent extends CustomComponent {
  const IdeExplorerMarkdownComponent() : super.base();

  // Tag name constants:
  static const String _tagIdeExplorer = 'IdeExplorer';
  static const String _tagIdeProjectRoot = 'IdeProjectRoot';
  static const String _tagIdeFolder = 'IdeFolder';
  static const String _tagIdePage = 'IdePage';

  // Attribute name constants:
  static const String _attrId = 'id';
  static const String _attrLabel = 'label';
  static const String _attrIsDefaultPage = 'is-default-page';
  static const String _attrStartsClosed = 'starts-closed';
  static const String _attrBadge = 'badge';
  static const String _attrBadgeColor = 'badge-color';
  static const String _attrSubtitle = 'subtitle';

  // Default values:
  static const String _defaultRootPrefix = 'root';
  static const String _defaultNodePrefix = 'node';

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode || node.tag != _tagIdeExplorer) {
      return null;
    }

    final projectRootElements = node.children
        ?.whereType<ElementNode>()
        .where((n) => n.tag == _tagIdeProjectRoot)
        .toList();

    if (projectRootElements == null || projectRootElements.isEmpty) {
      print(
        '[ERROR] <$_tagIdeExplorer> requires at '
        'least one <$_tagIdeProjectRoot> child element.',
      );
      return const Component.empty();
    }

    final customContents = <String, Component>{};
    final roots = <IdeExplorerProjectRoot>[];
    for (final (index, rootEl) in projectRootElements.indexed) {
      final rootId = _generateNodeId(
        rootEl.attributes,
        _defaultRootPrefix,
        index,
      );
      roots.add(
        IdeExplorerProjectRoot(
          id: rootId,
          label: rootEl.attributes[_attrLabel],
          children: _parseTreeNodes(
            rootEl.children,
            builder,
            customContents,
            rootId,
          ),
        ),
      );
    }

    return IdeExplorer(
      roots: roots,
      customContents: customContents,
    );
  }

  /// Generates a node ID from attributes or creates a default one.
  String _generateNodeId(
    Map<String, String> attributes,
    String prefix,
    int index, [
    String? parentId,
  ]) {
    if (attributes[_attrId] case final String idAttribute) {
      return idAttribute;
    }
    final label = attributes[_attrLabel];
    final localId = (label != null && label.isNotEmpty)
        ? slugify(label)
        : '$prefix-$index';
    return parentId != null ? '$parentId-$localId' : localId;
  }

  List<IdeTreeNode> _parseTreeNodes(
    List<Node>? nodes,
    NodesBuilder builder,
    Map<String, Component> customContents,
    String parentId,
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
        parentId,
      );

      result.add(treeNode);
    }

    return result;
  }

  /// Builds a single [IdeTreeNode] from an [ElementNode].
  IdeTreeNode _buildTreeNodeFromElement(
    ElementNode element,
    int index,
    NodesBuilder builder,
    Map<String, Component> customContents,
    String parentId,
  ) {
    final attributes = element.attributes;
    final label = attributes[_attrLabel] ?? '';
    final id = _generateNodeId(attributes, _defaultNodePrefix, index, parentId);

    // Parse boolean attributes
    final isDefaultPage = _getBoolAttribute(
      attributes,
      _attrIsDefaultPage,
      defaultValue: false,
    );

    // Parse badge attributes
    final badge = attributes[_attrBadge];
    final badgeColor = attributes[_attrBadgeColor] != null
        ? IdeBadgeColor.fromString(attributes[_attrBadgeColor])
        : null;

    final subtitle = attributes[_attrSubtitle];

    _storeCustomContentIfPresent(
      element.children,
      id,
      builder,
      customContents,
    );

    if (element.tag == _tagIdeFolder) {
      final startsClosed = _getBoolAttribute(
        attributes,
        _attrStartsClosed,
        defaultValue: true,
      );

      // Recursively parse children
      final nestedTreeNodes = _parseTreeNodes(
        element.children,
        builder,
        customContents,
        id,
      );

      return IdeFolderNode(
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

    return IdeFileNode(
      id: id,
      label: label,
      isDefaultPage: isDefaultPage,
      badge: badge,
      badgeColor: badgeColor,
      subtitle: subtitle,
    );
  }

  /// Parses a boolean attribute value, returning [defaultValue] if not present.
  bool _parseBoolAttribute(
    Map<String, String> attributes,
    String key, {
    required bool defaultValue,
  }) {
    final value = attributes[key];
    return value != null ? value == 'true' : defaultValue;
  }

  /// Checks if a node represents body content (not a folder/page structure).
  bool _isBodyContent(Node node) {
    if (node is ElementNode &&
        (node.tag == _tagIdeFolder || node.tag == _tagIdePage)) {
      return false;
    }
    if (node is TextNode && node.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  /// Extracts non-structural content nodes from children.
  List<Node> _extractContentNodes(List<Node> children) {
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

  /// Stores custom body content for a node if it exists.
  void _storeCustomContentIfPresent(
    List<Node>? children,
    String nodeId,
    NodesBuilder builder,
    Map<String, Component> customContents,
  ) {
    if (children == null || !_hasCustomBodyContent(children)) {
      return;
    }

    final contentNodes = _extractContentNodes(children);
    if (contentNodes.isNotEmpty) {
      customContents[nodeId] = builder.build(contentNodes);
    }
  }

  /// Checks if a list of nodes has custom body content.
  bool _hasCustomBodyContent(List<Node> children) {
    return children.any(_isBodyContent);
  }
}
