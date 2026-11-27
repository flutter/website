// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:github/github.dart' as github;

import 'sites.dart';

/// Marker prefix used to identify staging preview comments.
const previewCommentMarker = '<!-- flutter-preview -->';

/// The deployment and build status of a preview.
enum PreviewStatus {
  pending('⏳ Building'),
  rebuilding('⏳ Rebuilding'),
  ready('✅ Ready'),
  failed('❌ Failed');

  const PreviewStatus(this.label);

  /// Human-readable label with an emoji indicator.
  final String label;
}

/// Staged preview metadata for a single [Site].
final class PreviewEntry {
  const PreviewEntry({required this.status, this.url, required this.commitSha});

  /// The build and deployment status of this preview.
  final PreviewStatus status;

  /// The public staging URL for this preview, if ready.
  final String? url;

  /// The commit SHA for which this preview was built or deployed.
  final String commitSha;

  Map<String, Object?> toJson() => {
    'status': status.name,
    if (url != null) 'url': url,
    'commitSha': commitSha,
  };

  static PreviewEntry? fromJson(Object? json) {
    if (json
        case final Map<String, Object?> map &&
            {
              'status': final String statusName,
              'commitSha': final String commitSha,
            }
        when commitSha.isNotEmpty) {
      final status =
          PreviewStatus.values.asNameMap()[statusName] ?? PreviewStatus.ready;
      final url = map['url'] as String?;
      return PreviewEntry(status: status, url: url, commitSha: commitSha);
    }

    if (json
        case <String, Object?>{
          'url': final String url,
          'commitSha': final String commitSha,
        }
        when url.isNotEmpty && commitSha.isNotEmpty) {
      return PreviewEntry(
        status: PreviewStatus.ready,
        url: url,
        commitSha: commitSha,
      );
    }

    return null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreviewEntry &&
          other.runtimeType == runtimeType &&
          other.status == status &&
          other.url == url &&
          other.commitSha == commitSha;

  @override
  int get hashCode => Object.hash(status, url, commitSha);

  @override
  String toString() =>
      'PreviewEntry(status: $status, url: $url, commitSha: $commitSha)';
}

/// Parses existing [PreviewEntry] values by site from a preview [commentBody].
///
/// Reads machine-readable JSON metadata from the
/// `<!-- flutter-preview-data: ... -->` marker.
Map<Site, PreviewEntry> parsePreviewCommentEntries(String commentBody) {
  final entries = <Site, PreviewEntry>{};

  final dataMatch = RegExp(r'<!--\s*flutter-preview-data:\s*(\{.*?\})\s*-->')
      .firstMatch(commentBody);

  if (dataMatch != null) {
    try {
      final jsonStr = dataMatch.group(1);
      final decoded = jsonDecode(jsonStr!) as Object?;
      if (decoded case final Map<String, Object?> map) {
        final siteMap = Site.values.asNameMap();
        for (final MapEntry(:key, :value) in map.entries) {
          final site = siteMap[key];
          if (site == null) continue;
          final entry = PreviewEntry.fromJson(value);
          if (entry != null) {
            entries[site] = entry;
          }
        }
      }
    } catch (_) {
      // Ignore malformed JSON metadata.
    }
  }

  return entries;
}

/// Generates the Markdown body for the combined staging preview comment.
///
/// Formats a table dashboard with status emojis, preview links, and commit
/// links for all staged sites.
String buildPreviewCommentBody(
  Map<Site, PreviewEntry> previews, {
  String? repoFullName,
}) {
  final buffer = StringBuffer();
  buffer.writeln(previewCommentMarker);

  final data = {
    for (final MapEntry(:key, :value) in previews.entries)
      key.name: value.toJson(),
  };
  buffer.writeln('<!-- flutter-preview-data: ${jsonEncode(data)} -->');
  buffer.writeln('### 🚀 Staged Previews');
  buffer.writeln();
  buffer.writeln('| Site | Status | Preview Link | Commit |');
  buffer.writeln('| :--- | :--- | :--- | :--- |');

  final sortedSites = previews.keys.toList()
    ..sort((a, b) => a.index.compareTo(b.index));

  for (final site in sortedSites) {
    final entry = previews[site]!;
    final shortSha = entry.commitSha.length > 7
        ? entry.commitSha.substring(0, 7)
        : entry.commitSha;

    final commitDisplay = repoFullName != null
        ? '[`$shortSha`](https://github.com/$repoFullName/commit/${entry.commitSha})'
        : '`$shortSha`';

    final previewLink = switch (entry.status) {
      _ when entry.url != null => '[Visit Preview ↗](${entry.url})',
      PreviewStatus.pending || PreviewStatus.rebuilding => '_Deploying..._',
      PreviewStatus.failed => '_Failed_',
      _ => '—',
    };

    buffer.writeln(
      '| **${site.host}** | ${entry.status.label} | '
      '$previewLink | $commitDisplay |',
    );
  }

  return buffer.toString().trimRight();
}

/// Finds an existing preview comment on [issueNumber], if present.
Future<github.IssueComment?> findExistingPreviewComment({
  required github.GitHub gitHub,
  required github.RepositorySlug repository,
  required int issueNumber,
}) async {
  await for (final comment in gitHub.issues.listCommentsByIssue(
    repository,
    issueNumber,
  )) {
    final body = comment.body;
    if (body != null && body.contains(previewCommentMarker)) {
      return comment;
    }
  }
  return null;
}

/// Finds the ID of an existing preview comment on [issueNumber], if present.
Future<int?> findExistingPreviewCommentId({
  required github.GitHub gitHub,
  required github.RepositorySlug repository,
  required int issueNumber,
}) async {
  final comment = await findExistingPreviewComment(
    gitHub: gitHub,
    repository: repository,
    issueNumber: issueNumber,
  );
  return comment?.id;
}

/// Updates or creates the staged preview comment on the pull request.
///
/// Sets the [status] and optional [stagingUrl] for [site] on the PR,
/// maintaining all site previews in a single dashboard comment.
///
/// Returns `0` on success or `1` if the GitHub API call fails.
Future<int> updatePreviewCommentOnGitHub({
  required Site site,
  required PreviewStatus status,
  String? stagingUrl,
  required int prNumber,
  required String repoFullName,
  required String commitSha,
  required String githubToken,
}) async {
  final gitHub = github.GitHub(
    auth: github.Authentication.withToken(githubToken),
  );
  try {
    final repository = github.RepositorySlug.full(repoFullName);

    final existingComment = await findExistingPreviewComment(
      gitHub: gitHub,
      repository: repository,
      issueNumber: prNumber,
    );

    final previews = <Site, PreviewEntry>{};
    if (existingComment?.body case final body?) {
      previews.addAll(parsePreviewCommentEntries(body));
    }

    final existingEntry = previews[site];
    final resolvedStatus =
        status == PreviewStatus.pending && existingEntry?.url != null
        ? PreviewStatus.rebuilding
        : status;
    final resolvedUrl = stagingUrl ?? existingEntry?.url;

    previews[site] = PreviewEntry(
      status: resolvedStatus,
      url: resolvedUrl,
      commitSha: commitSha,
    );

    final commentBody = buildPreviewCommentBody(
      previews,
      repoFullName: repoFullName,
    );

    if (existingComment?.id case final commentId?) {
      await gitHub.issues.updateComment(repository, commentId, commentBody);
    } else {
      await gitHub.issues.createComment(repository, prNumber, commentBody);
    }
  } on Exception catch (error) {
    stderr.writeln('Error: Failed to comment on the pull request: $error');
    return 1;
  } finally {
    gitHub.dispose();
  }

  return 0;
}
