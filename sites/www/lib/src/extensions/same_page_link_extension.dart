// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// Keeps fragment links on their content page despite the site's base URL.
final class SamePageLinkExtension implements PageExtension {
  const SamePageLinkExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async =>
      _processNodes(page.url, nodes);

  List<Node> _processNodes(String url, List<Node> nodes) => [
    for (final node in nodes)
      if (node is ElementNode)
        ElementNode(
          node.tag,
          {
            ...node.attributes,
            // With `<base href="/">` links to fragments
            // need the page URL to stay on the page.
            if (node.attributes['href'] case final href?
                when node.tag == 'a' && href.startsWith('#'))
              'href': '$url$href',
          },
          node.children == null ? null : _processNodes(url, node.children!),
        )
      else
        node,
  ];
}
