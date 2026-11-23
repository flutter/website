// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:math';

import 'package:flutter_website/src/utils/asset_utils.dart';
import 'package:image/image.dart' as img;
import 'package:jaspr_content/jaspr_content.dart';
import 'package:test/test.dart';

void main() {
  const transformer = ResizingAssetTransformer();

  for (final format in [img.WebPFormat.lossy, img.WebPFormat.lossless]) {
    test('preserves ${format.name} WebP encoding when resizing', () {
      final bytes = img.encodeWebP(
        _testImage(192, 64),
        lossless: format == img.WebPFormat.lossless,
      );
      final asset = Asset.fromBytes('photo.webp', bytes);

      final result = transformer.transform(asset, 48);
      final info = img.WebPDecoder().startDecode(result.readAsBytes())!;

      expect(result.path, 'photo.w48.webp');
      expect((info.width, info.height, info.format), (48, 16, format));
    });
  }

  test('keeps animated WebP files intact', () {
    final animation = _testImage(192, 64)..addFrame();
    final bytes = img.encodeWebP(animation);
    final asset = Asset.fromBytes('animated.webp', bytes);

    expect(transformer.transform(asset, 48).readAsBytes(), bytes);
  });

  test('resizes a JPEG using its EXIF display width', () {
    final portrait = _testImage(64, 192)..exif.imageIfd.orientation = 6;
    final asset = Asset.fromBytes('rotated.jpg', img.encodeJpg(portrait));

    final result = transformer.transform(asset, 96);
    final image = img.decodeJpg(result.readAsBytes())!;

    expect((image.width, image.height), (96, 32));
  });
}

// Seeded noise ensures that reducing the dimensions also reduces the file size.
img.Image _testImage(int width, int height) => img.noise(
  img.Image(width: width, height: height),
  64,
  random: Random(1),
);
