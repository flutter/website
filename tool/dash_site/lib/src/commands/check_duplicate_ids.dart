// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';

import '../duplicate_ids.dart';
import '../sites.dart';
import '../utils.dart';

final class CheckDuplicateIdsCommand extends Command<int> {
  @override
  String get name => 'check-duplicate-ids';

  @override
  String get description => 'Check generated HTML for duplicate element IDs.';

  @override
  int run() {
    final site = selectedSite;
    final output = findBuildOutputDirectory(site);
    if (output == null) return 1;

    final duplicates = findDuplicateIds(output);
    if (duplicates.isNotEmpty) {
      stderr.writeln('Duplicate IDs in ${site.buildOutputDirectory}:\n');
      stderr.writeln(duplicates.join('\n'));
      return 1;
    }

    stdout.writeln('No duplicate IDs in ${site.buildOutputDirectory}.');
    return 0;
  }
}
