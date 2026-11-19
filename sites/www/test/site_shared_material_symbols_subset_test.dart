// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as p;
import 'package:site_shared/layouts.dart';
import 'package:test/test.dart';

void main() {
  group('Material Symbols Outlined subset synchronization', () {
    test(
      'DashLayout.fontUrls icon_names matches all workspace Outlined icons',
      () {
        final workspaceRoot = _resolveWorkspaceRoot();
        final symbolsHref = const _TestDashLayout().fontUrls.singleWhere(
          (url) => url.contains('Material+Symbols+Outlined'),
        );
        final symbolsUri = Uri.parse(symbolsHref);
        expect(symbolsUri.queryParameters['display'], 'block');

        final rawIconNames = symbolsUri.queryParameters['icon_names'];
        expect(rawIconNames, isNotNull);
        final configuredList = rawIconNames!.split(',');
        expect(configuredList, isNotEmpty);
        expect(
          configuredList,
          orderedEquals([...configuredList]..sort()),
          reason: 'icon_names in DashLayout.fontUrls must be sorted.',
        );
        final configuredSet = configuredList.toSet();
        expect(
          configuredList.length,
          configuredSet.length,
          reason: 'icon_names in DashLayout.fontUrls must not have duplicates.',
        );

        final discovered = _discoverWorkspaceOutlinedIcons(workspaceRoot);
        final missingFromUrl = discovered.difference(configuredSet).toList()
          ..sort();
        final unusedInUrl = configuredSet.difference(discovered).toList()
          ..sort();

        expect(
          missingFromUrl,
          isEmpty,
          reason:
              'Material Symbols Outlined icons used in source files are '
              'missing from DashLayout.fontUrls (and BlogLayout.'
              'additionalFontUrls): ${missingFromUrl.join(', ')}',
        );
        expect(
          unusedInUrl,
          isEmpty,
          reason:
              'DashLayout.fontUrls lists unused Material Symbols Outlined '
              'icons: ${unusedInUrl.join(', ')}',
        );
      },
    );

    test(
      'extractors parse valid ligatures and ignore comments/code blocks',
      () {
        expect(
          extractDartOutlinedIcons(
            '''
          // MaterialIcon('commented_out')
          final a = MaterialIcon('rocket_launch');
          final b = Button(icon: 'open_in_new', content: 'Open');
          final c = MaterialIcon('toc');
          final d = Button(icon: active ? 'note' : 'light', content: 'Toggle');
          ''',
            sourcePath: 'sample.dart',
          ),
          {'rocket_launch', 'open_in_new', 'toc', 'note', 'light'},
        );

        expect(
          extractDataIconValues(
            '''
icon: toc
icon: note
''',
            sourcePath: 'sidenav.yml',
          ),
          {'toc', 'note'},
        );

        expect(
          extractMarkupOutlinedIcons(
            '''
          ```dart
          Icon(Icons.photo_album)
          ```
          <Icon id="book_5" title="Guide"></Icon>
          <span class="material-symbols">chevron_right</span>
          <span class="material-symbols-rounded">arrow_forward</span>
          ''',
            sourcePath: 'sample.md',
          ),
          {'book_5', 'chevron_right'},
        );

        expect(
          extractScssOutlinedIcons(
            '''
          // content: 'ignored_comment';
          .search::before {
            font-family: var(--site-icon-fontFamily);
            content: 'search';
          }
          ''',
            sourcePath: '_header.scss',
          ),
          {'search'},
        );
      },
    );

    test('rejects invalid or dynamic ligatures in static markup spans', () {
      expect(
        () => extractMarkupOutlinedIcons(
          '<span class="material-symbols">Not Valid!</span>',
          sourcePath: 'bad.md',
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('bad.md'),
          ),
        ),
      );
    });
  });
}

final class _TestDashLayout extends DashLayout {
  const _TestDashLayout();

  @override
  String get name => 'test';

  @override
  String get siteHost => 'docs.flutter.dev';

  @override
  String get iconUrl => '/favicon.ico';

  @override
  String get iconUrlApple => '/apple.png';

  @override
  String get twitterSiteTag => '@flutterdev';

  @override
  String get twitterDefaultImageUrl => '/social.png';

  @override
  String get tagManagerId => 'GTM-TEST';

  @override
  Component buildBody(Page page, Component child) => child;
}

String _resolveWorkspaceRoot() {
  var dir = Directory.current;
  while (true) {
    final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
    if (pubspec.existsSync() &&
        pubspec.readAsStringSync().contains('name: flutter_websites')) {
      return dir.path;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw StateError('Could not locate flutter_websites workspace root.');
    }
    dir = parent;
  }
}

