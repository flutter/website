// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/image_dimensions.dart';
import 'package:site_shared/markdown.dart';

import '../../extensions/image_dimension_processor.dart';

class DashImage with CustomComponentBase {
  const DashImage({this.webRoot});

  /// Optional path to the site's `web/` directory for hermetic testing.
  final String? webRoot;

  @override
  Pattern get pattern => RegExp('DashImage', caseSensitive: false);

  @override
  Component apply(_, Map<String, String> attributes, _) {
    final isFigure = attributes.containsKey('figure');
    final imgSrc =
        attributes['image'] ??
        (throw Exception(
          '<DashImage> component requires an "image" attribute.',
        ));

    final caption = attributes['caption'] ?? '';
    final alt = attributes['alt'] ?? caption;

    final figureClass = isFigure ? attributes['class'] : null;
    final imgClass = attributes[isFigure ? 'img-class' : 'class'];
    final style = buildDashImageStyle(attributes);

    final resolvedSrc = '/assets/images/docs/$imgSrc';
    final dims = resolveDocsWebImageDimensions(resolvedSrc, webRoot: webRoot);

    final child = Component.fragment([
      img(
        src: resolvedSrc,
        alt: alt,
        classes: imgClass,
        width: dims?.width,
        height: dims?.height,
        attributes: {
          if (style.isNotEmpty) 'style': style,
        },
      ),
      if (caption.isNotEmpty)
        figcaption(classes: 'figure-caption', [
          DashMarkdown(content: caption),
        ]),
    ]);

    if (isFigure) {
      return figure(classes: figureClass, [
        div(classes: 'site-figure-container', [
          child,
        ]),
      ]);
    }

    return child;
  }
}
