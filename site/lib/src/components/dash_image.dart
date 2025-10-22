// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../markdown/markdown_parser.dart';

class DashImage with CustomComponentBase {
  const DashImage();

  @override
  Pattern get pattern => RegExp('DashImage', caseSensitive: false);

  @override
  Component apply(_, Map<String, String> attributes, _) {
    final isFigure = attributes.containsKey('figure');
    final imgSrc = attributes['image']!;
    final caption = attributes['caption'] ?? '';
    final alt = attributes['alt'] ?? caption;

    final figureClass = isFigure ? attributes['class'] : null;
    final imgClass = attributes[isFigure ? 'img-class' : 'class'];

    var style = attributes['img-style'] ?? '';

    if (attributes['width'] case final width?) {
      if (style.isNotEmpty && !style.trim().endsWith(';')) {
        style += '; ';
      }
      style += 'width: $width;';
    }
    if (attributes['height'] case final height?) {
      if (style.isNotEmpty && !style.trim().endsWith(';')) {
        style += '; ';
      }
      style += 'height: $height;';
    }

    final child = Component.fragment([
      img(
        src: '/assets/images/docs/$imgSrc',
        alt: alt,
        classes: imgClass,
        attributes: {
          if (style.isNotEmpty) 'style': style,
        },
      ),
      if (caption.isNotEmpty)
        figcaption(classes: 'figure-caption', [
          if (caption.isNotEmpty) DashMarkdown(content: caption),
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
