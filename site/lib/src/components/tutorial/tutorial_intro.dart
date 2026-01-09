// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

/// A component that visually separates the intro section from the main content
/// of a tutorial page.
///
/// The `<TutorialIntro>` component wraps markdown content, videos, and
/// SummaryCard components that should appear in the tutorial's introduction.
///
/// Usage in markdown:
/// ```markdown
/// <TutorialIntro>
///
/// Welcome to this tutorial!
///
/// <YouTubeEmbed id="abc123" title="Intro Video"/>
///
/// <SummaryCard>
/// title: What you'll learn
/// items:
///   - icon: lightbulb
///     title: Flutter basics
/// </SummaryCard>
///
/// </TutorialIntro>
/// ```
class TutorialIntro extends CustomComponent {
  const TutorialIntro() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(tag: 'TutorialIntro', :final children?)) {
      return section(
        classes: 'tutorial-intro',
        [builder.build(children)],
      );
    }
    return null;
  }
}
