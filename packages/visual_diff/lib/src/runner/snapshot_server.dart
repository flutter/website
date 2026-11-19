// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;

/// A lightweight in-process static HTTP server for snapshotting and reviewing.
final class SnapshotServer {
  final HttpServer _server;
  final Directory rootDirectory;

  SnapshotServer._(this._server, this.rootDirectory);

  int get port => _server.port;
  String get baseUrl => 'http://127.0.0.1:$port';

  /// Starts a local static file server serving files from [rootDirectory].
  static Future<SnapshotServer> start(
    Directory rootDirectory, {
    int port = 0,
  }) async {
    final server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
      shared: true,
    );
    final snapshotServer = SnapshotServer._(server, rootDirectory);
    snapshotServer._listen();
    return snapshotServer;
  }

  void _listen() {
    _server.listen((HttpRequest request) async {
      try {
        final decodedPath = Uri.decodeComponent(request.uri.path);
        final file = _resolveFile(decodedPath);

        if (file != null && file.existsSync()) {
          final mimeType = _resolveContentType(file.path);
          request.response.headers.contentType = mimeType;
          request.response.headers.add('Cache-Control', 'no-cache');
          request.response.headers.add('Access-Control-Allow-Origin', '*');
          await file.openRead().pipe(request.response);
          return;
        }

        // Check for 404.html fallback.
        final notFoundFile = File(path.join(rootDirectory.path, '404.html'));
        if (notFoundFile.existsSync()) {
          request.response.statusCode = HttpStatus.notFound;
          request.response.headers.contentType = ContentType(
            'text',
            'html',
            charset: 'utf-8',
          );
          await notFoundFile.openRead().pipe(request.response);
          return;
        }

        request.response.statusCode = HttpStatus.notFound;
        request.response.write('Not Found: $decodedPath');
        await request.response.close();
      } catch (error) {
        try {
          request.response.statusCode = HttpStatus.internalServerError;
          request.response.write('Internal Server Error: $error');
          await request.response.close();
        } catch (_) {}
      }
    });
  }

  File? _resolveFile(String requestPath) {
    var relative = requestPath.startsWith('/')
        ? requestPath.substring(1)
        : requestPath;

    if (relative.isEmpty) {
      relative = 'index.html';
    }

    final candidate = File(path.join(rootDirectory.path, relative));
    if (candidate.existsSync()) {
      return candidate;
    }

    // Try relative + index.html
    final indexCandidate = File(
      path.join(rootDirectory.path, relative, 'index.html'),
    );
    if (indexCandidate.existsSync()) {
      return indexCandidate;
    }

    // Try relative + .html
    final htmlCandidate = File('${candidate.path}.html');
    if (htmlCandidate.existsSync()) {
      return htmlCandidate;
    }

    return null;
  }

  ContentType _resolveContentType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    return _mimeTypes[extension] ?? ContentType.binary;
  }

  static final Map<String, ContentType> _mimeTypes = {
    '.html': ContentType('text', 'html', charset: 'utf-8'),
    '.css': ContentType('text', 'css', charset: 'utf-8'),
    '.js': ContentType('application', 'javascript', charset: 'utf-8'),
    '.json': ContentType('application', 'json', charset: 'utf-8'),
    '.png': ContentType('image', 'png'),
    '.jpg': ContentType('image', 'jpeg'),
    '.jpeg': ContentType('image', 'jpeg'),
    '.svg': ContentType('image', 'svg+xml'),
    '.webp': ContentType('image', 'webp'),
    '.ico': ContentType('image', 'x-icon'),
    '.woff': ContentType('font', 'woff'),
    '.woff2': ContentType('font', 'woff2'),
    '.ttf': ContentType('font', 'ttf'),
  };

  /// Closes the static server.
  Future<void> close({bool force = false}) => _server.close(force: force);
}
