// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

import '../../components/common/client/mermaid_diagram.dart';

final class MermaidProcessor implements PageExtension {
  const MermaidProcessor();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async =>
      _processNodes(nodes);

  List<Node> _processNodes(List<Node> nodes) {
    return [
      for (final node in nodes)
        if (node case ElementNode(
          tag: 'div',
          attributes: {'class': 'mermaid-container'},
          children: [
            ElementNode(attributes: {'data-source': final diagram}),
            ...,
          ],
        ))
          ComponentNode(MermaidViewer(diagram: diagram))
        else if (node is ElementNode)
          ElementNode(
            node.tag,
            node.attributes,
            node.children != null ? _processNodes(node.children!) : null,
          )
        else
          node,
    ];
  }
}
