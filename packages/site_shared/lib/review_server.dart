// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Server-only helper for mounting the same-origin `/__dash_review/api/*`
/// local review proxy middleware on Jaspr `ServerApp`.
library;

import 'package:review_comments_jaspr/server.dart' as jaspr_review_server;

import 'src/review/review_config.dart';

/// Registers the same-origin `/__dash_review/api/*` proxy middleware on Jaspr's
/// `ServerApp` when `DASH_REVIEW_MODE=local` (and `PRODUCTION=false`).
void registerDashReviewServerMiddleware() {
  if (!ReviewConfig.isEnabled || ReviewConfig.mode != 'local') {
    return;
  }
  const env = ReviewEnvironment.fromEnvironment();
  jaspr_review_server.registerReviewLocalProxyMiddleware(
    config: env.toCoreConfig(
      feedbackFile: defaultDashFeedbackFile,
      cliResolveCommand: defaultDashResolveCommand,
    ),
  );
}
