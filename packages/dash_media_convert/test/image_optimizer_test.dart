// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:dash_media_convert/dash_media_convert.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'test_images.dart';

void main() {
  late ImageOptimizer optimizer;
  late Directory directory;

  setUpAll(() async {
    optimizer = await ImageOptimizer.create();
  });

  setUp(() => directory = Directory.systemTemp.createTempSync('optimizer'));
  tearDown(() => directory.deleteSync(recursive: true));

  String write(String name, List<int> bytes) =>
      (File(p.join(directory.path, name))..writeAsBytesSync(bytes)).path;

  test('validates image extensions', () {
    expect(validateImagePaths(['a/b.png', 'c.JPG', 'd.jpeg']), isNull);
    for (final imagePath in ['b.webp', 'b.gif']) {
      expect(validateImagePaths([imagePath]), isNotNull, reason: imagePath);
    }
  });

  test('replaces images with smaller WebP images', () async {
    final png = write('screenshot.png', pngBytes());
    final jpeg = write('photo.jpg', jpegBytes());

    final results = await optimizer.optimizeFiles([png, jpeg]);

    expect(results.map((r) => r.imagePath), [png, jpeg]);
    expect(results.map((r) => r.result), everyElement(isA<WebpConverted>()));
    expect(
      directory.listSync().map((e) => p.basename(e.path)),
      unorderedEquals(['screenshot.webp', 'photo.webp']),
    );
  });

  test('keeps images that should not be converted', () async {
    final animated = write('animated.png', animatedPngBytes());

    final results = await optimizer.optimizeFiles([animated]);

    expect(results.single.result, isSkippedBecause(WebpSkipReason.animated));
    expect(File(animated).existsSync(), isTrue);
    expect(directory.listSync(), hasLength(1));
  });

  test('supports opting into lossy PNG conversion', () async {
    final png = write('photo.png', pngBytes());
    final lossyOptimizer = await ImageOptimizer.create(lossyPng: true);

    final results = await lossyOptimizer.optimizeFiles([png]);

    expect(
      results.single.result,
      isA<WebpConverted>().having((r) => r.lossless, 'lossless', isFalse),
    );
    expect(File(png).existsSync(), isFalse);
    expect(File(p.setExtension(png, '.webp')).existsSync(), isTrue);
  });

  test('fails without overwriting existing WebP images', () async {
    final png = write('image.png', pngBytes());
    final existing = write('image.webp', [1, 2, 3]);

    final results = await optimizer.optimizeFiles([png]);

    expect(results.single.result, isA<WebpFailed>());
    expect(File(png).existsSync(), isTrue);
    expect(File(existing).readAsBytesSync(), [1, 2, 3]);
  });

  for (final jpegName in ['image.jpg', 'Image.jpg']) {
    test(
      'rejects image.png and $jpegName before converting any images',
      () async {
        final pngSource = pngBytes();
        final jpegSource = jpegBytes();
        final png = write('image.png', pngSource);
        final jpeg = write(jpegName, jpegSource);
        final other = write('other.png', pngSource);

        await expectLater(
          optimizer.optimizeFiles([other, png, jpeg]),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Multiple inputs would write to'),
            ),
          ),
        );
        expect(File(png).readAsBytesSync(), pngSource);
        expect(File(jpeg).readAsBytesSync(), jpegSource);
        expect(File(other).readAsBytesSync(), pngSource);
        expect(
          directory.listSync().map((e) => p.basename(e.path)),
          unorderedEquals(['image.png', jpegName, 'other.png']),
        );
      },
    );
  }

  for (final equivalentPath in [false, true]) {
    test(
      'rejects ${equivalentPath ? 'equivalent' : 'duplicate'} input paths',
      () async {
        final source = pngBytes();
        final png = write('image.png', source);
        final duplicate = equivalentPath
            ? p.join(p.relative(directory.path), '.', 'image.png')
            : png;

        await expectLater(
          optimizer.optimizeFiles([png, duplicate]),
          throwsArgumentError,
        );
        expect(File(png).readAsBytesSync(), source);
        expect(directory.listSync(), hasLength(1));
      },
    );
  }

  group(
    'directory symlinks',
    // Creating symlinks on Windows requires additional privileges.
    testOn: '!windows',
    () {
      late String images;
      late String alias;

      setUp(() {
        images = p.join(directory.path, 'images');
        Directory(images).createSync();
        alias = p.join(directory.path, 'alias');
        Link(alias).createSync(images);
      });

      test('rejects output collisions through a symlink', () {
        expect(
          validateImagePaths([
            p.join(images, 'image.png'),
            p.join(alias, 'image.jpg'),
          ]),
          contains('Multiple inputs would write to'),
        );
      });

      test('accepts distinct output paths through a symlink', () {
        expect(
          validateImagePaths([
            p.join(images, 'screenshot.png'),
            p.join(alias, 'photo.jpg'),
          ]),
          isNull,
        );
      });
    },
  );

  test('fails on images that are not valid', () async {
    final invalid = write('invalid.png', [1, 2, 3]);

    final results = await optimizer.optimizeFiles([invalid]);

    expect(results.single.result, isA<WebpFailed>());
    expect(File(invalid).existsSync(), isTrue);
  });

  for (final missingPath in ['missing.png', p.join('missing', 'image.png')]) {
    test('reports $missingPath without losing other results', () async {
      final missing = p.join(directory.path, missingPath);
      final valid = write('valid.png', pngBytes());

      final results = await optimizer.optimizeFiles([missing, valid]);

      expect(results.map((r) => r.imagePath), [missing, valid]);
      expect(results.first.result, isA<WebpFailed>());
      expect(results.last.result, isA<WebpConverted>());
      expect(File(valid).existsSync(), isFalse);
      expect(File(p.setExtension(valid, '.webp')).existsSync(), isTrue);
    });
  }
}
