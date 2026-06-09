// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import '../../utils/asset_utils.dart';

class Image extends StatelessComponent {
  const Image({
    super.key,
    required this.src,
    this.alt,
    this.fullWidth = false,
    this.rounded = false,
  });

  factory Image.fromAttrs(Map<String, Object?> attrs) {
    return Image(
      src: attrs['src'] as String,
      alt: attrs['alt'] as String,
      fullWidth: attrs['format'] == 'fullwidth',
      rounded: attrs['rounded'] == 'true' || attrs['rounded'] == true,
    );
  }

  final String src;
  final String? alt;
  final bool fullWidth;
  final bool rounded;

  @override
  Component build(BuildContext context) {
    return img(
      src: context.asset(src, width: 800),
      classes: [
        'richtext-image',
        if (fullWidth) 'full-width',
        if (rounded) 'rounded',
      ].join(' '),
      alt: alt,
    );
  }
}
