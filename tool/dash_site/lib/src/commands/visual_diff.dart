// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import 'package:visual_diff/visual_diff.dart';

import '../sites.dart';
import '../utils.dart';
import 'build.dart';

/// Command to run local visual regression diffing against a baseline branch.
final class VisualDiffCommand extends Command<int> {
  static const String _updateBaselineFlag = 'update-baseline';
  static const String _updateFlag = 'update';
  static const String _fromOption = 'from';
  static const String _currentFlag = 'current';
  static const String _buildFlag = 'build';
  static const String _openFlag = 'open';
  static const String _serveFlag = 'serve';
  static const String _routeOption = 'route';
  static const String _routeFilterOption = 'route-filter';
  static const String _limitOption = 'limit';
  static const String _viewportOption = 'viewport';
  static const String _concurrencyOption = 'concurrency';
  static const String _chromePathOption = 'chrome-path';
  static const String _outputDirOption = 'output-dir';
  static const String _maxHeightOption = 'max-height';
  static const String _javascriptFlag = 'javascript';
  static const String _minDiffPixelsOption = 'min-diff-pixels';

  VisualDiffCommand() {
    argParser.addFlag(
      _updateBaselineFlag,
      defaultsTo: false,
      negatable: false,
      help:
          'Update baseline snapshots. When used with --from or --current, '
          'creates a clean baseline. When used alone, updates the baseline '
          'from current diff snapshots.',
    );
    argParser.addFlag(
      _updateFlag,
      defaultsTo: false,
      negatable: false,
      help: 'Alias for --update-baseline.',
    );
    argParser.addOption(
      _fromOption,
      help:
          'Git branch or ref to generate baseline snapshots from '
          '(e.g. --from=main).',
    );
    argParser.addFlag(
      _currentFlag,
      defaultsTo: false,
      negatable: false,
      help:
          'Generate baseline snapshots from the current branch or '
          'working copy.',
    );
    argParser.addFlag(
      _buildFlag,
      defaultsTo: true,
      help: 'Build the site before snapshotting.',
    );
    argParser.addFlag(
      _openFlag,
      defaultsTo: true,
      help: 'Automatically open the visual diff report in your browser.',
    );
    argParser.addFlag(
      _serveFlag,
      defaultsTo: false,
      negatable: false,
      help:
          'Start the review server and open the UI without '
          're-running snapshots.',
    );
    argParser.addMultiOption(
      _routeOption,
      splitCommas: true,
      help: 'Specific route(s) to snapshot (e.g. --route=/cookbook).',
    );
    argParser.addOption(
      _routeFilterOption,
      help: 'Regular expression pattern to filter discovered routes.',
    );
    argParser.addOption(
      _limitOption,
      help: 'Maximum number of routes to snapshot.',
    );
    argParser.addOption(
      _viewportOption,
      defaultsTo: 'all',
      allowed: ['all', 'desktop', 'mobile'],
      help: 'Viewport(s) to snapshot.',
    );
    argParser.addOption(
      _concurrencyOption,
      defaultsTo: '4',
      help: 'Number of concurrent browser pages for capturing snapshots.',
    );
    argParser.addOption(
      _chromePathOption,
      help: 'Path to custom Chrome or Chromium executable.',
    );
    argParser.addOption(
      _outputDirOption,
      help: 'Custom directory for visual diff artifacts.',
    );
    argParser.addOption(
      _maxHeightOption,
      defaultsTo: '4500',
      help:
          'Maximum page snapshot height in pixels (0 for unconstrained full '
          'page).',
    );
    argParser.addFlag(
      _javascriptFlag,
      defaultsTo: false,
      negatable: true,
      help:
          'Enable JavaScript execution during snapshotting. Defaults to false '
          'for faster initial load snapshots.',
    );
    argParser.addOption(
      _minDiffPixelsOption,
      defaultsTo: '10',
      help:
          'Minimum number of differing pixels required to flag a snapshot as '
          'changed (diffs with fewer pixels are treated as equal).',
    );
  }

  @override
  String get description =>
      'Run visual regression diffing against baseline snapshots.';

