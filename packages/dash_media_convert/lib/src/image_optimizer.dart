// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

import 'cwebp.dart';
import 'webp_converter.dart';

/// The file extensions of images that [ImageOptimizer] can optimize.
const Set<String> _optimizableImageExtensions = {'.png', '.jpg', '.jpeg'};

/// Checks that [imagePaths] can be optimized together by
/// [ImageOptimizer.optimizeFiles].
///
/// Returns a description of the first problem found, such as
/// an input that isn't a PNG or JPEG or multiple inputs with
/// the same canonical output path, or `null` if there are none.
///
/// Output paths are compared without case on every platform to
/// reject batches that would collide on case-insensitive file systems.
String? validateImagePaths(List<String> imagePaths) {
  final outputPaths = <String>{};
  for (final imagePath in imagePaths) {
    if (!_optimizableImageExtensions.contains(
      p.extension(imagePath).toLowerCase(),
    )) {
      return '$imagePath isn\'t a PNG or JPEG image.';
    }
    final outputPath = p.canonicalize(_webpPath(imagePath));
    if (!outputPaths.add(outputPath.toLowerCase())) {
      return 'Multiple inputs would write to $outputPath.';
    }
  }
  return null;
}

String _webpPath(String imagePath) => p.setExtension(imagePath, '.webp');

/// The result of optimizing the image at `imagePath`.
///
/// If the image was converted, it was replaced by a WebP image
/// with the same name and a `.webp` extension.
typedef ImageOptimization = ({String imagePath, WebpConversionResult result});

/// Optimizes PNG and JPEG image files in place by
/// converting them to WebP images and deleting the originals.
final class ImageOptimizer {
  ImageOptimizer._(this._converter);

  /// Creates an optimizer that uses the `cwebp` binary that
  /// [Cwebp.resolve] finds or installs.
  ///
  /// Images wider than [maxWidth] are resized to that width.
  /// [lossyPng] enables lossy PNG encoding instead of the lossless default.
  static Future<ImageOptimizer> create({
    int? maxWidth,
    bool lossyPng = false,
  }) async => ImageOptimizer._(
    WebpConverter(
      cwebp: await Cwebp.resolve(),
      maxWidth: maxWidth,
      lossyPng: lossyPng,
    ),
  );

  final WebpConverter _converter;

  /// Optimizes the images at [imagePaths],
  /// running one conversion per processor at a time.
  ///
  /// Each image that's smaller as a WebP image is replaced by
  /// one with the same name and a `.webp` extension.
  /// Returns the results in the same order as [imagePaths].
  ///
  /// Throws an [ArgumentError] before converting any images if
  /// [validateImagePaths] finds a problem with [imagePaths].
  Future<List<ImageOptimization>> optimizeFiles(List<String> imagePaths) async {
    if (validateImagePaths(imagePaths) case final problem?) {
      throw ArgumentError(problem);
    }

    final pool = Pool(Platform.numberOfProcessors);
    try {
      return await [
        for (final imagePath in imagePaths)
          pool.withResource(
            () async =>
                (imagePath: imagePath, result: await _optimizeFile(imagePath)),
          ),
      ].wait;
    } finally {
      await pool.close();
    }
  }

  Future<WebpConversionResult> _optimizeFile(String imagePath) async {
    final outputPath = _webpPath(imagePath);
    try {
      if (File(outputPath).existsSync()) {
        return WebpFailed(
          '${p.basename(outputPath)} already exists next to it',
        );
      }
      final result = await _converter.convert(imagePath, outputPath);
      if (result is WebpConverted) await File(imagePath).delete();
      return result;
    } on IOException catch (e) {
      return WebpFailed('an I/O error occurred: $e');
    }
  }
}
