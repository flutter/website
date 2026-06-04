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
/// and publishes a deployment status on the source GitHub PR when requested.
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
            'The pull request number to publish a deployment for. '
            'Required together with --$_repoOption to publish a deployment.',
      )
      ..addOption(
        _repoOption,
        help:
            'The full repository name in "owner/repository" form. '
            'Required together with --$_prNumberOption to '
            'publish a deployment.',
        valueHelp: 'owner/repository',
      )
      ..addOption(
        _commitShaOption,
        help:
            'The commit SHA being staged. '
            'Required to publish a deployment.',
      )
      ..addOption(
        _headBranchOption,
        help: 'The branch name to include in the staging channel name.',
      );
  }

  @override
  String get description =>
      'Build the site, deploy it to a Firebase staging channel, '
      'and publish the preview URL as a GitHub deployment.';

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
          'publish a deployment.',
        );
        return 1;
      }
      const githubPatTokenEnv = 'GH_PAT_TOKEN';
      final githubToken = _nonEmpty(Platform.environment[githubPatTokenEnv]);
      if (githubToken == null) {
        stderr.writeln(
          'Error: $githubPatTokenEnv must be set to '
          'publish a deployment.',
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
          'to publish a deployment; skipping the GitHub deployment.',
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
      print('No pull request context available; skipping GitHub deployment.');
      print(stagingUrl);
      return 0;
    }

    return _publishStagingDeploymentOnGitHub(
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

/// The GitHub REST API version used for preview deployment calls.
const String _githubApiVersion = '2026-03-10';

/// The GitHub REST API media type used for raw deployment calls.
const String _githubJsonMimeType = 'application/vnd.github+json';

/// The deployment task used to distinguish site previews from other deploys.
const String _previewDeploymentTask = 'deploy:preview';

/// Publishes [stagingUrl] as the latest PR/site preview deployment.
///
/// Each staging run creates a deployment for the staged commit. The success
/// status is followed by inactive statuses and deletes for older deployments
/// for the same environment.
///
/// Returns `0` on success or `1` if the GitHub API call fails.
Future<int> _publishStagingDeploymentOnGitHub({
  required Site site,
  required String stagingUrl,
  required _PullRequestContext context,
}) async {
  final environment = _previewEnvironmentForSite(
    site,
    prNumber: context.prNumber,
  );

  print(
    'Publishing ${site.host} staging URL to GitHub deployment '
    '$environment...',
  );
  final gitHub = github.GitHub(
    auth: github.Authentication.withToken(context.githubToken),
    version: _githubApiVersion,
  );
  try {
    final repository = github.RepositorySlug.full(context.repoFullName);
    final previousDeploymentIds = await _findPreviewDeploymentIds(
      gitHub: gitHub,
      repository: repository,
      environment: environment,
    );
    final deploymentId = await _createPreviewDeployment(
      gitHub: gitHub,
      repository: repository,
      site: site,
      stagingUrl: stagingUrl,
      environment: environment,
      context: context,
    );

    await _createPreviewDeploymentStatus(
      gitHub: gitHub,
      repository: repository,
      deploymentId: deploymentId,
      site: site,
      stagingUrl: stagingUrl,
      environment: environment,
      commitSha: context.commitSha,
    );
    await _deletePreviewDeployments(
      gitHub: gitHub,
      repository: repository,
      deploymentIds: previousDeploymentIds,
      environment: environment,
    );
  } on github.GitHubError catch (error) {
    stderr.writeln('Error: Failed to publish the GitHub deployment: $error');
    return 1;
  } finally {
    gitHub.dispose();
  }

  return 0;
}

/// Returns existing deployment ids for a PR/site preview [environment].
Future<List<int>> _findPreviewDeploymentIds({
  required github.GitHub gitHub,
  required github.RepositorySlug repository,
  required String environment,
}) async {
  final deploymentIds = <int>[];
  var page = 1;
  while (true) {
    final deployments = await gitHub.getJSON<Object?, List<Object?>>(
      '/repos/${repository.fullName}/deployments',
      params: <String, String>{
        'environment': environment,
        'task': _previewDeploymentTask,
        'per_page': '100',
        'page': '$page',
      },
      convert: (json) => json as List<Object?>,
    );
    if (deployments.isEmpty) {
      return deploymentIds;
    }
    for (final deployment in deployments) {
      if (deployment case <String, Object?>{'id': final num id}) {
        deploymentIds.add(id.toInt());
      }
    }
    page += 1;
  }
}

/// Creates the GitHub deployment record for the staged preview.
Future<int> _createPreviewDeployment({
  required github.GitHub gitHub,
  required github.RepositorySlug repository,
  required Site site,
  required String stagingUrl,
  required String environment,
  required _PullRequestContext context,
}) async {
  final response = await gitHub.postJSON<Object?, Map<String, Object?>>(
    '/repos/${repository.fullName}/deployments',
    statusCode: 201,
    body: jsonEncode(<String, Object?>{
      'ref': context.commitSha,
      'task': _previewDeploymentTask,
      'auto_merge': false,
      'required_contexts': <String>[],
      'payload': <String, Object?>{
        'id': _previewDeploymentPayloadId(site, prNumber: context.prNumber),
        'site': site.name,
        'site_host': site.host,
        'pull_request': context.prNumber,
        'preview_url': stagingUrl,
      },
      'environment': environment,
      'description': 'Staged preview for ${site.host} PR #${context.prNumber}.',
      'transient_environment': true,
      'production_environment': false,
    }),
    convert: _jsonMap,
  );
  if (response case <String, Object?>{'id': final num id}) {
    return id.toInt();
  }
  throw github.GitHubError(
    gitHub,
    'Failed to find a deployment id in the GitHub response.',
  );
}

/// Creates a successful deployment status with [stagingUrl] as the preview URL.
Future<void> _createPreviewDeploymentStatus({
  required github.GitHub gitHub,
  required github.RepositorySlug repository,
  required int deploymentId,
  required Site site,
  required String stagingUrl,
  required String environment,
  required String commitSha,
}) async {
  await gitHub.postJSON<Object?, Map<String, Object?>>(
    '/repos/${repository.fullName}/deployments/$deploymentId/statuses',
    statusCode: 201,
    body: jsonEncode(<String, Object?>{
      'state': 'success',
      'log_url': stagingUrl,
      'description': 'Staged ${site.host} preview for ${_shortSha(commitSha)}.',
      'environment': environment,
      'environment_url': stagingUrl,
      'auto_inactive': false,
    }),
    convert: _jsonMap,
  );
}

/// Marks older transient preview deployments inactive and deletes them.
Future<void> _deletePreviewDeployments({
  required github.GitHub gitHub,
  required github.RepositorySlug repository,
  required List<int> deploymentIds,
  required String environment,
}) async {
  for (final deploymentId in deploymentIds) {
    await _createInactiveDeploymentStatus(
      gitHub: gitHub,
      repository: repository,
      deploymentId: deploymentId,
      environment: environment,
    );
    await gitHub.request(
      'DELETE',
      '/repos/${repository.fullName}/deployments/$deploymentId',
      statusCode: 204,
      headers: _githubJsonHeaders,
    );
  }
}

/// Creates an inactive status for a superseded transient preview deployment.
Future<void> _createInactiveDeploymentStatus({
  required github.GitHub gitHub,
  required github.RepositorySlug repository,
  required int deploymentId,
  required String environment,
}) async {
  await gitHub.postJSON<Object?, Map<String, Object?>>(
    '/repos/${repository.fullName}/deployments/$deploymentId/statuses',
    statusCode: 201,
    body: jsonEncode(<String, Object?>{
      'state': 'inactive',
      'description': 'Superseded by a newer staged preview.',
      'environment': environment,
      'auto_inactive': false,
    }),
    convert: _jsonMap,
  );
}

Map<String, String> get _githubJsonHeaders => <String, String>{
  'Accept': _githubJsonMimeType,
  'X-GitHub-Api-Version': _githubApiVersion,
};

/// Converts a decoded GitHub JSON object to a string-keyed map.
Map<String, Object?> _jsonMap(Object? json) =>
    Map<String, Object?>.from(json as Map<dynamic, dynamic>);

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

/// Returns the GitHub environment name shown for a PR/site preview.
///
/// The PR number keeps the deployment unique while giving GitHub's UI a
/// readable environment name.
String _previewEnvironmentForSite(Site site, {required int prNumber}) =>
    'Preview: ${site.host} (PR #$prNumber)';

/// Returns the stable payload id for a PR/site preview deployment.
String _previewDeploymentPayloadId(Site site, {required int prNumber}) =>
    '${site.name}-pr-$prNumber';

/// Returns a shortened commit SHA for status descriptions.
String _shortSha(String sha) {
  if (sha.length <= 7) {
    return sha;
  }
  return sha.substring(0, 7);
}

/// Returns [value] if it is non-null and non-empty, otherwise `null`.
String? _nonEmpty(String? value) {
  if (value == null || value.isEmpty) return null;
  return value;
}

/// Everything required to publish a preview deployment for a pull request.
///
/// Built during option parsing so that a misconfigured Cloud Build trigger
/// fails before the build and deploy runs.
typedef _PullRequestContext = ({
  int prNumber,
  String repoFullName,
  String githubToken,
  String commitSha,
});