  @override
  String get name => 'visual-diff';

  @override
  Future<int> run() async {
    final site = selectedSite;
    final results = argResults;

    final updateBaselineRequested =
        results.get<bool>(_updateBaselineFlag, false) ||
        results.get<bool>(_updateFlag, false);
    final fromBranch = results?.option(_fromOption);
    final useCurrentForBaseline = results.get<bool>(_currentFlag, false);

    if (fromBranch != null && useCurrentForBaseline) {
      usageException('Cannot combine --$_fromOption and --$_currentFlag.');
    }

    final isBaselineOperation =
        updateBaselineRequested || fromBranch != null || useCurrentForBaseline;

    final shouldBuild = results.get<bool>(_buildFlag, true);
    final shouldOpen = results.get<bool>(_openFlag, true);
    final serveOnly = results.get<bool>(_serveFlag, false);
    final explicitRoutes = results?.multiOption(_routeOption);
    final filterPattern = results?.option(_routeFilterOption);
    final limitStr = results?.option(_limitOption);
    final limit = limitStr != null ? int.tryParse(limitStr) : null;
    final viewportChoice = results?.option(_viewportOption) ?? 'all';
    final concurrency =
        int.tryParse(results?.option(_concurrencyOption) ?? '4') ?? 4;
    final chromePath = results?.option(_chromePathOption);
    final maxHeight =
        int.tryParse(results?.option(_maxHeightOption) ?? '4500') ?? 4500;
    final enableJavaScript = results.get<bool>(_javascriptFlag, false);
    final minDiffPixels =
        int.tryParse(results?.option(_minDiffPixelsOption) ?? '10') ?? 10;

    final RegExp? filterRegex;
    if (filterPattern != null && filterPattern.isNotEmpty) {
      try {
        filterRegex = RegExp(filterPattern);
      } on FormatException catch (e) {
        usageException(
          'Invalid regular expression for --$_routeFilterOption: ${e.message}',
        );
      }
    } else {
      filterRegex = null;
    }

    final List<SnapshotViewport> viewports;
    switch (viewportChoice) {
      case 'desktop':
        viewports = [SnapshotViewport.desktop];
      case 'mobile':
        viewports = [SnapshotViewport.mobile];
      case 'all':
      default:
        viewports = SnapshotViewport.all;
    }

    final isTargeted =
        (explicitRoutes != null && explicitRoutes.isNotEmpty) ||
        filterPattern != null ||
        limit != null;

    final customOutputDir = results?.option(_outputDirOption);
    final visualDiffDir = Directory(
      customOutputDir ?? path.join(repositoryRoot, '.visual-diff', site.name),
    );
    final baselineDir = Directory(path.join(visualDiffDir.path, 'baseline'));
    final currentDir = Directory(path.join(visualDiffDir.path, 'current'));
    final diffOutputDir = Directory(path.join(visualDiffDir.path, 'diff'));

    if (!visualDiffDir.existsSync()) {
      visualDiffDir.createSync(recursive: true);
    }

    if (serveOnly) {
      return await _startReviewServer(
        visualDiffDir: visualDiffDir,
        shouldOpen: shouldOpen,
      );
    }

    final runner = SnapshotRunner(
      customChromePath: chromePath,
      concurrency: concurrency,
      hideCookieBanner: true,
      maxHeight: maxHeight,
      disableJavaScript: !enableJavaScript,
      fontCacheDirectory: Directory(
        path.join(repositoryRoot, '.visual-diff', '.font-cache'),
      ),
    );

    // Baseline management operations: always separate from diffing.
    if (isBaselineOperation) {
      if (fromBranch != null) {
        return await _createBaselineFromBranch(
          site: site,
          fromBranch: fromBranch,
          baselineDir: baselineDir,
          isTargeted: isTargeted,
          explicitRoutes: explicitRoutes,
          filterRegex: filterRegex,
          limit: limit,
          viewports: viewports,
          runner: runner,
          shouldBuild: shouldBuild,
        );
      } else if (useCurrentForBaseline) {
        return await _createBaselineFromCurrent(
          site: site,
          baselineDir: baselineDir,
          isTargeted: isTargeted,
          explicitRoutes: explicitRoutes,
          filterRegex: filterRegex,
          limit: limit,
          viewports: viewports,
          runner: runner,
          shouldBuild: shouldBuild,
        );
      } else {
        return await _updateBaselineFromExistingSnapshots(
          site: site,
          baselineDir: baselineDir,
          currentDir: currentDir,
          diffOutputDir: diffOutputDir,
          visualDiffDir: visualDiffDir,
          isTargeted: isTargeted,
          explicitRoutes: explicitRoutes,
          viewports: viewports,
          minDiffPixels: minDiffPixels,
        );
      }
    }

    // Normal diff run: ALWAYS assume a baseline exists.
    final baselineSnapshotCount = _countPngSnapshots(baselineDir);
    if (baselineSnapshotCount == 0) {
      stderr.writeln(
        'Error: No baseline snapshots found for site "${site.name}".\n\n'
        'Before running visual-diff, create a baseline first:\n'
        '  • From a git branch (e.g. main):\n'
        '    dart run dash_site --site=${site.name} visual-diff '
        '--update-baseline --from=main\n'
        '  • From the current working copy:\n'
        '    dart run dash_site --site=${site.name} visual-diff '
        '--update-baseline --current\n',
      );
      return 1;
    }

    print('⚡ Using existing baseline ($baselineSnapshotCount snapshots).\n');

    // Load persisted baseline metadata and content hashes if present.
    final baselineMetaMap = <String, HeaderMetadata>{};
    final baselineMetaFile = File(path.join(baselineDir.path, 'metadata.json'));
    if (baselineMetaFile.existsSync()) {
      try {
        final json = jsonDecode(
          baselineMetaFile.readAsStringSync(),
        ) as Map<String, dynamic>;
        for (final entry in json.entries) {
          baselineMetaMap[entry.key] = HeaderMetadata.fromJson(
            entry.value as Map<String, dynamic>,
          );
        }
      } catch (_) {}
    }

    final baselineHashes = SiteContentHashes.loadFromFile(
      File(path.join(baselineDir.path, 'content_hashes.json')),
    );

    // Build current working copy and capture snapshots eagerly if requested.
    final currentBuildDir = Directory(
      path.join(repositoryRoot, site.buildOutputDirectory),
    );
    if (!currentBuildDir.existsSync()) {
      currentBuildDir.createSync(recursive: true);
    }

    // 3. Prepare current snapshot output directory.
    if (!isTargeted && currentDir.existsSync()) {
      currentDir.deleteSync(recursive: true);
    }
    currentDir.createSync(recursive: true);

    if (!isTargeted && diffOutputDir.existsSync()) {
      diffOutputDir.deleteSync(recursive: true);
    }
    diffOutputDir.createSync(recursive: true);

    if (shouldBuild) {
      if (isTargeted) {
        print(
          '🔨 Building ${site.name}...\n'
          '   (Tip: Pass --no-build if the site is already built to test '
          'instantly.)',
        );
      } else {
        print('🔨 Building ${site.name}...');
      }

      final buildExitCode = await buildSite(site, productionRelease: false);
      if (buildExitCode != 0) {
        stderr.writeln(
          'Error: Site build failed with exit code $buildExitCode.',
        );
        return buildExitCode;
      }
    }

    final currentRoutes = discoverRoutes(
      currentBuildDir,
      explicitRoutes: explicitRoutes,
      filter: filterRegex,
      limit: limit,
    );

    if (currentRoutes.isEmpty) {
      stderr.writeln(
        'Error: No routes discovered in current build directory: '
        '${currentBuildDir.path}.\n'
        'Run "dart run dash_site build" first or omit --no-build.',
      );
      return 1;
    }

    if (isTargeted) {
      print('🎯 Targeted run for ${currentRoutes.length} route(s):');
      for (final r in currentRoutes.take(5)) {
        print('   • $r');
      }
      if (currentRoutes.length > 5) {
        print('   • ... and ${currentRoutes.length - 5} more');
      }
      print('');
    }

    print('⚡ Starting static server for current snapshotting...');
    final server = await SnapshotServer.start(currentBuildDir);
    try {
      await runner.captureSnapshots(
        server: server,
        routes: currentRoutes,
        outputDirectory: currentDir,
        viewports: viewports,
        buildDirectory: currentBuildDir,
        baselineDirectory: baselineDir,
        baselineHashes: baselineHashes,
        baselineMetadata: baselineMetaMap,
        onProgress: print,
      );
    } finally {
      await server.close();
    }

    print('✅ Current snapshots saved to ${currentDir.path}\n');

    // Run pure Dart pixel diffing across all snapshots.
    final manifestFile = File(
      path.join(visualDiffDir.path, 'diff_manifest.json'),
    );
    final differ = BatchDiffer(
      pixelDiffer: PixelDiffer(minDiffPixels: minDiffPixels),
    );
    final manifest = await differ.run(
      baselineDir: baselineDir,
      currentDir: currentDir,
      diffOutputDir: diffOutputDir,
      manifestFile: manifestFile,
      site: site.name,
      baseRef: 'baseline',
      targetRoutes: isTargeted ? currentRoutes.toSet() : null,
      targetViewports: viewports.length < SnapshotViewport.all.length
          ? viewports.map((v) => v.name).toSet()
          : null,
      onProgress: print,
    );

    print('\n📊 Visual diff manifest: ${manifestFile.path}');

    // 6. Open report in review server.
    if (shouldOpen) {
      return await _startReviewServer(
        visualDiffDir: visualDiffDir,
        shouldOpen: true,
      );
    }

    return manifest.hasDiff ? 1 : 0;
  }

