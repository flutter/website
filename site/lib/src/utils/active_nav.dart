// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

ActiveNavEntry activeNavEntry(String pageUrlPath) {
  if (pageUrlPath.startsWith('/learn/pathway')) {
    return ActiveNavEntry.learn;
  }

  return ActiveNavEntry.home;
}

enum ActiveNavEntry {
  home,
  learn,
  // reference,
}
