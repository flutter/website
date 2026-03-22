// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';

ActiveNavEntry activeNavEntry(String pageUrlPath) {
  final firstFragment = pageUrlPath
      .split('/')
      .firstWhereOrNull((fragment) => fragment.isNotEmpty)
      ?.trim()
      .toLowerCase();

  return switch (firstFragment) {
    'learn' || 'tutorial' => ActiveNavEntry.learn,
    _ => ActiveNavEntry.home,
  };
}

enum ActiveNavEntry {
  home,
  learn,
  // reference,
}
