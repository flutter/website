// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// A node-processing, page extension for Jaspr Content that
/// wraps each `<table>` element in a div with the `table-wrapper` class to
/// enable improved styling and horizontal scrolling.
final class TableWrapperExtension implements PageExtension {
  const TableWrapperExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    return _processNodes(nodes, isRoot: true);
  }

  List<Node> _processNodes(List<Node> nodes, {bool isRoot = false}) {
    final processedNodes = <Node>[];

    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];

      if (node is ElementNode && node.tag.toLowerCase() == 'table') {
        // Check if the previous node was a div with table-wrapper class
        // (only check at root level to avoid issues with nested structures).
        if (isRoot && i > 0) {
          final prevNode = processedNodes.last;
          if (prevNode is ElementNode &&
              prevNode.tag.toLowerCase() == 'div' &&
              (prevNode.attributes['class'] ?? '').contains('table-wrapper')) {
            // This table is already wrapped, skip wrapping.
            processedNodes.add(_processNode(node));
            continue;
          }
        }

        // Wrap the table.
        processedNodes.add(
          ElementNode('div', {'class': 'table-wrapper'}, [node]),
        );
      } else {
        processedNodes.add(_processNode(node));
      }
    }

    return processedNodes;
  }

  Node _processNode(Node node) {
    if (node is! ElementNode) return node;

    final tagName = node.tag.toLowerCase();

    // Don't process table elements here as they're handled in _processNodes.
    if (tagName == 'table') return node;

    // Check if this is already a table-wrapper div.
    if (tagName == 'div' &&
        (node.attributes['class'] ?? '').contains('table-wrapper')) {
      // Don't recurse into table-wrapper divs to avoid double wrapping.
      return node;
    }

    // Recurse into children for other elements.
    final nodeChildren = node.children;
    return ElementNode(
      node.tag,
      node.attributes,
      nodeChildren != null ? _processNodes(nodeChildren) : null,
    );
  }
}
