// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../sites.dart';
import '../utils.dart';

final class VerifyFirebaseJsonCommand extends Command<int> {
  @override
  String get description =>
      'Verify the firebase.json file is valid and '
      'meets the site standards.';

  @override
  String get name => 'verify-firebase-json';

  @override
  Future<int> run() async => _verifyFirebaseJson(selectedSite);
}

int _verifyFirebaseJson(Site site) {
  final firebasePath = path.join(repositoryRoot, site.firebaseConfigPath);
  final firebaseFile = File(firebasePath);

  if (!firebaseFile.existsSync()) {
    stderr.writeln(
      'Cannot find the ${site.name} Firebase config at $firebasePath.',
    );
    return 1;
  }

  try {
    final firebaseConfigString = firebaseFile.readAsStringSync();
    final firebaseConfig =
        jsonDecode(firebaseConfigString) as Map<String, Object?>;

    final hostingConfig = firebaseConfig['hosting'] as Map<String, Object?>?;

    if (hostingConfig == null) {
      stderr.writeln(
        "Error: The firebase.json file is missing a top-level 'hosting' entry.",
      );
      return 1;
    }

    if (!_verifyHostingEmulatorPort(firebaseConfig, site)) {
      return 1;
    }

    final redirects = hostingConfig['redirects'];

    if (redirects == null) {
      stdout.writeln(
        'There are no redirects specified within the firebase.json file.',
      );
      return 0;
    }

    if (redirects is! List<Object?>) {
      stderr.writeln(
        "Error: The firebase.json file's 'redirect' entry is not a list.",
      );
      return 1;
    }

    if (redirects.isEmpty) {
      return 0;
    }

    final sources = <String>{};

    var duplicatesFound = 0;

    for (final redirect in redirects) {
      if (redirect is! Map<String, Object?>) {
        stderr.writeln(
          'Error: Each redirect must be a map containing '
          "a 'source' or 'regex' field.",
        );
        return 1;
      }

      final source = redirect['source'] ?? redirect['regex'];
      if (source == null) {
        stderr.writeln(
          'Error: The firebase.json file has a '
          "redirect missing a 'source' or 'regex'.",
        );
        return 1;
      }

      if (source is! String) {
        stderr.writeln(
          'Error: The firebase.json redirect $redirect has a '
          "'source' or 'regex' specified which is not a string.",
        );
        return 1;
      }

      if (source.isEmpty) {
        stderr.writeln(
          'Error: The firebase.json redirect $redirect has an '
          "empty 'source' or 'regex'.",
        );
        return 1;
      }

      if (sources.contains(source)) {
        stderr.writeln("Error: Multiple redirects share the '$source' source.");
        duplicatesFound += 1;
      }

      sources.add(source);

      final destination = redirect['destination'];

      if (destination == null) {
        stderr.writeln(
          'Error: The firebase.json file has a '
          "redirect missing a 'destination'.",
        );
        return 1;
      }

      if (destination is! String) {
        stderr.writeln(
          'Error: The firebase.json redirect $redirect has a '
          "'destination' specified which is not a string.",
        );
        return 1;
      }

      if (destination.isEmpty) {
        stderr.writeln(
          'Error: The firebase.json redirect $redirect has '
          "an empty 'destination'.",
        );
        return 1;
      }
    }

    if (duplicatesFound > 0) {
      stderr.writeln(
        'Error: $duplicatesFound duplicate sources found '
        'in the firebase.json redirects.',
      );
      return 1;
    }
  } catch (e) {
    stderr.writeln(
      'Error: Encountered an error when loading the firebase.json file:',
    );
    stderr.writeln(e);
    return 1;
  }

  return 0;
}

bool _verifyHostingEmulatorPort(
  Map<String, Object?> firebaseConfig,
  Site site,
) {
  final emulatorsConfig = firebaseConfig['emulators'];
  if (emulatorsConfig is! Map<String, Object?>) {
    stderr.writeln(
      "Error: The firebase.json file is missing a top-level 'emulators' entry.",
    );
    return false;
  }

  final hostingEmulatorConfig = emulatorsConfig['hosting'];
  if (hostingEmulatorConfig is! Map<String, Object?>) {
    stderr.writeln(
      "Error: The firebase.json file is missing an 'emulators.hosting' entry.",
    );
    return false;
  }

  final port = hostingEmulatorConfig['port'];
  if (port != site.firebaseEmulatorPort) {
    stderr.writeln(
      "Error: The firebase.json 'emulators.hosting.port' value must be "
      '${site.firebaseEmulatorPort} for the ${site.name} site, '
      'but found $port.',
    );
    return false;
  }

  return true;
}
