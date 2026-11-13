// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';
import 'package:review_comments_core/review_comments_core.dart' as core;
import 'package:review_comments_jaspr/review_comments_jaspr.dart'
    as jaspr_review;

import '../../util.dart';

export 'package:review_comments_core/review_comments_core.dart'
    show encodeReviewJsonForHtml;

/// Default GitHub repository slug for Flutter website PR previews.
const String defaultDashReviewRepo = 'flutter/website';

/// Default local feedback Markdown file path used across `flutter/website`.
const String defaultDashFeedbackFile = '.dash_review/feedback.md';

/// Default CLI command used to mark local review comments resolved.
const String defaultDashResolveCommand = 'dart run dash_site review resolve';

const core.ReviewConfig _dashCoreEnv = core.ReviewConfig.fromEnvironment(
  defaultRepo: defaultDashReviewRepo,
  feedbackFile: defaultDashFeedbackFile,
  cliResolveCommand: defaultDashResolveCommand,
);

/// Compile-time configuration for the visual review and PR comment overlay.
///
/// Delegates to [core.ReviewConfig] from `package:review_comments_core` while
/// preserving static accessors for Dash site layouts and tests.
abstract final class ReviewConfig {
  /// The active review mode (`'local'` or `'preview'`), or empty when disabled.
  static String get mode => _dashCoreEnv.mode;

  /// The explicit site identifier (`'docs'` or `'www'`), if provided.
  static String get site => _dashCoreEnv.site;

  /// The loopback port for the local review sync server (e.g. `'4099'`).
  static String get serverPort => _dashCoreEnv.serverPort;

  /// The GitHub pull request number for staged PR previews.
  static String get prNumber => _dashCoreEnv.prNumber;

  /// The GitHub `owner/repo` slug used in preview mode.
  static String get repo => _dashCoreEnv.effectiveRepo(defaultDashReviewRepo);

  /// The Git commit SHA associated with the staged PR preview.
  static String get commitSha => _dashCoreEnv.commitSha;

  /// The head branch name associated with the staged PR preview.
  static String get headBranch => _dashCoreEnv.headBranch;

  /// Whether the visual review overlay is enabled for the current build.
  static bool get isEnabled => !productionBuild && _dashCoreEnv.isEnabled;

  /// Returns the loopback origin URL when [serverPort] is configured.
  static String get serverOrigin => _dashCoreEnv.serverOrigin;
}

/// Immutable snapshot of review environment settings backed by
/// [core.ReviewConfig].
final class ReviewEnvironment {
  /// Creates a [ReviewEnvironment] with explicit values.
  const ReviewEnvironment({
    this.mode = '',
    this.isProduction = false,
    this.site = '',
    this.serverPort = '',
    this.prNumber = '',
    this.repo = defaultDashReviewRepo,
    this.commitSha = '',
    this.headBranch = '',
  });

  /// Creates a [ReviewEnvironment] backed by compile-time `--dart-define`s.
  const ReviewEnvironment.fromEnvironment()
    : mode = _envMode,
      isProduction = productionBuild,
      site = _envSite,
      serverPort = _envServerPort,
      prNumber = _envPrNumber,
      repo = _envRepo,
      commitSha = _envCommitSha,
      headBranch = _envHeadBranch;

