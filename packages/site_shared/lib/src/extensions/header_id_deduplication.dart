// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// An extension that makes existing IDs unique among
/// `h1` through `h6` headings.
///
/// Appends numeric suffixes to repeated IDs,
/// leaving headings without IDs alone.
/// A suffixed ID never takes the original ID of another heading,
/// so a later "Step 1" heading keeps `step-1` even if
/// two earlier "Step" headings share `step`.
///
/// Apply this after heading attributes are resolved and
/// before extensions that extract heading IDs or generate heading links.
final class HeaderIdDeduplicationExtension implements PageExtension {
  const HeaderIdDeduplicationExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    final headings = [
      for (final heading in _findHeadings(nodes))
        if (heading.attributes['id'] case final id?) (heading, id),
    ];

    final originalIds = {for (final (_, id) in headings) id};
    final usedIds = <String>{};

    for (final (heading, originalId) in headings) {
      final headerId = _uniqueId(originalId, usedIds, originalIds);
      usedIds.add(headerId);
      if (headerId != originalId) {
        heading.attributes['id'] = headerId;
      }
    }

    return nodes;
  }

  /// Finds all `h1` through `h6` elements in [nodes], in document order.
  static List<ElementNode> _findHeadings(List<Node> nodes) {
    const headingTags = {'h1', 'h2', 'h3', 'h4', 'h5', 'h6'};

    return [
      for (final node in nodes)
        if (node is ElementNode)
          if (headingTags.contains(node.tag.toLowerCase()))
            node
          else if (node.children case final children?)
            ..._findHeadings(children),
    ];
  }

  /// Returns [originalId] if no earlier heading uses it, otherwise
  /// the first suffixed form that's neither used nor
  /// the original ID of another heading.
  static String _uniqueId(
    String originalId,
    Set<String> usedIds,
    Set<String> originalIds,
  ) {
    if (!usedIds.contains(originalId)) return originalId;

    for (var i = 1; ; i += 1) {
      final candidate = '$originalId-$i';
      if (!usedIds.contains(candidate) && !originalIds.contains(candidate)) {
        return candidate;
      }
    }
  }
}
