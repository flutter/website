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
  bool inFrontMatter = false;
  bool firstLine = true;

  for (final line in lines) {
    final stripped = line.trim();

    if (firstLine) {
      firstLine = false;
      if (stripped == '---') {
        inFrontMatter = true;
        output.add(line);
        continue;
      }
    }

    if (inFrontMatter) {
      output.add(line);
      if (stripped == '---') {
        inFrontMatter = false;
      }
      continue;
    }

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
  final content = text.trim();
  
  if (content.isEmpty) return [leadingSpace];

  // Split by spaces that follow punctuation (.,;:!?)
  // We use a lookbehind to keep the punctuation with the preceding chunk.
  final chunks = content.split(RegExp(r'(?<=[.,;:!?])\s+'));
  final lines = <String>[];
  var currentLine = leadingSpace;

  for (final chunk in chunks) {
    // If the chunk itself is longer than width, fallback to word wrapping for this chunk
    if (chunk.length > width) {
      // Flush current line if not empty
      if (currentLine != leadingSpace) {
        lines.add(currentLine);
        currentLine = leadingSpace;
      }
      
      // Word wrap the chunk
      final words = chunk.split(RegExp(r'\s+'));
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
      continue;
    }

    final space = currentLine == leadingSpace ? '' : ' ';
    if ((currentLine.length + space.length + chunk.length) > width) {
      if (currentLine != leadingSpace) {
        lines.add(currentLine);
      }
      currentLine = leadingSpace + chunk;
    } else {
      currentLine += space + chunk;
    }
  }

  if (currentLine != leadingSpace) {
    lines.add(currentLine);
  }

  return lines;
}
