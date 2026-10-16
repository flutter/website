// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_media_convert/src/image_info.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'test_images.dart';

void main() {
  late Directory directory;

  setUp(() => directory = Directory.systemTemp.createTempSync('image_info'));
  tearDown(() => directory.deleteSync(recursive: true));

  SourceImageInfo? read(List<int> bytes) {
    final file = File(p.join(directory.path, 'image'))..writeAsBytesSync(bytes);
    return SourceImageInfo.readFile(file.path);
  }

  test('reads PNG dimensions', () {
    final info = read(pngBytes(width: 123, height: 45))!;
    expect(info.format, SourceImageFormat.png);
    expect(info.width, 123);
    expect(info.height, 45);
    expect(info.isAnimated, isFalse);
  });

  test('detects animated PNGs', () {
    final info = read(animatedPngBytes())!;
    expect(info.format, SourceImageFormat.png);
    expect(info.isAnimated, isTrue);
  });

  test('reads JPEG dimensions', () {
    final info = read(jpegBytes(width: 321, height: 54))!;
    expect(info.format, SourceImageFormat.jpeg);
    expect(info.width, 321);
    expect(info.height, 54);
  });

  test('returns null for other and malformed data', () {
    expect(read(Uint8List(0)), isNull);
    expect(read(utf8.encode('<svg></svg>')), isNull);

    final png = pngBytes();
    expect(read(Uint8List.sublistView(png, 0, 20)), isNull);

    final jpeg = jpegBytes();
    for (final length in [3, 10, 30, 100]) {
      expect(
        () => read(Uint8List.sublistView(jpeg, 0, length)),
        returnsNormally,
      );
    }
  });
}
