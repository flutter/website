// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// A page extension for Jaspr Content that structures pages using the
/// `story` layout into distinct storytelling chapters.
final class StoryStructureExtension implements PageExtension {
  const StoryStructureExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    final layout = page.data.page['layout'];
    if (layout != 'story') {
      return nodes;
    }

    final chapters = <Node>[];
    var currentChapterNodes = <Node>[];
    var chapterIndex = 0;
    Node? currentH2Node;

    void flushCurrentChapter() {
      if (currentChapterNodes.isEmpty && currentH2Node == null) return;

      final isPrologue = currentH2Node == null;
      final numStr = isPrologue
          ? '00'
          : (chapterIndex < 10 ? '0$chapterIndex' : '$chapterIndex');

      final chapterChildren = <Node>[];

      // Group kicker and heading into a sticky header group
      final headerGroupChildren = <Node>[
        if (!isPrologue)
          ElementNode(
            'div',
            const {'class': 'chapter-kicker'},
            [
              ElementNode(
                'span',
                const {'class': 'chapter-number'},
                [TextNode(numStr)],
              ),
              const ElementNode('span', {'class': 'chapter-rule'}, []),
            ],
          ),
        if (currentH2Node != null) currentH2Node!,
      ];

      if (headerGroupChildren.isNotEmpty) {
        chapterChildren.add(
          ElementNode(
            'div',
            const {'class': 'chapter-header-group'},
            headerGroupChildren,
          ),
        );
      }

      if (currentChapterNodes.isNotEmpty) {
        chapterChildren.add(
          ElementNode(
            'div',
            const {'class': 'chapter-content'},
            List<Node>.from(currentChapterNodes),
          ),
        );
      }

      chapters.add(
        ElementNode(
          'section',
          {
            'class': isPrologue
                ? 'story-chapter story-prologue'
                : 'story-chapter',
            'data-chapter': numStr,
          },
          chapterChildren,
        ),
      );

      currentChapterNodes = <Node>[];
      currentH2Node = null;
    }

    for (final node in nodes) {
      if (_isH2(node)) {
        flushCurrentChapter();
        chapterIndex++;
        currentH2Node = node;
      } else {
        currentChapterNodes.add(node);
      }
    }

    flushCurrentChapter();

    return chapters;
  }

  static bool _isH2(Node node) {
    if (node is! ElementNode) return false;
    if (node.tag.toLowerCase() == 'h2') return true;
    if (node.tag == 'div' &&
        (node.attributes['class']?.contains('header-wrapper') ?? false)) {
      return node.children?.any(
            (child) => child is ElementNode && child.tag.toLowerCase() == 'h2',
          ) ??
          false;
    }
    return false;
  }
}
