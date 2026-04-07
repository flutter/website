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
        RegExp(r'^\d+\.').hasMatch(stripped)) {
      output.addAll(wrapText(line, width));
      continue;
    }

    // Normal text paragraph
    output.addAll(wrapText(line, width));
  }

  return output.join('\n');
}

List<String> wrapText(String text, int width) {
  final leadingSpace = RegExp(r'^\s*').stringMatch(text) ?? '';
  final words = text.trim().split(RegExp(r'\s+'));
  final lines = <String>[];
  var currentLine = leadingSpace;

  for (final word in words) {
    final space = currentLine == leadingSpace ? '' : ' ';
    if ((currentLine.length + space.length + word.length) > width) {
      if (currentLine != leadingSpace) {
        lines.add(currentLine);
        currentLine = leadingSpace + word;
      } else {
        lines.add(leadingSpace + word);
        currentLine = leadingSpace;
      }
    } else {
      currentLine += space + word;
    }
  }
  if (currentLine != leadingSpace) {
    lines.add(currentLine);
  }
  return lines;
}
