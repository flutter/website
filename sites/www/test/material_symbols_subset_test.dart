// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter_website/src/layouts/blog_layout.dart';
import 'package:flutter_website/src/layouts/default_layout.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart' hide BlogLayout;
import 'package:path/path.dart' as p;
import 'package:site_shared/layouts.dart';
import 'package:test/test.dart';

void main() {
  group('sites/www Material Symbols & font scoping synchronization', () {
    test('DefaultLayout excludes blog-only fonts and BlogLayout matches DashLayout Outlined URL', () {
      expect(DefaultLayout().additionalFontUrls, isEmpty);

      final blogFontUrls = BlogLayout().additionalFontUrls;
      expect(
        blogFontUrls.any((url) => url.contains('Roboto+Serif')),
        isTrue,
        reason: 'BlogLayout.additionalFontUrls must load Roboto Serif.',
      );

      final sharedOutlinedUrl = const _RefDashLayout().fontUrls.singleWhere(
        (url) => url.contains('Material+Symbols+Outlined'),
      );
      final blogOutlinedUrl = blogFontUrls.singleWhere(
        (url) => url.contains('Material+Symbols+Outlined'),
      );
      expect(
        blogOutlinedUrl,
        equals(sharedOutlinedUrl),
        reason:
            'BlogLayout.additionalFontUrls must stay in sync with '
            'DashLayout.fontUrls for Material Symbols Outlined.',
      );
    });

    test('DefaultLayout Material Symbols Rounded icon_names matches all sites/www usages', () {
      final wwwRoot = _resolveWwwRoot();
      final defaultLayoutSource = File(
        p.join(wwwRoot, 'lib', 'src', 'layouts', 'default_layout.dart'),
      ).readAsStringSync();

      final roundedUrl = _extractRoundedFontUrl(defaultLayoutSource);
      final roundedUri = Uri.parse(roundedUrl);
      expect(roundedUri.queryParameters['display'], 'block');

      final rawIconNames = roundedUri.queryParameters['icon_names'];
      expect(rawIconNames, isNotNull);
      final configuredList = rawIconNames!.split(',');
      expect(configuredList, isNotEmpty);
      expect(
        configuredList,
        orderedEquals([...configuredList]..sort()),
        reason: 'Material Symbols Rounded icon_names must be sorted.',
      );
      final configuredSet = configuredList.toSet();
      expect(configuredList.length, configuredSet.length);

      final discovered = _discoverWwwRoundedIcons(wwwRoot);
      final missingFromUrl = discovered.difference(configuredSet).toList()
        ..sort();
      final unusedInUrl = configuredSet.difference(discovered).toList()..sort();

      expect(
        missingFromUrl,
        isEmpty,
        reason:
            'Material Symbols Rounded icons used in sites/www are missing from '
            'default_layout.dart: ${missingFromUrl.join(', ')}',
      );
      expect(
        unusedInUrl,
        isEmpty,
        reason:
            'default_layout.dart lists unused Material Symbols Rounded icons: '
            '${unusedInUrl.join(', ')}',
      );
    });

    test(
      'Dart Rounded extractor captures valid symbols and ternary branches',
      () {
        expect(
          extractWwwDartRoundedIcons('''
          // Icon(symbol: 'ignored_comment')
          const a = Icon(symbol: 'toc');
          const b = Icon(symbol: 'note');
          final c = Icon(symbol: open ? 'close' : 'light');
        '''),
          {'toc', 'note', 'close', 'light'},
        );
      },
    );
  });
}

final class _RefDashLayout extends DashLayout {
  const _RefDashLayout();

  @override
  String get name => 'ref';

  @override
  String get siteHost => 'flutter.dev';

  @override
  String get iconUrl => '/favicon.png';

  @override
  String get iconUrlApple => '/favicon.png';

  @override
  String get twitterSiteTag => '@flutterdev';

  @override
  String get twitterDefaultImageUrl => '/social.png';

  @override
  String get tagManagerId => 'GTM-TEST';

  @override
  Component buildBody(Page page, Component child) => child;
}

String _resolveWwwRoot() {
  if (Directory('content').existsSync() && Directory('lib').existsSync()) {
    return Directory.current.path;
  }
  final fromWorkspace = Directory(p.join('sites', 'www'));
  if (fromWorkspace.existsSync()) return fromWorkspace.path;
  throw StateError('Could not locate sites/www directory.');
}

String _extractRoundedFontUrl(String dartSource) {
  final stripped = _stripCStyleComments(dartSource);
  expect(stripped, isNot(contains('Roboto+Serif')));
  expect(stripped, isNot(contains('Material+Symbols+Outlined')));

  final adjacentStrings =
      RegExp(
        r"(?:'(?:\\.|[^'\\])*'\s*)+",
      ).allMatches(stripped).map((match) {
        return RegExp(r"'((?:\\.|[^'\\])*)'")
            .allMatches(match.group(0)!)
            .map((m) => m.group(1)!)
            .join();
      });
  return adjacentStrings.singleWhere(
    (s) => s.contains('Material+Symbols+Rounded'),
  );
}

