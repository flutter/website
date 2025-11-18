// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:http/http.dart' as http;
import 'package:io/io.dart' as io;
import 'package:path/path.dart' as path;

import '../utils.dart';

final class BuildSiteCommand extends Command<int> {
  static const String _releaseFlag = 'release';

  BuildSiteCommand() {
    argParser.addFlag(
      _releaseFlag,
      defaultsTo: false,
      help:
          'Build a release build for docs.flutter.dev. '
          'Optimizes site resources.',
    );
  }

  @override
  String get description => 'Build the site.';

  @override
  String get name => 'build';

  @override
  Future<int> run() async {
    installJasprCliIfNecessary();

    final productionRelease = argResults.get<bool>(_releaseFlag, false);

    final process = await Process.start(
      Platform.resolvedExecutable,
      [
        'pub',
        'global',
        'run',
        'jaspr_cli:jaspr',
        'build',
        // Use build_web_compiler options specified in build.yaml instead of
        // those specified by jaspr_cli.
        '--no-managed-build-options',
        '--sitemap-domain=https://docs.flutter.dev',
        // Exclude secondary Markdown output files from sitemap.
        r'--sitemap-exclude=\.html\.md$',
        '--dart-define=PRODUCTION=$productionRelease',
      ],
      workingDirectory: 'site',
      mode: ProcessStartMode.inheritStdio,
    );

    final processExitCode = await process.exitCode;

    await _runPageFind();

    final originalOutputDirectoryPath = path.join(
      repositoryRoot,
      'site',
      'build',
      'jaspr',
    );
    if (!Directory(originalOutputDirectoryPath).existsSync()) {
      stderr.writeln(
        'Error: Jaspr output directory not found at: '
        '$originalOutputDirectoryPath',
      );
      return 1;
    }

    // Copy the entire site output to the _site directory.
    io.copyPathSync(originalOutputDirectoryPath, siteOutputDirectoryPath);

    // Copy pagefind output to the web directory so allow subsequent serving.
    io.copyPathSync(
      path.join(originalOutputDirectoryPath, 'pagefind'),
      path.join(repositoryRoot, 'site', 'web', 'pagefind'),
    );

    _move404File();

    return processExitCode;
  }
}

/// Moves the 404 file to the location expected by Firebase hosting.
void _move404File() {
  final initial404Directory = path.join(siteOutputDirectoryPath, '404');
  final original404File = File(path.join(initial404Directory, 'index.html'));
  if (original404File.existsSync()) {
    // If the 404 is in its own directory,
    // copy the 404.html file to the root of the output directory.
    original404File.copySync(path.join(siteOutputDirectoryPath, '404.html'));
    Directory(initial404Directory).deleteSync(recursive: true);
  }
}

Future<void> _runPageFind() async {
  final pageFindExecutableFile = File(
    path.join('tool', 'dash_site', '.dart_tool', 'pagefind', 'pagefind'),
  );

  if (!pageFindExecutableFile.existsSync()) {
    await _downloadPageFind();
  }

  final process = await Process.start(
    pageFindExecutableFile.path,
    [
      '--site',
      path.join(repositoryRoot, 'site', 'build', 'jaspr'),
      '--write-playground',
    ],
    workingDirectory: repositoryRoot,
    mode: ProcessStartMode.inheritStdio,
  );

  final processExitCode = await process.exitCode;
  if (processExitCode != 0) {
    stderr.writeln('Error: pagefind failed with exit code $processExitCode');
  }
}

Future<void> _downloadPageFind() async {
  final latestReleaseUri = Uri.https(
    'github.com',
    '/pagefind/pagefind/releases/latest',
  );
  final request = http.Request('GET', latestReleaseUri)
    ..followRedirects = false;
  final response = await request.send();

  assert(response.statusCode == 302);

  final tag = response.headers['location']!.split('/').last;

  final os = switch (Platform.operatingSystem) {
    'linux' => 'unknown-linux-musl',
    'macos' => 'apple-darwin',
    'windows' => 'pc-windows-msvc',
    _ => throw UnsupportedError(
      'Unsupported operating system: ${Platform.operatingSystem}',
    ),
  };

  final arch = getCPUArchitecture();

  final downloadUri = Uri.https(
    'github.com',
    '/pagefind/pagefind/releases/download/$tag/pagefind-$tag-$arch-$os.tar.gz',
  );

  print('Downloading pagefind...');

  final downloadResponse = await http.get(downloadUri);
  if (downloadResponse.statusCode != 200) {
    throw Exception(
      'Failed to download pagefind: ${downloadResponse.statusCode}',
    );
  }

  final tarFile = File(
    path.join('tool', 'dash_site', '.dart_tool', 'pagefind', 'pagefind.tar.gz'),
  );
  await tarFile.create(recursive: true);
  await tarFile.writeAsBytes(downloadResponse.bodyBytes);

  final tar = Process.runSync(
    'tar',
    ['-xzf', 'pagefind.tar.gz'],
    workingDirectory: path.join('tool', 'dash_site', '.dart_tool', 'pagefind'),
  );

  if (tar.exitCode != 0) {
    throw Exception('Failed to extract pagefind: ${tar.exitCode}');
  }

  tarFile.deleteSync();
}

String getCPUArchitecture() {
  final String cpu;
  if (Platform.isWindows) {
    cpu = Platform.environment['PROCESSOR_ARCHITECTURE']!.toLowerCase();
  } else {
    final info = Process.runSync('uname', ['-m']);
    cpu = info.stdout.toString().trim().toLowerCase();
  }
  if (cpu case 'arm64' || 'aarch64') {
    return 'aarch64';
  } else {
    return 'x86_64';
  }
}