  Future<int> _startReviewServer({
    required Directory visualDiffDir,
    required bool shouldOpen,
  }) async {
    final webDir = Directory(
      path.join(repositoryRoot, 'packages', 'visual_diff', 'web'),
    );
    final clientJs = File(path.join(webDir.path, 'main.client.dart.js'));
    if (_needsClientJsCompilation(clientJs, webDir)) {
      print('⚡ Compiling visual diff review web application...');
      final res = await Process.run('dart', [
        'compile',
        'js',
        path.join(webDir.path, 'main.dart'),
        '-o',
        clientJs.path,
        '-O2',
      ]);
      if (res.exitCode != 0) {
        stderr.writeln(
          'Warning: Failed to compile visual diff client app: ${res.stderr}',
        );
      } else {
        final legacyJs = File(path.join(webDir.path, 'main.dart.js'));
        clientJs.copySync(legacyJs.path);
      }
    }

    final reviewServer = await VisualDiffServer.start(
      visualDiffDirectory: visualDiffDir,
      webAppDirectory: webDir,
    );

    print('\n🚀 Visual Diff Reviewer running at: ${reviewServer.url}');
    if (shouldOpen) {
      await VisualDiffServer.openInBrowser(reviewServer.url);
    }

    if (stdout.hasTerminal) {
      print('Press Ctrl+C to stop the review server.');
      final sigint = ProcessSignal.sigint.watch();
      final sigterm = Platform.isWindows ? null : ProcessSignal.sigterm.watch();
      await Future.any([sigint.first, if (sigterm != null) sigterm.first]);
      await reviewServer.close();
      print('\nReview server stopped.');
    }

    return 0;
  }

