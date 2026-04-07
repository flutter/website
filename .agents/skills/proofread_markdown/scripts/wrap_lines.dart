import 'dart:io';

/// A script to wrap markdown lines at 80 columns, preserving headings and code blocks.
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart wrap_lines.dart <file_path>');
    exit(1);
  }

  final filePath = arguments[0];
  final file = File(filePath);

  if (!file.existsSync()) {
    print('File not found: $filePath');
    exit(1);
  }

  final content = file.readAsStringSync();
  final wrappedContent = wrapMarkdown(content);
  file.writeAsStringSync(wrappedContent);

  print('Successfully wrapped markdown for $filePath');
}

String wrapMarkdown(String content, {int width = 80}) {
  final lines = content.split('\n');
  final output = <String>[];
  bool inCodeBlock = false;

  for (final line in lines) {
    final stripped = line.trim();

    // Handle code blocks
    if (stripped.startsWith('```') || stripped.startsWith('~~~')) {
      inCodeBlock = !inCodeBlock;
      output.add(line);
      continue;
    }

    if (inCodeBlock) {
      output.add(line);
      continue;
    }

    // Handle headings
    if (stripped.startsWith('#')) {
      output.add(line);
      continue;
    }

    // Handle empty lines
    if (stripped.isEmpty) {
      output.add('');
      continue;
    }

    // Handle lists or quotes (matching python script's simple approach)
    if (stripped.startsWith('-') ||
        stripped.startsWith('*') ||
        stripped.startsWith('1.') ||
        stripped.startsWith('2.') ||
        stripped.startsWith('3.')) {
      output.addAll(wrapText(line, width));
      continue;
    }

    // Normal text paragraph
    output.addAll(wrapText(line, width));
  }

  return output.join('\n');
}

List<String> wrapText(String text, int width) {
  final words = text.split(RegExp(r'\s+'));
  final lines = <String>[];
  var currentLine = '';

  for (final word in words) {
    if ((currentLine + word).length > width) {
      if (currentLine.isNotEmpty) {
        lines.add(currentLine.trim());
        currentLine = word;
      } else {
        lines.add(word);
        currentLine = '';
      }
    } else {
      currentLine += (currentLine.isEmpty ? '' : ' ') + word;
    }
  }
  if (currentLine.isNotEmpty) {
    lines.add(currentLine.trim());
  }
  return lines;
}
