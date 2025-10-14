// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';
import 'package:meta/meta.dart';

final class HeaderExtractorExtension implements PageExtension {
  const HeaderExtractorExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    page.apply(data: {'contentHeaders': _extractHeaders(nodes)});

    return nodes;
  }

  List<ContentHeader> _extractHeaders(List<Node> nodes) {
    final headers = <ContentHeader>[];

    for (final node in nodes) {
      if (node is ElementNode) {
        final tagName = node.tag.toLowerCase();

        if (tagName.startsWith('h')) {
          // Verify this is a header element with a valid level.
          final level = int.tryParse(tagName.substring(1));
          if (level != null && level >= 1 && level <= 6) {
            headers.add(
              ContentHeader(
                text: node.innerText,
                level: level,
                attributes: node.attributes,
              ),
            );
          }
        }

        if (node.children case final children?) {
          headers.addAll(_extractHeaders(children));
        }
      }
    }

    return headers;
  }
}

@immutable
final class ContentHeader {
  final String text;
  final int level;
  final Map<String, String> attributes;

  const ContentHeader({
    required this.text,
    required this.level,
    this.attributes = const {},
  });
}
