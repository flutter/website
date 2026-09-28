// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:math';
import 'dart:typed_data';

import 'package:dash_media_convert/dash_media_convert.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

/// Creates a noisy, photo-like test image that
/// compresses much better with lossy encoding.
img.Image testImage({int width = 400, int height = 300}) {
  final random = Random(42);
  final image = img.Image(width: width, height: height);
  for (final pixel in image) {
    pixel
      ..r = min(pixel.x * 255 ~/ width + random.nextInt(24), 255)
      ..g = min(pixel.y * 255 ~/ height + random.nextInt(24), 255)
      ..b = 128 + random.nextInt(24);
  }
  return image;
}

/// Creates a PNG image of thin lines on a flat background, which
/// compresses much better with lossless encoding.
Uint8List flatPngBytes() {
  final image = img.Image(width: 256, height: 256)
    ..clear(img.ColorRgb8(255, 255, 255));
  final color = img.ColorRgb8(2, 86, 155);
  for (var i = 0; i < 256; i += 6) {
    img.drawLine(image, x1: i, y1: 0, x2: i, y2: 255, color: color);
    img.drawLine(image, x1: 0, y1: i, x2: 255, y2: i, color: color);
  }
  return img.encodePng(image);
}

/// Creates a low-quality JPEG image of random noise,
/// which is larger when encoded as a WebP image.
Uint8List noisyJpegBytes() {
  final random = Random(42);
  final image = img.Image(width: 256, height: 256);
  for (final pixel in image) {
    pixel
      ..r = random.nextInt(256)
      ..g = random.nextInt(256)
      ..b = random.nextInt(256);
  }
  return img.encodeJpg(image, quality: 10);
}

Uint8List pngBytes({int width = 400, int height = 300}) =>
    img.encodePng(testImage(width: width, height: height));

Uint8List jpegBytes({int width = 400, int height = 300}) {
  final image = testImage(width: width, height: height);
  return img.encodeJpg(image, quality: 95);
}

Uint8List animatedPngBytes() {
  final animation = testImage(width: 64, height: 64)..frameDuration = 100;
  animation.addFrame(img.invert(testImage(width: 64, height: 64)));
  return img.encodePng(animation);
}

/// Matches a [WebpSkipped] result that was skipped because of [reason].
Matcher isSkippedBecause(WebpSkipReason reason) =>
    isA<WebpSkipped>().having((s) => s.reason, 'reason', reason);
