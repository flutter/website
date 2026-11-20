// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

/// A cached HTTP response for a font stylesheet or font binary file.
final class CachedFontResponse {
  final int status;
  final String? contentType;
  final Map<String, String> headers;
  final Uint8List bodyBytes;

  const CachedFontResponse({
    required this.status,
    required this.contentType,
    required this.headers,
    required this.bodyBytes,
  });
}

/// In-memory and persistent disk cache for Google Fonts and Material Symbols.
///
/// Pre-warms or intercepts font requests on the first route and serves
/// them locally for all subsequent routes via CDP `Fetch.fulfillRequest`,
/// eliminating external network latency and stalls.
final class FontCache {
  static const String defaultChromeUserAgent =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '
      'AppleWebKit/537.36 (KHTML, like Gecko) '
      'Chrome/130.0.0.0 Safari/537.36';

  static const List<String> defaultKnownFontUrls = [
    'https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0..1,0',
    'https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,400,0..1,0&display=block',
    'https://fonts.googleapis.com/css2?family=Google+Sans+Flex:opsz,wght@6..72,400..700&family=Google+Sans+Code:ital,wght@0,400..700;1,400..700&display=swap',
    'https://fonts.googleapis.com/css2?family=Google+Sans+Flex:opsz,wght@6..120,400..700&family=Google+Sans+Code:ital,wght@0,400..700;1,400..700&display=swap',
  ];

  static final RegExp _fontUrlPattern = RegExp(
    r'url\((https://fonts\.gstatic\.com/[^)]+)\)',
  );

  final Directory? cacheDirectory;
  final HttpClient _client = HttpClient();
  final Map<String, CachedFontResponse> _memoryCache = {};
  final Map<String, Future<CachedFontResponse?>> _inFlight = {};

  FontCache({this.cacheDirectory}) {
    if (cacheDirectory case final dir?) {
      if (!dir.existsSync()) {
        try {
          dir.createSync(recursive: true);
        } catch (_) {}
      }
    }
  }

  /// Default cache directory in system temp or `.visual-diff/.font-cache`.
  static Directory defaultCacheDirectory() {
    return Directory(
      path.join(Directory.systemTemp.path, 'visual_diff_font_cache'),
    );
  }