  Future<int> _createBaselineFromBranch({
    required Site site,
    required String fromBranch,
    required Directory baselineDir,
    required bool isTargeted,
    required List<String>? explicitRoutes,
    required RegExp? filterRegex,
    required int? limit,
    required List<SnapshotViewport> viewports,
    required SnapshotRunner runner,
    required bool shouldBuild,
  }) async {
    print('ℹ️  Generating baseline snapshots from branch "$fromBranch"...');

    final worktree = await GitWorktree.create(
      repositoryRoot: repositoryRoot,
      baseRef: fromBranch,
    );

    try {
      if (shouldBuild) {
        print('📦 Installing dependencies in baseline worktree...');
        final pubGetResult = await Process.run('dart', [
          'pub',
          'get',
        ], workingDirectory: worktree.directory.path);
        if (pubGetResult.exitCode != 0) {
          stderr.writeln(
            'Error: Failed to get dependencies in baseline worktree: '
            '${pubGetResult.stderr}',
          );
          return pubGetResult.exitCode;
        }

        print('🔨 Building baseline site in worktree...');
        final buildResult = await Process.run('dart', [
          'run',
          'dash_site',
          '--site=${site.name}',
          'build',
          '--no-production',
        ], workingDirectory: worktree.directory.path);
        if (buildResult.exitCode != 0) {
          stderr.writeln(
            'Error: Failed to build baseline site in worktree: '
            '${buildResult.stderr}',
          );
          return buildResult.exitCode;
        }
      }

      final baselineBuildDir = Directory(
        path.join(worktree.directory.path, site.buildOutputDirectory),
      );
      if (!baselineBuildDir.existsSync()) {
        stderr.writeln(
          'Error: Baseline build output directory not found at: '
          '${baselineBuildDir.path}',
        );
        return 1;
      }

      final baselineRoutes = discoverRoutes(
        baselineBuildDir,
        explicitRoutes: explicitRoutes,
        filter: filterRegex,
        limit: limit,
      );

      if (baselineRoutes.isEmpty) {
        stderr.writeln(
          'Error: No routes discovered in baseline build directory: '
          '${baselineBuildDir.path}',
        );
        return 1;
      }

      if (!isTargeted && baselineDir.existsSync()) {
        baselineDir.deleteSync(recursive: true);
      }
      baselineDir.createSync(recursive: true);

      print('⚡ Starting static server for baseline snapshotting...');
      final server = await SnapshotServer.start(baselineBuildDir);
      try {
        await runner.captureSnapshots(
          server: server,
          routes: baselineRoutes,
          outputDirectory: baselineDir,
          viewports: viewports,
          buildDirectory: baselineBuildDir,
          onProgress: print,
        );
      } finally {
        await server.close();
      }

      print(
        '✅ Baseline snapshots from "$fromBranch" saved to '
        '${baselineDir.path}\n',
      );
      return 0;
    } finally {
      await worktree.cleanup(repositoryRoot: repositoryRoot);
    }
  }

