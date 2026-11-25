// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter_website/main.server.options.dart';
import 'package:flutter_website/src/components/common/image_zoombox.dart';
import 'package:jaspr/server.dart';
import 'package:test/test.dart';

void main() {
  group('buildZoomboxTriggerLabel', () {
    test('uses alt text when non-empty', () {
      expect(
        buildZoomboxTriggerLabel(alt: 'Architecture diagram'),
        equals('Expand image: Architecture diagram'),
      );
    });

    test('falls back to caption when alt text is empty', () {
      expect(
        buildZoomboxTriggerLabel(
          alt: '   ',
          caption: 'Figure 1: Data flow',
        ),
        equals('Expand image: Figure 1: Data flow'),
      );
    });

    test('prefers alt text over caption when both are present', () {
      expect(
        buildZoomboxTriggerLabel(
          alt: 'Alt description',
          caption: 'Caption text',
        ),
        equals('Expand image: Alt description'),
      );
    });

    test('returns generic label when neither alt nor caption is present', () {
      expect(
        buildZoomboxTriggerLabel(alt: ''),
        equals('Expand image'),
      );
      expect(
        buildZoomboxTriggerLabel(alt: ' ', caption: '  '),
        equals('Expand image'),
      );
    });
  });

  group('buildZoomboxDialogLabel', () {
    test('uses alt or caption when present', () {
      expect(
        buildZoomboxDialogLabel(alt: 'Fine print diagram'),
        equals('Expanded image: Fine print diagram'),
      );
      expect(
        buildZoomboxDialogLabel(alt: '', caption: 'Detailed view'),
        equals('Expanded image: Detailed view'),
      );
    });

    test('returns generic label when empty', () {
      expect(
        buildZoomboxDialogLabel(alt: ''),
        equals('Expanded image'),
      );
    });
  });

  group('computeZoomScrollOffset', () {
    test('returns 0 when image fits within viewport', () {
      expect(
        computeZoomScrollOffset(
          clickRatio: 0.5,
          imageOffset: 24,
          imageSize: 800,
          viewportSize: 1200,
          scrollSize: 1200,
        ),
        equals(0),
      );
    });

    test('centers clicked point when overflowing', () {
      expect(
        computeZoomScrollOffset(
          clickRatio: 0.5,
          imageOffset: 24,
          imageSize: 2000,
          viewportSize: 1000,
          scrollSize: 2048,
        ),
        equals(524),
      );
    });

    test('clamps to start and end bounds', () {
      expect(
        computeZoomScrollOffset(
          clickRatio: 0.0,
          imageOffset: 24,
          imageSize: 2000,
          viewportSize: 1000,
          scrollSize: 2048,
        ),
        equals(0),
      );
      expect(
        computeZoomScrollOffset(
          clickRatio: 1.0,
          imageOffset: 24,
          imageSize: 2000,
          viewportSize: 1000,
          scrollSize: 2048,
        ),
        equals(1048),
      );
    });
  });

  group('extractDiagramWrapClasses', () {
    test('keeps only diagram wrapper classes', () {
      expect(
        extractDiagramWrapClasses([
          'diagram-wrap',
          'custom-class',
          'small-diagram-wrap',
          'rounded',
        ]),
        equals(['diagram-wrap', 'small-diagram-wrap']),
      );
    });

    test('returns empty list when no diagram wrapper classes exist', () {
      expect(
        extractDiagramWrapClasses(['foo', 'bar']),
        isEmpty,
      );
    });
  });

  group('ImageZoombox rendering', () {
    setUpAll(() => Jaspr.initializeApp(options: defaultServerOptions));

    test('renders closed dialog on server without active image', () async {
      final result = await renderComponent(
        const ImageZoombox(),
        standalone: true,
      );
      final html = utf8.decode(result.body);
      expect(html, contains('<!--@image_zoombox'));
      expect(html, contains('<dialog'));
      expect(html, contains('class="image-zoombox"'));
      expect(html, contains('aria-label="Expanded image"'));
      expect(html, isNot(contains(' open')));
      expect(html, isNot(contains('<img')));
    });
  });
}
