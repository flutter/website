// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

/// A component that provides the structure for a tutorial lesson page.
///
/// The `<TutorialLesson>` component expects three child sections:
/// - `<TutorialIntro>`: The intro section with description, video, and SummaryCard
/// - `<TutorialSteps>`: The main content wrapped in a Stepper
/// - `<TutorialOutro>`: The completion section with the summary SummaryCard
///
/// Usage in markdown:
/// ```markdown
/// <TutorialLesson>
/// <TutorialIntro>
///
/// Learn the basics of Flutter widgets.
///
/// <YouTubeEmbed id="..." title="..."/>
///
/// <SummaryCard>
/// title: What you'll accomplish
/// items:
///   - ...
/// </SummaryCard>
///
/// </TutorialIntro>
///
/// <TutorialSteps>
///
/// ### First step
/// ...content...
///
/// ### Test yourself
/// <Quiz>...</Quiz>
///
/// </TutorialSteps>
///
/// <TutorialOutro>
///
/// <SummaryCard>
/// title: What you accomplished
/// ...
/// </SummaryCard>
///
/// </TutorialOutro>
/// </TutorialLesson>
/// ```
class TutorialLesson extends CustomComponent {
  const TutorialLesson() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(tag: 'TutorialLesson', :final children?)) {
      List<Node>? introContent;
      List<Node>? stepsContent;
      List<Node>? outroContent;

      for (final child in children) {
        if (child case ElementNode(tag: 'TutorialIntro', :final children?)) {
          introContent = children;
        } else if (child case ElementNode(
          tag: 'TutorialSteps',
          :final children?,
        )) {
          stepsContent = children;
        } else if (child case ElementNode(
          tag: 'TutorialOutro',
          :final children?,
        )) {
          outroContent = children;
        }
      }

      return section(classes: 'tutorial-lesson', [
        // Intro section
        if (introContent != null)
          section(classes: 'tutorial-intro', [
            ..._buildIntroContent(introContent, builder),
          ]),
        // Divider between intro and steps
        if (introContent != null && stepsContent != null)
          const hr(classes: 'tutorial-divider'),
        // Steps section
        if (stepsContent != null)
          section(classes: 'tutorial-steps', [
            const h2([.text('Steps')]),
            // Wrap steps content in a Stepper with level="3"
            builder.build([
              ElementNode('Stepper', {'level': '3'}, stepsContent),
            ]),
          ]),
        // Outro section
        if (outroContent != null)
          section(classes: 'tutorial-outro', [
            builder.build(outroContent),
          ]),
      ]);
    }

    return null;
  }

  /// Builds the intro content, automatically wrapping:
  /// - Paragraph elements (`<p>`) get 'description' class added
  /// - YouTubeEmbed elements in a div with class 'intro-video'
  List<Component> _buildIntroContent(List<Node> content, NodesBuilder builder) {
    final wrappedContent = <Component>[];

    for (final node in content) {
      if (node case ElementNode(tag: 'p', :final children)) {
        // Check if paragraph contains only a video embed
        final videoChild = _findVideoChild(children);
        if (videoChild != null) {
          // Extract video from paragraph and wrap in intro-video div
          wrappedContent.add(
            div(classes: 'intro-video', [
              builder.build([videoChild]),
            ]),
          );
        } else {
          // Regular paragraph - add description class
          wrappedContent.add(
            p(classes: 'description', [builder.build(children ?? [])]),
          );
        }
      } else if (_isVideoEmbed(node)) {
        // Direct video embed (not wrapped in paragraph)
        wrappedContent.add(
          div(classes: 'intro-video', [
            builder.build([node]),
          ]),
        );
      } else {
        // Pass through other elements (SummaryCard, comments, etc.)
        wrappedContent.add(builder.build([node]));
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
