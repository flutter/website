// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// An extension that wraps `h2` through `h5` headings and
/// adds permalink anchors.
///
/// Heading IDs must already be unique.
final class HeaderWrapperExtension implements PageExtension {
  const HeaderWrapperExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async =>
      _processNodes(nodes);

  List<Node> _processNodes(List<Node> nodes) => [
    for (final node in nodes) _processNode(node),
  ];

  Node _processNode(Node node) {
    if (node is! ElementNode) return node;

    final tagName = node.tag.toLowerCase();
    if (!const {'h2', 'h3', 'h4', 'h5'}.contains(tagName)) {
      // If it's not any of the supported heading levels,
      // recurse into its children.
      final nodeChildren = node.children;
      return ElementNode(
        node.tag,
        node.attributes,
        nodeChildren != null ? _processNodes(nodeChildren) : null,
      );
    }

    final headerId = node.attributes['id'];
    if (headerId == null) return node;

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
