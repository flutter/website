// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'analytics_server.dart'
    if (dart.library.js_interop) 'analytics_web.dart';

/// Used to report analytic events.
final Analytics analytics = AnalyticsImplementation();

/// Used for reporting analytics events.
abstract class Analytics {
  /// Reports an event named [eventName], along with the specified [parameters].
  void sendEvent(String eventName, Map<String, Object?> parameters);

  /// Reports whether the user found the current page [helpful].
  void sendFeedback(bool helpful) {
    sendEvent('feedback', {'feedback_type': helpful ? 'up' : 'down'});
  }
}
