// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_website/src/components/common/dash_image.dart';
import 'package:flutter_website/src/utils/image_dimensions.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';
import 'package:path/path.dart' as p;
import 'package:site_shared/image_dimensions.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  late Directory tempRoot;

  setUp(() {
    clearImageDimensionsCache();
    tempRoot = Directory.systemTemp.createTempSync('www_img_dim_test_');
    addTearDown(() => tempRoot.deleteSync(recursive: true));

    File(p.join(tempRoot.path, 'images', 'sample.png'))
      ..createSync(recursive: true)
      ..writeAsBytesSync(_minimalPngHeader(width: 960, height: 540));
  });

  test(
    'dimensionsForResolvedAsset resolves assets and ignores malformed URIs '
    'or traversal',
    () {
      final outsideFile = File(
        p.join(
          tempRoot.parent.path,
          'outside_${p.basename(tempRoot.path)}.png',
        ),
      )..writeAsBytesSync(_minimalPngHeader(width: 64, height: 64));
      addTearDown(() {
        if (outsideFile.existsSync()) outsideFile.deleteSync();
      });

      expect(
        dimensionsForResolvedAsset(
          '/assets/images/sample.png?v=1#top',
          assetRoots: [tempRoot.path],
        ),
        const ImageDimensions(width: 960, height: 540),
      );
      expect(
        dimensionsForResolvedAsset(
          '/assets/foo:bar.png',
          assetRoots: [tempRoot.path],
        ),
        isNull,
      );
      expect(
        dimensionsForResolvedAsset(
          '/assets/100%.png',
          assetRoots: [tempRoot.path],
        ),
        isNull,
      );
      expect(
        dimensionsForResolvedAsset(
          '/assets/../${p.basename(outsideFile.path)}',
          assetRoots: [tempRoot.path],
        ),
        isNull,
      );
    },
  );

  test(
    'DashImage appends width: auto on height-only overrides without width',
    () async {
      final assetManager = AssetManager(
        directory: tempRoot.path,
        assetTransformers: const [],
      );
      final app = ContentApp.custom(
        loaders: [
          MemoryLoader(
            pages: const [
              MemoryPage(
                path: 'index.md',
                content:
                    '<DashImage src="/images/sample.png" height="240px" '
                    'alt="Sample" />\n',
              ),
            ],
          ),
        ],
        configResolver: PageConfig.all(
          enableFrontmatter: false,
          dataLoaders: [assetManager.dataLoader],
          parsers: const [MarkdownParser()],
          components: const [DashImage()],
          theme: const ContentTheme.none(),
        ),
      );

      final response = await renderComponent(
        app,
        request: Request('GET', Uri.parse('https://0.0.0.0/')),
        standalone: true,
      );
      final html = String.fromCharCodes(response.body);
      expect(html, contains('style="height: 240px; width: auto;"'));
    },
  );
}

Uint8List _minimalPngHeader({required int width, required int height}) {
  final bytes = ByteData(24);
  const sig = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
  for (var i = 0; i < sig.length; i++) {
    bytes.setUint8(i, sig[i]);
  }
  bytes.setUint32(8, 13);
  const ihdr = [0x49, 0x48, 0x44, 0x52];
  for (var i = 0; i < ihdr.length; i++) {
    bytes.setUint8(12 + i, ihdr[i]);
  }
  bytes.setUint32(16, width);
  bytes.setUint32(20, height);
  return bytes.buffer.asUint8List();
}
