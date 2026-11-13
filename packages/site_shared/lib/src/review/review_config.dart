// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr_content/jaspr_content.dart';

import '../../util.dart';

/// Compile-time configuration for the visual review and PR comment overlay.
///
/// Controlled strictly via `--dart-define` flags so that production deployments
/// (`PRODUCTION=true`) and standard CI builds (`DASH_REVIEW_MODE` unset)
/// never emit review overlay markup or scripts.
abstract final class ReviewConfig {
  /// The active review mode (`'local'` or `'preview'`), or empty when disabled.
  static const String mode = String.fromEnvironment('DASH_REVIEW_MODE');

  /// The explicit site identifier (`'docs'` or `'www'`), if provided.
  static const String site = String.fromEnvironment('DASH_REVIEW_SITE');

  /// The loopback port for the local review sync server (e.g. `'4099'`).
  static const String serverPort = String.fromEnvironment(
    'DASH_REVIEW_SERVER_PORT',
  );

  /// The GitHub pull request number for staged PR previews.
  static const String prNumber = String.fromEnvironment(
    'DASH_REVIEW_PR_NUMBER',
  );

  /// The GitHub `owner/repo` slug used in preview mode.
  static const String repo = String.fromEnvironment(
    'DASH_REVIEW_REPO',
    defaultValue: 'flutter/website',
  );

  /// The Git commit SHA associated with the staged PR preview.
  static const String commitSha = String.fromEnvironment(
    'DASH_REVIEW_COMMIT_SHA',
  );

  /// The head branch name associated with the staged PR preview.
  static const String headBranch = String.fromEnvironment(
    'DASH_REVIEW_HEAD_BRANCH',
  );

  /// Whether the visual review overlay is enabled for the current build.
  ///
  /// Always returns `false` when [productionBuild] is `true` or when [mode]
  /// is anything other than `'local'` or `'preview'`.
  static bool get isEnabled =>
      !productionBuild && (mode == 'local' || mode == 'preview');

  /// Returns the loopback origin URL when [serverPort] is configured.
  static String get serverOrigin {
    final trimmedPort = serverPort.trim();
    return trimmedPort.isNotEmpty ? 'http://127.0.0.1:$trimmedPort' : '';
  }
}

/// Immutable snapshot of review environment settings.
///
/// Defaults to compile-time values from [ReviewConfig] via
/// [ReviewEnvironment.fromEnvironment], while allowing explicit overrides in
/// unit tests.
final class ReviewEnvironment {
  /// Creates a [ReviewEnvironment] with explicit values.
  const ReviewEnvironment({
    this.mode = '',
    this.isProduction = false,
    this.site = '',
    this.serverPort = '',
    this.prNumber = '',
    this.repo = 'flutter/website',
    this.commitSha = '',
    this.headBranch = '',
  });

  /// Creates a [ReviewEnvironment] backed by [ReviewConfig] `--dart-define`s.
  const ReviewEnvironment.fromEnvironment()
    : mode = ReviewConfig.mode,
      isProduction = productionBuild,
      site = ReviewConfig.site,
      serverPort = ReviewConfig.serverPort,
      prNumber = ReviewConfig.prNumber,
      repo = ReviewConfig.repo,
      commitSha = ReviewConfig.commitSha,
      headBranch = ReviewConfig.headBranch;

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
  String get effectiveRepo {
    final trimmed = repo.trim();
    return trimmed.isNotEmpty ? trimmed : 'flutter/website';
  }

  /// The loopback HTTP origin for the local review sync server, if configured.
  String get serverOrigin {
    final trimmedPort = serverPort.trim();
    return trimmedPort.isNotEmpty ? 'http://127.0.0.1:$trimmedPort' : '';
  }
}

/// Resolves the repository-relative source file path for a rendered page.
///
/// Prefers an explicit non-empty `sourceFile` entry in [pageData], otherwise
/// joins [contentRootPrefix] and [pagePath] using clean POSIX slashes.
String resolveReviewSourceFile({
  required Map<String, Object?> pageData,
  required String pagePath,
  required String contentRootPrefix,
}) {
  if (pageData['sourceFile'] case final String explicitSource
      when explicitSource.trim().isNotEmpty) {
    return _normalizeRepoRelativePath(explicitSource);
  }

  final cleanPath = _normalizeRepoRelativePath(pagePath);
  if (cleanPath.isEmpty) {
    return '';
  }

  final cleanPrefix = _normalizeRepoRelativePath(contentRootPrefix);
  if (cleanPrefix.isEmpty ||
      cleanPath == cleanPrefix ||
      cleanPath.startsWith('$cleanPrefix/')) {
    return cleanPath;
  }

  return '$cleanPrefix/$cleanPath';
}

/// Builds the serializable per-page configuration payload consumed by the
/// client review overlay script.
Map<String, Object?> buildReviewPageConfigMap(
  Page page, {
  required String defaultSite,
  required String contentRootPrefix,
  ReviewEnvironment environment = const ReviewEnvironment.fromEnvironment(),
}) {
  final pageData = page.data.page;
  final siteData = page.data.site;
  final rawTitle = pageData['title'] ?? siteData['title'];
  final pageTitle = rawTitle is String ? rawTitle.trim() : '';

  final configuredSite = environment.site.trim();
  final effectiveSite = configuredSite.isNotEmpty
      ? configuredSite
      : defaultSite.trim();

  final sourceFile = resolveReviewSourceFile(
    pageData: pageData,
    pagePath: page.path,
    contentRootPrefix: contentRootPrefix,
  );

  return <String, Object?>{
    'mode': environment.mode,
    'site': effectiveSite,
    'pageUrl': page.url,
    'pageTitle': pageTitle,
    'sourceFile': sourceFile,
    'serverOrigin': environment.serverOrigin,
    'prNumber': environment.prNumber.trim(),
    'repo': environment.effectiveRepo,
    'commitSha': environment.commitSha.trim(),
    'headBranch': environment.headBranch.trim(),
  };
}

/// Encodes [data] as JSON safe for embedding inside an HTML `<script>` tag.
///
/// Escapes `</` as `<\/` and `<!--` as `\u003c!--` so untrusted or arbitrary
/// page titles, URLs, or metadata can never break out of `<script>`.
String encodeReviewJsonForHtml(Map<String, Object?> data) =>
    jsonEncode(data).replaceAll('</', r'<\/').replaceAll('<!--', r'\u003c!--');

String _normalizeRepoRelativePath(String rawPath) {
  var normalized = rawPath.trim().replaceAll(r'\', '/');
  while (normalized.startsWith('./')) {
    normalized = normalized.substring(2);
  }
  while (normalized.startsWith('/')) {
    normalized = normalized.substring(1);
  }
  while (normalized.endsWith('/')) {
    normalized = normalized.substring(0, normalized.length - 1);
  }
  return normalized;
}
