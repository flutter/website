// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'snapshot_viewport.dart';

/// Represents a dedicated WebSocket CDP session connected to an
/// [ObscuraDaemon] process.
final class ObscuraSession {
  final WebSocket _ws;
  String? _sessionId;
  final Map<int, Completer<Map<String, dynamic>>> _pending = {};
  int _nextId = 1;

  ObscuraSession._(this._ws) {
    _ws.listen(
      (data) {
        try {
          final json = jsonDecode(data as String) as Map<String, dynamic>;
          final id = json['id'] as int?;
          final completer = id != null ? _pending.remove(id) : null;
          completer?.complete(json);
        } catch (_) {}
      },
      onDone: () {
        for (final completer in _pending.values) {
          if (!completer.isCompleted) {
            completer.completeError(
              StateError('WebSocket connection closed unexpectedly.'),
            );
          }
        }
        _pending.clear();
      },
      onError: (Object error) {
        for (final completer in _pending.values) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        }
        _pending.clear();
      },
    );
  }

  /// The CDP session ID associated with this target page.
  String? get sessionId => _sessionId;

  /// Creates and initializes a new page target session on [ws].
  static Future<ObscuraSession> connect(
    WebSocket ws, {
    bool disableJavaScript = true,
  }) async {
    final session = ObscuraSession._(ws);
    await session._initTarget(disableJavaScript: disableJavaScript);
    return session;
  }

  Future<void> _initTarget({required bool disableJavaScript}) async {
    final createRes = await send(
      'Target.createTarget',
      {'url': 'about:blank'},
      false,
    );
    final createResult = createRes['result'] as Map<String, dynamic>?;
    final targetId = createResult?['targetId'] as String?;
    if (targetId == null) {
      throw StateError('Failed to create target page: $createRes');
    }

    final attachRes = await send(
      'Target.attachToTarget',
      {'targetId': targetId, 'flatten': true},
      false,
    );
    final attachResult = attachRes['result'] as Map<String, dynamic>?;
    final sid = attachResult?['sessionId'] as String?;
    if (sid == null) {
      throw StateError('Failed to attach to target $targetId: $attachRes');
    }
    _sessionId = sid;

    if (disableJavaScript) {
      await send(
        'Emulation.setScriptExecutionDisabled',
        {'value': true},
      );
    }
  }

  /// Sends a CDP command on this session and awaits its response.
  Future<Map<String, dynamic>> send(
    String method, [
    Map<String, dynamic>? params,
    bool attachSession = true,
    Duration timeout = const Duration(seconds: 30),
  ]) {
    final id = _nextId++;
    final completer = Completer<Map<String, dynamic>>();
    _pending[id] = completer;

    final payload = jsonEncode({
      'id': id,
      'method': method,
      'params': ?params,
      if (attachSession && _sessionId != null) 'sessionId': _sessionId,
    });
    _ws.add(payload);

    return completer.future.timeout(
      timeout,
      onTimeout: () {
        _pending.remove(id);
        throw TimeoutException(
          'Timed out after ${timeout.inSeconds}s waiting for CDP "$method".',
          timeout,
        );
      },
    );
  }

  /// Navigates this page session to [url].
  Future<void> navigate(
    String url, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    await send('Page.navigate', {'url': url}, true, timeout);
  }

  /// Captures a screenshot for [viewport], properly capping its height to
  /// [maxHeight].
  Future<Uint8List> captureViewportSnapshot({
    required SnapshotViewport viewport,
    int maxHeight = 4500,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    await send(
      'Emulation.setDeviceMetricsOverride',
      {
        'width': viewport.width,
        'height': viewport.height,
        'deviceScaleFactor': viewport.deviceScaleFactor,
        'mobile': viewport.isMobile,
      },
      true,
      timeout,
    );

    var captureHeight = viewport.height;
    if (maxHeight > 0) {
      try {
        final metricsRes = await send(
          'Page.getLayoutMetrics',
          null,
          true,
          timeout,
        );
        final result = metricsRes['result'] as Map<String, dynamic>?;
        final cssContentSize =
            result?['cssContentSize'] as Map<String, dynamic>?;
        final contentHeight = (cssContentSize?['height'] as num?)?.round();
        if (contentHeight != null && contentHeight > 0) {
          captureHeight = min(contentHeight, maxHeight);
        }
      } catch (_) {}
    }

    final shotRes = await send(
      'Page.captureScreenshot',
      {
        'format': 'png',
        if (maxHeight > 0 && captureHeight > 0)
          'clip': {
            'x': 0,
            'y': 0,
            'width': viewport.width,
            'height': captureHeight,
            'scale': 1,
          },
        'captureBeyondViewport': true,
      },
      true,
      timeout,
    );

    final shotResult = shotRes['result'] as Map<String, dynamic>?;
    final base64Data = shotResult?['data'] as String?;
    if (base64Data == null || base64Data.isEmpty) {
      throw StateError('Page.captureScreenshot returned no data: $shotRes');
    }

    return base64Decode(base64Data);
  }

  /// Closes this session and its dedicated WebSocket.
  Future<void> close() async {
    try {
      await _ws.close();
    } catch (_) {}
  }
}

