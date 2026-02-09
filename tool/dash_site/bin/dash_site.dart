// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dash_site/dash_site.dart';
import 'package:io/io.dart' as io;
import 'package:path/path.dart' as path;

void main(List<String> args) async {
  // Verify that we are running from the root of the website repository.
  if (!Directory(path.join('tool', 'dash_site')).existsSync()) {
    throw Exception('Error: Wrong directory, run from root of the repository.');
  }

  final runner = DashSiteCommandRunner();
  try {
    final result = await runner
        .run(args)
        .whenComplete(io.sharedStdIn.terminate);

    exit(result is int ? result : 0);
  } on UsageException catch (e) {
    stderr.writeln(e);
    exit(64);
  } catch (e, stackTrace) {
    stderr.writeln(e);
    stderr.writeln(stackTrace);
    exit(1);
  }
}
