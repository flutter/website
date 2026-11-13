// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:review_comments_cli/review_comments_cli.dart' as cli;

import 'review_source_locator.dart';

export 'package:review_comments_cli/review_comments_cli.dart'
    show
        ReviewComment,
        computeCommentCounts,
        defaultReviewServerPort,
        normalizeReviewPageUrl;

/// Repository-relative directory storing local visual review artifacts.
const String reviewDirectoryRelativePath = '.dash_review';

/// Repository-relative path to the structured JSON comment store.
const String reviewCommentsRelativePath = '.dash_review/comments.json';

/// Repository-relative path to the agent-ready Markdown feedback file.
const String reviewFeedbackRelativePath = '.dash_review/feedback.md';

/// Manages atomic persistence of `.dash_review/comments.json` and
/// `.dash_review/feedback.md` via [cli.ReviewCommentStore].
extension type ReviewStore._(cli.ReviewCommentStore _store)
    implements cli.ReviewCommentStore {
  ReviewStore(String repoRoot)
    : _store = cli.ReviewCommentStore(
        repoRoot,
        config: dashWebsiteReviewConfig,
      );
}

/// Local HTTP server bound strictly to `127.0.0.1` that syncs browser visual
/// review highlights and comments with `.dash_review/comments.json` and
/// `.dash_review/feedback.md` via [cli.ReviewLocalServer].
extension type ReviewLocalServer._(cli.ReviewLocalServer _server)
    implements cli.ReviewLocalServer {
  /// Starts the local review server on `127.0.0.1`, trying [preferredPort]
  /// (`4099` by default) first and falling back to an OS-assigned ephemeral
  /// port (`0`) if [preferredPort] is occupied.
  static Future<ReviewLocalServer> start({
    required String repoRoot,
    required String site,
    int preferredPort = cli.defaultReviewServerPort,
  }) async {
    final server = await cli.ReviewLocalServer.start(
      repoRoot: repoRoot,
      site: site,
      preferredPort: preferredPort,
      config: dashWebsiteReviewConfig.copyWith(defaultSite: site),
    );
    return ReviewLocalServer._(server);
  }
}
