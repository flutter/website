// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
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
    this.isHighPriority = false,
    super.key,
  });

  /// The image URL, already resolved to its final asset path.
  final String src;

  /// The alternative text, or an empty string for a decorative image.
  final String alt;

  /// The optional caption, rendered as inline Markdown.
  final String? caption;

  /// Whether to wrap the image in a figure.
  ///
  /// The image is always wrapped in a figure if it has a non-empty [caption],
  /// since a `<figcaption>` must be a child of a `<figure>`.
  final bool isFigure;

  /// The CSS classes for the optional figure wrapper.
  final String? figureClass;

  /// The CSS classes for the image.
  final String? imageClass;

  /// The inline CSS declarations for the image.
  final String imageStyle;

  /// Whether the image should load eagerly with a high fetch priority,
  /// such as for a hero image that's likely the largest contentful paint.
  final bool isHighPriority;

  @override
  Component build(BuildContext context) {
    final caption = switch (this.caption) {
      final caption? when caption.isNotEmpty => caption,
      _ => null,
    };

    final child = Component.fragment([
      img(
        src: src,
        alt: alt,
        classes: imageClass,
        loading: isHighPriority ? MediaLoading.eager : null,
        attributes: {
          if (imageStyle.isNotEmpty) 'style': imageStyle,
          if (isHighPriority) 'fetchpriority': 'high',
        },
      ),
      if (caption != null)
        figcaption(classes: 'figure-caption', [
          DashMarkdown(content: caption, inline: true),
        ]),
    ]);

    return isFigure || caption != null
        ? figure(classes: figureClass, [child])
        : child;
  }
}
