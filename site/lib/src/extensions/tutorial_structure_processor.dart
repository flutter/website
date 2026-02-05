// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// A page extension for Jaspr Content that enforces the tutorial
/// page structure for all pages in the tutorial.
final class TutorialStructureExtension implements PageExtension {
  const TutorialStructureExtension();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    if (!page.path.startsWith('learn/pathway/tutorial/') ||
        page.path.endsWith('index.md')) {
      return nodes;
    }

    final dividerIndex = nodes.indexWhere(
      (node) => node is ElementNode && node.tag == 'hr',
    );

    List<Node> introContent;
    List<Node> stepsContent;
    List<Node> trailingContent;

    if (dividerIndex >= 0) {
      introContent = nodes.sublist(0, dividerIndex);

      final trailingDividerIndex = nodes.indexWhere(
        (node) => node is ElementNode && node.tag == 'hr',
        dividerIndex + 1,
      );

      stepsContent = trailingDividerIndex >= 0
          ? nodes.sublist(dividerIndex + 1, trailingDividerIndex)
          : nodes.sublist(dividerIndex + 1);
      trailingContent = trailingDividerIndex >= 0
          ? nodes.sublist(trailingDividerIndex)
          : <Node>[];
    } else {
      introContent = <Node>[];
      stepsContent = <Node>[];
      trailingContent = nodes;
    }

    return [
      ElementNode(
        'section',
        {'class': 'tutorial-lesson'},
        [
          if (introContent.isNotEmpty)
            ElementNode(
              'section',
              {'class': 'tutorial-intro'},
              _buildIntroContent(introContent),
            ),
          if (introContent.isNotEmpty && stepsContent.isNotEmpty)
            const ElementNode('hr', {'class': 'tutorial-divider'}, []),
          if (stepsContent.isNotEmpty)
            ElementNode(
              'section',
              {'class': 'tutorial-steps'},
              [
                const ElementNode('h2', {}, [TextNode('Steps')]),
                ElementNode('Stepper', {
                  'level': '3',
                  'actions': 'continue-only',
                }, stepsContent),
              ],
            ),
          ...trailingContent,
        ],
      ),
    ];
  }

  /// Builds the intro content, automatically wrapping:
  /// - Paragraph elements (`<p>`) get 'description' class added
  /// - YouTubeEmbed elements in a div with class 'intro-video'
  List<Node> _buildIntroContent(List<Node> content) {
    final wrappedContent = <Node>[];

    for (final node in content) {
      if (node case ElementNode(tag: 'p', :final children)) {
        // Check if paragraph contains only a video embed
        final videoChild = _findVideoChild(children);
        if (videoChild != null) {
          // Extract video from paragraph and wrap in intro-video div
          wrappedContent.add(
            ElementNode('div', {'class': 'intro-video'}, [videoChild]),
          );
        } else {
          // Regular paragraph - add description class
          wrappedContent.add(
            ElementNode('p', {'class': 'description'}, children),
          );
        }
      } else if (_isVideoEmbed(node)) {
        // Direct video embed (not wrapped in paragraph)
        wrappedContent.add(
          ElementNode('div', {'class': 'intro-video'}, [node]),
        );
      } else {
        // Pass through other elements (SummaryCard, comments, etc.)
        wrappedContent.add(node);
      }
    }

    return wrappedContent;
  }

  /// Checks if a node is a YouTube video embed
  bool _isVideoEmbed(Node node) {
    if (node case ElementNode(tag: final tag)) {
      final lowerTag = tag.toLowerCase();
      return lowerTag == 'youtubeembed' || lowerTag == 'lite-youtube';
    }
    return false;
  }

  /// Finds a video embed child in a list of nodes, returns it if it's the only
  /// meaningful content (ignoring whitespace text nodes)
  Node? _findVideoChild(List<Node>? children) {
    if (children == null) return null;

    Node? videoChild;
    for (final child in children) {
      if (_isVideoEmbed(child)) {
        videoChild = child;
      } else if (child case TextNode(:final text)) {
        // Ignore whitespace-only text nodes
        if (text.trim().isNotEmpty) return null;
      } else {
        // Non-video, non-whitespace content found
        return null;
      }
    }
    return videoChild;
  }
}
