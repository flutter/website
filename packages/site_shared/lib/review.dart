// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Visual review and staged PR comment overlay shared across Dash sites,
/// delegating to `package:review_comments_core` and
/// `package:review_comments_jaspr`.
library;

export 'package:review_comments_core/review_comments_core.dart'
    show
        buildReviewClientScript,
        encodeReviewJsonForHtml,
        reviewOverlayClientScript,
        reviewOverlayStyles;

export 'src/review/review_config.dart';
export 'src/review/review_overlay.dart';