  Future<int> _createBaselineFromCurrent({
    required Site site,
    required Directory baselineDir,
    required bool isTargeted,
    required List<String>? explicitRoutes,
    required RegExp? filterRegex,
    required int? limit,
    required List<SnapshotViewport> viewports,
    required SnapshotRunner runner,
    required bool shouldBuild,
  }) async {
    print('ℹ️  Generating baseline snapshots from current working copy...');

    if (shouldBuild) {
      print('🔨 Building current working copy for ${site.name}...');
      final buildExitCode = await buildSite(site, productionRelease: false);
      if (buildExitCode != 0) {
        stderr.writeln(
          'Error: Site build failed with exit code $buildExitCode.',
        );
        return buildExitCode;
      }
    }

    final currentBuildDir = Directory(
      path.join(repositoryRoot, site.buildOutputDirectory),
    );
    if (!currentBuildDir.existsSync()) {
      stderr.writeln(
        'Error: Build directory not found at: ${currentBuildDir.path}.\n'
        'Run "dart run dash_site build" first or omit --no-build.',
      );
      return 1;
    }

    final baselineRoutes = discoverRoutes(
      currentBuildDir,
      explicitRoutes: explicitRoutes,
      filter: filterRegex,
      limit: limit,
    );

    if (baselineRoutes.isEmpty) {
      stderr.writeln(
        'Error: No routes discovered in build directory: '
        '${currentBuildDir.path}',
      );
      return 1;
    }

    if (!isTargeted && baselineDir.existsSync()) {
      baselineDir.deleteSync(recursive: true);
    }
    baselineDir.createSync(recursive: true);

    print('⚡ Starting static server for baseline snapshotting...');
    final server = await SnapshotServer.start(currentBuildDir);
    try {
      await runner.captureSnapshots(
        server: server,
        routes: baselineRoutes,
        outputDirectory: baselineDir,
        viewports: viewports,
        buildDirectory: currentBuildDir,
        onProgress: print,
      );
    } finally {
      await server.close();
    }

    print('✅ Baseline snapshots saved to ${baselineDir.path}\n');
    return 0;
  }

