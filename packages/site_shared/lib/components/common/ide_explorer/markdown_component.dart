import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../../util.dart';
import 'ide_explorer.dart';

/// A custom markdown component that parses `<IdeExplorer>` and its
/// `<IdeRoot>`, `<IdeFolder>`, and `<IdePage>` children. Defers
/// building the IDE html to the [IdeExplorer] component.
class IdeExplorerMarkdownComponent extends CustomComponent {
  const IdeExplorerMarkdownComponent() : super.base();

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
