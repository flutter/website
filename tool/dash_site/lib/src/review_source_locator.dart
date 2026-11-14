// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:review_comments/cli.dart' as cli;

export 'package:review_comments/cli.dart'
    show SourceLocationResult, sanitizeRepoRelativePath;

/// Shared `flutter/website` (`docs` + `www`) configuration preset for
/// `package:review_comments_cli`.
final cli.ReviewProjectConfig dashWebsiteReviewConfig =
    cli.ReviewProjectConfig.flutterWebsite();

/// Resolves a highlighted text quote, element text, or heading anchor back to
/// its repository-relative source file and 1-based line range using
/// `package:review_comments_cli`.
cli.SourceLocationResult locateHighlightInRepo({
  required String repoRoot,
  required String site,
  String? sourceFile,
  int? startLine,
  int? endLine,
  String? selectedText,
  String? elementText,
  String? headingAnchor,
  String? selector,
  String? pageUrl,
}) => cli.locateHighlightInRepo(
  repoRoot: repoRoot,
  site: site,
  sourceFile: sourceFile,
  startLine: startLine,
  endLine: endLine,
  selectedText: selectedText,
  elementText: elementText,
  headingAnchor: headingAnchor,
  selector: selector,
  pageUrl: pageUrl,
  config: dashWebsiteReviewConfig,
);
