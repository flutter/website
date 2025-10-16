// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

import '../markdown/attribute_syntax.dart';

/// A node-processing, page extension for Jaspr Content that looks for
/// attribute markers from [AttributeBlockSyntax] and [AttributeInlineSyntax],
/// to remove them and transfer their configured attributes.
class AttributeProcessor implements PageExtension {
  const AttributeProcessor();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    return _processNodes(nodes);
  }

  List<Node> _processNodes(List<Node> nodes) {
    final processedNodes = <Node>[];

    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];

      if (node is ElementNode && node.tag == 'attribute-marker') {
        // Found an attribute marker,
        // apply its attributes to the previous element.
        if (i > 0 && processedNodes.isNotEmpty) {
          final previousIndex = processedNodes.length - 1;
          final previousNode = processedNodes[previousIndex];
          if (previousNode is ElementNode) {
            processedNodes[previousIndex] = _applyAttributesToElement(
              previousNode,
              node.attributes,
            );
          }
        }
        // Skip adding this marker to processed nodes (effectively removing it).
        continue;
      } else if (node is ElementNode) {
        final nodeChildren = node.children;
        final processedChildren = nodeChildren != null
            ? _processNodes(nodeChildren)
            : null;
        processedNodes.add(
          ElementNode(node.tag, node.attributes, processedChildren),
        );
      } else {
        processedNodes.add(node);
      }
    }

    return processedNodes;
  }

  ElementNode _applyAttributesToElement(
    ElementNode element,
    Map<String, String> attributes,
  ) {
    final newAttributes = Map<String, String>.of(element.attributes);

    for (final entry in attributes.entries) {
      if (entry.key == 'class') {
        final existingClass = newAttributes['class'];
        if (existingClass != null && existingClass.isNotEmpty) {
          newAttributes['class'] = '$existingClass ${entry.value}';
        } else {
          newAttributes['class'] = entry.value;
        }
      } else {
        // For other attributes (such as id),
        // set them directly.
        newAttributes[entry.key] = entry.value;
      }
    }

    return ElementNode(element.tag, newAttributes, element.children);
  }
}
