// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:linkcheck/linkcheck.dart' as linkcheck show run;
import 'package:path/path.dart' as path;

import '../utils.dart';

final class CheckLinksCommand extends Command<int> {
  static const String _externalFlag = 'external';

  CheckLinksCommand() {
    argParser.addFlag(
      _externalFlag,
      abbr: 'e',
      defaultsTo: false,
      help: 'Verify external links as well.',
    );
  }

  @override
  String get description => 'Verify all links between pages on the site work.';

  @override
  String get name => 'check-links';

  @override
  Future<int> run() async => _checkLinks(
        checkExternal: argResults.get<bool>(_externalFlag, false),
      );
}

/// The port that the firebase emulator runs on by default.
/// This must match what's declared in the `firebase.json`
/// and can't be 5000, since Airplay uses it.
const int _emulatorPort = 5500;

/// The path from root where the linkcheck skip list lives.
final String _skipFilePath = path.join(
  'tool',
  'config',
  'linkcheck-skip-list.txt',
);

Future<int> _checkLinks({bool checkExternal = false}) async {
  if (await _isPortInUse(_emulatorPort)) {
    stderr.writeln(
      'Error: Port $_emulatorPort is already in use! '
      'Are you running the emulator elsewhere?',
    );
    return 1;
  }

  print('Starting the Firebase hosting emulator asynchronously...');
  final emulatorProcess = await Process.start(
    'npm',
    const [
      'exec',
      '--',
      'firebase',
      'emulators:start',
      '--only',
      'hosting',
      '--project',
      'default',
      '--log-verbosity',
      'QUIET',
    ],
    mode: ProcessStartMode.inheritStdio,
  );

  // Give the emulator a few seconds to start up.
  await Future<void>.delayed(const Duration(seconds: 5));

  try {
    // Check to see if the emulator is running.
    if (!(await _isPortInUse(_emulatorPort))) {
      stderr.writeln('Error: The Firebase hosting emulator did not start!');
      return 1;
    }

    try {
      final result = await linkcheck.run(
        [
          ':$_emulatorPort',
          '--skip-file',
          _skipFilePath,
          if (checkExternal) 'external'
        ],
        stdout,
      );
      await Future<void>.delayed(const Duration(seconds: 1));
      return result;
    } catch (e, stackTrace) {
      stderr.writeln('Error: linkcheck failed to execute properly!');
      stderr.writeln(e);
      stderr.writeln(stackTrace);
      return 1;
    }
  } finally {
    print('Shutting down Firebase hosting emulator...');
    emulatorProcess.kill();
    emulatorProcess.kill(ProcessSignal.sigkill);
    print('Done!\n');
  }
}

/// If the specified [port] is in use.
Future<bool> _isPortInUse(int port) async {
  try {
    // Try to bind to the specified port.
    final server = await ServerSocket.bind(
      InternetAddress.loopbackIPv4,
      port,
      shared: false,
    ).timeout(const Duration(seconds: 3)); // Ignore timeout.

    // If we reach this line, the port was available,
    // and we know the Firebase hosting emulator is not running.
    // So close the fake server and return as not in use.
    await server.close();
    return false;
  } on SocketException {
    // If there is a socket exception,
    // assume it is because the Firebase hosting emulator is already
    // using the port.
    return true;
  }
}
