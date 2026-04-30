// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:path/path.dart' as path;

/// The sites maintained in this repository.
enum Site {
  /// The Flutter documentation site.
  docs;

  String get directory => path.join('sites', name);
}
