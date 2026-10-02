// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/markdown.dart';

/// An image in page content, with an optional figure and Markdown caption.
class ContentImage extends StatelessComponent {
  const ContentImage({
    required this.src,
    required this.alt,
    this.caption,
    this.isFigure = false,
    this.figureClass,
    this.imageClass,
    this.imageStyle = '',
    super.key,
  });

  /// The image path, resolved relative to the current page.
  final String src;

  /// The alternative text, or an empty string for a decorative image.
  final String alt;

  /// The optional caption, rendered as inline Markdown.
  final String? caption;

  /// Whether to wrap the image and caption in a figure.
  final bool isFigure;

  /// The CSS classes for the optional figure wrapper.
  final String? figureClass;

  /// The CSS classes for the image.
  final String? imageClass;

  /// The inline CSS declarations for the image.
  final String imageStyle;

  @override
  Component build(BuildContext context) {
    final child = Component.fragment([
      img(
        src: context.resolveAsset(src),
        alt: alt,
        classes: imageClass,
        attributes: {
          if (imageStyle.isNotEmpty) 'style': imageStyle,
        },
      ),
      if (caption case final caption? when caption.isNotEmpty)
        figcaption(classes: 'figure-caption', [
          DashMarkdown(content: caption, inline: true),
        ]),
    ]);

    return isFigure ? figure(classes: figureClass, [child]) : child;
  }
}
