// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../util.dart';
import 'analytics.dart';

/// Web implementation of [Analytics].
///
/// Don't use directly. Access through [analytics] instead.
@internal
final class AnalyticsImplementation extends Analytics {
  @override
  void sendEvent(String eventName, Map<String, Object?> parameters) {
    if (!productionBuild) {
      return;
    }
    final dataLayer = web.window['dataLayer'];
    if (dataLayer.isA<JSArray>()) {
      (dataLayer as JSArray).toDart.add(
        {
          'event': eventName,
          ...parameters,
        }.jsify(),
      );
    }
  }
}
