// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:github/github.dart' as github;
import 'package:path/path.dart' as path;

import '../firebase.dart';
import '../sites.dart';
import '../utils.dart';
import 'build.dart';

/// Builds the selected or default site,
/// deploys it to a Firebase Hosting preview channel,
/// and posts or updates a comment on the source GitHub PR when requested.
final class StagePreviewCommand extends Command<int> {
  static const String _projectOption = 'project';
  static const String _channelOption = 'channel';
  static const String _expiresOption = 'expires';
  static const String _prNumberOption = 'pr-number';
  static const String _repoOption = 'repo';
  static const String _commitShaOption = 'commit-sha';
  static const String _headBranchOption = 'head-branch';

  StagePreviewCommand() {
    argParser
      ..addOption(
        _projectOption,
        help:
            'The Firebase project ID or alias to stage to. '
            'Defaults to the selected site production project. '
            'Use this to test previews against a personal Firebase project.',
        valueHelp: 'project-id',
      )
      ..addOption(
        _channelOption,
        help:
            'The Firebase Hosting preview channel name. '
            'Defaults to a stable name based on the selected site and PR.',
        valueHelp: 'channel',
      )
      ..addOption(
        _expiresOption,
        defaultsTo: '7d',
        help: 'How long the Firebase Hosting preview channel should live.',
        valueHelp: 'duration',
      )
      ..addOption(
        _prNumberOption,
        help:
            'The pull request number to comment on. '
            'Required together with --$_repoOption to post a preview comment.',
      )
      ..addOption(
        _repoOption,
        help:
            'The full repository name in "owner/repository" form. '
            'Required together with --$_prNumberOption to '
            'post a preview comment.',
        valueHelp: 'owner/repository',
      )
      ..addOption(
        _commitShaOption,
        help:
            'The commit SHA being staged. '
            'Required to post a preview comment.',
      )
      ..addOption(
        _headBranchOption,
        help: 'The branch name to include in the staging channel name.',
      );
  }

  @override
  String get description =>
      'Build the site, deploy it to a Firebase staging channel, '
      'and comment the preview URL on GitHub.';

  @override
  String get name => 'stage-preview';

  @override
  Future<int> run() async {
    final selectedSite = this.selectedSite;
    final argResults = this.argResults!;

    final project =
        argResults.option(_projectOption) ??
        selectedSite.defaultFirebaseProjectId;
    final channel = _nonEmpty(argResults.option(_channelOption));
    final expires = argResults.option(_expiresOption)!;
    final prNumberArg = _nonEmpty(argResults.option(_prNumberOption));
    final repoFullName = _nonEmpty(argResults.option(_repoOption));
    final commitSha = _nonEmpty(argResults.option(_commitShaOption));
    final headBranch = _nonEmpty(argResults.option(_headBranchOption));

    // Validate PR-context preconditions up front so a misconfigured
    // trigger fails before the build and deploy runs unnecessarily.
    final _PullRequestContext? prContext;
    if (prNumberArg != null && repoFullName != null) {
      final prNumber = int.tryParse(prNumberArg);
      if (prNumber == null) {
        stderr.writeln('Error: --$_prNumberOption must be an integer.');
        return 1;
      }
      if (!repoFullName.contains('/')) {
        stderr.writeln(
          'Error: --$_repoOption must be in the form "owner/repository".',
        );
        return 1;
      }
      if (commitSha == null) {
        stderr.writeln(
          'Error: --$_commitShaOption must be set to '
          'comment on the pull request.',
        );
        return 1;
      }
      const githubPatTokenEnv = 'GH_PAT_TOKEN';
      final githubToken = _nonEmpty(Platform.environment[githubPatTokenEnv]);
      if (githubToken == null) {
        stderr.writeln(
          'Error: $githubPatTokenEnv must be set to '
          'comment on the pull request.',
        );
        return 1;
      }
      prContext = (
        prNumber: prNumber,
        repoFullName: repoFullName,
        githubToken: githubToken,
        commitSha: commitSha,
      );
    } else {
      if (prNumberArg != null || repoFullName != null) {
        stderr.writeln(
          'Warning: Both --$_prNumberOption and --$_repoOption must be set '
          'to comment on the pull request; skipping the GitHub comment.',
        );
      }
      prContext = null;
    }

    final firebaseToolsVersion = await validateFirebaseCli();
    if (firebaseToolsVersion == null) {
      return 1;
    }

    if (await buildSite(selectedSite, productionRelease: false)
        case final buildResult when buildResult != 0) {
      return buildResult;
    }

    print('Using firebase-tools $firebaseToolsVersion.');
    final branchOrSha = headBranch ?? commitSha ?? 'manual';
    final stagingUrl = await _deploySiteToStaging(
      selectedSite,
      project: project,
      channel:
          channel ??
          _firebaseChannelForSite(
            selectedSite,
            prNumber: prNumberArg,
            branchOrSha: branchOrSha,
          ),
      expires: expires,
    );
    if (stagingUrl == null) {
      return 1;
    }

    if (prContext == null) {
      print('No pull request context available; skipping GitHub comment.');
      print(stagingUrl);
      return 0;
    }

    return _commentStagingUrlOnGitHub(
      site: selectedSite,
      stagingUrl: stagingUrl,
      context: prContext,
    );
  }
}

