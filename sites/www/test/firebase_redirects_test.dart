// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';

final RegExp _lookaroundPattern = RegExp(r'\(\?(?:!|=|<=|<!)');
final RegExp _splatParamPattern = RegExp(r':([a-zA-Z0-9_]+)\*');

void main() {
  group('Firebase Hosting redirect configs', () {
    String resolveRepoPath(String relative) {
      for (final prefix in ['../..', '.']) {
        final candidate = path.join(prefix, relative);
        if (File(candidate).existsSync()) return candidate;
      }
      throw StateError(
        'Unable to locate $relative from ${Directory.current.path}',
      );
    }

    for (final configPath in const [
      'sites/docs/firebase.json',
      'sites/www/firebase.json',
      'sites/blog_redirects/firebase.json',
    ]) {
      test(
        '$configPath uses RE2-compatible regexes and valid splat destinations',
        () {
          final raw = File(resolveRepoPath(configPath)).readAsStringSync();
          final decoded = jsonDecode(raw) as Map<String, Object?>;
          final hosting = decoded['hosting'] as Map<String, Object?>;
          final redirects = (hosting['redirects'] as List<Object?>)
              .cast<Map<String, Object?>>();

          final seenSources = <String>{};
          for (final rule in redirects) {
            final key = (rule['source'] ?? rule['regex']) as String;
            expect(
              seenSources.add(key),
              isTrue,
              reason: 'Duplicate redirect key: $key',
            );

            final destination = rule['destination'] as String;
            expect(destination, isNotEmpty);

            if (rule['regex'] case final String pattern) {
              expect(
                _lookaroundPattern.hasMatch(pattern),
                isFalse,
                reason: 'RE2 rejects lookaround syntax in $pattern',
              );
              expect(() => RegExp(pattern), returnsNormally);
            }

            if (rule['source'] case final String source) {
              for (final match in _splatParamPattern.allMatches(source)) {
                final paramName = match.group(1)!;
                final bareToken = RegExp(':$paramName(?!\\*)');
                expect(
                  bareToken.hasMatch(destination),
                  isFalse,
                  reason:
                      'Rule "$source" -> "$destination" drops trailing "*" on :$paramName*',
                );
              }
            }
          }
        },
      );
    }
  });
}
