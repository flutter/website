// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';
import 'package:path/path.dart' as path;

import 'jaspr_options.dart'; // Generated. Do not remove or edit.
import 'src/components/card.dart';
import 'src/components/client/archive_table.dart';
import 'src/components/client/download_latest_button.dart';
import 'src/components/expansion_list.dart';
import 'src/components/os_selector.dart';
import 'src/components/pages/devtools_release_notes_index.dart';
import 'src/components/pages/learning_resource_index.dart';
import 'src/components/tabs.dart';
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
    secondaryOutputs: [const RobotsTxtOutput(), MarkdownOutput()],
  ),
);

final RegExp _passThroughPattern = RegExp(r'.*\.(txt|json|pdf)$');

/// Custom "components" that can be used from Markdown files.
List<CustomComponent> get _embeddableComponents => [
  const DashTabs(),
  CustomComponent(
    pattern: RegExp('OSSelector', caseSensitive: false),
    builder: (name, attributes, child) {
      return const OsSelector();
    },
  ),
  CustomComponent(
    pattern: RegExp('Card', caseSensitive: false),
    builder: (name, attributes, child) {
      final link = attributes['link'];
      final title = attributes['title']!;
      final outlined = attributes['outlined'] == 'true';
      return Card(
        header: [
          header(classes: 'card-title', [text(title)]),
        ],
        content: [?child],
        link: link,
        filled: link != null,
        outlined: outlined,
      );
    },
  ),
  CustomComponent(
    pattern: RegExp('YouTubeEmbed', caseSensitive: false),
    builder: (name, attributes, child) {
      final rawVideoId = attributes['id'] as String;
      final videoTitle = attributes['title'] as String;
      final playlistId = attributes['playlist'];

      final String videoId;
      final int startTime;
      if (rawVideoId.contains('?')) {
        final idAndStartTime = rawVideoId.split('?');
        videoId = idAndStartTime[0];

        final rawStartTime = idAndStartTime[1].split('start=')[1];
        startTime = int.tryParse(rawStartTime) ?? 0;
      } else {
        startTime = 0;
        videoId = rawVideoId;
      }

      // Instead of directly including a YouTube embed iframe,
      // we use https://github.com/justinribeiro/lite-youtube which
      // lazily loads the video, significantly reduces page load times,
      // and enables configurability through element attributes.
      return raw('''
<lite-youtube videoid="$videoId" videotitle="$videoTitle" videoStartAt="$startTime" ${playlistId != null ? 'playlistid="$playlistId"' : ''}>
  <a class="lite-youtube-fallback" href="https://www.youtube.com/watch/$videoId" target="_blank" rel="noopener">Watch on YouTube in a new tab: "$videoTitle"</a>
</lite-youtube>
''');
    },
  ),
  CustomComponent(
    pattern: RegExp('LearningResourceIndex', caseSensitive: false),
    builder: (_, _, _) => LearningResourceIndex(),
  ),
  CustomComponent(
    pattern: RegExp('ArchiveTable'),
    builder: (_, attributes, _) {
      final os = attributes['os'] as String;
      final channel = attributes['channel'] as String;
      return ArchiveTable(os: os.toLowerCase(), channel: channel.toLowerCase());
    },
  ),
  CustomComponent(
    pattern: RegExp('DownloadLatestButton', caseSensitive: false),
    builder: (_, attributes, _) {
      final os = attributes['os'] as String;
      final arch = attributes['arch'];
      return DownloadLatestButton(
        os: os.toLowerCase(),
        arch: arch?.toLowerCase(),
      );
    },
  ),
  CustomComponent(
    pattern: RegExp('ExpansionList', caseSensitive: false),
    builder: (_, attributes, _) {
      final listName =
          attributes['list'] ??
          (throw Exception(
            'ExpansionList component requires a "list" attribute.',
          ));
      final baseId =
          attributes['baseid'] ??
          (throw Exception(
            'ExpansionList component requires a "baseId" attribute.',
          ));

      return ExpansionList.load(listName, baseId: baseId);
    },
  ),
  CustomComponent(
    pattern: RegExp('DevToolsReleaseNotesIndex', caseSensitive: false),
    builder: (_, _, _) => const DevToolsReleaseNotesIndex(),
  ),
];
