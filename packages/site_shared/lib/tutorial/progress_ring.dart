// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'client/progress_ring.dart';

class ProgressRing extends CustomComponentBase {
  const ProgressRing();

  @override
  Pattern get pattern => RegExp('ProgressRing', caseSensitive: false);

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    final progress = double.tryParse(attributes['progress'] ?? '') ?? 0.0;
    assert(
      progress >= 0.0 && progress <= 1.0,
      'ProgressRing progress must be between 0.0 and 1.0',
    );

    final small = attributes['small'] != null;
    final large = attributes['large'] != null;

    return InteractiveProgressRing(
      progress: progress,
      size: small
          ? 24
          : large
          ? 48
          : 32,
    );
  }
}
