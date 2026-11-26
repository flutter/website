// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'snapshot_viewport.dart';

/// Manages a persistent `obscura serve` process and provides lightweight CDP
/// communication over a single WebSocket connection.
final class ObscuraDaemon {
  final Process _process;
  final int port;
  final WebSocket _ws;
  final StreamController<Map<String, dynamic>> _messages =
      StreamController.broadcast();
  int _nextId = 1;

  ObscuraDaemon._({
    required this._process,
    required this.port,
    required this._ws,
  }) {
    _ws.listen(
      (data) {
        try {
          final json = jsonDecode(data as String) as Map<String, dynamic>;
          _messages.add(json);
        } catch (_) {}
      },
      onDone: _messages.close,
    );
  }

  /// Starts an `obscura serve` background daemon on an available local port and
  /// connects to its `/devtools/browser` WebSocket endpoint.
  static Future<ObscuraDaemon> start({
    String obscuraBin = 'obscura',
    int? customPort,
    Directory? fontDirectory,
  }) async {
    final int port;
    if (customPort != null) {
      port = customPort;
    } else {
      final tempSocket = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      port = tempSocket.port;
      await tempSocket.close();
    }

    final process = await Process.start(
      obscuraBin,
      [
        'serve',
        '--port',
        '$port',
        '--allow-private-network',
        if (fontDirectory != null && fontDirectory.existsSync()) ...[
          '--font-dir',
          fontDirectory.path,
        ],
      ],
      environment: {
        'OBSCURA_ALLOW_PRIVATE_NETWORK': '1',
      },
    );

    // Wait until the CDP server is listening.
    final client = HttpClient();
    final deadline = DateTime.now().add(const Duration(seconds: 10));
    var isReady = false;

    while (DateTime.now().isBefore(deadline)) {
      try {
        final req = await client.getUrl(
          Uri.parse('http://127.0.0.1:$port/json/version'),
        );
        final res = await req.close();
        if (res.statusCode == 200) {
          isReady = true;
          break;
        }
      } catch (_) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }
    }
    client.close();

    if (!isReady) {
      process.kill();
      throw StateError(
        'Timed out waiting for "obscura serve" to start on port $port.',
      );
    }

    final ws = await WebSocket.connect('ws://127.0.0.1:$port/devtools/browser');
    return ObscuraDaemon._(
      process: process,
      port: port,
      ws: ws,
    );
  }

  /// Sends a CDP command and awaits its matching response.
  Future<Map<String, dynamic>> send(
    String method, [
    Map<String, dynamic>? params,
    String? sessionId,
  ]) {
    final id = _nextId++;
    final completer = Completer<Map<String, dynamic>>();

    late final StreamSubscription<Map<String, dynamic>> sub;
    sub = _messages.stream.listen((msg) {
      if (msg['id'] == id) {
        unawaited(sub.cancel());
        completer.complete(msg);
      }
    });

    final payload = jsonEncode({
      'id': id,
      'method': method,
      'params': ?params,
      'sessionId': ?sessionId,
    });
    _ws.add(payload);

    return completer.future;
  }

  /// Creates a new target page and attaches to it, returning its `sessionId`.
  Future<String> createSession({bool disableJavaScript = true}) async {
    final createRes = await send('Target.createTarget', {'url': 'about:blank'});
    final createResult = createRes['result'] as Map<String, dynamic>?;
    final targetId = createResult?['targetId'] as String?;
    if (targetId == null) {
      throw StateError('Failed to create target page: $createRes');
    }

    final attachRes = await send('Target.attachToTarget', {
      'targetId': targetId,
      'flatten': true,
    });
    final attachResult = attachRes['result'] as Map<String, dynamic>?;
    final sessionId = attachResult?['sessionId'] as String?;
    if (sessionId == null) {
      throw StateError('Failed to attach to target $targetId: $attachRes');
    }

    if (disableJavaScript) {
      await send('Emulation.setScriptExecutionDisabled', {
        'value': true,
      }, sessionId);
    }

    return sessionId;
  }

  /// Navigates to [url] and captures a PNG screenshot for [viewport].
  Future<Uint8List> captureSnapshot({
    required String sessionId,
    required String url,
    required SnapshotViewport viewport,
    int maxHeight = 4500,
  }) async {
    await send('Emulation.setDeviceMetricsOverride', {
      'width': viewport.width,
      'height': maxHeight,
      'deviceScaleFactor': 1,
      'mobile': viewport.isMobile,
    }, sessionId);

    await send('Page.navigate', {'url': url}, sessionId);

    final shotRes = await send('Page.captureScreenshot', {
      'format': 'png',
      'captureBeyondViewport': true,
    }, sessionId);

    final shotResult = shotRes['result'] as Map<String, dynamic>?;
    final base64Data = shotResult?['data'] as String?;
    if (base64Data == null || base64Data.isEmpty) {
      throw StateError('Page.captureScreenshot returned no data: $shotRes');
    }

    return base64Decode(base64Data);
  }

  /// Shuts down the CDP WebSocket and terminates the `obscura serve` process.
  Future<void> close() async {
    try {
      await _ws.close();
    } catch (_) {}
    try {
      await _messages.close();
    } catch (_) {}
    _process.kill();
  }
}
