// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

final class InlineExcerptsCommand extends Command<int> {
  @override
  String get description =>
      'Inline code excerpts from Markdown files into example files.';

  @override
  String get name => 'inline-excerpts';

  @override
  Future<int> run() async {
    final filePath = argResults?.rest.firstOrNull;
    if (filePath == null) {
      stderr.writeln('Please provide a file path.');
      return 1;
    }

    final file = File(filePath);
    if (!file.existsSync()) {
      stderr.writeln('File not found: ${file.path}');
      return 1;
    }

    _processFile(file);
    return 0;
  }

  void _processFile(File file) {
    final lines = file.readAsLinesSync();
    final newLines = <String>[];
    var inMagicBlock = false;
    var magicBlockLines = <String>[];
    var magicBlockIndent = '';
    String? id;

    for (final line in lines) {
      if (inMagicBlock) {
        if (line.trim() == '```') {
          inMagicBlock = false;
          if (id != null) {
            final newFile = _createExampleFile(file, id, magicBlockLines);
            newLines.add('<?code-excerpt "${newFile.path}"?>');
            magicBlockLines.clear();
            id = null;
          }
        } else {
          magicBlockLines.add(line);
        }
      } else if (line.trim().startsWith('```dart magic')) {
        inMagicBlock = true;
        magicBlockLines = [];
        magicBlockIndent = line.substring(0, line.indexOf('`'));
        id = _getId(line);
      } else {
        newLines.add(line);
      }
    }

    if (magicBlockLines.isNotEmpty) {
      newLines.addAll(magicBlockLines);
    }

    file.writeAsStringSync(newLines.join('\n'));
  }

  String? _getId(String line) {
    final match = RegExp(r'id=([\w-]+)').firstMatch(line);
    return match?.group(1);
  }

  File _createExampleFile(
      File originalFile, String id, List<String> lines) {
    final originalFileName = path.basenameWithoutExtension(originalFile.path);
    final sanitizedFileName = originalFileName.replaceAll('-', '_');
    final newFileName = '${sanitizedFileName}_$id.dart';
    final newPath = path.join('examples', newFileName);

    final newFile = File(newPath);
    newFile.createSync(recursive: true);
    newFile.writeAsStringSync(lines.join('\n'));

    return newFile;
  }
}