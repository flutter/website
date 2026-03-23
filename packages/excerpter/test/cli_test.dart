// Copyright (c) 2023. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  final excerpterPath = path.join('bin', 'excerpter.dart');

  test('no args', () {
    final process = Process.runSync(Platform.executable, [
      'run',
      excerpterPath,
    ]);

    expect(process.exitCode, equals(1));
  });

  test('invalid format', () {
    final process = Process.runSync(Platform.executable, [
      'run',
      excerpterPath,
      '-f-23-423-4',
    ]);

    expect(process.exitCode, equals(1));
  });
}