/// Deploys [site] to a Firebase Hosting preview channel and
/// returns the channel's public URL on success, or
/// `null` if the deploy fails or no URL can be extracted.
Future<String?> _deploySiteToStaging(
  Site site, {
  required String project,
  required String channel,
  required String expires,
}) async {
  print(
    'Deploying ${site.host} to Firebase project $project '
    'preview channel $channel...',
  );

  final result = await Process.run(
    firebaseCliExecutable,
    [
      'hosting:channel:deploy',
      channel,
      '--project=$project',
      '--expires',
      expires,
      '--json',
    ],
    workingDirectory: path.join(repositoryRoot, site.firebaseConfigDirectory),
  );

  if (result.exitCode != 0) {
    stderr.writeln(result.stderr);
    stderr.writeln(result.stdout);
    return null;
  }

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  final stagingUrl = _extractDeployedUrl(result.stdout as String);
  if (stagingUrl == null) {
    stderr.writeln('Failed to find a Firebase staging URL for ${site.host}.');
    return null;
  }

  return stagingUrl;
}

/// Extracts the deployed preview URL from
/// `firebase hosting:channel:deploy --json` output.
///
/// Returns `null` if the input isn't valid JSON or doesn't contain a URL.
String? _extractDeployedUrl(String firebaseJsonOutput) {
  final Object? parsed;
  try {
    parsed = jsonDecode(firebaseJsonOutput);
  } on FormatException {
    return null;
  }
  if (parsed case <String, Object?>{
    'result': final Map<String, Object?> result,
  }) {
    for (final entry in result.values) {
      if (entry case <String, Object?>{'url': final String url}) {
        return url;
      }
    }
  }
  return null;
}

/// Posts a new preview comment on the pull request,
/// or updates the existing one identified by an HTML marker that
/// includes the [site]'s name.
///
/// Returns `0` on success or `1` if the GitHub API call fails.
Future<int> _commentStagingUrlOnGitHub({
  required Site site,
  required String stagingUrl,
  required _PullRequestContext context,
}) async {
  final commentMarker = '<!-- flutter-preview-${site.name} -->';
  final commentBody =
      '''
$commentMarker
Staged preview of the updated ${site.host} site (updated for commit ${context.commitSha}):

$stagingUrl''';

  print('Commenting ${site.host} staging URL on the PR...');
  final gitHub = github.GitHub(
    auth: github.Authentication.withToken(context.githubToken),
  );
  try {
    final repository = github.RepositorySlug.full(context.repoFullName);
    final existingCommentId = await _findExistingPreviewCommentId(
      gitHub: gitHub,
      repository: repository,
      issueNumber: context.prNumber,
      commentMarker: commentMarker,
    );

    if (existingCommentId == null) {
      await gitHub.issues.createComment(
        repository,
        context.prNumber,
        commentBody,
      );
    } else {
      // package:github's IssuesService.updateComment issues a POST,
      // but GitHub's REST API requires PATCH for this endpoint.
      await gitHub.request(
        'PATCH',
        '/repos/${repository.fullName}/issues/comments/$existingCommentId',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'body': commentBody}),
        statusCode: github.StatusCodes.OK,
      );
    }
  } on github.GitHubError catch (error) {
    stderr.writeln('Error: Failed to comment on the pull request: $error');
    return 1;
  } finally {
    gitHub.dispose();
  }

  return 0;
}

/// Returns the id of the first comment on the issue whose body
/// contains the specified [commentMarker].
///
/// Returns `null` if no matching comment exists.
Future<int?> _findExistingPreviewCommentId({
  required github.GitHub gitHub,
  required github.RepositorySlug repository,
  required int issueNumber,
  required String commentMarker,
}) async {
  await for (final comment in gitHub.issues.listCommentsByIssue(
    repository,
    issueNumber,
  )) {
    if (comment.body?.contains(commentMarker) ?? false) {
      return comment.id;
    }
  }
  return null;
}

/// Builds a Firebase Hosting channel name for [site] that
/// incorporates [branchOrSha] and if specified, [prNumber],
/// and satisfies Firebase's naming constraints:
///
/// - Lowercase a-z characters, 0-9 digits, and dashes (`-`).
/// - No longer than 63 characters.
/// - No trailing dashes.
String _firebaseChannelForSite(
  Site site, {
  String? prNumber,
  required String branchOrSha,
}) {
  final prefix = prNumber != null ? 'pr$prNumber-' : '';
  var channel = '${site.name}-$prefix$branchOrSha'.toLowerCase().replaceAll(
    RegExp('[^a-z0-9-]+'),
    '-',
  );
  if (channel.length > 63) {
    channel = channel.substring(0, 63);
  }
  return channel.replaceAll(RegExp(r'-+$'), '');
}

/// Returns [value] if it is non-null and non-empty, otherwise `null`.
String? _nonEmpty(String? value) {
  if (value == null || value.isEmpty) return null;
  return value;
}

/// Everything required to post a preview comment on a GitHub pull request.
///
/// Built during option parsing so that a misconfigured Cloud Build trigger
/// fails before the build and deploy runs.
typedef _PullRequestContext = ({
  int prNumber,
  String repoFullName,
  String githubToken,
  String commitSha,
});
