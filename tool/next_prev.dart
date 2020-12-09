import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

const frontMatterMarker = '---';

/// Update the front matter next/prev entries of all cookbook pages.
void main(List<String> args) {
  if (!File('pubspec.yaml').existsSync()) {
    _warn('This tool must be run from the project root.');
    exit(1);
  }

  final pageList = _getPageList();
  final orderedPageList = _sortPageList(pageList);

  _doublyLinkPages(orderedPageList);
  orderedPageList.forEach(_updatePageLinks);

  print('Processed ${orderedPageList.length} pages.');
}

List<Page> _getPageList() {
  final basePath = 'src/docs/cookbook';

  Iterable<FileSystemEntity> files = Directory(basePath)
      .listSync(recursive: true)
      .where((FileSystemEntity entity) =>
          entity is File &&
          entity.path.endsWith('.md') &&
          !entity.path.contains('index.md'));

  Iterable<Page> pages = files.map((e) => Page(e)).where((p) => p.rest != null);

  return pages.toList();
}

List<Page> _sortPageList(List<Page> pageList) => pageList
  ..sort((a, b) {
    var dirComp = a.dir.compareTo(b.dir);
    return dirComp != 0 ? dirComp : a.title.compareTo(b.title);
  })
  ..toList();

void _doublyLinkPages(List<Page> orderedPageList) {
  Page prev;
  for (final page in orderedPageList) {
    if (prev != null) {
      prev.next = page;
      page.prev = prev;
    }
    prev = page;
  }
}

void _updatePageLinks(Page page) {
  yamlRemoveKey(page.frontMatter, 'prev');
  yamlRemoveKey(page.frontMatter, 'next');

  if (page.prev != null) yamlAppendKey(page.frontMatter, 'prev', page.prev);
  if (page.next != null) yamlAppendKey(page.frontMatter, 'next', page.next);

  page.file.writeAsStringSync(page.content);
}

void _warn(String msg) => print("WARNING: $msg");

void yamlRemoveKey(List<String> frontMatter, String key) {
  var i = frontMatter.indexOf('$key:');
  if (i < 0) return;
  frontMatter.removeAt(i);
  while (i < frontMatter.length && frontMatter[i].startsWith(' ')) {
    frontMatter.removeAt(i);
  }
}

void yamlAppendKey(List<String> frontMatter, String key, Page page) {
  // Add the key
  var i = frontMatter.length;
  var title = page.title;
  if (title.contains('"')) title = '"' + title + '"';
  frontMatter.insert(i++, '$key:');
  frontMatter.insert(i++, '  title: $title');
  frontMatter.insert(i++, '  path: ${page.path}');
}

class Page {
  final File file;
  String title;
  String path;
  String dir;

  // @nullable
  Page prev, next;
  List<String> frontMatter, rest;

  Page(this.file) {
    dir = p.dirname(file.path);
    path = file.path.substring('src'.length); // Skip 'src' prefix
    path = path.substring(0, path.length - '.md'.length); // Drop '.md' suffix
    _readAndParsePage();
  }

  void _readAndParsePage() {
    final content = file.readAsStringSync();
    final lines = content.split('\n');

    if (lines[0] != frontMatterMarker) {
      _warn('Jekyll frontmatter expected but none found: ${file.path}');
      return;
    }

    final endOfFrontMatterIndex = lines.indexOf(frontMatterMarker, 1);
    if (endOfFrontMatterIndex < 0) {
      _warn(
          'Jekyll frontmatter has no ending "$frontMatterMarker" marker: ${file.path}');
      return;
    }

    frontMatter = lines.getRange(1, endOfFrontMatterIndex).toList();
    rest = lines.getRange(endOfFrontMatterIndex + 1, lines.length).toList();

    final yaml = loadYaml(frontMatter.join('\n'));
    title = yaml['title'];
  }

  String get content {
    final output = [frontMatterMarker];
    output.addAll(frontMatter);
    output.add(frontMatterMarker);
    output.addAll(rest);
    return output.join('\n');
  }

  @override
  String toString() => '$path';
}
