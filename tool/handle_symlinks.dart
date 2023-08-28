import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

final symlinkFile = File('.symlinks');

void main(List<String> args) async {
  final command = args.singleOrNull;
  if (command == null) {
    throw ArgumentError.notNull();
  }
  switch (command) {
    case 'find':
      _find();
    case 'replace':
      _replace();
    default:
      throw UnimplementedError();
  }
}

void _find() {
  final links = Directory.current
      .listSync(recursive: true)
      .where(
        (file) => !file.path.contains('node_modules'),
      ) // Exclude node_modules.
      .where((file) => FileSystemEntity.isLinkSync(file.path));
  final linksContent = Map.fromEntries(
    links.map(
      (link) => MapEntry(
        Uri.file(
          p.relative(
            link.path,
            from: Directory.current.path,
          ),
        ).toFilePath(windows: false),
        Uri.file(
          p.relative(
            link.resolveSymbolicLinksSync(),
            from: Directory.current.path,
          ),
        ).toFilePath(windows: false),
      ),
    ),
  );
  print(linksContent.entries.join('\n'));
  symlinkFile.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(linksContent),
  );
}

Future<void> _replace() async {
  final linksContent =
      jsonDecode(symlinkFile.readAsStringSync()) as Map<String, dynamic>;
  final links = linksContent.entries;
  if (links.isEmpty) {
    return;
  }
  for (final link in links) {
    final key = p.join(
      Directory.current.path,
      Uri.file(link.key).toFilePath(),
    );
    final value = p.join(
      Directory.current.path,
      Uri.file(link.value).toFilePath(),
    );
    if (FileSystemEntity.isDirectorySync(key)) {
      await Directory(key).delete(recursive: true);
      _copySync(Directory(value), Directory(key));
    } else {
      await File(key).delete();
      File(value).copySync(key);
    }
  }
}

void _copySync(Directory source, Directory destination) {
  // Creates the destination folder if not exist.
  if (!destination.existsSync()) {
    destination.createSync(recursive: true);
  }
  // Get all files from source.
  source.listSync(recursive: false).forEach((entity) {
    final newPath = p.join(destination.path, p.basename(entity.path));
    if (entity is File) {
      entity.copySync(newPath);
    } else if (entity is Directory) {
      _copySync(entity, Directory(newPath));
    }
  });
}
