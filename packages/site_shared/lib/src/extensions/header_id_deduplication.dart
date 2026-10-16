// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// An extension that makes existing IDs unique among
/// `h2` through `h5` headings.
///
/// Appends numeric suffixes to repeated IDs,
/// leaving headings without IDs alone.
/// Apply this after heading attributes are resolved and
/// before extensions that extract heading IDs or generate heading links.
final class HeaderIdDeduplicationExtension implements PageExtension {
  const HeaderIdDeduplicationExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    _processNodes(nodes, <String>{});
    return nodes;
  }

  void _processNodes(List<Node> nodes, Set<String> usedIds) {
    for (final node in nodes) {
      if (node is! ElementNode) continue;

      final tagName = node.tag.toLowerCase();
      if (const {'h2', 'h3', 'h4', 'h5'}.contains(tagName)) {
        if (node.attributes['id'] case final rawHeaderId?) {
          var headerId = rawHeaderId;
          for (var i = 1; usedIds.contains(headerId); i += 1) {
            headerId = '$rawHeaderId-$i';
          }
          usedIds.add(headerId);
          node.attributes['id'] = headerId;
        }
      } else if (node.children case final children?) {
        _processNodes(children, usedIds);
      }
    }
  }
}
