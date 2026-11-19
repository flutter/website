// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:archive/archive.dart';
import 'package:jaspr/server.dart' show kGenerateMode;
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

/// Packages the DartPad fences in a single rendered page.
final class DartPadProjects {
  DartPadProjects(this.page);

  final Page page;
  String _pathBase = '';
  String? _nextExcerpt;
  int _archiveCount = 0;

  static final _base = RegExp(r'^<!--code-excerpt\s+path-base\s*=\s*"([^"]*)"');
  static final _file = RegExp(r'^<!--code-excerpt\s+"([^"\s]+)');
  static final _packageName = RegExp(r'^[a-z_][a-z0-9_]*$');
  static final String _examples = p.canonicalize(
    p.join('..', '..', 'examples'),
  );

  /// Tracks the page's excerpt directory and consumes a file directive at
  /// the next block, even when that block is an ordinary code sample.
  String? excerptFor(Node node) {
    if (node case TextNode(:final text)) {
      if (text.trim().isEmpty) return null;
      if (node.raw && text.startsWith('<!--code-excerpt')) {
        if (_base.firstMatch(text) case final match?) {
          _pathBase = match[1]!;
        }
        final file = _file.firstMatch(text)?[1];
        _nextExcerpt = file == null ? null : p.join(_pathBase, file);
        return null;
      }
    }
    final excerpt = _nextExcerpt;
    _nextExcerpt = null;
    return excerpt;
  }

  /// Packages [source] with the pubspec of the example at [excerpt] or,
  /// without an excerpt, with the [dependencies] code block option.
  ///
  /// The [dependencies] option is a flow-style YAML map of
  /// package names to pub package descriptors.
  ({String archive, String? file}) build(
    String source, {
    required String? excerpt,
    required String? dependencies,
  }) {
    final manifest = _manifest(excerpt, dependencies);
    final packages = Map<String, Object?>.from(
      manifest['dependencies'] as Map? ?? {},
    );
    final isFlutter = packages.containsKey('flutter');
    final file = isFlutter ? 'lib/main.dart' : 'bin/main.dart';
    final files = {file: source};
    if (packages.containsKey('video_player')) {
      files[file] = _registerVideoPlayer(source);
      files['lib/dartpad_plugins.dart'] = _videoPlugin;
      packages['flutter_web_plugins'] = {'sdk': 'flutter'};
      packages.putIfAbsent('video_player_web', () => '^2.4.0');
    }

    files['pubspec.yaml'] = YamlWriter(allowUnquotedStrings: true).write({
      'name': manifest['name'],
      'environment': manifest['environment'],
      if (packages.isNotEmpty) 'dependencies': packages,
      if (manifest['flutter'] case final settings?)
        'flutter': settings
      else if (isFlutter)
        'flutter': {'uses-material-design': true},
    });

    final tar = Archive();
    for (final MapEntry(:key, :value) in files.entries) {
      tar.add(ArchiveFile.string(key, value)..lastModTime = 0);
    }
    final bytes = GZipCodec(level: 9).encode(TarEncoder().encodeBytes(tar));
    final index = _archiveCount++;
    final String archive;
    if (kGenerateMode) {
      // Name archives by page and position rather than by content, so
      // a page cached or left open from an earlier deploy still finds one.
      final route = page.url.replaceAll(RegExp(r'^/+|/+$'), '');
      archive =
          '/assets/dartpad/${route.isEmpty ? 'index' : route}/$index.tar.gz';
      final output = File(p.join('build', 'jaspr', archive.substring(1)));
      output.parent.createSync(recursive: true);
      output.writeAsBytesSync(bytes);
    } else {
      archive = Uri.dataFromBytes(
        bytes,
        mimeType: 'application/gzip',
      ).toString();
    }
    // DartPad opens `lib/main.dart` unless the embed names another file.
    return (archive: archive, file: isFlutter ? null : file);
  }

  Map<Object?, Object?> _manifest(String? excerpt, String? dependencies) =>
      switch ((excerpt, dependencies)) {
        (final excerpt?, null) => _exampleManifest(excerpt),
        (null, final dependencies?) => {
          'name': 'dartpad_example',
          'environment': _readManifest(
            p.join(_examples, 'pubspec.yaml'),
          )['environment'],
          'dependencies': _parseDependencies(dependencies),
        },
        (null, null) => throw StateError(
          'A dartpad code block in ${page.path} needs a preceding '
          'code-excerpt directive or a dependencies option.',
        ),
        (_?, _?) => throw StateError(
          'A dartpad code block in ${page.path} has both a code-excerpt '
          'directive and a dependencies option. '
          "Remove the option and edit the example's pubspec instead.",
        ),
      };

  YamlMap _exampleManifest(String excerpt) {
    var directory = p.dirname(p.canonicalize(p.join(_examples, excerpt)));
    while (p.isWithin(_examples, directory)) {
      final manifest = File(p.join(directory, 'pubspec.yaml'));
      if (manifest.existsSync()) return _readManifest(manifest.path);
      directory = p.dirname(directory);
    }
    throw StateError('No example pubspec for "$excerpt" in ${page.path}.');
  }

  YamlMap _readManifest(String path) =>
      loadYamlDocument(page.readPartialSync(path)).contents as YamlMap;

  YamlMap _parseDependencies(String dependencies) {
    final parsed = loadYaml(dependencies);
    if (parsed is! YamlMap) {
      throw StateError(
        'The dependencies option of a dartpad code block in ${page.path} '
        'must be a flow-style YAML map, such as "{flutter: {sdk: flutter}}".',
      );
    }
    // YAML reads a descriptor written as `name:^1.2.3` as part of the name.
    for (final name in parsed.keys) {
      if (name is! String || !_packageName.hasMatch(name)) {
        throw StateError(
          'The dependencies option of a dartpad code block in ${page.path} '
          'has an invalid package name "$name". '
          'Separate each name from its descriptor with a colon and a space.',
        );
      }
    }
    return parsed;
  }
}

// Preview's editor Run button always starts the open file, even when the
// URL names a separate entrypoint. Register the plugin in that file's main.
String _registerVideoPlayer(String source) {
  final lastImport = RegExp(
    r'^import .*;$',
    multiLine: true,
  ).allMatches(source).lastOrNull;
  final main = RegExp(
    r'^void main\(\) (?:=> (.*);|\{)$',
    multiLine: true,
  ).firstMatch(source);
  if (lastImport == null || main == null) {
    throw StateError(
      'A video_player DartPad example needs an import and '
      'a one-line or block-bodied `void main()`.',
    );
  }
  const registration = 'dartpad.registerVideoPlayer();';
  final registered = switch (main[1]) {
    final call? => 'void main() {\n  $registration\n  $call;\n}',
    null => 'void main() {\n  $registration',
  };
  // Edit main before the earlier imports so the import offset stays valid.
  return source
      .replaceRange(main.start, main.end, registered)
      .replaceRange(
        lastImport.end,
        lastImport.end,
        "\n\nimport 'dartpad_plugins.dart' as dartpad;",
      );
}

const _videoPlugin = '''
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:video_player_web/video_player_web.dart';

void registerVideoPlayer() {
  VideoPlayerPlugin.registerWith(webPluginRegistrar);
  webPluginRegistrar.registerMessageHandler();
}
''';
