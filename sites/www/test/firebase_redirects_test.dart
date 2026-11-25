// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';

final RegExp _lookaroundPattern = RegExp(r'\(\?(?:!|=|<=|<!)');
final RegExp _re2UnsupportedEscapePattern = RegExp(
  r'(?<!\\)(?:\\\\)*\\(?:[1-9]|k<|u)',
);
final RegExp _capturingGroupPattern = RegExp(
  r'(?<!\\)(?:\\\\)*\((?:\?P?<[a-zA-Z0-9_]+>|(?!\?))',
);
final RegExp _positionalRefPattern = RegExp(r':([1-9][0-9]*)');
final RegExp _splatParamPattern = RegExp(r':([a-zA-Z0-9_]+)([*+])');
final RegExp _wildcardTokenPattern = RegExp(r'[*:+?{}()@]');

List<String> validateFirebaseRedirects(List<Object?> rawRedirects) {
  final errors = <String>[];
  final seenKeys = <String>{};
  final priorWildcards = <(String source, RegExp matcher)>[];

  for (var i = 0; i < rawRedirects.length; i++) {
    final result = _validateRuleShape(rawRedirects[i], i);
    errors.addAll(result.errors);
    final key = result.key;
    if (key == null) continue;

    if (!seenKeys.add(key)) {
      errors.add('Duplicate redirect key: $key');
    }

    if (result.source case final String sourceStr) {
      if (_wildcardTokenPattern.hasMatch(sourceStr)) {
        priorWildcards.add((sourceStr, _firebaseGlobToRegExp(sourceStr)));
      } else if (_findShadowingWildcard(sourceStr, priorWildcards)
          case final String wildcardSource) {
        errors.add(
          'Redirect "$sourceStr" is shadowed by earlier wildcard '
          '"$wildcardSource".',
        );
      }
    }
  }
  return errors;
}

String? _findShadowingWildcard(
  String literalSource,
  List<(String, RegExp)> priorWildcards,
) {
  for (final (wildcardSource, matcher) in priorWildcards) {
    if (matcher.hasMatch(literalSource)) return wildcardSource;
  }
  return null;
}

({String? key, String? source, List<String> errors}) _validateRuleShape(
  Object? entry,
  int index,
) {
  if (entry is! Map<String, Object?>) {
    return (
      key: null,
      source: null,
      errors: ['Redirect [$index] is not a JSON object.'],
    );
  }
  final source = entry['source'];
  final regex = entry['regex'];
  if ((source != null) == (regex != null)) {
    return (
      key: null,
      source: null,
      errors: [
        'Redirect [$index] must specify exclusively one of '
            '"source" or "regex".',
      ],
    );
  }
  final key = source ?? regex;
  final destination = entry['destination'];
  if (key is! String ||
      key.isEmpty ||
      destination is! String ||
      destination.isEmpty) {
    return (
      key: null,
      source: null,
      errors: ['Redirect [$index] must have non-empty key and destination.'],
    );
  }

  final type = entry['type'];
  final errors = <String>[
    if (type != 301 && type != 302)
      'Redirect "$key" must use status type 301 or 302 (got $type).',
    if (regex is String) ..._validateRegexRule(regex, destination),
    if (source is String) ..._validateSplatModifiers(source, destination),
  ];
  return (key: key, source: source is String ? source : null, errors: errors);
}

List<String> _validateRegexRule(String pattern, String destination) {
  final errors = <String>[
    if (_lookaroundPattern.hasMatch(pattern))
      'RE2 rejects lookaround syntax in "$pattern".',
    if (_re2UnsupportedEscapePattern.hasMatch(pattern))
      'RE2 rejects backreference or \\u escape in "$pattern".',
  ];
  try {
    RegExp(pattern);
  } on FormatException catch (e) {
    return [...errors, 'Invalid regex "$pattern": ${e.message}'];
  }

  final groupCount = _capturingGroupPattern.allMatches(pattern).length;
  for (final match in _positionalRefPattern.allMatches(destination)) {
    final groupIndex = int.parse(match.group(1)!);
    if (groupIndex > groupCount) {
      errors.add(
        'Regex "$pattern" ($groupCount groups) cannot expand '
        ':$groupIndex in "$destination".',
      );
    }
  }
  return errors;
}

