import 'dart:io';

import 'package:test/test.dart';
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
      '<!DOCTYPE html><html><body><h1>Obscura Test</h1></body></html>',
    );

    final server = await SnapshotServer.start(tempDir);
    ObscuraDaemon? daemon;

    try {
      daemon = await ObscuraDaemon.start();
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
      tempDir.deleteSync(recursive: true);
    }
  });
}
