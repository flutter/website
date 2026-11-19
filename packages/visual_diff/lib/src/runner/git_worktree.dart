// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;

/// Manages a temporary git worktree used to build baseline snapshots.
final class GitWorktree {
  final Directory directory;
  final String baseRef;

  GitWorktree._(this.directory, this.baseRef);

  /// Creates a temporary git worktree for [baseRef] in
  /// the system temp directory.
  static Future<GitWorktree> create({
    required String repositoryRoot,
    String baseRef = 'main',
  }) async {
    final systemTemp = Directory.systemTemp;
    final worktreeDir = Directory(
      path.join(
        systemTemp.path,
        'flutter_website_baseline_${DateTime.now().millisecondsSinceEpoch}',
      ),
    );

    print('🌿 Creating temporary git worktree for baseline ($baseRef)...');
    final addResult = await Process.run(
      'git',
      ['worktree', 'add', '--detach', worktreeDir.path, baseRef],
      workingDirectory: repositoryRoot,
    );

    if (addResult.exitCode != 0) {
      throw StateError(
        'Failed to create git worktree for $baseRef: ${addResult.stderr}',
      );
    }

    print('📦 Resolving Dart packages in baseline worktree...');
    final pubResult = await Process.run(
      Platform.resolvedExecutable,
      ['pub', 'get'],
      workingDirectory: worktreeDir.path,
    );

    if (pubResult.exitCode != 0) {
      await _cleanupWorktree(repositoryRoot, worktreeDir);
      throw StateError(
        'Failed to run "dart pub get" in baseline worktree: '
        '${pubResult.stderr}',
      );
    }

    return GitWorktree._(worktreeDir, baseRef);
  }

  /// Builds the site in this worktree using dash_site.
  Future<void> buildSiteInWorktree({
    required String siteName,
  }) async {
    print('🔨 Building baseline site in worktree ($baseRef)...');
    final buildProcess = await Process.start(
      Platform.resolvedExecutable,
      ['run', 'dash_site', '--site=$siteName', 'build'],
      workingDirectory: directory.path,
      mode: ProcessStartMode.inheritStdio,
    );
    final buildExitCode = await buildProcess.exitCode;

    if (buildExitCode != 0) {
      throw StateError(
        'Building site "$siteName" failed in worktree '
        'with exit code $buildExitCode.',
      );
    }
  }

  /// Removes the git worktree and deletes its directory.
  Future<void> cleanup({required String repositoryRoot}) async {
    await _cleanupWorktree(repositoryRoot, directory);
  }

  static Future<void> _cleanupWorktree(
    String repositoryRoot,
    Directory worktreeDir,
  ) async {
    print('🧹 Cleaning up temporary git worktree...');
    try {
      await Process.run(
        'git',
        ['worktree', 'remove', '--force', worktreeDir.path],
        workingDirectory: repositoryRoot,
      );
    } catch (_) {}

    if (worktreeDir.existsSync()) {
      try {
        worktreeDir.deleteSync(recursive: true);
      } catch (_) {}
    }
  }
}
