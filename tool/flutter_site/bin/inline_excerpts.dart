import 'dart:io';

import 'package:path/path.dart' as path;

void main(List<String> args) {
  if (args.isEmpty) {
    print('Please provide a file path.');
    return;
  }

  final file = File(args[0]);
  if (!file.existsSync()) {
    print('File not found: ${file.path}');
    return;
  }

  processFile(file);
}

void processFile(File file) {
  final lines = file.readAsLinesSync();
  final newLines = <String>[];
  var inMagicBlock = false;
  var magicBlockLines = <String>[];
  var magicBlockIndent = '';

  for (final line in lines) {
    if (inMagicBlock) {
      if (line.trim() == '```') {
        inMagicBlock = false;
        final newFile = createExampleFile(file, magicBlockLines, magicBlockIndent);
        newLines.add('<?code-excerpt "${newFile.path}"?>');
        magicBlockLines.clear();
      } else {
        magicBlockLines.add(line);
      }
    } else if (line.trim().startsWith('```dart magic')) {
      inMagicBlock = true;
      magicBlockLines = [];
      magicBlockIndent = line.substring(0, line.indexOf('`'));
    } else {
      newLines.add(line);
    }
  }

  if (magicBlockLines.isNotEmpty) {
    // This should not happen if the file is well-formed.
    newLines.addAll(magicBlockLines);
  }

  file.writeAsStringSync(newLines.join('\n'));
}

File createExampleFile(File originalFile, List<String> lines, String indent) {
  final originalPath = originalFile.path;
  final relativePath = path.relative(originalPath, from: 'src/content');
  final newPath = path.join('examples', relativePath.replaceAll('.md', '.dart'));

  final newFile = File(newPath);
  newFile.createSync(recursive: true);
  newFile.writeAsStringSync(lines.map((line) => line.substring(indent.length)).join('\n'));

  return newFile;
}
