// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'analytics.dart';

/// Server implementation of [Analytics].
///
/// Don't use directly. Access through [analytics] instead.
@internal
final class AnalyticsImplementation extends Analytics {
  @override
  void sendEvent(String eventName, Map<String, Object?> parameters) {
    // Ignore on the server.
  }
}
