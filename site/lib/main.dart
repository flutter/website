// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';
import 'package:path/path.dart' as path;

import 'jaspr_options.dart'; // Generated. Do not remove or edit.
import 'src/components/common/card.dart';
import 'src/components/common/client/download_latest_button.dart';
import 'src/components/common/client/os_selector.dart';
import 'src/components/common/dash_image.dart';
import 'src/components/common/tabs.dart';
import 'src/components/common/youtube_embed.dart';
import 'src/components/pages/archive_table.dart';
import 'src/components/pages/devtools_release_notes_index.dart';
import 'src/components/pages/expansion_list.dart';
import 'src/components/pages/learning_resource_index.dart';
import 'src/extensions/registry.dart';
import 'src/layouts/catalog_page_layout.dart';
import 'src/layouts/doc_layout.dart';
import 'src/layouts/toc_layout.dart';
import 'src/loaders/data_processor.dart';
import 'src/markdown/markdown_parser.dart';
import 'src/pages/custom_pages.dart';
import 'src/pages/robots_txt.dart';
import 'src/templating/dash_template_engine.dart';
import 'src/util.dart';

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(options: defaultJasprOptions);

  runApp(_docsFlutterDevSite);
}

Component get _docsFlutterDevSite => ContentApp.custom(
  eagerlyLoadAllPages: true,
  loaders: [
    FilesystemLoader(
      path.join(siteSrcDirectoryPath, 'content'),
      keepSuffixPattern: _passThroughPattern,
    ),
    MemoryLoader(pages: allMemoryPages),
  ],
  configResolver: PageConfig.all(
    dataLoaders: [
      FilesystemDataLoader(path.join(siteSrcDirectoryPath, 'data')),
      DataProcessor(),
    ],
    templateEngine: DashTemplateEngine(
      partialDirectoryPath: path.canonicalize(
        path.join(siteSrcDirectoryPath, '_includes'),
      ),
    ),
    parsers: const [
      DashMarkdownParser(),
      HtmlParser(),
    ],
    rawOutputPattern: _passThroughPattern,
    extensions: allNodeProcessingExtensions,
    components: _embeddableComponents,
    layouts: const [DocLayout(), TocLayout(), CatalogPageLayout()],
    theme: const ContentTheme.none(),
    secondaryOutputs: [
      const RobotsTxtOutput(),
      MarkdownOutput(
        createHeader: (page) {
          final header = StringBuffer();
          if (page.data.page['title'] case final String title
              when title.isNotEmpty) {
            header.writeln('# $title');

            if (page.data.page['description'] case final String description
                when description.isNotEmpty) {
              header.writeln();
              header.writeln('> $description');
            }
          }

          return header.toString();
        },
      ),
    ],
  ),
);

final RegExp _passThroughPattern = RegExp(r'.*\.(txt|json|pdf)$');

/// Custom "components" that can be used from Markdown files.
List<CustomComponent> get _embeddableComponents => [
  const DashTabs(),
  const DashImage(),
  const YoutubeEmbed(),
  CustomComponent(
    pattern: RegExp('OSSelector', caseSensitive: false),
    builder: (_, _, _) => const OsSelector(),
  ),
  CustomComponent(
    pattern: RegExp('Card', caseSensitive: false),
    builder: (_, attrs, child) => Card.fromAttributes(attrs, child),
  ),
  CustomComponent(
    pattern: RegExp('LearningResourceIndex', caseSensitive: false),
    builder: (_, _, _) => LearningResourceIndex(),
  ),
  CustomComponent(
    pattern: RegExp('ArchiveTable'),
    builder: (_, attrs, _) => ArchiveTable.fromAttributes(attrs),
  ),
  CustomComponent(
    pattern: RegExp('DownloadLatestButton', caseSensitive: false),
    builder: (_, attrs, _) => DownloadLatestButton.fromAttributes(attrs),
  ),
  CustomComponent(
    pattern: RegExp('ExpansionList', caseSensitive: false),
    builder: (_, attrs, _) => ExpansionList.fromAttributes(attrs),
  ),
  CustomComponent(
    pattern: RegExp('DevToolsReleaseNotesIndex', caseSensitive: false),
    builder: (_, _, _) => const DevToolsReleaseNotesIndex(),
  ),
];
