// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

import '../components/common/client/api_link_tooltip.dart';

/// A node-processing, page extension for Jaspr Content that looks for links to
/// the flutter API docs and enhances them with interactive tooltips.
class ApiLinkProcessor implements PageExtension {
  const ApiLinkProcessor();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    return _processNodes(nodes);
  }

  List<Node> _processNodes(List<Node> nodes) {
    final processedNodes = <Node>[];

    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];

      if (node case ElementNode(
        tag: 'a',
        attributes: {'href': final href},
      ) when href.startsWith('https://api.flutter.dev/')) {
        if (node.children case [
          ElementNode(tag: 'code', children: [TextNode(:final text)]),
        ]) {
          // Only enable the tooltip for links that contain a code element.
          processedNodes.add(
            ComponentNode(ApiLinkTooltip(url: href, text: text)),
          );
          continue;
        } else {
          processedNodes.add(node);
        }
      } else if (node is ElementNode && node.children != null) {
        processedNodes.add(
          ElementNode(node.tag, node.attributes, _processNodes(node.children!)),
        );
      } else {
        processedNodes.add(node);
      }
    }

    return processedNodes;
  }
}
