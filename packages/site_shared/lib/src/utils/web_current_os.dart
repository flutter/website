// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Utilities for detecting the platform a user's web browser is running on.
library;

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

/// An operating system that a user's web browser can run on.
enum OperatingSystem {
  windows(id: 'windows', label: 'Windows'),
  macOS(id: 'macos', label: 'macOS'),
  linux(id: 'linux', label: 'Linux'),
  chromeOS(id: 'chromeos', label: 'ChromeOS');

  const OperatingSystem({required this.id, required this.label});

  /// All-lowercase identifier for the operating system.
  final String id;

  /// Human-readable name of the operating system.
  final String label;
}

/// The [OperatingSystem] reported by the current web browser,
/// determined from its user agent string.
///
/// Is `null` if the operating system can't be determined or
/// when not running on the web (such as during server-side rendering).
OperatingSystem? get browserOperatingSystem {
  // The browser user agent is only available when running on the web.
  if (!kIsWeb) return null;

  final userAgent = web.window.navigator.userAgent;
  if (userAgent.contains('Mac')) {
    // macOS or iPhone.
    return .macOS;
  }

  if (userAgent.contains('Win')) {
    // Windows.
    return .windows;
  }

  if ((userAgent.contains('Linux') || userAgent.contains('X11')) &&
      !userAgent.contains('Android')) {
    // Linux, but not Android.
    return .linux;
  }

  if (userAgent.contains('CrOS')) {
    // ChromeOS.
    return .chromeOS;
  }

  // Any other, undetermined operating system.
  return null;
}
