import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:test/test.dart';
import 'package:visual_diff/src/runner/font_cache.dart';
import 'package:visual_diff/src/runner/obscura_daemon.dart';
import 'package:visual_diff/src/runner/snapshot_server.dart';
import 'package:visual_diff/src/runner/snapshot_viewport.dart';

void main() {
  test('ObscuraDaemon captures snapshots over persistent CDP', () async {
    // Check if obscura is installed
    try {
      final res = Process.runSync('obscura', ['--version']);
      if (res.exitCode != 0) return;
    } catch (_) {
      return; // Skip if obscura is not installed on this machine
    }

    final tempDir = Directory.systemTemp.createTempSync('obscura_test_');
    final indexHtml = File('${tempDir.path}/index.html');
    indexHtml.writeAsStringSync(
      '<!DOCTYPE html><html><body><h1>Obscura Test</h1>'
      '<span class="material-symbols-outlined">search</span>'
      '</body></html>',
    );

    final fontCache = FontCache(
      cacheDirectory: Directory('${tempDir.path}/font_cache'),
    );
    final fontDir = await fontCache.ensureTtfFonts();

    final server = await SnapshotServer.start(tempDir);
    ObscuraDaemon? daemon;

    try {
      daemon = await ObscuraDaemon.start(fontDirectory: fontDir);
      final sessionId = await daemon.createSession(disableJavaScript: true);

      final pngBytes = await daemon.captureSnapshot(
        sessionId: sessionId,
        url: '${server.baseUrl}/',
        viewport: SnapshotViewport.desktop,
        maxHeight: 1000,
      );

      expect(pngBytes.isNotEmpty, isTrue);
      expect(pngBytes.length, greaterThan(1000));
    } finally {
      await daemon?.close();
      await server.close();
      fontCache.close();
      tempDir.deleteSync(recursive: true);
    }
  });

  test(
    'ObscuraSession caps snapshot height and supports multi-workers',
    () async {
      try {
        final res = Process.runSync('obscura', ['--version']);
        if (res.exitCode != 0) return;
      } catch (_) {
        return;
      }

      final tempDir = Directory.systemTemp.createTempSync('obscura_tall_test_');
      final indexHtml = File('${tempDir.path}/index.html');
      indexHtml.writeAsStringSync(
        '<!DOCTYPE html><html><body style="margin: 0; padding: 0;">'
        '<div style="height: 6000px; '
        'background: linear-gradient(to bottom, #f00, #00f);">'
        '<h1>Tall Page</h1>'
        '</div></body></html>',
      );

      final server = await SnapshotServer.start(tempDir);
      ObscuraDaemon? daemon;

      try {
        daemon = await ObscuraDaemon.start(workers: 2);
        final session1 = await daemon.createWorkerSession();
        final session2 = await daemon.createWorkerSession();

        await Future.wait([
          session1.navigate('${server.baseUrl}/'),
          session2.navigate('${server.baseUrl}/'),
        ]);

        // Capture desktop with maxHeight 1500 on session 1
        final bytesDesktop = await session1.captureViewportSnapshot(
          viewport: SnapshotViewport.desktop,
          maxHeight: 1500,
        );
        final imgDesktop = img.decodePng(bytesDesktop);
        expect(imgDesktop, isNotNull);
        expect(imgDesktop!.width, equals(1280));
        expect(imgDesktop.height, equals(1500));

        // Capture mobile with maxHeight 1200 on session 2
        final bytesMobile = await session2.captureViewportSnapshot(
          viewport: SnapshotViewport.mobile,
          maxHeight: 1200,
        );
        final imgMobile = img.decodePng(bytesMobile);
        expect(imgMobile, isNotNull);
        expect(imgMobile!.width, equals(SnapshotViewport.mobile.width));
        expect(imgMobile.height, equals(1200));

        await Future.wait([
          session1.close(),
          session2.close(),
        ]);
      } finally {
        await daemon?.close();
        await server.close();
        tempDir.deleteSync(recursive: true);
      }
    },
  );
}
