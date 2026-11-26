// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// The browser engine used to capture rendered website snapshots.
enum SnapshotBackend {
  /// Headless Chromium via Puppeteer.
  chrome,

  /// Lightweight Rust-powered headless browser (obscura.sh).
  obscura;

  static SnapshotBackend fromString(String? value) {
    return switch (value?.toLowerCase().trim()) {
      'obscura' => SnapshotBackend.obscura,
      _ => SnapshotBackend.chrome,
    };
  }
}