  static const String _envMode =
      String.fromEnvironment('REVIEW_COMMENTS_MODE') != ''
      ? String.fromEnvironment('REVIEW_COMMENTS_MODE')
      : String.fromEnvironment('DASH_REVIEW_MODE');
  static const String _envSite =
      String.fromEnvironment('REVIEW_COMMENTS_SITE') != ''
      ? String.fromEnvironment('REVIEW_COMMENTS_SITE')
      : String.fromEnvironment('DASH_REVIEW_SITE');
  static const String _envServerPort =
      String.fromEnvironment('REVIEW_COMMENTS_SERVER_PORT') != ''
      ? String.fromEnvironment('REVIEW_COMMENTS_SERVER_PORT')
      : String.fromEnvironment('DASH_REVIEW_SERVER_PORT');
  static const String _envPrNumber =
      String.fromEnvironment('REVIEW_COMMENTS_PR_NUMBER') != ''
      ? String.fromEnvironment('REVIEW_COMMENTS_PR_NUMBER')
      : String.fromEnvironment('DASH_REVIEW_PR_NUMBER');
  static const String _envRepo =
      String.fromEnvironment('REVIEW_COMMENTS_REPO') != ''
      ? String.fromEnvironment('REVIEW_COMMENTS_REPO')
      : String.fromEnvironment(
          'DASH_REVIEW_REPO',
          defaultValue: defaultDashReviewRepo,
        );
  static const String _envCommitSha =
      String.fromEnvironment('REVIEW_COMMENTS_COMMIT_SHA') != ''
      ? String.fromEnvironment('REVIEW_COMMENTS_COMMIT_SHA')
      : String.fromEnvironment('DASH_REVIEW_COMMIT_SHA');
  static const String _envHeadBranch =
      String.fromEnvironment('REVIEW_COMMENTS_HEAD_BRANCH') != ''
      ? String.fromEnvironment('REVIEW_COMMENTS_HEAD_BRANCH')
      : String.fromEnvironment('DASH_REVIEW_HEAD_BRANCH');

  /// The configured review mode (`'local'`, `'preview'`, or empty).
  final String mode;

  /// Whether `PRODUCTION=true` is active.
  final bool isProduction;

  /// The configured site identifier (`'docs'` or `'www'`).
  final String site;

  /// The configured local review server port.
  final String serverPort;

  /// The configured pull request number.
  final String prNumber;

  /// The configured GitHub repository (`owner/repo`).
  final String repo;

  /// The configured head commit SHA.
  final String commitSha;

  /// The configured head branch name.
  final String headBranch;

  /// Hard safety gate ensuring production and non-review builds stay clean.
  bool get isEnabled => !isProduction && (mode == 'local' || mode == 'preview');

  /// The normalized repository slug, falling back to `'flutter/website'`.
  String get effectiveRepo => toCoreConfig().effectiveRepo(
    defaultDashReviewRepo,
  );

  /// The loopback HTTP origin for the local review sync server, if configured.
  String get serverOrigin => toCoreConfig().serverOrigin;

  /// Converts this snapshot into a [core.ReviewConfig].
  core.ReviewConfig toCoreConfig({
    String feedbackFile = '',
    String cliResolveCommand = '',
  }) => core.ReviewConfig(
    mode: mode,
    productionBuild: isProduction,
    site: site,
    serverPort: serverPort,
    prNumber: prNumber,
    repo: repo.trim().isNotEmpty ? repo.trim() : defaultDashReviewRepo,
    commitSha: commitSha,
    headBranch: headBranch,
    feedbackFile: feedbackFile,
    cliResolveCommand: cliResolveCommand,
  );
}

/// Resolves the repository-relative source file path for a rendered page via
/// [core.normalizeReviewSourceFile].
String resolveReviewSourceFile({
  required Map<String, Object?> pageData,
  required String pagePath,
  required String contentRootPrefix,
}) => core.normalizeReviewSourceFile(
  contentRootPrefix,
  pagePath,
  explicitSourceFile: pageData['sourceFile'] is String
      ? pageData['sourceFile'] as String
      : null,
);

/// Builds the serializable per-page configuration payload consumed by the
/// client review overlay script via [jaspr_review.buildReviewPageConfigMap].
Map<String, Object?> buildReviewPageConfigMap(
  Page page, {
  required String defaultSite,
  required String contentRootPrefix,
  ReviewEnvironment environment = const ReviewEnvironment.fromEnvironment(),
  String feedbackFile = '',
  String cliResolveCommand = '',
}) => jaspr_review.buildReviewPageConfigMap(
  page,
  defaultSite: defaultSite,
  contentRootPrefix: contentRootPrefix,
  defaultRepo: defaultDashReviewRepo,
  config: environment.toCoreConfig(
    feedbackFile: feedbackFile,
    cliResolveCommand: cliResolveCommand,
  ),
  feedbackFile: feedbackFile,
  cliResolveCommand: cliResolveCommand,
);
