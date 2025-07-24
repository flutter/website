// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

final class InlineExcerptsCommand extends Command<int> {
  InlineExcerptsCommand() {
    argParser.addOption(
      'file',
      abbr: 'f',
      help: 'The file to process.',
    );
  }

  @override
  String get description => 'Replaces magic code blocks with code excerpts.';

  @override
  String get name => 'inline-excerpts';

  @override
  Future<int> run() async {
    final file = argResults?['file'];
    if (file == null) {
      print('Please provide a file path with the --file option.');
      return 1;
    }

    final result = await Process.run(
      'dart',
      ['tool/flutter_site/bin/inline_excerpts.dart', file],
    );
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    return result.exitCode;
  }
}
