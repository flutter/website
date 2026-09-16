// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:github/github.dart' as github;
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;

import 'sites.dart';

/// Whether the pull request has changes that can affect [site].
///
/// Returns `true` with a warning if the changes can't be determined reliably.
/// Returns `false` only for a complete file list at [commitSha].
Future<bool> pullRequestAffectsSite({
  required String githubToken,
  required String repoFullName,
  required int prNumber,
  required String commitSha,
  required Site site,
}) async {
  final pullRequestPath = '/repos/$repoFullName/pulls/$prNumber';

  bool stageWithWarning(String reason) {
    stderr.writeln(
      'Warning: Couldn\'t determine changes affecting ${site.host}: '
      '$reason Continuing preview staging.',
    );
    return true;
  }

  final gitHub = github.GitHub(
    auth: github.Authentication.withToken(githubToken),
  );
  try {
    final pathGlobs = [
      for (final pattern in site.previewPathPatterns)
        // GitHub paths use forward slashes on every platform.
        Glob(pattern, context: path.posix),
    ];
    final revision = await _readPullRequestRevision(gitHub, pullRequestPath);
    if (revision.headSha != commitSha) {
      return stageWithWarning(
        'The pull request head differs from the requested commit.',
      );
    }

    // GitHub's pull request files endpoint returns at most 3,000 files.
    if (revision.changedFiles > 3000) {
      return stageWithWarning('The pull request exceeds GitHub\'s file limit.');
    }

    final filenames = <String>{};
    // `PullRequestFile` omits `previous_filename`,
    // which is needed to detect renames out of the selected site's directory.
    await for (final file
        in github.PaginationHelper(gitHub).jsonObjects<Object?>(
          'GET',
          '$pullRequestPath/files',
          params: {'per_page': 100},
        )) {
      final changedPaths = _changedFilePaths(file);
      if (changedPaths.any(
        (changedPath) => pathGlobs.any((glob) => glob.matches(changedPath)),
      )) {
        return true;
      }
      filenames.add(changedPaths.first);
    }

    if (filenames.length != revision.changedFiles) {
      return stageWithWarning('GitHub returned an incomplete file list.');
    }

    // The files endpoint isn't pinned to a commit.
    // Don't skip if the PR changed while reading its pages,
    // including changes to the base branch.
    if (await _readPullRequestRevision(gitHub, pullRequestPath) != revision) {
      return stageWithWarning('The pull request changed during the check.');
    }
    return false;
  } on Exception catch (error) {
    return stageWithWarning('$error');
  } finally {
    gitHub.dispose();
  }
}

/// The paths changed by a [file] entry from GitHub's pull request files API:
/// its current path, followed by its previous path if it was renamed.
List<String> _changedFilePaths(Object? file) {
  if (file
      case {'filename': final String filename, 'status': final String status}
      when filename.isNotEmpty && status.isNotEmpty) {
    final previousFilename = file['previous_filename'];
    if (previousFilename == null && status != 'renamed') {
      return [filename];
    }
    if (previousFilename is String && previousFilename.isNotEmpty) {
      return [filename, previousFilename];
    }
    throw const FormatException('Missing or invalid rename source.');
  }
  throw const FormatException('Missing or invalid changed file.');
}

Future<({String headSha, String baseSha, int changedFiles})>
_readPullRequestRevision(github.GitHub gitHub, String pullRequestPath) async {
  final response = await gitHub.request(
    'GET',
    pullRequestPath,
    statusCode: 200,
  );
  final decoded = jsonDecode(response.body) as Object?;
  if (decoded
      case {
        'head': {'sha': final String headSha},
        'base': {'sha': final String baseSha},
        'changed_files': final int changedFiles,
      }
      when baseSha.isNotEmpty) {
    return (headSha: headSha, baseSha: baseSha, changedFiles: changedFiles);
  }
  throw const FormatException('Missing or invalid pull request metadata.');
}
