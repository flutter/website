// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'analytics_server.dart'
    if (dart.library.js_interop) 'analytics_web.dart';

/// Used to report analytic events.
final analytics = AnalyticsImplementation();

/// Contains methods for reporting analytics events.
abstract class Analytics {
  @internal
  void sendEvent(String eventName, Map<String, Object?> parameters);

  void sendFeedback(bool helpful) {
    sendEvent('feedback', {'feedback_type': helpful ? 'up' : 'down'});
  }
}
