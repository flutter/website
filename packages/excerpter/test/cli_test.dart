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

  test('multiple stale excerpts return one failure exit code', () {
    final temporaryDirectory = Directory.systemTemp.createTempSync(
      'excerpter-cli-test-',
    );
    addTearDown(() => temporaryDirectory.deleteSync(recursive: true));

    File(
      path.join(temporaryDirectory.path, 'source.dart'),
    ).writeAsStringSync('void main() {}\n');
    final target = File(path.join(temporaryDirectory.path, 'target.md'))
      ..writeAsStringSync(
        '<?code-excerpt "source.dart"?>\n'
        '```dart\n'
        'outdated\n'
        '```\n'
        '\n'
        '<?code-excerpt "source.dart"?>\n'
        '```dart\n'
        'outdated\n'
        '```\n',
      );

    final process = Process.runSync(Platform.executable, [
      'run',
      excerpterPath,
      '--dry-run',
      '--fail-on-update',
      '--base-source=${temporaryDirectory.path}',
      target.path,
    ]);

    expect(process.stdout, contains('2 out of 2 excerpts'));
    expect(process.exitCode, equals(1));
  });
}
