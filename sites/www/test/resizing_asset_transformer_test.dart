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
      'extracts and resizes the final composited poster frame on animated WebP',
      () {
        final firstFrame = img.Image(width: 400, height: 200, frameDuration: 40)
          ..clear(img.ColorRgba8(10, 20, 30, 255));
        final finalFrame = _createGradientImage(width: 400, height: 200)
          ..frameDuration = 40;
        firstFrame.addFrame(finalFrame);

        final animatedBytes = img.encodeWebP(
          firstFrame,
          lossless: false,
          quality: 85,
        );
        final asset = Asset.fromBytes('news/release.webp', animatedBytes);

        final result = transformer.transform(asset, 200);

        expect(result.path, 'news/release.w200.webp');
        final resizedBytes = result.readAsBytes();
        expect(
          resizedBytes.lengthInBytes,
          lessThan(animatedBytes.lengthInBytes),
        );

        final decoded = img.decodeWebP(resizedBytes);
        expect(decoded, isNotNull);
        expect(decoded!.numFrames, 1);
        expect(decoded.width, 200);
        expect(decoded.height, 100);
        // Verify the poster comes from the final frame rather than the dark
        // initial frame.
        final centerPixel = decoded.getPixel(100, 50);
        expect(centerPixel.r, greaterThan(40));
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
