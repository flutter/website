// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:dash_media_convert/src/cwebp.dart';
import 'package:dash_media_convert/src/cwebp_pins.dart';
import 'package:dash_media_convert/src/utils.dart';
import 'package:dash_media_convert/src/webp_converter.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'test_images.dart';

void main() {
  late Cwebp cwebp;
  late WebpConverter converter;
  late Directory directory;
  late String outputPath;

  setUpAll(() async {
    cwebp = await Cwebp.resolve();
    converter = WebpConverter(cwebp: cwebp);
  });

  setUp(() {
    directory = Directory.systemTemp.createTempSync('webp_test');
    outputPath = p.join(directory.path, 'output.webp');
  });
  tearDown(() => directory.deleteSync(recursive: true));

  /// Writes [source] to a file, then converts it to [outputPath] with
  /// [using], or with [converter] by default.
  Future<WebpConversionResult> convert(
    List<int> source, {
    WebpConverter? using,
  }) {
    final sourcePath = p.join(directory.path, 'source');
    File(sourcePath).writeAsBytesSync(source);
    return (using ?? converter).convert(sourcePath, outputPath);
  }

  img.WebPInfo outputInfo() =>
      img.WebPDecoder().startDecode(File(outputPath).readAsBytesSync())!;

  group(
    'pinned cwebp cache',
    () {
      /// Copies the already verified binary into the cache in [directory]
      /// to avoid downloading it for every test run.
      Future<File> cacheExecutable() {
        final cachedExecutable = File(
          pinnedCwebpPath(
            directory.path,
            currentCwebpPlatform,
            cwebpPins[currentCwebpPlatform]!,
          ),
        );
        cachedExecutable.parent.createSync(recursive: true);
        return File(cwebp.executablePath).copy(cachedExecutable.path);
      }

      test('resolves the pinned version from the specified cache', () async {
        final cachedExecutable = await cacheExecutable();

        final resolved = await Cwebp.resolve(
          toolCacheDirectory: directory.path,
          log: (_) {},
        );

        expect(resolved.executablePath, cachedExecutable.path);
        expect(resolved.version, pinnedCwebpVersion);
      });

      test('reports tool cache directories that are not writable', () async {
        Process.runSync('chmod', ['555', directory.path]);
        addTearDown(() => Process.runSync('chmod', ['755', directory.path]));

        await expectLater(
          Cwebp.resolve(
            toolCacheDirectory: p.join(directory.path, 'cwebp'),
            log: (_) {},
          ),
          throwsA(isA<CwebpException>()),
        );
      }, testOn: '!windows');

      test('reports tool cache directories cwebp cannot run from', () async {
        // Like a directory on a file system mounted with `noexec`.
        final cachedExecutable = await cacheExecutable();
        Process.runSync('chmod', ['644', cachedExecutable.path]);

        final messages = <String>[];
        await expectLater(
          Cwebp.resolve(toolCacheDirectory: directory.path, log: messages.add),
          throwsA(isA<CwebpException>()),
        );
        expect(messages, [contains(directory.path)]);
      }, testOn: '!windows');
    },
    skip: (Platform.environment['CWEBP_PATH']?.isNotEmpty ?? false)
        ? 'CWEBP_PATH bypasses the pinned cache.'
        : false,
  );

  for (final (format, createBytes, lossless) in [
    ('PNG', pngBytes, true),
    ('JPEG', jpegBytes, false),
  ]) {
    test('converts $format images to smaller WebP images', () async {
      final bytes = createBytes();
      final result = await convert(bytes) as WebpConverted;

      expect(
        outputInfo().format,
        lossless ? img.WebPFormat.lossless : img.WebPFormat.lossy,
      );
      expect(result.outputSize, File(outputPath).lengthSync());
      expect(result.outputSize, lessThan(bytes.length));
      expect(result.sourceSize, bytes.length);
      expect(result.lossless, lossless);
      expect(result.resizedWidth, isNull);

      if (lossless) {
        final source = img.decodePng(bytes)!;
        final output = img.decodeWebP(File(outputPath).readAsBytesSync())!;
        expect((output.width, output.height), (source.width, source.height));
        expect(
          output.getBytes(order: img.ChannelOrder.rgba),
          source.getBytes(order: img.ChannelOrder.rgba),
        );
      }
    });
  }

  test('converts flat-color PNG images losslessly', () async {
    final source = flatPngBytes();
    final result = await convert(source) as WebpConverted;

    expect(result.lossless, isTrue);
    expect(outputInfo().format, img.WebPFormat.lossless);
    expect(result.outputSize, lessThan(source.length));
  });

  test('encodes PNGs lossily when enabled', () async {
    final source = pngBytes();
    final lossy = WebpConverter(cwebp: cwebp, lossyPng: true);

    final result = await convert(source, using: lossy) as WebpConverted;

    expect(result.lossless, isFalse);
    expect(outputInfo().format, img.WebPFormat.lossy);
    expect(result.outputSize, lessThan(source.length));
    expect(result.resizedWidth, isNull);
  });

  test('the lossy PNG option does not change JPEG encoding', () async {
    final source = jpegBytes();
    await convert(source);
    final defaultOutput = File(outputPath).readAsBytesSync();
    File(outputPath).deleteSync();

    await convert(source, using: WebpConverter(cwebp: cwebp, lossyPng: true));

    expect(File(outputPath).readAsBytesSync(), defaultOutput);
  });

  test('skips JPEG images when the WebP would be larger', () async {
    expect(
      await convert(noisyJpegBytes()),
      isSkippedBecause(WebpSkipReason.notSmaller),
    );
    expect(File(outputPath).existsSync(), isFalse);
  });

  test('resizes images wider than the maximum width', () async {
    final resizing = WebpConverter(cwebp: cwebp, maxWidth: 200);

    final wide =
        await convert(pngBytes(width: 400), using: resizing) as WebpConverted;
    expect(wide.resizedWidth, (from: 400, to: 200));
    expect(outputInfo().width, 200);

    File(outputPath).deleteSync();
    final narrow =
        await convert(pngBytes(width: 150), using: resizing) as WebpConverted;
    expect(narrow.resizedWidth, isNull);
    expect(outputInfo().width, 150);
  });

  test('skips animated PNG images', () async {
    expect(
      await convert(animatedPngBytes()),
      isSkippedBecause(WebpSkipReason.animated),
    );
    expect(File(outputPath).existsSync(), isFalse);
  });

  test('fails to convert unsupported and invalid images', () async {
    expect(await convert(Uint8List(10)), isA<WebpFailed>());

    // Valid headers, but truncated image data.
    final truncated = Uint8List.sublistView(pngBytes(), 0, 200);
    expect(
      await convert(truncated),
      isA<WebpFailed>().having((f) => f.message, 'message', contains('cwebp')),
    );
    expect(File(outputPath).existsSync(), isFalse);
  });

  test('summarizes conversions', () {
    const conversion = WebpConverted(
      sourceSize: 1200000,
      outputSize: 180000,
      lossless: true,
      resizedWidth: (from: 4000, to: 2400),
    );
    expect(
      conversion.summary,
      '1.2 MB → 180.0 kB (85% smaller), lossless, '
      'resized from 4000 to 2400 pixels wide',
    );
    expect(
      const WebpConverted(
        sourceSize: 900,
        outputSize: 500,
        lossless: false,
      ).summary,
      '900 B → 500 B (44% smaller)',
    );
  });

  test('writes files atomically', () async {
    final path = p.join(directory.path, 'image.webp');

    await writeFileAtomically(
      path,
      (temporaryPath) => File(temporaryPath).writeAsBytes([1, 2, 3]),
    );
    expect(File(path).readAsBytesSync(), [1, 2, 3]);
    expect(directory.listSync(), hasLength(1));

    await expectLater(
      writeFileAtomically(path, (temporaryPath) async {
        await File(temporaryPath).writeAsBytes([4]);
        throw const FileSystemException('Interrupted');
      }),
      throwsA(isA<FileSystemException>()),
    );
    expect(File(path).readAsBytesSync(), [1, 2, 3]);
    expect(directory.listSync(), hasLength(1));
  });
}