Set<String> _discoverWwwRoundedIcons(String wwwRoot) => {
  ..._discoverWwwDartRoundedIcons(wwwRoot),
  ..._discoverWwwContentRoundedIcons(wwwRoot),
  ..._discoverWwwScssRoundedIcons(wwwRoot),
};

Set<String> _discoverWwwDartRoundedIcons(String wwwRoot) {
  final icons = <String>{};
  for (final file in _listFiles(p.join(wwwRoot, 'lib'), {'.dart'})) {
    if (_isGeneratedDartFile(file.path)) continue;
    icons.addAll(extractWwwDartRoundedIcons(file.readAsStringSync()));
  }
  return icons;
}

Set<String> extractWwwDartRoundedIcons(String dartSource) {
  final icons = <String>{};
  final stripped = _stripCStyleComments(dartSource);
  for (final pattern in [
    _iconCtorPattern,
    _symbolOrIconNamedArgPattern,
    _roundedSpanInDartPattern,
  ]) {
    for (final match in pattern.allMatches(stripped)) {
      for (var group = 1; group <= match.groupCount; group++) {
        if (match.group(group) case final value?) {
          icons.add(value);
        }
      }
    }
  }
  return icons;
}

Set<String> _discoverWwwContentRoundedIcons(String wwwRoot) {
  final icons = <String>{};
  const exts = {'.md', '.html', '.yaml', '.yml', '.json'};
  for (final file in _listFiles(p.join(wwwRoot, 'content'), exts)) {
    final ext = p.extension(file.path).toLowerCase();
    final content = file.readAsStringSync();
    if (ext == '.md' || ext == '.html') {
      final withoutFences = content.replaceAll(_fencedCodeBlockPattern, '');
      for (final match in _roundedHtmlSpanPattern.allMatches(withoutFences)) {
        icons.add(match.group(1)!.trim());
      }
    } else {
      for (final match in _yamlIconLinePattern.allMatches(content)) {
        icons.add(match.group(1)!);
      }
    }
  }
  return icons;
}

Set<String> _discoverWwwScssRoundedIcons(String wwwRoot) {
  final icons = <String>{};
  for (final file in _listFiles(p.join(wwwRoot, 'lib', 'styles'), {'.scss'})) {
    final stripped = _stripCStyleComments(file.readAsStringSync());
    if (!stripped.contains('material-symbols-rounded')) continue;
    for (final match in _scssContentPattern.allMatches(stripped)) {
      icons.add(match.group(1)!);
    }
  }
  return icons;
}

bool _isGeneratedDartFile(String path) =>
    path.endsWith('.g.dart') ||
    path.endsWith('.mapper.dart') ||
    path.endsWith('.options.dart');

List<File> _listFiles(String rootPath, Set<String> extensions) {
  final dir = Directory(rootPath);
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => extensions.contains(p.extension(f.path).toLowerCase()))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
}

final RegExp _cStyleCommentPattern = RegExp(
  r'''("(?:\\.|[^"\\])*")|('(?:\\.|[^'\\])*')|//[^\n]*|/\*[\s\S]*?\*/''',
);
final RegExp _fencedCodeBlockPattern = RegExp(r'```[\s\S]*?```');
final RegExp _iconCtorPattern = RegExp(
  r'''\bIcon\(\s*(?:[^)]*?\bsymbol:\s*)?['"]([a-z0-9_]+)['"]''',
);
final RegExp _symbolOrIconNamedArgPattern = RegExp(
  r'''\b(?:symbol|icon)\s*:\s*(?:[^,);\n]*?\?\s*)?['"]([a-z0-9_]+)['"](?:\s*:\s*['"]([a-z0-9_]+)['"])?''',
);
final RegExp _roundedSpanInDartPattern = RegExp(
  r'''material-symbols-rounded['"][\s\S]{0,200}?\.text\(\s*['"]([a-z0-9_]+)['"]\s*\)''',
);
final RegExp _roundedHtmlSpanPattern = RegExp(
  r'''<span\b[^>]*class=["'][^"']*material-symbols-rounded[^"']*["'][^>]*>([^<]*)</span>''',
);
final RegExp _yamlIconLinePattern = RegExp(
  r'''^\s*icon:\s*['"]?([a-z][a-z0-9_]*)['"]?\s*$''',
  multiLine: true,
);
final RegExp _scssContentPattern = RegExp(
  r'''\bcontent\s*:\s*['"]([a-z0-9_]+)['"]''',
);

String _stripCStyleComments(String source) =>
    source.replaceAllMapped(_cStyleCommentPattern, (match) {
      if (match.group(1) != null || match.group(2) != null) {
        return match.group(0)!;
      }
      return '';
    });