  Future<int> _updateBaselineFromExistingSnapshots({
    required Site site,
    required Directory baselineDir,
    required Directory currentDir,
    required Directory diffOutputDir,
    required Directory visualDiffDir,
    required bool isTargeted,
    required List<String>? explicitRoutes,
    required List<SnapshotViewport> viewports,
    int minDiffPixels = 10,
  }) async {
    final currentSnapshotCount = _countPngSnapshots(currentDir);
    if (currentSnapshotCount == 0) {
      stderr.writeln(
        'Error: No current snapshots found in ${currentDir.path}.\n'
        'Run visual-diff first to generate current snapshots, or specify '
        '--from=<branch> or --current to create a baseline from scratch.',
      );
      return 1;
    }

    if (!baselineDir.existsSync()) {
      baselineDir.createSync(recursive: true);
    }

    if (isTargeted && explicitRoutes != null && explicitRoutes.isNotEmpty) {
      print('🔄 Updating baseline snapshots for targeted route(s)...');
      for (final route in explicitRoutes) {
        for (final vp in viewports) {
          final filename = snapshotFileName(route, vp.name);
          final currentFile = File(path.join(currentDir.path, filename));
          if (currentFile.existsSync()) {
            currentFile.copySync(path.join(baselineDir.path, filename));
          }
          final diffFile = File(path.join(diffOutputDir.path, filename));
          if (diffFile.existsSync()) {
            diffFile.deleteSync();
          }
        }
      }
      print('✅ Baseline updated for targeted route(s).\n');
    } else {
      print('🔄 Updating baseline snapshots from all current snapshots...');
      for (final entity in currentDir.listSync()) {
        if (entity is File && entity.path.endsWith('.png')) {
          entity.copySync(
            path.join(baselineDir.path, path.basename(entity.path)),
          );
        }
      }
      final currentMeta = File(path.join(currentDir.path, 'metadata.json'));
      if (currentMeta.existsSync()) {
        currentMeta.copySync(path.join(baselineDir.path, 'metadata.json'));
      }
      final currentHashes = File(
        path.join(currentDir.path, 'content_hashes.json'),
      );
      if (currentHashes.existsSync()) {
        currentHashes.copySync(
          path.join(baselineDir.path, 'content_hashes.json'),
        );
      }
      if (diffOutputDir.existsSync()) {
        for (final entity in diffOutputDir.listSync()) {
          if (entity is File && entity.path.endsWith('.png')) {
            entity.deleteSync();
          }
        }
      }
      print('✅ Baseline updated from all current snapshots.\n');
    }

    final manifestFile = File(
      path.join(visualDiffDir.path, 'diff_manifest.json'),
    );
    if (manifestFile.existsSync()) {
      final differ = BatchDiffer(
        pixelDiffer: PixelDiffer(minDiffPixels: minDiffPixels),
      );
      await differ.run(
        baselineDir: baselineDir,
        currentDir: currentDir,
        diffOutputDir: diffOutputDir,
        manifestFile: manifestFile,
        site: site.name,
        baseRef: 'baseline',
      );
    }

    return 0;
  }

  bool _needsClientJsCompilation(File clientJs, Directory webDir) {
    if (!clientJs.existsSync()) return true;
    final jsModTime = clientJs.lastModifiedSync();
    final libDir = Directory(
      path.join(repositoryRoot, 'packages', 'visual_diff', 'lib'),
    );
    for (final dir in [libDir, webDir]) {
      if (!dir.existsSync()) continue;
      for (final entity in dir.listSync(recursive: true)) {
        if (entity is File && entity.path.endsWith('.dart')) {
          if (entity.lastModifiedSync().isAfter(jsModTime)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  static int _countPngSnapshots(Directory directory) {
    if (!directory.existsSync()) return 0;
    var count = 0;
    for (final entity in directory.listSync()) {
      if (entity is File && entity.path.endsWith('.png')) {
        count++;
      }
    }
    return count;
  }
}
