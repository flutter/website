// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:dash_site/src/commands/visual_diff.dart';
import 'package:test/test.dart';

void main() {
  group('VisualDiffCommand', () {
    late CommandRunner<int> runner;
    late VisualDiffCommand command;

    setUp(() {
      runner = CommandRunner<int>('dash_site', 'CLI');
      command = VisualDiffCommand();
      runner.addCommand(command);
    });

    test('is named visual-diff', () {
      expect(command.name, equals('visual-diff'));
    });

    test('defines required flags and options', () {
      final parser = command.argParser;
      expect(parser.options.containsKey('base'), isTrue);
      expect(parser.options.containsKey('current'), isTrue);
      expect(parser.options.containsKey('full'), isTrue);
      expect(parser.options.containsKey('save-baseline'), isTrue);
      expect(parser.options.containsKey('update'), isTrue);
      expect(parser.options.containsKey('build'), isTrue);
      expect(parser.options.containsKey('open'), isTrue);
      expect(parser.options.containsKey('serve'), isTrue);
      expect(parser.options.containsKey('route'), isTrue);
      expect(parser.options.containsKey('route-filter'), isTrue);
      expect(parser.options.containsKey('limit'), isTrue);
      expect(parser.options.containsKey('viewport'), isTrue);
      expect(parser.options.containsKey('concurrency'), isTrue);
      expect(parser.options.containsKey('chrome-path'), isTrue);
      expect(parser.options.containsKey('output-dir'), isTrue);
      expect(parser.options.containsKey('hide-cookie-banner'), isTrue);
    });
  });
}