  /// Checks if [url] points to Google Fonts CSS or a static font file.
  static bool isFontUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    final host = uri.host.toLowerCase();
    return host == 'fonts.googleapis.com' ||
        host == 'fonts.gstatic.com' ||
        host.endsWith('.gstatic.com') ||
        host.endsWith('.googleapis.com');
  }

  /// Pre-warms the cache by fetching [cssUrls] and all linked font binaries.
  Future<void> prewarm([List<String> cssUrls = defaultKnownFontUrls]) async {
    final cssResponses = await Future.wait(
      cssUrls.map(getOrFetch),
    );

    final fontBinaryUrls = <String>{};
    for (final response in cssResponses) {
      if (response == null) continue;
      final cssText = utf8.decode(response.bodyBytes, allowMalformed: true);
      for (final match in _fontUrlPattern.allMatches(cssText)) {
        if (match.group(1) case final fontUrl?) {
          fontBinaryUrls.add(fontUrl);
        }
      }
    }

    if (fontBinaryUrls.isNotEmpty) {
      await Future.wait(fontBinaryUrls.map(getOrFetch));
    }
  }

  /// Retrieves a cached response or fetches and caches it if absent.
  Future<CachedFontResponse?> getOrFetch(
    String url, {
    Map<String, String>? requestHeaders,
  }) async {
    // 1. In-memory cache hit.
    if (_memoryCache[url] case final cached?) {
      return cached;
    }

    // 2. Persistent disk cache hit.
    if (cacheDirectory != null) {
      final diskCached = _readFromDisk(url);
      if (diskCached != null) {
        _memoryCache[url] = diskCached;
        return diskCached;
      }
    }

    // 3. Deduplicate in-flight requests for the exact same URL.
    if (_inFlight[url] case final inFlightFuture?) {
      return await inFlightFuture;
    }

    final completer = Completer<CachedFontResponse?>();
    _inFlight[url] = completer.future;

    try {
      final fetched = await _fetchFromNetwork(url, requestHeaders);
      if (fetched != null) {
        _memoryCache[url] = fetched;
        if (cacheDirectory != null) {
          _writeToDisk(url, fetched);
        }
      }
      completer.complete(fetched);
      return fetched;
    } catch (_) {
      completer.complete(null);
      return null;
    } finally {
      unawaited(_inFlight.remove(url));
    }
  }

  Future<CachedFontResponse?> _fetchFromNetwork(
    String url,
    Map<String, String>? requestHeaders,
  ) async {
    try {
      final uri = Uri.parse(url);
      final request = await _client.getUrl(uri);

      // Supply modern Chrome User-Agent so Google Fonts delivers modern WOFF2.
      final userAgent =
          requestHeaders?['user-agent'] ??
          requestHeaders?['User-Agent'] ??
          defaultChromeUserAgent;
      request.headers.set(HttpHeaders.userAgentHeader, userAgent);

      if (requestHeaders != null) {
        for (final entry in requestHeaders.entries) {
          final key = entry.key.toLowerCase();
          if (key != 'host' && key != 'user-agent' && key != 'content-length') {
            request.headers.add(entry.key, entry.value);
          }
        }
      }

      final response = await request.close();
      final bytesBuilder = BytesBuilder(copy: false);
      await for (final chunk in response) {
        bytesBuilder.add(chunk);
      }
      final bodyBytes = bytesBuilder.takeBytes();

      final headers = <String, String>{};
      response.headers.forEach((name, values) {
        headers[name] = values.join(', ');
      });

      // Ensure CORS header allows cross-origin font rendering.
      headers['access-control-allow-origin'] = '*';

      return CachedFontResponse(
        status: response.statusCode,
        contentType: response.headers.contentType?.toString(),
        headers: headers,
        bodyBytes: bodyBytes,
      );
    } catch (_) {
      return null;
    }
  }

  String _cacheKey(String url) {
    return md5.convert(utf8.encode(url)).toString();
  }

  CachedFontResponse? _readFromDisk(String url) {
    try {
      final dir = cacheDirectory;
      if (dir == null || !dir.existsSync()) return null;

      final key = _cacheKey(url);
      final metaFile = File(path.join(dir.path, '$key.json'));
      final binFile = File(path.join(dir.path, '$key.bin'));

      if (!metaFile.existsSync() || !binFile.existsSync()) return null;

      final metaJson =
          jsonDecode(metaFile.readAsStringSync()) as Map<String, dynamic>;
      final status = metaJson['status'] as int? ?? 200;
      final contentType = metaJson['contentType'] as String?;
      final rawHeaders = metaJson['headers'] as Map<String, dynamic>? ?? {};
      final headers = rawHeaders.map((k, v) => MapEntry(k, v.toString()));
      final bodyBytes = binFile.readAsBytesSync();

      return CachedFontResponse(
        status: status,
        contentType: contentType,
        headers: headers,
        bodyBytes: bodyBytes,
      );
    } catch (_) {
      return null;
    }
  }

  void _writeToDisk(String url, CachedFontResponse response) {
    try {
      final dir = cacheDirectory;
      if (dir == null) return;
      if (!dir.existsSync()) dir.createSync(recursive: true);

      final key = _cacheKey(url);
      final metaFile = File(path.join(dir.path, '$key.json'));
      final binFile = File(path.join(dir.path, '$key.bin'));

      final metaJson = {
        'url': url,
        'status': response.status,
        'contentType': response.contentType,
        'headers': response.headers,
      };
      metaFile.writeAsStringSync(jsonEncode(metaJson));
      binFile.writeAsBytesSync(response.bodyBytes);
    } catch (_) {}
  }

  /// Closes the underlying HTTP client.
  void close() {
    _client.close();
  }
}
