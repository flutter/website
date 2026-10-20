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

    // Start with every original ID taken so a suffixed ID never reuses one.
    final takenIds = {for (final (_, id) in headings) id};
    final seenIds = <String>{};

    for (final (heading, id) in headings) {
      // The first heading with each ID keeps it.
      if (seenIds.add(id)) continue;

      var suffix = 1;
      while (takenIds.contains('$id-$suffix')) {
        suffix += 1;
      }

      final uniqueId = '$id-$suffix';
      takenIds.add(uniqueId);
      heading.attributes['id'] = uniqueId;
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
}
