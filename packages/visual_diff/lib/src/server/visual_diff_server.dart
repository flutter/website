// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as path;

import '../differ/batch_differ.dart';
import '../models/diff_manifest.dart';

/// A local HTTP server that serves the Jaspr visual diff review application
/// alongside the compared screenshot artifacts.
final class VisualDiffServer {
  final HttpServer _server;
  final Directory visualDiffDirectory;
  final Directory? webAppDirectory;

  VisualDiffServer._(
    this._server, {
    required this.visualDiffDirectory,
    this.webAppDirectory,
  });

  int get port => _server.port;
  String get url => 'http://127.0.0.1:$port';

  /// Starts the visual diff review server on [port] (defaults to dynamic port).
  static Future<VisualDiffServer> start({
    required Directory visualDiffDirectory,
    Directory? webAppDirectory,
    int port = 0,
  }) async {
    webAppDirectory ??= await defaultWebAppDirectory();

    final server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
      shared: true,
    );

    final diffServer = VisualDiffServer._(
      server,
      visualDiffDirectory: visualDiffDirectory,
      webAppDirectory: webAppDirectory,
    );
    diffServer._listen();
    return diffServer;
  }

  /// Attempts to resolve the default web application directory for visual diff.
  static Future<Directory?> defaultWebAppDirectory() async {
    try {
      final packageUri = await Isolate.resolvePackageUri(
        Uri.parse('package:visual_diff/visual_diff.dart'),
      );
      if (packageUri != null) {
        final packageDir = path.dirname(path.dirname(packageUri.toFilePath()));
        final webDir = Directory(path.join(packageDir, 'web'));
        if (webDir.existsSync()) {
          return webDir;
        }
      }
    } catch (_) {}
    return null;
  }

  void _listen() {
    _server.listen((HttpRequest request) async {
      try {
        final decodedPath = Uri.decodeComponent(request.uri.path);

        // 1. Serve manifest JSON
        if (decodedPath == '/diff_manifest.json') {
          final manifestFile = File(
            path.join(visualDiffDirectory.path, 'diff_manifest.json'),
          );
          if (manifestFile.existsSync()) {
            request.response.headers.contentType = ContentType(
              'application',
              'json',
              charset: 'utf-8',
            );
            request.response.headers.set(
              'Cache-Control',
              'no-store, no-cache, must-revalidate, max-age=0',
            );
            request.response.headers.add('Access-Control-Allow-Origin', '*');
            await manifestFile.openRead().pipe(request.response);
            return;
          }
        }

        // 2. API to accept/update baseline for a specific route
        if (request.method == 'POST' && decodedPath == '/api/update-baseline') {
          final targetRoute = request.uri.queryParameters['route'];
          if (targetRoute == null || targetRoute.isEmpty) {
            request.response.statusCode = HttpStatus.badRequest;
            request.response.headers.contentType = ContentType.json;
            request.response.write(
              jsonEncode({'error': 'Missing route parameter'}),
            );
            await request.response.close();
            return;
          }

          final manifestFile = File(
            path.join(visualDiffDirectory.path, 'diff_manifest.json'),
          );
          if (!manifestFile.existsSync()) {
            request.response.statusCode = HttpStatus.notFound;
            request.response.headers.contentType = ContentType.json;
            request.response.write(
              jsonEncode({'error': 'diff_manifest.json not found'}),
            );
            await request.response.close();
            return;
          }

          final manifest = DiffManifest.loadFromFile(manifestFile);
          final baselineDir = Directory(
            path.join(visualDiffDirectory.path, 'baseline'),
          );
          final currentDir = Directory(
            path.join(visualDiffDirectory.path, 'current'),
          );
          final diffDir = Directory(
            path.join(visualDiffDirectory.path, 'diff'),
          );

          var updatedCount = 0;
          for (final entry in manifest.entries) {
            if (entry.route == targetRoute) {
              final currentFile = File(
                path.join(currentDir.path, entry.filename),
              );
              if (currentFile.existsSync()) {
                currentFile.copySync(
                  path.join(baselineDir.path, entry.filename),
                );
                updatedCount++;
              }
              final diffFile = File(path.join(diffDir.path, entry.filename));
              if (diffFile.existsSync()) {
                diffFile.deleteSync();
              }
            }
          }

          const differ = BatchDiffer();
          final updatedManifest = await differ.run(
            baselineDir: baselineDir,
            currentDir: currentDir,
            diffOutputDir: diffDir,
            manifestFile: manifestFile,
            site: manifest.site,
            baseRef: manifest.baseRef,
          );

          request.response.headers.contentType = ContentType.json;
          request.response.headers.set('Cache-Control', 'no-cache');
          request.response.headers.add('Access-Control-Allow-Origin', '*');
          request.response.write(
            jsonEncode({
              'success': true,
              'updated': updatedCount,
              'hasDiff': updatedManifest.hasDiff,
            }),
          );
          await request.response.close();
          return;
        }

        // 2. Serve screenshot artifacts from baseline, current, or diff
        if (decodedPath.startsWith('/baseline/') ||
            decodedPath.startsWith('/current/') ||
            decodedPath.startsWith('/diff/')) {
          final relPath = decodedPath.substring(1);
          final artifactFile = File(
            path.join(visualDiffDirectory.path, relPath),
          );
          if (artifactFile.existsSync()) {
            request.response.headers.contentType = _resolveContentType(
              artifactFile.path,
            );
            request.response.headers.add('Cache-Control', 'no-cache');
            request.response.headers.add('Access-Control-Allow-Origin', '*');
            await artifactFile.openRead().pipe(request.response);
            return;
          }
        }

        // 3. Serve web app assets or index.html fallback
        final webDir = webAppDirectory;
        if (webDir != null && webDir.existsSync()) {
          final appFile = _resolveWebAppFile(webDir, decodedPath);
          if (appFile != null && appFile.existsSync()) {
            request.response.headers.contentType = _resolveContentType(
              appFile.path,
            );
            request.response.headers.set(
              'Cache-Control',
              'no-store, no-cache, must-revalidate, max-age=0',
            );
            request.response.headers.set('Pragma', 'no-cache');
            await appFile.openRead().pipe(request.response);
            return;
          }

          // Fallback to index.html for client routing only if not an asset
          // request.
          final ext = path.extension(decodedPath);
          if (ext.isEmpty) {
            final indexFile = File(path.join(webDir.path, 'index.html'));
            if (indexFile.existsSync()) {
              request.response.headers.contentType = ContentType(
                'text',
                'html',
                charset: 'utf-8',
              );
              await indexFile.openRead().pipe(request.response);
              return;
            }
          }
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

  File? _resolveWebAppFile(Directory webDir, String requestPath) {
    var relative = requestPath.startsWith('/')
        ? requestPath.substring(1)
        : requestPath;

    if (relative.isEmpty) {
      relative = 'index.html';
    }

    final file = File(path.join(webDir.path, relative));
    if (file.existsSync()) {
      return file;
    }

    final htmlFile = File('${file.path}.html');
    if (htmlFile.existsSync()) {
      return htmlFile;
    }

    return null;
  }

  static ContentType _resolveContentType(String filePath) {
    final ext = path.extension(filePath).toLowerCase();
    return _mimeTypes[ext] ?? ContentType.binary;
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

  /// Opens the review UI in the default system browser.
  static Future<void> openInBrowser(String url) async {
    print('📂 Opening Visual Diff Reviewer: $url');
    if (Platform.isMacOS) {
      await Process.run('open', [url]);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', [url]);
    } else if (Platform.isWindows) {
      await Process.run('cmd', ['/c', 'start', '', url]);
    }
  }

  /// Closes the server.
  Future<void> close({bool force = false}) => _server.close(force: force);
}