/// Manages a persistent `obscura serve` process and provides lightweight CDP
/// communication over WebSocket connections.
final class ObscuraDaemon {
  final Process _process;
  final int port;
  final WebSocket _ws;
  final Map<int, Completer<Map<String, dynamic>>> _pending = {};
  int _nextId = 1;

  ObscuraDaemon._(this._process, this.port, this._ws) {
    _ws.listen(
      (data) {
        try {
          final json = jsonDecode(data as String) as Map<String, dynamic>;
          final id = json['id'] as int?;
          final completer = id != null ? _pending.remove(id) : null;
          completer?.complete(json);
        } catch (_) {}
      },
      onDone: () {
        for (final completer in _pending.values) {
          if (!completer.isCompleted) {
            completer.completeError(
              StateError('WebSocket connection closed unexpectedly.'),
            );
          }
        }
        _pending.clear();
      },
      onError: (Object error) {
        for (final completer in _pending.values) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        }
        _pending.clear();
      },
    );
  }

  /// Starts an `obscura serve` background daemon on an available local port and
  /// connects to its `/devtools/browser` WebSocket endpoint.
  ///
  /// When [workers] is greater than 1, launches Obscura with `--workers` to run
  /// parallel CDP server processes behind the listener.
  static Future<ObscuraDaemon> start({
    String obscuraBin = 'obscura',
    int? customPort,
    Directory? fontDirectory,
    int workers = 1,
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
        if (workers > 1) ...['--workers', '$workers'],
        '--allow-private-network',
        '--quiet',
        if (fontDirectory != null && fontDirectory.existsSync()) ...[
          '--font-dir',
          fontDirectory.path,
        ],
      ],
      environment: {
        'OBSCURA_ALLOW_PRIVATE_NETWORK': '1',
      },
    );

    // Actively drain stdout and stderr so OS pipe buffers (typically 64KB on
    // macOS/Linux) never fill up and cause the child process to block on write.
    process.stdout.listen((_) {});
    process.stderr.listen((_) {});

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
    return ObscuraDaemon._(process, port, ws);
  }

  /// Creates an independent worker session with its own dedicated WebSocket
  /// connection to allow concurrent processing across Obscura worker processes.
  Future<ObscuraSession> createWorkerSession({
    bool disableJavaScript = true,
  }) async {
    final ws = await WebSocket.connect('ws://127.0.0.1:$port/devtools/browser');
    return await ObscuraSession.connect(
      ws,
      disableJavaScript: disableJavaScript,
    );
  }

  /// Sends a CDP command and awaits its matching response on the default
  /// browser connection.
  Future<Map<String, dynamic>> send(
    String method, [
    Map<String, dynamic>? params,
    String? sessionId,
    Duration timeout = const Duration(seconds: 30),
  ]) {
    final id = _nextId++;
    final completer = Completer<Map<String, dynamic>>();
    _pending[id] = completer;

    final payload = jsonEncode({
      'id': id,
      'method': method,
      'params': ?params,
      'sessionId': ?sessionId,
    });
    _ws.add(payload);

    return completer.future.timeout(
      timeout,
      onTimeout: () {
        _pending.remove(id);
        throw TimeoutException(
          'Timed out after ${timeout.inSeconds}s waiting for CDP "$method".',
          timeout,
        );
      },
    );
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

  /// Navigates to [url] and captures a PNG screenshot for [viewport], properly
  /// capping its height to [maxHeight].
  Future<Uint8List> captureSnapshot({
    required String sessionId,
    required String url,
    required SnapshotViewport viewport,
    int maxHeight = 4500,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    await send(
      'Emulation.setDeviceMetricsOverride',
      {
        'width': viewport.width,
        'height': viewport.height,
        'deviceScaleFactor': viewport.deviceScaleFactor,
        'mobile': viewport.isMobile,
      },
      sessionId,
      timeout,
    );

    await send('Page.navigate', {'url': url}, sessionId, timeout);

    var captureHeight = viewport.height;
    if (maxHeight > 0) {
      try {
        final metricsRes = await send(
          'Page.getLayoutMetrics',
          null,
          sessionId,
          timeout,
        );
        final result = metricsRes['result'] as Map<String, dynamic>?;
        final cssContentSize =
            result?['cssContentSize'] as Map<String, dynamic>?;
        final contentHeight = (cssContentSize?['height'] as num?)?.round();
        if (contentHeight != null && contentHeight > 0) {
          captureHeight = min(contentHeight, maxHeight);
        }
      } catch (_) {}
    }

    final shotRes = await send(
      'Page.captureScreenshot',
      {
        'format': 'png',
        if (maxHeight > 0 && captureHeight > 0)
          'clip': {
            'x': 0,
            'y': 0,
            'width': viewport.width,
            'height': captureHeight,
            'scale': 1,
          },
        'captureBeyondViewport': true,
      },
      sessionId,
      timeout,
    );

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
    _process.kill();
  }
}
