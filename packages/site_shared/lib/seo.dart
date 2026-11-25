// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Server-side SEO utilities for `robots.txt` and Git `<lastmod>` metadata.
library;

export 'src/loaders/last_modified.dart'
    show
        GitLastModifiedIndex,
        LastModifiedLoader,
        isNoIndexFlag,
        loadProjectLastModifiedDates;
export 'src/pages/robots_txt.dart' show RobotsTxtOutput;
