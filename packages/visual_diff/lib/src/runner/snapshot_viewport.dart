// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

/// Configuration for a viewport used when capturing screenshot snapshots.
@immutable
final class SnapshotViewport {
  /// Identifier, e.g. `desktop` or `mobile`.
  final String name;

  /// Viewport width in CSS pixels.
  final int width;

  /// Viewport height in CSS pixels.
  final int height;

  /// Device pixel ratio scale factor.
  final num deviceScaleFactor;

  /// Whether this viewport simulates a mobile device.
  final bool isMobile;

  /// Whether touch events are enabled.
  final bool hasTouch;

  const SnapshotViewport({
    required this.name,
    required this.width,
    required this.height,
    this.deviceScaleFactor = 1,
    this.isMobile = false,
    this.hasTouch = false,
  });

  static const SnapshotViewport desktop = SnapshotViewport(
    name: 'desktop',
    width: 1280,
    height: 800,
  );

  static const SnapshotViewport mobile = SnapshotViewport(
    name: 'mobile',
    width: 375,
    height: 667,
    isMobile: true,
    hasTouch: true,
  );

  static const List<SnapshotViewport> all = [desktop, mobile];
}
