// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;

import 'cwebp.dart';
import 'image_info.dart';
import 'utils.dart';

/// The sets of `cwebp` encoding options that images are encoded with.
enum _WebpOptions {
  /// Lossless options for PNG images to preserve text and fine details
  /// in screenshots, diagrams, and illustrations.
  pngLossless(quality: 85, method: 6, lossless: true),

  /// Opt-in lossy options for PNG photos and artwork.
  pngLossy(quality: 85, method: 6, sharpYuv: true),

  /// Lossy options for JPEG images, which are already lossy photos.
  jpeg(quality: 85, method: 6);

  const _WebpOptions({
    required this.quality,
    required this.method,
    this.lossless = false,
    this.sharpYuv = false,
  });

  /// The quality factor from 0 to 100.
  ///
  /// For lossless encoding, this is the compression effort instead.
  final int quality;

  /// The compression method, from 0 (fastest) to 6 (most effort).
  final int method;

  /// Whether to encode losslessly.
  final bool lossless;

  /// Whether to use the more accurate and sharper RGB to YUV conversion.
  final bool sharpYuv;

  /// The `cwebp` arguments for these options.
  List<String> get arguments => [
    if (lossless) '-lossless',
    '-q',
    '$quality',
    '-m',
    '$method',
    if (sharpYuv) '-sharp_yuv',
    // Keep color profiles so wide-gamut images display correctly,
    // but strip other metadata such as EXIF and XMP.
    '-metadata',
    'icc',
  ];
}

/// The result of trying to convert an image to WebP.
sealed class WebpConversionResult {
  const WebpConversionResult();
}

/// An image that was converted to a smaller WebP image.
final class WebpConverted extends WebpConversionResult {
  const WebpConverted({
    required this.sourceSize,
    required this.outputSize,
    required this.lossless,
    this.resizedWidth,
  });

  /// The size of the source image in bytes.
  final int sourceSize;

  /// The size of the WebP image in bytes.
  final int outputSize;

  /// Whether the image was encoded losslessly.
  final bool lossless;

  /// The source image's width and the width it was resized to,
  /// if it was resized.
  final ({int from, int to})? resizedWidth;

  /// A human-readable summary of the conversion,
  /// such as "1.2 MB → 180.0 kB (85% smaller), lossless".
  String get summary {
    final percentSmaller = 100 - (outputSize * 100 / sourceSize).round();
    return [
      '${_formatSize(sourceSize)} → ${_formatSize(outputSize)} '
          '($percentSmaller% smaller)',
      if (lossless) 'lossless',
      if (resizedWidth case (:final from, :final to))
        'resized from $from to $to pixels wide',
    ].join(', ');
  }
}

String _formatSize(int bytes) => switch (bytes) {
  < 1000 => '$bytes B',
  < 1000 * 1000 => '${(bytes / 1000).toStringAsFixed(1)} kB',
  _ => '${(bytes / (1000 * 1000)).toStringAsFixed(1)} MB',
};

/// Why an image was intentionally left in its original format.
enum WebpSkipReason {
  /// The image is an animated PNG,
  /// whose animation `cwebp` doesn't preserve.
  animated('it is an animated PNG'),

  /// The image wouldn't be smaller as a WebP image.
  notSmaller('it would not be smaller as a WebP image');

  const WebpSkipReason(this.description);

  /// A human-readable description of the reason,
  /// such as "it is an animated PNG".
  final String description;
}

/// An image that was intentionally left in its original format.
final class WebpSkipped extends WebpConversionResult {
  const WebpSkipped(this.reason);

  /// Why the image wasn't converted.
  final WebpSkipReason reason;
}

/// An image that couldn't be converted.
final class WebpFailed extends WebpConversionResult {
  const WebpFailed(this.message);

  /// Why the image couldn't be converted,
  /// such as "it isn't a valid PNG or JPEG image".
  final String message;
}

/// Converts PNG and JPEG image files to WebP with `cwebp`.
final class WebpConverter {
  /// Creates a converter that encodes images with [cwebp].
  ///
  /// PNG images are encoded losslessly unless [lossyPng] is `true`.
  /// JPEG images are always encoded lossily.
  ///
  /// Images wider than [maxWidth] are resized to that width,
  /// preserving their aspect ratio. Resizing can change image details
  /// even when the resized image is encoded losslessly.
  WebpConverter({required this.cwebp, this.maxWidth, this.lossyPng = false});

  final Cwebp cwebp;
  final int? maxWidth;

  /// Whether to encode PNG images lossily at quality 85
  /// with sharp YUV conversion.
  final bool lossyPng;

  /// Tries to convert the PNG or JPEG image at [sourcePath] to
  /// a WebP image at [outputPath], leaving the source image in place.
  ///
  /// The image is left in its original format if it's animated or
  /// wouldn't be smaller as a WebP image.
  /// Converting fails if the source isn't a valid PNG or JPEG image or
  /// `cwebp` fails to encode it.
  ///
  /// [outputPath] is only written to if the image is converted,
  /// and never contains a partially written image.
  Future<WebpConversionResult> convert(
    String sourcePath,
    String outputPath,
  ) async {
    final info = SourceImageInfo.readFile(sourcePath);
    if (info == null) {
      return const WebpFailed('it isn\'t a valid PNG or JPEG image');
    }
    if (info.isAnimated) {
      return const WebpSkipped(.animated);
    }
    final maxWidth = this.maxWidth;
    final resizeWidth = maxWidth != null && info.width > maxWidth
        ? maxWidth
        : null;
    final options = switch (info.format) {
      .png => lossyPng ? _WebpOptions.pngLossy : _WebpOptions.pngLossless,
      .jpeg => _WebpOptions.jpeg,
    };

    final sourceSize = File(sourcePath).lengthSync();

    // Encode to a temporary directory, so an interrupted conversion
    // doesn't leave encoded images next to the source image.
    final tempDirectory = await Directory.systemTemp.createTemp('cwebp');
    try {
      final encodedPath = p.join(tempDirectory.path, 'output.webp');
      final result = await Process.run(cwebp.executablePath, [
        '-quiet',
        ...options.arguments,
        if (resizeWidth != null) ...['-resize', '$resizeWidth', '0'],
        '-o',
        encodedPath,
        // Don't interpret a source path starting with `-` as an option.
        '--',
        sourcePath,
      ]);
      if (result.exitCode != 0) {
        return WebpFailed(
          'cwebp failed to encode it: ${(result.stderr as String).trim()}',
        );
      }

      final outputSize = File(encodedPath).lengthSync();
      if (outputSize >= sourceSize) {
        return const WebpSkipped(.notSmaller);
      }

      await writeFileAtomically(outputPath, File(encodedPath).copy);
      return WebpConverted(
        sourceSize: sourceSize,
        outputSize: outputSize,
        lossless: options.lossless,
        resizedWidth: resizeWidth == null
            ? null
            : (from: info.width, to: resizeWidth),
      );
    } finally {
      await tempDirectory.delete(recursive: true);
    }
  }
}
