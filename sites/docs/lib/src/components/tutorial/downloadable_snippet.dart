// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;

import '../../extensions/code_block_processor.dart';
import '../../util.dart';
import '../common/client/copy_button.dart';
import '../common/client/download_button.dart';
import '../common/wrapped_code_block.dart';

class DownloadableSnippet extends CustomComponentBase {
  const DownloadableSnippet();

  @override
  Pattern get pattern => 'DownloadableSnippet';

  @override
  Component apply(_, Map<String, String> attributes, _) {
    final src = attributes['src'];
    final name = attributes['name'];

    if (src == null || name == null) {
      throw ArgumentError(
        'SnippetDownloadButton requires "src" and "name" attributes.',
      );
    }

    return Builder(
      builder: (context) {
        final page = context.page;
        final snippet = page.loader.readPartialSync(
          path.join(siteSrcDirectoryPath, '_snippets', src),
          page,
        );
        final language = src.split('.').last;

        final processedContent = CodeBlockProcessor.highlightCode(
          snippet
              .split('\n')
              .map((l) => CodeLine(content: l, highlights: const []))
              .toList(),
          language: language,
        );

        final codeBlock = WrappedCodeBlock(
          content: processedContent,
          language: language,
          languagesToHide: const {
            'plaintext',
            'text',
            'console',
            'ps',
            'diff',
          },
          title: name,
          showLineNumbers: true,
          showCopyButton: false,
          collapsed: true,
          actions: [
            DownloadButton(
              name: name,
            ),
            const CopyButton(
              title: 'Copy to clipboard',
            ),
          ],
        );

        return codeBlock;
      },
    );
  }
}
