// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'header_metadata.dart';

/// The visual regression status of a compared screenshot.
enum DiffStatus {
  /// The screenshot exists in both baseline and current, and differences
  /// were detected.
  changed,

  /// The screenshot only exists in the current build (new route or viewport).
  added,

  /// The screenshot only exists in the baseline build (deleted route).
  removed,

  /// The screenshot exists in both baseline and current with zero or
  /// sub-threshold differences.
  unchanged;

  /// Creates a [DiffStatus] from its string name.
  static DiffStatus fromString(String value) => switch (value) {
    'changed' => DiffStatus.changed,
    'added' => DiffStatus.added,
    'removed' => DiffStatus.removed,
    _ => DiffStatus.unchanged,
  };
}

/// The bounding box coordinates encompassing all detected pixel differences.
@immutable
final class DiffBoundingBox {
  final int minX;
  final int minY;
  final int maxX;
  final int maxY;

  const DiffBoundingBox({
    required this.minX,
    required this.minY,
    required this.maxX,
    required this.maxY,
  });

  int get width => maxX - minX + 1;
  int get height => maxY - minY + 1;

  Map<String, dynamic> toJson() => {
    'minX': minX,
    'minY': minY,
    'maxX': maxX,
    'maxY': maxY,
    'width': width,
    'height': height,
  };

  factory DiffBoundingBox.fromJson(Map<String, dynamic> json) =>
      DiffBoundingBox(
        minX: json['minX'] as int? ?? 0,
        minY: json['minY'] as int? ?? 0,
        maxX: json['maxX'] as int? ?? 0,
        maxY: json['maxY'] as int? ?? 0,
      );
}

/// An individual screenshot comparison entry between baseline and current.
@immutable
final class DiffEntry {
  /// Unique identifier, e.g. `reference__flutter-cli@desktop`.
  final String id;

  /// The route path represented, e.g. `/reference/flutter-cli`.
  final String route;

  /// The viewport name, e.g. `desktop` or `mobile`.
  final String viewport;

  /// The filename of the screenshot, e.g. `reference__flutter-cli@desktop.png`.
  final String filename;

  /// The visual regression status.
  final DiffStatus status;

  /// The percentage of differing pixels (0.0 to 100.0).
  final double diffPercentage;

  /// The total number of differing pixels.
  final int diffPixels;

  /// The total number of compared pixels (width * height).
  final int totalPixels;

  /// The width in pixels.
  final int width;

  /// The height in pixels.
  final int height;

  /// Relative path to baseline PNG, e.g. `baseline/404@desktop.png`.
  final String? baselineRelativePath;

  /// Relative path to current PNG, e.g. `current/404@desktop.png`.
  final String? currentRelativePath;

  /// Relative path to diff PNG, e.g. `diff/404@desktop.png`.
  final String? diffRelativePath;

  /// Bounding box of all detected changes.
  final DiffBoundingBox? boundingBox;

  /// Captured HTML header metadata for the current build.
  final HeaderMetadata? currentMetadata;

  /// Captured HTML header metadata for the baseline build.
  final HeaderMetadata? baselineMetadata;

  /// Diff summary of header metadata between baseline and current.
  final HeaderDiff? headerDiff;

  const DiffEntry({
    required this.id,
    required this.route,
    required this.viewport,
    required this.filename,
    required this.status,
    required this.diffPercentage,
    required this.diffPixels,
    required this.totalPixels,
    required this.width,
    required this.height,
    this.baselineRelativePath,
    this.currentRelativePath,
    this.diffRelativePath,
    this.boundingBox,
    this.currentMetadata,
    this.baselineMetadata,
    this.headerDiff,
  });

  /// Whether any visual or header metadata differences were detected.
  bool get hasDiff => status == DiffStatus.changed || hasHeaderDiff;

  /// Whether header metadata (title, canonical, or meta tags) has differences.
  bool get hasHeaderDiff => headerDiff?.hasDiff ?? false;

  Map<String, dynamic> toJson() => {
    'id': id,
    'route': route,
    'viewport': viewport,
    'filename': filename,
    'status': status.name,
    'diffPercentage': diffPercentage,
    'diffPixels': diffPixels,
    'totalPixels': totalPixels,
    'width': width,
    'height': height,
    'baselineRelativePath': baselineRelativePath,
    'currentRelativePath': currentRelativePath,
    'diffRelativePath': diffRelativePath,
    if (boundingBox != null) 'boundingBox': boundingBox!.toJson(),
    if (currentMetadata != null) 'currentMetadata': currentMetadata!.toJson(),
    if (baselineMetadata != null)
      'baselineMetadata': baselineMetadata!.toJson(),
    if (headerDiff != null) 'headerDiff': headerDiff!.toJson(),
  };

  factory DiffEntry.fromJson(Map<String, dynamic> json) => DiffEntry(
    id: json['id'] as String,
    route: json['route'] as String,
    viewport: json['viewport'] as String,
    filename: json['filename'] as String,
    status: DiffStatus.fromString(json['status'] as String? ?? 'unchanged'),
    diffPercentage: (json['diffPercentage'] as num?)?.toDouble() ?? 0.0,
    diffPixels: json['diffPixels'] as int? ?? 0,
    totalPixels: json['totalPixels'] as int? ?? 0,
    width: json['width'] as int? ?? 0,
    height: json['height'] as int? ?? 0,
    baselineRelativePath: json['baselineRelativePath'] as String?,
    currentRelativePath: json['currentRelativePath'] as String?,
    diffRelativePath: json['diffRelativePath'] as String?,
    boundingBox: json['boundingBox'] != null
        ? DiffBoundingBox.fromJson(
            json['boundingBox'] as Map<String, dynamic>,
          )
        : null,
    currentMetadata: json['currentMetadata'] != null
        ? HeaderMetadata.fromJson(
            json['currentMetadata'] as Map<String, dynamic>,
          )
        : null,
    baselineMetadata: json['baselineMetadata'] != null
        ? HeaderMetadata.fromJson(
            json['baselineMetadata'] as Map<String, dynamic>,
          )
        : null,
    headerDiff: json['headerDiff'] != null
        ? HeaderDiff.fromJson(json['headerDiff'] as Map<String, dynamic>)
        : null,
  );
}
