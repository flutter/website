// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:review_comments_jaspr/review_comments_jaspr.dart'
    as jaspr_review;

import 'review_config.dart';

/// Builds the `<script>` components required to mount the visual review overlay
/// on [page] by delegating to `package:review_comments_jaspr`.
List<Component> buildReviewOverlayComponents(
  Page page, {
  required String defaultSite,
  required String contentRootPrefix,
  ReviewEnvironment? environment,
}) {
  final effectiveEnv = environment ?? const ReviewEnvironment.fromEnvironment();
  if (environment == null ? !ReviewConfig.isEnabled : !effectiveEnv.isEnabled) {
    return const [];
  }

  return jaspr_review.buildReviewOverlayComponents(
    page,
    defaultSite: defaultSite,
    contentRootPrefix: contentRootPrefix,
    defaultRepo: defaultDashReviewRepo,
    config: effectiveEnv.toCoreConfig(
      feedbackFile: defaultDashFeedbackFile,
      cliResolveCommand: defaultDashResolveCommand,
    ),
    feedbackFile: defaultDashFeedbackFile,
    cliResolveCommand: defaultDashResolveCommand,
  );
}