Set<String> _discoverWorkspaceOutlinedIcons(String workspaceRoot) {
  final icons = <String>{};
  for (final relDir in [
    'packages/site_shared/lib',
    'sites/docs/lib',
    'sites/www/lib',
  ]) {
    icons
      ..addAll(_discoverLibDartIcons(workspaceRoot, relDir))
      ..addAll(_discoverLibScssIcons(workspaceRoot, relDir));
  }
  for (final relDir in ['sites/docs/src', 'sites/www/content']) {
    icons.addAll(_discoverContentIcons(workspaceRoot, relDir));
  }
  return icons;
}

Set<String> _discoverLibDartIcons(String workspaceRoot, String relDir) {
  final icons = <String>{};
  for (final file in _listFiles(p.join(workspaceRoot, relDir), {'.dart'})) {
    final rel = _posixRelPath(workspaceRoot, file.path);
    if (_isGeneratedDartFile(rel)) continue;
    icons.addAll(
      extractDartOutlinedIcons(file.readAsStringSync(), sourcePath: rel),
    );
  }
  return icons;
}

Set<String> _discoverLibScssIcons(String workspaceRoot, String relDir) {
  final icons = <String>{};
  for (final file in _listFiles(p.join(workspaceRoot, relDir), {'.scss'})) {
    final rel = _posixRelPath(workspaceRoot, file.path);
    icons.addAll(
      extractScssOutlinedIcons(file.readAsStringSync(), sourcePath: rel),
    );
  }
  return icons;
}

Set<String> _discoverContentIcons(String workspaceRoot, String relDir) {
  final icons = <String>{};
  const exts = {'.md', '.html', '.yaml', '.yml', '.json'};
  for (final file in _listFiles(p.join(workspaceRoot, relDir), exts)) {
    final rel = _posixRelPath(workspaceRoot, file.path);
    final ext = p.extension(rel).toLowerCase();
    final content = file.readAsStringSync();
    if (ext == '.md' || ext == '.html') {
      icons.addAll(extractMarkupOutlinedIcons(content, sourcePath: rel));
    } else if (!rel.startsWith('sites/www/')) {
      icons.addAll(extractDataIconValues(content, sourcePath: rel));
    }
  }
  return icons;
}

String _posixRelPath(String root, String filePath) =>
    p.posix.joinAll(p.split(p.relative(filePath, from: root)));

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

final RegExp _validLigaturePattern = RegExp(r'^[a-z][a-z0-9_]*$');
final RegExp _cStyleCommentPattern = RegExp(
  r'''("(?:\\.|[^"\\])*")|('(?:\\.|[^'\\])*')|//[^\n]*|/\*[\s\S]*?\*/''',
);
final RegExp _fencedCodeBlockPattern = RegExp(r'```[\s\S]*?```');
final RegExp _materialIconCallPattern = RegExp(
  r'''\bMaterialIcon\(\s*['"]([a-z0-9_]+)['"]''',
);
final RegExp _namedIconArgPattern = RegExp(
  r'''\b(?:leadingIcon|trailingIcon|icon|iconId)\s*:\s*(?:[^,);\n]*?\?\s*)?['"]([a-z0-9_]+)['"](?:\s*:\s*['"]([a-z0-9_]+)['"])?''',
);
final RegExp _materialSpanInDartPattern = RegExp(
  r'''material-symbols['"][\s\S]{0,200}?\.text\(\s*['"]([a-z0-9_]+)['"]\s*\)''',
);
final RegExp _enumOrSwitchReturnPattern = RegExp(
  r'''=>\s*['"]([a-z][a-z0-9_]*)['"]|\(\s*['"]([a-z][a-z0-9_]*)['"]\s*,''',
);
final RegExp _themeModeCtorPattern = RegExp(
  r'''\b(?:light|dark|auto)\([^)]*['"]([a-z][a-z0-9_]*)['"]\s*\)''',
);
final RegExp _htmlSpanIconPattern = RegExp(
  r'''<span\b[^>]*class=["']([^"']*material-symbols[^"']*)["'][^>]*>([^<]*)</span>''',
);
final RegExp _customIconTagPattern = RegExp(
  r'''<(?:Icon|MaterialIcon|PlatformCard|SummaryCardItem|Chip|Button)\b([^>]*?)/?>''',
);
final RegExp _iconAttrPattern = RegExp(
  r'''\b(?:icon|id)=["']([a-z0-9_]+)["']''',
);
final RegExp _yamlIconLinePattern = RegExp(
  r'''^\s*icon:\s*['"]?([a-z][a-z0-9_]*)['"]?\s*$''',
  multiLine: true,
);
final RegExp _scssContentPattern = RegExp(
  r'''\bcontent\s*:\s*['"]([a-z0-9_]+)['"]''',
);