List<String> _validateSplatModifiers(String source, String destination) {
  final errors = <String>[];
  for (final match in _splatParamPattern.allMatches(source)) {
    final paramName = match.group(1)!;
    final modifier = match.group(2)!;
    final bareOrMismatched = RegExp(
      ':$paramName(?![a-zA-Z0-9_]|${RegExp.escape(modifier)})',
    );
    if (bareOrMismatched.hasMatch(destination)) {
      errors.add(
        'Rule "$source" -> "$destination" drops trailing "$modifier" '
        'on :$paramName$modifier.',
      );
    }
  }
  return errors;
}

RegExp _firebaseGlobToRegExp(String source) {
  final parts = <String>['^'];
  final paramPattern = RegExp(r'^:([a-zA-Z0-9_]+)([*+?])?');
  var i = 0;
  while (i < source.length) {
    if (source.startsWith('**', i)) {
      parts.add('.*');
      i += 2;
    } else if (source[i] == '*') {
      parts.add('[^/]*');
      i += 1;
    } else if (source[i] == ':' &&
        paramPattern.matchAsPrefix(source.substring(i)) != null) {
      final match = paramPattern.matchAsPrefix(source.substring(i))!;
      final modifier = match.group(2);
      if (modifier == '*' && parts.last == '/') {
        parts.removeLast();
        parts.add('(?:/.*)?');
      } else {
        parts.add(_paramModifierPattern(modifier));
      }
      i += match.group(0)!.length;
    } else {
      parts.add(RegExp.escape(source[i]));
      i += 1;
    }
  }
  parts.add(r'/?$');
  return RegExp(parts.join());
}

String _paramModifierPattern(String? modifier) => switch (modifier) {
  '*' => '.*',
  '+' => '.+',
  '?' => '[^/]*',
  _ => '[^/]+',
};

String _resolveRepoRoot() {
  for (final candidate in const ['../..', '.']) {
    if (Directory(path.join(candidate, 'sites')).existsSync()) {
      return candidate;
    }
  }
  throw StateError(
    'Unable to locate repository root from ${Directory.current.path}',
  );
}

List<Map<String, Object?>> _loadRedirects(String repoRoot, String configPath) {
  final raw = File(path.join(repoRoot, configPath)).readAsStringSync();
  final decoded = jsonDecode(raw) as Map<String, Object?>;
  final hosting = decoded['hosting'] as Map<String, Object?>;
  return (hosting['redirects'] as List<Object?>).cast<Map<String, Object?>>();
}

bool _hasBareRouteContent(
  String repoRoot,
  List<String> contentDirs,
  String bareRoute,
) {
  final rel = bareRoute.replaceFirst('/', '');
  for (final dir in contentDirs) {
    final base = path.join(repoRoot, dir, rel);
    if (Directory(base).existsSync() ||
        File('$base.md').existsSync() ||
        File('$base.html').existsSync()) {
      return true;
    }
  }
  return false;
}

List<String> _findUncoveredBarePrefixes(
  String repoRoot,
  String configPath,
  List<String> contentDirs,
) {
  final sources = {
    for (final rule in _loadRedirects(repoRoot, configPath))
      if (rule['source'] case final String s) s,
  };
  final uncovered = <String>[];
  for (final source in sources) {
    if (!source.endsWith('/**')) continue;
    final bare = source.substring(0, source.length - 3);
    if (!sources.contains(bare) &&
        !_hasBareRouteContent(repoRoot, contentDirs, bare)) {
      uncovered.add('$configPath: "$source" leaves "$bare" uncovered');
    }
  }
  return uncovered;
}

List<String> _findParameterizedCrossSiteMismatches(String repoRoot) {
  final docsMap = {
    for (final rule in _loadRedirects(repoRoot, 'sites/docs/firebase.json'))
      if (rule['source'] case final String s) s: rule['destination'] as String,
  };
  final wwwMap = {
    for (final rule in _loadRedirects(repoRoot, 'sites/www/firebase.json'))
      if (rule['source'] case final String s) s: rule['destination'] as String,
  };
  final mismatches = <String>[];
  for (final MapEntry(key: source, value: wwwDest) in wwwMap.entries) {
    if (!_splatParamPattern.hasMatch(source)) continue;
    final docsDest = docsMap[source];
    if (docsDest != null &&
        docsDest.startsWith('/') &&
        wwwDest.startsWith('https://docs.flutter.dev/') &&
        wwwDest != 'https://docs.flutter.dev$docsDest') {
      mismatches.add(
        '$source: www -> "$wwwDest" vs docs -> "$docsDest"',
      );
    }
  }
  return mismatches;
}

