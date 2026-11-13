// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:review_comments_cli/review_comments_cli.dart' as cli;

import '../review_source_locator.dart';
import '../sites.dart';
import '../utils.dart';

/// CLI command for inspecting, exporting, resolving, and clearing local visual
/// review comments stored in `.dash_review/` via `package:review_comments_cli`.
extension type ReviewCommand._(cli.ReviewCommand _command)
    implements cli.ReviewCommand, Command<int> {
  ReviewCommand({String? repoRoot, StringSink? out, StringSink? err})
    : _command = cli.ReviewCommand(
        repoRoot: repoRoot ?? repositoryRoot,
        config: dashWebsiteReviewConfig,
        allowedSites: [for (final site in Site.values) site.name],
        out: out,
        err: err,
      );
}
