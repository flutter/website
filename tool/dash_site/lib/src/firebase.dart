// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

/// The executable name for the Firebase CLI.
const String firebaseCliExecutable = 'firebase';

/// Validates that the Firebase CLI is available and returns its version.
///
/// Returns `null` and prints actionable feedback if the CLI isn't available
/// or can't report its version.
Future<String?> validateFirebaseCli() async {
  final ProcessResult versionResult;
  try {
    versionResult = await Process.run(firebaseCliExecutable, const [
      '--version',
    ]);
  } on ProcessException catch (error) {
    stderr.writeln(
      'Error: The Firebase CLI is required, but '
      '`firebase --version` could not run.',
    );
    stderr.writeln(_firebaseCliInstallMessage);
    if (error.message.isNotEmpty) {
      stderr.writeln(error.message);
    }
    return null;
  }

  if (versionResult.exitCode != 0) {
    stderr.writeln(
      'Error: The Firebase CLI is required, but '
      '`firebase --version` failed.',
    );
    _writeErrorOutput(versionResult.stdout);
    _writeErrorOutput(versionResult.stderr);
    stderr.writeln(_firebaseCliInstallMessage);
    return null;
  }

  final version = versionResult.stdout.toString().trim();
  if (version.isEmpty) {
    stderr.writeln('Error: Could not determine firebase-tools version.');
    stderr.writeln(_firebaseCliInstallMessage);
    return null;
  }

  return version;
}

/// Help text shown when the Firebase CLI can't be validated.
const String _firebaseCliInstallMessage =
    'Install firebase-tools and make sure the `firebase` executable is '
    'available on your PATH.';

/// Writes [output] to stderr if it contains non-whitespace content.
void _writeErrorOutput(Object? output) {
  final trimmedOutput = output?.toString().trim() ?? '';
  if (trimmedOutput.isNotEmpty) {
    stderr.writeln(trimmedOutput);
  }
}
