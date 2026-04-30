// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// A node-processing, page extension for Jaspr Content that
/// wraps each `h1` -> `h5` element in a div with the `header-wrapper` class
/// and adds an anchor that can clicked and linked to.
final class HeaderWrapperExtension implements PageExtension {
  const HeaderWrapperExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    final usedIds = <String>{};
    return _processNodes(nodes, usedIds);
  }

  List<Node> _processNodes(List<Node> nodes, Set<String> usedIds) {
    return [for (final node in nodes) _processNode(node, usedIds)];
  }

  Node _processNode(Node node, Set<String> usedIds) {
    if (node is! ElementNode) return node;

    final tagName = node.tag.toLowerCase();
    if (!const {'h2', 'h3', 'h4', 'h5'}.contains(tagName)) {
      // If it's not any of the supported heading levels,
      // recurse into its children.
      final nodeChildren = node.children;
      return ElementNode(
        node.tag,
        node.attributes,
        nodeChildren != null ? _processNodes(nodeChildren, usedIds) : null,
      );
    }

    final rawHeaderId = node.attributes['id'];
    if (rawHeaderId == null) return node;

    // Account for headers with the same base id,
    // appending a dash and an integer until the header has a unique id.
    var headerId = rawHeaderId;
    for (var i = 1; usedIds.contains(headerId); i += 1) {
      headerId = '$rawHeaderId-$i';
    }
    usedIds.add(headerId);

    // Update header ID to be the unique one as well.
    node.attributes['id'] = headerId;

    final headerText = node.innerText;

    return ElementNode(
      'div',
      {'class': 'header-wrapper'},
      [
        node,
        ElementNode(
          'a',
          {
            'class': 'heading-link',
            'href': '#$headerId',
            'aria-label': "Link to '$headerText' section",
          },
          const [TextNode('#')],
        ),
      ],
    );
  }
}
