// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'content_image.dart';

class DashImage with CustomComponentBase {
  const DashImage();

  @override
  Pattern get pattern => RegExp('DashImage', caseSensitive: false);

  @override
  Component apply(_, Map<String, String> attributes, _) {
    final isFigure = attributes.containsKey('figure');
    final imgSrc =
        attributes['src'] ??
        (throw Exception(
          '<DashImage> component requires a "src" attribute.',
        ));

    final caption = attributes['caption'] ?? '';
    final alt = attributes['alt'] ?? caption;

    final figureClass = isFigure ? attributes['class'] : null;
    final imgClass = attributes[isFigure ? 'img-class' : 'class'];

    final style =
        [
              ?attributes['img-style'],
              if (attributes['width'] case final w?) 'width: $w',
              if (attributes['height'] case final h?) 'height: $h',
            ]
            .map((style) => style.trim())
            .map((style) => style.endsWith(';') ? style : '$style;')
            .join(' ');

    return ContentImage(
      src: imgSrc,
      alt: alt,
      caption: caption,
      isFigure: isFigure,
      figureClass: figureClass,
      imageClass: imgClass,
      imageStyle: style,
    );
  }
}
