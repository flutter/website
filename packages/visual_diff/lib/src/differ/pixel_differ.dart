// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:image/image.dart' as img;
import 'package:meta/meta.dart';

import '../models/diff_entry.dart';

/// The result of a pixel-by-pixel comparison between two images.
@immutable
final class PixelDiffResult {
  /// The total number of differing pixels detected.
  final int diffPixels;

  /// The total number of pixels evaluated (`max(width) * max(height)`).
  final int totalPixels;

  /// The percentage of differing pixels (0.0 to 100.0).
  final double diffPercentage;

  /// The generated visual diff image highlighting differences.
  /// Null if [diffPixels] is 0.
  final img.Image? diffImage;

  /// The bounding box encompassing all differences, if any.
  final DiffBoundingBox? boundingBox;

  const PixelDiffResult({
    required this.diffPixels,
    required this.totalPixels,
    required this.diffPercentage,
    this.diffImage,
    this.boundingBox,
  });

  bool get hasDiff => diffPixels > 0;
}

/// Pure Dart pixel comparison engine.
///
/// Compares two images using normalized perceptual RGBA Euclidean distance,
/// detects dimension shifts, and renders a high-contrast diff mask with
/// context-preserving dimmed background.
final class PixelDiffer {
  /// Color distance threshold (0.0 to 1.0) above which two pixels
  /// are considered different.
  final double threshold;

  /// Minimum number of differing pixels required to flag an image as changed.
  /// Differences with fewer than [minDiffPixels] pixels are treated as equal.
  final int minDiffPixels;

  /// Diff highlight color components in RGBA.
  final int highlightR;
  final int highlightG;
  final int highlightB;
  final int highlightA;

  const PixelDiffer({
    this.threshold = 0.08,
    this.minDiffPixels = 10,
    this.highlightR = 255,
    this.highlightG = 0,
    this.highlightB = 122,
    this.highlightA = 255,
  });

  /// Compares [baseline] and [current] images.
  PixelDiffResult compare(img.Image baseline, img.Image current) {
    final width = math.max(baseline.width, current.width);
    final height = math.max(baseline.height, current.height);
    final totalPixels = width * height;

    if (totalPixels == 0) {
      return const PixelDiffResult(
        diffPixels: 0,
        totalPixels: 0,
        diffPercentage: 0.0,
      );
    }

    var diffPixels = 0;
    var minX = width;
    var minY = height;
    var maxX = -1;
    var maxY = -1;

    // Precompute threshold squared for fast distance comparison.
    // Normalized maximum possible squared distance in RGBA is 4 * (255^2).
    const maxDistanceSquared = 4.0 * 255.0 * 255.0;
    final thresholdDistanceSquared = threshold * threshold * maxDistanceSquared;

    // Fast pass: evaluate pixel differences without allocating diff image.
    for (var y = 0; y < height; y++) {
      final inBaselineY = y < baseline.height;
      final inCurrentY = y < current.height;

      for (var x = 0; x < width; x++) {
        final inBaselineX = inBaselineY && x < baseline.width;
        final inCurrentX = inCurrentY && x < current.width;

        if (inBaselineX && inCurrentX) {
          final p1 = baseline.getPixel(x, y);
          final p2 = current.getPixel(x, y);

          // Fast-path: exact color equality skips distance calculation.
          if (p1.r == p2.r && p1.g == p2.g && p1.b == p2.b && p1.a == p2.a) {
            continue;
          }

          final dr = p1.r - p2.r;
          final dg = p1.g - p2.g;
          final db = p1.b - p2.b;
          final da = p1.a - p2.a;

          final distSquared = (dr * dr) + (dg * dg) + (db * db) + (da * da);

          if (distSquared > thresholdDistanceSquared) {
            diffPixels++;
            if (x < minX) minX = x;
            if (x > maxX) maxX = x;
            if (y < minY) minY = y;
            if (y > maxY) maxY = y;
          }
        } else {
          // Pixel exists in one image but not the other (dimension shift).
          diffPixels++;
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    }

    if (diffPixels < minDiffPixels) {
      return PixelDiffResult(
        diffPixels: 0,
        totalPixels: totalPixels,
        diffPercentage: 0.0,
      );
    }

    // Second pass: only allocate and render diff mask if differences exist.
    final diffImg = img.Image(width: width, height: height);

    for (var y = 0; y < height; y++) {
      final inBaselineY = y < baseline.height;
      final inCurrentY = y < current.height;

      for (var x = 0; x < width; x++) {
        final inBaselineX = inBaselineY && x < baseline.width;
        final inCurrentX = inCurrentY && x < current.width;

        if (inBaselineX && inCurrentX) {
          final p1 = baseline.getPixel(x, y);
          final p2 = current.getPixel(x, y);

          final isIdentical =
              p1.r == p2.r && p1.g == p2.g && p1.b == p2.b && p1.a == p2.a;

          final bool isDiff;
          if (isIdentical) {
            isDiff = false;
          } else {
            final dr = p1.r - p2.r;
            final dg = p1.g - p2.g;
            final db = p1.b - p2.b;
            final da = p1.a - p2.a;
            final distSquared = (dr * dr) + (dg * dg) + (db * db) + (da * da);
            isDiff = distSquared > thresholdDistanceSquared;
          }

          if (isDiff) {
            diffImg.setPixelRgba(
              x,
              y,
              highlightR,
              highlightG,
              highlightB,
              highlightA,
            );
          } else {
            // Unchanged pixel: render a subtle dimmed grayscale version.
            final gray = ((0.299 * p1.r) + (0.587 * p1.g) + (0.114 * p1.b))
                .round();
            final dimmed = ((gray * 0.45) + 130).clamp(0, 255).toInt();
            diffImg.setPixelRgba(x, y, dimmed, dimmed, dimmed, 180);
          }
        } else {
          // Dimension shift.
          diffImg.setPixelRgba(
            x,
            y,
            highlightR,
            highlightG,
            highlightB,
            highlightA,
          );
        }
      }
    }

    final diffPercentage = (diffPixels / totalPixels) * 100.0;
    final boundingBox = DiffBoundingBox(
      minX: minX,
      minY: minY,
      maxX: maxX,
      maxY: maxY,
    );

    return PixelDiffResult(
      diffPixels: diffPixels,
      totalPixels: totalPixels,
      diffPercentage: diffPercentage,
      diffImage: diffImg,
      boundingBox: boundingBox,
    );
  }
}
