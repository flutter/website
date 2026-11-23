// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:typed_data';

import 'package:flutter_website/src/utils/asset_utils.dart';
import 'package:image/image.dart' as img;
import 'package:jaspr_content/jaspr_content.dart';
import 'package:test/test.dart';

void main() {
  const transformer = ResizingAssetTransformer();

  group('ResizingAssetTransformer WebP support', () {
    test('resizes wider lossy WebP images and reduces byte size', () {
      final sourceImage = _createGradientImage(width: 800, height: 450);
      final sourceBytes = img.encodeWebP(
        sourceImage,
        lossless: false,
        quality: 85,
      );
      final asset = Asset.fromBytes('news/featured.webp', sourceBytes);

      final result = transformer.transform(asset, 320);

      expect(result.path, 'news/featured.w320.webp');
      final resizedBytes = result.readAsBytes();
      expect(resizedBytes.lengthInBytes, lessThan(sourceBytes.lengthInBytes));

      final decoded = img.decodeWebP(resizedBytes);
      expect(decoded, isNotNull);
      expect(decoded!.width, 320);
      expect(decoded.height, 180);
    });

    test('preserves lossless encoding when resizing lossless WebP images', () {
      final sourceImage = _createGradientImage(width: 600, height: 300);
      final sourceBytes = img.encodeWebP(sourceImage);
      final asset = Asset.fromBytes('diagrams/architecture.webp', sourceBytes);

      final result = transformer.transform(asset, 200);

      expect(result.path, 'diagrams/architecture.w200.webp');
      final resizedBytes = result.readAsBytes();
      expect(resizedBytes.lengthInBytes, lessThan(sourceBytes.lengthInBytes));

      final info = img.WebPDecoder().startDecode(resizedBytes);
      expect(info, isNotNull);
      expect(info!.format, img.WebPFormat.lossless);
      expect(info.width, 200);
      expect(info.height, 100);
    });

    test(
      'keeps the original animated WebP when a smaller width is requested',
      () {
        final animation = img.Image(width: 400, height: 200, frameDuration: 40)
          ..addFrame(_createGradientImage(width: 400, height: 200));
        final bytes = img.encodeWebP(animation, lossless: false, quality: 85);
        expect(img.WebPDecoder().startDecode(bytes)!.numFrames, 2);
        final asset = Asset.fromBytes('news/release.webp', bytes);

        expect(transformer.transform(asset, 200), same(asset));
      },
    );

    test('returns original asset when WebP width is already within target', () {
      final sourceImage = _createGradientImage(width: 300, height: 200);
      final sourceBytes = img.encodeWebP(
        sourceImage,
        lossless: false,
        quality: 80,
      );
      final asset = Asset.fromBytes('home/card.webp', sourceBytes);

      final result = transformer.transform(asset, 300);

      expect(result, same(asset));
    });

    test('leaves unsupported AVIF assets untouched', () {
      final asset = Asset.fromBytes(
        'events/featured.avif',
        Uint8List.fromList([0, 0, 0, 24]),
      );

      final result = transformer.transform(asset, 300);

      expect(result, same(asset));
    });

    test('resizes wider PNG images cleanly without corrupting chunks', () {
      final sourceImage = _createGradientImage(width: 600, height: 300);
      final sourceBytes = img.encodePng(sourceImage);
      final asset = Asset.fromBytes('images/hero.png', sourceBytes);

      final result = transformer.transform(asset, 200);

      expect(result.path, 'images/hero.w200.png');
      final decoded = img.decodePng(result.readAsBytes());
      expect(decoded, isNotNull);
      expect(decoded!.width, 200);
      expect(decoded.height, 100);
    });

    test('resizes a JPEG whose EXIF orientation makes it wider', () {
      // Stored 100 pixels wide, but displayed 200 pixels wide.
      final sourceImage = _createGradientImage(width: 100, height: 200)
        ..exif.imageIfd.orientation = 6;
      final sourceBytes = img.encodeJpg(sourceImage);
      final asset = Asset.fromBytes('images/photo.jpg', sourceBytes);

      final result = transformer.transform(asset, 150);

      expect(result.path, 'images/photo.w150.jpg');
      final decoded = img.decodeJpg(result.readAsBytes());
      expect(decoded, isNotNull);
      expect(decoded!.width, 150);
      expect(decoded.height, 75);
    });
  });
}

img.Image _createGradientImage({required int width, required int height}) {
  final image = img.Image(width: width, height: height);
  for (var y = 0; y < height; y += 1) {
    for (var x = 0; x < width; x += 1) {
      image.setPixelRgba(
        x,
        y,
        (x * 255) ~/ width,
        (y * 255) ~/ height,
        ((x + y) * 127) ~/ (width + height) + 64,
        255,
      );
    }
  }
  return image;
}