/// HTML element names constructed via `md.Element('span', ...)` in
/// `alert_syntax.dart` that match [_enumOrSwitchReturnPattern].
const Set<String> _htmlElementTokens = {'aside', 'div', 'span'};

Set<String> extractDartOutlinedIcons(
  String dartSource, {
  required String sourcePath,
}) {
  final stripped = _stripCStyleComments(dartSource);
  final icons = <String>{};

  for (final pattern in [
    _materialIconCallPattern,
    _namedIconArgPattern,
    _materialSpanInDartPattern,
  ]) {
    _addValidatedMatches(icons, pattern.allMatches(stripped), sourcePath);
  }

  if (sourcePath.endsWith('theme_switcher.dart')) {
    _addValidatedMatches(
      icons,
      _themeModeCtorPattern.allMatches(stripped),
      sourcePath,
    );
  }

  if (_isEnumIconSource(sourcePath)) {
    _addValidatedMatches(
      icons,
      _enumOrSwitchReturnPattern.allMatches(stripped),
      sourcePath,
      ignoreTokens: _htmlElementTokens,
    );
  }

  return icons;
}

bool _isEnumIconSource(String sourcePath) =>
    sourcePath.endsWith('page_header_options.dart') ||
    sourcePath.endsWith('alert_syntax.dart') ||
    sourcePath.endsWith('glossary.dart') ||
    sourcePath.endsWith('sidenav.dart');

void _addValidatedMatches(
  Set<String> icons,
  Iterable<RegExpMatch> matches,
  String sourcePath, {
  Set<String> ignoreTokens = const {},
}) {
  for (final match in matches) {
    for (var group = 1; group <= match.groupCount; group++) {
      final value = match.group(group);
      if (value == null || ignoreTokens.contains(value)) continue;
      _validateLigature(value, sourcePath: sourcePath);
      icons.add(value);
    }
  }
}

Set<String> extractMarkupOutlinedIcons(
  String markup, {
  required String sourcePath,
}) {
  final withoutFences = markup.replaceAll(_fencedCodeBlockPattern, '');
  final icons = <String>{};

  for (final match in _htmlSpanIconPattern.allMatches(withoutFences)) {
    final classes = match.group(1)!;
    if (classes.contains('material-symbols-rounded')) continue;
    final ligature = match.group(2)!.trim();
    _validateLigature(ligature, sourcePath: sourcePath);
    icons.add(ligature);
  }

  for (final match in _customIconTagPattern.allMatches(withoutFences)) {
    final attrs = match.group(1)!;
    for (final attrMatch in _iconAttrPattern.allMatches(attrs)) {
      final ligature = attrMatch.group(1)!;
      _validateLigature(ligature, sourcePath: sourcePath);
      icons.add(ligature);
    }
  }

  icons.addAll(extractDataIconValues(withoutFences, sourcePath: sourcePath));
  return icons;
}

Set<String> extractDataIconValues(
  String content, {
  required String sourcePath,
}) {
  final icons = <String>{};
  for (final match in _yamlIconLinePattern.allMatches(content)) {
    final value = match.group(1)!;
    if (value != 'none') {
      _validateLigature(value, sourcePath: sourcePath);
      icons.add(value);
    }
  }
  return icons;
}

Set<String> extractScssOutlinedIcons(
  String scssSource, {
  required String sourcePath,
}) {
  final stripped = _stripCStyleComments(scssSource);
  if (!stripped.contains('site-icon-fontFamily') &&
      !stripped.contains('material-symbol')) {
    return const {};
  }
  if (stripped.contains('material-symbols-rounded')) return const {};

  final icons = <String>{};
  for (final match in _scssContentPattern.allMatches(stripped)) {
    final value = match.group(1)!;
    _validateLigature(value, sourcePath: sourcePath);
    icons.add(value);
  }
  return icons;
}

String _stripCStyleComments(String source) =>
    source.replaceAllMapped(_cStyleCommentPattern, (match) {
      if (match.group(1) != null || match.group(2) != null) {
        return match.group(0)!;
      }
      return '';
    });

void _validateLigature(String ligature, {required String sourcePath}) {
  if (!_validLigaturePattern.hasMatch(ligature)) {
    throw StateError(
      'Invalid or dynamic Material Symbols ligature "$ligature" in '
      '$sourcePath.',
    );
  }
}