void main() {
  group('validateFirebaseRedirects unit checks', () {
    test('accepts valid RE2 regexes, splats, and ordered rules', () {
      final errors = validateFirebaseRedirects([
        {
          'regex': '^/(flutter(/.*)?)',
          'destination': 'https://api.flutter.dev/:1',
          'type': 301,
        },
        {'source': '/tagged/:tag*', 'destination': '/:tagged', 'type': 301},
        {
          'source': '/reference/widgets/widgetindex',
          'destination': '/reference/widgets',
          'type': 301,
        },
        {
          'source': '/reference/widgets/:catalogpage+',
          'destination': '/ui/widgets/:catalogpage+',
          'type': 302,
        },
      ]);
      expect(errors, isEmpty);
    });

    test('rejects invalid RE2 syntax, captures, splats, and shadowing', () {
      final cases = <(Map<String, Object?>, String)>[
        (
          {'regex': '^/(?!admin)(.+)', 'destination': '/:1', 'type': 301},
          'lookaround',
        ),
        (
          {'regex': r'^/([a-z]+)/\1$', 'destination': '/:1', 'type': 301},
          'backreference',
        ),
        ({'regex': r'^/\u0061$', 'destination': '/a', 'type': 301}, r'\u'),
        (
          {'regex': '^/(only-one)', 'destination': '/:2', 'type': 301},
          'cannot expand :2',
        ),
        (
          {'source': '/docs/:rest*', 'destination': '/:rest', 'type': 301},
          'drops trailing "*" on :rest*',
        ),
        (
          {
            'source': '/widgets/:page+',
            'destination': '/ui/:page',
            'type': 301,
          },
          'drops trailing "+" on :page+',
        ),
        (
          {
            'source': '/both',
            'regex': r'^/both$',
            'destination': '/',
            'type': 301,
          },
          'exclusively one',
        ),
        (
          {'source': '/bad-status', 'destination': '/', 'type': 307},
          'status type 301 or 302',
        ),
      ];
      for (final (rule, expectedSubstring) in cases) {
        expect(
          validateFirebaseRedirects([rule]),
          contains(contains(expectedSubstring)),
        );
      }

      final multiRuleErrors = validateFirebaseRedirects([
        {'source': '/docs/:rest*', 'destination': '/:rest*', 'type': 301},
        {'source': '/docs/:rest*', 'destination': '/:rest*', 'type': 301},
        {'source': '/docs/specific', 'destination': '/specific', 'type': 301},
      ]);
      expect(multiRuleErrors, [
        contains('Duplicate redirect key'),
        contains('shadowed by earlier wildcard'),
      ]);
    });
  });

  group('Firebase Hosting redirect configs', () {
    late final repoRoot = _resolveRepoRoot();

    for (final configPath in const [
      'sites/docs/firebase.json',
      'sites/www/firebase.json',
      'sites/blog_redirects/firebase.json',
    ]) {
      test(
        '$configPath uses RE2-compatible regexes, valid splats, and unshadowed literals',
        () {
          final redirects = _loadRedirects(repoRoot, configPath);
          expect(validateFirebaseRedirects(redirects), isEmpty);
        },
      );
    }

    test(
      'recursive /** rules cover bare prefixes and parameterized www/docs rules align',
      () {
        expect(
          [
            ..._findUncoveredBarePrefixes(
              repoRoot,
              'sites/docs/firebase.json',
              const ['sites/docs/src/content'],
            ),
            ..._findUncoveredBarePrefixes(
              repoRoot,
              'sites/www/firebase.json',
              const ['sites/www/content'],
            ),
            ..._findUncoveredBarePrefixes(
              repoRoot,
              'sites/blog_redirects/firebase.json',
              const [],
            ),
          ],
          isEmpty,
        );
        expect(_findParameterizedCrossSiteMismatches(repoRoot), isEmpty);
      },
    );
  });
}
