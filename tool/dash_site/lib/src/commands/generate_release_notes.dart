// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:github/github.dart' as github;
import 'package:path/path.dart' as path;

import '../utils.dart';

const String _defaultConfigurationPath = '.github/release.yml';
const String _owner = 'flutter';
const String _repository = 'flutter';
const String _releaseNotesDirectory =
    'sites/docs/src/content/release/release-notes';

final RegExp _stableVersionPattern = RegExp(r'^\d+\.\d+\.\d+$');

final class GenerateReleaseNotesCommand extends Command<int> {
  static const String _configurationOption = 'configuration';
  static const String _forceFlag = 'force';
  static const String _outputOption = 'output';
  static const String _previousTagOption = 'previous-tag';
  static const String _releaseOption = 'release';
  static const String _tagOption = 'tag';

  GenerateReleaseNotesCommand() {
    argParser.addOption(
      _releaseOption,
      abbr: 'r',
      help: 'The stable Flutter release version used in the page metadata.',
      valueHelp: 'version',
      mandatory: true,
    );
    argParser.addOption(
      _previousTagOption,
      abbr: 'p',
      help: 'The Flutter tag from which to start the generated changelog.',
      valueHelp: 'tag',
      mandatory: true,
    );
    argParser.addOption(
      _tagOption,
      abbr: 't',
      help:
          'The Flutter tag at which to end the generated changelog. '
          'Defaults to the release version.',
      valueHelp: 'tag',
    );
    argParser.addOption(
      _configurationOption,
      abbr: 'c',
      defaultsTo: _defaultConfigurationPath,
      help: 'The flutter/flutter release-note configuration file.',
      valueHelp: 'path',
    );
    argParser.addOption(
      _outputOption,
      abbr: 'o',
      help: 'The output Markdown path. Defaults to the docs release-note path.',
      valueHelp: 'path',
    );
    argParser.addFlag(
      _forceFlag,
      abbr: 'f',
      negatable: false,
      help: 'Overwrite an existing output file.',
    );
  }

  @override
  String get description =>
      'Generate a Flutter release-notes page from GitHub pull requests.';

  @override
  String get name => 'generate-release-notes';

  @override
  Future<int> run() async {
    final argResults = this.argResults!;
    final release = argResults.option(_releaseOption)!;
    final previousTag = argResults.option(_previousTagOption)!;
    final tag = argResults.option(_tagOption) ?? release;
    final configuration = argResults.option(_configurationOption)!;
    final output =
        argResults.option(_outputOption) ??
        path.join(
          repositoryRoot,
          _releaseNotesDirectory,
          'release-notes-$release.md',
        );
    final force = argResults.flag(_forceFlag);

    if (!_isStableFlutterVersion(release)) {
      stderr.writeln(
        "Error: '$release' isn't a stable Flutter version like 3.44.0.",
      );
      return 1;
    }

    final outputFile = File(output);
    if (outputFile.existsSync() && !force) {
      stderr.writeln(
        'Error: ${outputFile.path} already exists. '
        'Use --force to overwrite it.',
      );
      return 1;
    }

    final token = nonEmpty(Platform.environment['GITHUB_TOKEN']?.trim());
    if (token == null) {
      stderr.writeln(
        'Error: Set GITHUB_TOKEN to a GitHub token that '
        'can read flutter/flutter.',
      );
      return 1;
    }

    final gitHub = github.GitHub(auth: github.Authentication.withToken(token));

    try {
      print('Generating Flutter release notes from $previousTag to $tag...');
      final notes = await gitHub.repositories.generateReleaseNotes(
        github.CreateReleaseNotes(
          _owner,
          _repository,
          tag,
          previousTagName: previousTag,
          configurationFilePath: configuration,
        ),
      );
      final page = _createReleaseNotesPage(release, notes.body);

      await outputFile.parent.create(recursive: true);
      await outputFile.writeAsString(page);
      print('Wrote Flutter $release release notes to ${outputFile.path}.');
      return 0;
    } on github.GitHubError catch (error) {
      stderr.writeln('Error: GitHub failed to generate release notes: $error');
      return 1;
    } finally {
      gitHub.dispose();
    }
  }
}

/// Whether [version] is a three-part stable Flutter version.
bool _isStableFlutterVersion(String version) =>
    _stableVersionPattern.hasMatch(version);

/// Creates a docs.flutter.dev release-notes page for [release].
String _createReleaseNotesPage(String release, String generatedNotes) {
  final featureRelease = release.substring(0, release.lastIndexOf('.'));
  final cleanedNotes = _cleanGeneratedReleaseNotes(generatedNotes);

  return '''---
title: Flutter $release release notes
shortTitle: $release release notes
description: Release notes for Flutter $release.
skipTemplateRendering: true
---

This page has release notes for Flutter $featureRelease.

$cleanedNotes
''';
}

/// Cleans and normalizes the Markdown returned by GitHub's release-note API.
String _cleanGeneratedReleaseNotes(String generatedNotes) {
  const generatedComment =
      '<!-- Release notes generated using configuration in ';
  final pullRequestUrl = RegExp(
    r'https://github\.com/[^/\s]+/[^/\s]+/pull/(\d+)',
  );
  final cleanedLines = const LineSplitter()
      .convert(generatedNotes)
      .where((line) => !line.contains(generatedComment))
      .map((line) {
        // The '##' headings are fixed strings from GitHub's API,
        // while 'Other Changes' is a category title in
        // flutter/flutter's `release.yml` and can drift if that file changes.
        final sentenceCaseHeading = switch (line) {
          "## What's Changed" => "## What's changed",
          '### Other Changes' => '### Other changes',
          '## New Contributors' => '## New contributors',
          _ => line,
        };
        return sentenceCaseHeading.replaceAllMapped(
          pullRequestUrl,
          (match) => '[${match[1]}](${match[0]})',
        );
      });

  // Insert a blank line between each '##' heading and
  // adjacent non-empty lines.
  final normalizedLines = <String>[];
  for (final line in cleanedLines) {
    final previousLine = normalizedLines.lastOrNull;
    if (line.isNotEmpty &&
        (previousLine?.isNotEmpty ?? false) &&
        (line.startsWith('##') || previousLine!.startsWith('##'))) {
      normalizedLines.add('');
    }
    normalizedLines.add(line);
  }

  return normalizedLines.join('\n').trim();
}
