// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:site_shared/image_dimensions.dart';
import 'package:test/test.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    clearImageDimensionsCache();
    tempDir = Directory.systemTemp.createTempSync('image_dimensions_test_');
    addTearDown(() => tempDir.deleteSync(recursive: true));
  });

  test('ImageDimensions equality, hashCode, and scaledToMaxWidth', () {
    const a = ImageDimensions(width: 1600, height: 800);
    const b = ImageDimensions(width: 1600, height: 800);
    const c = ImageDimensions(width: 800, height: 1600);

    expect(a, equals(b));
    expect(b, equals(a));
    expect(a.hashCode, equals(b.hashCode));
    expect(a, isNot(equals(c)));

    expect(a.scaledToMaxWidth(null), equals(a));
    expect(a.scaledToMaxWidth(2000), equals(a));
    expect(
      a.scaledToMaxWidth(1200),
      equals(const ImageDimensions(width: 1200, height: 600)),
    );
  });

  test(
    'reads PNG, GIF, WebP, AVIF, and SVG headers including misnamed files',
    () {
      final pngPath = p.join(tempDir.path, 'sample.png');
      File(pngPath)
          .writeAsBytesSync(_minimalPngHeader(width: 600, height: 496));
      expect(
        readImageDimensions(pngPath),
        const ImageDimensions(width: 600, height: 496),
      );

      final gifPath = p.join(tempDir.path, 'anim.gif');
      File(gifPath).writeAsBytesSync([
        0x47, 0x49, 0x46, 0x38, 0x39, 0x61, // GIF89a
        0x40, 0x01, // 320
        0xF0, 0x00, // 240
      ]);
      expect(
        readImageDimensions(gifPath),
        const ImageDimensions(width: 320, height: 240),
      );

      // Misnamed AVIF with .png extension (matches marketing calendar assets).
      final avifMisnamedPath = p.join(tempDir.path, 'calendar.png');
      File(avifMisnamedPath).writeAsBytesSync(
        _minimalAvifHeader(width: 512, height: 288),
      );
      expect(
        readImageDimensions(avifMisnamedPath),
        const ImageDimensions(width: 512, height: 288),
      );

      final svgPath = p.join(tempDir.path, 'logo.svg');
      File(svgPath).writeAsStringSync(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 839 1039"></svg>',
      );
      expect(
        readImageDimensions(svgPath),
        const ImageDimensions(width: 839, height: 1039),
      );

      final commaSvgPath = p.join(tempDir.path, 'comma.svg');
      File(commaSvgPath).writeAsStringSync(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0,0,839,1039"></svg>',
      );
      expect(
        readImageDimensions(commaSvgPath),
        const ImageDimensions(width: 839, height: 1039),
      );

      final mixedSvgPath = p.join(tempDir.path, 'mixed.svg');
      File(mixedSvgPath).writeAsStringSync(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0, 0, 640, 480"></svg>',
      );
      expect(
        readImageDimensions(mixedSvgPath),
        const ImageDimensions(width: 640, height: 480),
      );

      final spriteSvgPath = p.join(tempDir.path, 'sprite.svg');
      File(spriteSvgPath).writeAsStringSync(
        '<svg xmlns="http://www.w3.org/2000/svg">'
        '<symbol id="icon" viewBox="0 0 24 24"></symbol></svg>',
      );
      expect(readImageDimensions(spriteSvgPath), isNull);
    },
  );

  test(
    'returns null without throwing on malformed binary or overflowing SVG '
    'files',
    () {
      final invalidUtf8Svg = p.join(tempDir.path, 'invalid_utf8.svg');
      File(invalidUtf8Svg)
          .writeAsBytesSync([0xFF, 0xFE, 0x3C, 0x73, 0x76, 0x67]);
      expect(readImageDimensions(invalidUtf8Svg), isNull);

      final overflowSvg = p.join(tempDir.path, 'overflow.svg');
      File(overflowSvg).writeAsStringSync(
        '<svg viewBox="0 0 ${'9' * 400} 100"></svg>',
      );
      expect(readImageDimensions(overflowSvg), isNull);

      final truncatedJpeg = p.join(tempDir.path, 'truncated.jpg');
      File(truncatedJpeg)
          .writeAsBytesSync([0xFF, 0xD8, 0xFF, 0xE0, 0x00, 0x10]);
      expect(readImageDimensions(truncatedJpeg), isNull);
    },
  );
}

Uint8List _minimalPngHeader({required int width, required int height}) {
  final bytes = ByteData(24);
  const sig = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
  for (var i = 0; i < sig.length; i++) {
    bytes.setUint8(i, sig[i]);
  }
  bytes.setUint32(8, 13);
  const ihdr = [0x49, 0x48, 0x44, 0x52];
  for (var i = 0; i < ihdr.length; i++) {
    bytes.setUint8(12 + i, ihdr[i]);
  }
  bytes.setUint32(16, width);
  bytes.setUint32(20, height);
  return bytes.buffer.asUint8List();
}

Uint8List _minimalAvifHeader({required int width, required int height}) {
  final bytes = ByteData(40);
  bytes.setUint32(0, 16);
  const ftypAvif = [0x66, 0x74, 0x79, 0x70, 0x61, 0x76, 0x69, 0x66];
  for (var i = 0; i < ftypAvif.length; i++) {
    bytes.setUint8(4 + i, ftypAvif[i]);
  }
  bytes.setUint32(16, 20);
  const ispe = [0x69, 0x73, 0x70, 0x65, 0x00, 0x00, 0x00, 0x00];
  for (var i = 0; i < ispe.length; i++) {
    bytes.setUint8(20 + i, ispe[i]);
  }
  bytes.setUint32(28, width);
  bytes.setUint32(32, height);
  return bytes.buffer.asUint8List();
}
