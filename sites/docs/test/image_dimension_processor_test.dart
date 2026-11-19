// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:docs_flutter_dev_site/src/components/common/dash_image.dart';
import 'package:docs_flutter_dev_site/src/extensions/image_dimension_processor.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as p;
import 'package:site_shared/image_dimensions.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  late Directory tempWebDir;

  setUp(() {
    clearImageDimensionsCache();
    tempWebDir = Directory.systemTemp.createTempSync('docs_img_dim_test_');
    addTearDown(() => tempWebDir.deleteSync(recursive: true));

    final assetFile = File(
      p.join(tempWebDir.path, 'assets', 'images', 'docs', 'diagram.png'),
    )..createSync(recursive: true);
    assetFile.writeAsBytesSync(_minimalPngHeader(width: 800, height: 400));
  });

  test('populates intrinsic width and height when absent', () async {
    final processor = ImageDimensionProcessor(webRoot: tempWebDir.path);
    final result = await processor.apply(_page(), const [
      ElementNode('img', {'src': '/assets/images/docs/diagram.png'}, null),
    ]);

    final imgNode = result.single as ElementNode;
    expect(imgNode.attributes['width'], '800');
    expect(imgNode.attributes['height'], '400');
  });

  test(
    'computes proportional height and strips px suffix on pixel width',
    () async {
      final processor = ImageDimensionProcessor(webRoot: tempWebDir.path);
      final result = await processor.apply(_page(), const [
        ElementNode('img', {
          'src': '/assets/images/docs/diagram.png',
          'width': '320px',
        }, null),
      ]);

      final imgNode = result.single as ElementNode;
      expect(imgNode.attributes['width'], '320');
      expect(imgNode.attributes['height'], '160');
    },
  );

  test(
    'moves percentage width to style and sets intrinsic HTML dimensions',
    () async {
      final processor = ImageDimensionProcessor(webRoot: tempWebDir.path);
      final result = await processor.apply(_page(), const [
        ElementNode('img', {
          'src': '/assets/images/docs/diagram.png',
          'width': '50%',
        }, null),
      ]);

      final imgNode = result.single as ElementNode;
      expect(imgNode.attributes['style'], 'width: 50%;');
      expect(imgNode.attributes['width'], '800');
      expect(imgNode.attributes['height'], '400');
    },
  );

  test(
    'moves percentage height to style with width: auto and sets intrinsic '
    'HTML dimensions',
    () async {
      final processor = ImageDimensionProcessor(webRoot: tempWebDir.path);
      final result = await processor.apply(_page(), const [
        ElementNode('img', {
          'src': '/assets/images/docs/diagram.png',
          'height': '50%',
        }, null),
      ]);

      final imgNode = result.single as ElementNode;
      expect(imgNode.attributes['style'], 'height: 50%; width: auto;');
      expect(imgNode.attributes['width'], '800');
      expect(imgNode.attributes['height'], '400');
    },
  );

  test(
    'handles empty dimension attributes and inline height-only styles cleanly',
    () async {
      final processor = ImageDimensionProcessor(webRoot: tempWebDir.path);
      final result = await processor.apply(_page(), const [
        ElementNode('img', {
          'src': '/assets/images/docs/diagram.png',
          'width': '   ',
        }, null),
        ElementNode('img', {
          'src': '/assets/images/docs/diagram.png',
          'style': 'height: 200px',
        }, null),
      ]);

      final emptyWidthImg = result[0] as ElementNode;
      expect(emptyWidthImg.attributes.containsKey('style'), isFalse);
      expect(emptyWidthImg.attributes['width'], '800');
      expect(emptyWidthImg.attributes['height'], '400');

      final styledHeightImg = result[1] as ElementNode;
      expect(
        styledHeightImg.attributes['style'],
        'height: 200px; width: auto;',
      );
      expect(styledHeightImg.attributes['width'], '800');
      expect(styledHeightImg.attributes['height'], '400');
    },
  );

  test(
    'rejects malformed URIs, colon paths, and path traversal outside webRoot',
    () {
      final outsideName = 'outside_${p.basename(tempWebDir.path)}.png';
      final outsideFile = File(p.join(tempWebDir.parent.path, outsideName))
        ..writeAsBytesSync(_minimalPngHeader(width: 100, height: 100));
      addTearDown(() {
        if (outsideFile.existsSync()) outsideFile.deleteSync();
      });

      expect(
        resolveDocsWebImageDimensions('/foo:bar.png', webRoot: tempWebDir.path),
        isNull,
      );
      expect(
        resolveDocsWebImageDimensions(
          '/assets/100%.png',
          webRoot: tempWebDir.path,
        ),
        isNull,
      );
      expect(
        resolveDocsWebImageDimensions(
          '/../$outsideName',
          webRoot: tempWebDir.path,
        ),
        isNull,
      );
    },
  );

  test(
    'DashImage appends width: auto on height-only overrides',
    () async {
      final component = DashImage(webRoot: tempWebDir.path).apply(
        'DashImage',
        const {'image': 'diagram.png', 'height': '240px', 'alt': 'Diagram'},
        null,
      );
      final response = await renderComponent(component, standalone: true);
      final html = String.fromCharCodes(response.body);
      expect(html, contains('style="height: 240px; width: auto;"'));
      expect(html, contains('width="800"'));
      expect(html, contains('height="400"'));
    },
  );
}

Page _page() => Page(
  path: 'index.md',
  url: '/',
  content: '',
  initialData: const {
    'page': <String, Object?>{},
    'site': {'url': 'https://docs.flutter.dev', 'title': 'Flutter'},
  },
  config: const PageConfig(),
  loader: MemoryLoader(pages: []),
);

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
