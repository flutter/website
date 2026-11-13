// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:path/path.dart' as path;

import 'review_source_locator.dart';

/// Default loopback port tried first by [ReviewLocalServer].
const int defaultReviewServerPort = 4099;

/// Repository-relative directory storing local visual review artifacts.
const String reviewDirectoryRelativePath = '.dash_review';

/// Repository-relative path to the structured JSON comment store.
const String reviewCommentsRelativePath = '.dash_review/comments.json';

/// Repository-relative path to the agent-ready Markdown feedback file.
const String reviewFeedbackRelativePath = '.dash_review/feedback.md';

const int _maxRequestBodyBytes = 1024 * 1024;

/// A single visual review comment anchored to a rendered page and source file.
final class ReviewComment {
  final String id;
  final String site;
  final String pageUrl;
  final String pageTitle;
  final String sourceFile;
  final String resolvedFile;
  final int? startLine;
  final int? endLine;
  final String? codeSnippet;
  final String anchorType;
  final String selectedText;
  final String prefixContext;
  final String suffixContext;
  final String selector;
  final String elementTag;
  final String elementText;
  final String headingAnchor;
  final Map<String, double>? rectPct;
  final String comment;
  final String author;
  final String status;
  final String createdAt;
  final String updatedAt;

  const ReviewComment({
    required this.id,
    required this.site,
    required this.pageUrl,
    required this.pageTitle,
    required this.sourceFile,
    required this.resolvedFile,
    required this.startLine,
    required this.endLine,
    required this.codeSnippet,
    required this.anchorType,
    required this.selectedText,
    required this.prefixContext,
    required this.suffixContext,
    required this.selector,
    required this.elementTag,
    required this.elementText,
    required this.headingAnchor,
    required this.rectPct,
    required this.comment,
    required this.author,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewComment.fromJson(Map<String, Object?> json) {
    Map<String, double>? parsedRect;
    if (json['rectPct'] case final Map<Object?, Object?> rawRect) {
      final mapped = <String, double>{};
      for (final entry in rawRect.entries) {
        if (entry.key is String && entry.value is num) {
          mapped[entry.key as String] = (entry.value as num).toDouble();
        }
      }
      if (mapped.isNotEmpty) {
        parsedRect = mapped;
      }
    }

    return ReviewComment(
      id: _asString(json['id']),
      site: _asString(json['site'], fallback: 'docs'),
      pageUrl: _asString(json['pageUrl'], fallback: '/'),
      pageTitle: _asString(json['pageTitle']),
      sourceFile: _asString(json['sourceFile']),
      resolvedFile: _asString(json['resolvedFile']),
      startLine: _asIntOrNull(json['startLine']),
      endLine: _asIntOrNull(json['endLine']),
      codeSnippet: _asNullableString(json['codeSnippet']),
      anchorType: _asString(json['anchorType'], fallback: 'text'),
      selectedText: _asString(json['selectedText']),
      prefixContext: _asString(json['prefixContext']),
      suffixContext: _asString(json['suffixContext']),
      selector: _asString(json['selector']),
      elementTag: _asString(json['elementTag']),
      elementText: _asString(json['elementText']),
      headingAnchor: _asString(json['headingAnchor']),
      rectPct: parsedRect,
      comment: _asString(json['comment']),
      author: _asString(json['author'], fallback: 'local'),
      status: _asString(json['status'], fallback: 'open') == 'resolved'
          ? 'resolved'
          : 'open',
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  ReviewComment copyWith({
    String? comment,
    String? status,
    String? updatedAt,
  }) => ReviewComment(
    id: id,
    site: site,
    pageUrl: pageUrl,
    pageTitle: pageTitle,
    sourceFile: sourceFile,
    resolvedFile: resolvedFile,
    startLine: startLine,
    endLine: endLine,
    codeSnippet: codeSnippet,
    anchorType: anchorType,
    selectedText: selectedText,
    prefixContext: prefixContext,
    suffixContext: suffixContext,
    selector: selector,
    elementTag: elementTag,
    elementText: elementText,
    headingAnchor: headingAnchor,
    rectPct: rectPct,
    comment: comment ?? this.comment,
    author: author,
    status: status ?? this.status,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'site': site,
    'pageUrl': pageUrl,
    'pageTitle': pageTitle,
    'sourceFile': sourceFile,
    'resolvedFile': resolvedFile,
    'startLine': startLine,
    'endLine': endLine,
    'codeSnippet': codeSnippet,
    'anchorType': anchorType,
    'selectedText': selectedText,
    'prefixContext': prefixContext,
    'suffixContext': suffixContext,
    'selector': selector,
    'elementTag': elementTag,
    'elementText': elementText,
    'headingAnchor': headingAnchor,
    'rectPct': rectPct,
    'comment': comment,
    'author': author,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  /// Formatted `file:startLine-endLine` label for prompts and CLI output.
  String get locationLabel {
    final targetFile = resolvedFile.isNotEmpty ? resolvedFile : sourceFile;
    if (targetFile.isEmpty) return '(unresolved source file)';
    if (startLine == null) return targetFile;
    if (endLine == null || endLine == startLine) {
      return '$targetFile:$startLine';
    }
    return '$targetFile:$startLine-$endLine';
  }
}

/// Computes open, resolved, and total counts for [comments].
Map<String, int> computeCommentCounts(Iterable<ReviewComment> comments) {
  var open = 0;
  var resolved = 0;
  for (final item in comments) {
    if (item.status == 'resolved') {
      resolved++;
    } else {
      open++;
    }
  }
  return {'open': open, 'resolved': resolved, 'total': open + resolved};
}

/// Normalizes a page URL path so `/ui/layout/`, `/ui/layout`, and
/// `/ui/layout/index.html` compare equal when filtering comments.
String normalizeReviewPageUrl(String rawUrl) {
  var value = rawUrl.trim();
  if (value.isEmpty) return '/';

  final parsed = Uri.tryParse(value);
  if (parsed != null && (parsed.hasScheme || parsed.path.isNotEmpty)) {
    value = parsed.path;
  } else {
    final qIdx = value.indexOf('?');
    if (qIdx >= 0) value = value.substring(0, qIdx);
    final hIdx = value.indexOf('#');
    if (hIdx >= 0) value = value.substring(0, hIdx);
  }

  if (!value.startsWith('/')) {
    value = '/$value';
  }
  if (value.endsWith('/index.html')) {
    value = value.substring(0, value.length - '/index.html'.length);
  } else if (value.endsWith('.html')) {
    value = value.substring(0, value.length - '.html'.length);
  }
  while (value.length > 1 && value.endsWith('/')) {
    value = value.substring(0, value.length - 1);
  }
  return value.isEmpty ? '/' : value;
}

/// Manages atomic persistence of `.dash_review/comments.json` and
/// `.dash_review/feedback.md` inside a repository root.
final class ReviewStore {
  static int _atomicCounter = 0;

  final String repoRoot;

  const ReviewStore(this.repoRoot);

  String get reviewDirectoryPath =>
      path.join(repoRoot, reviewDirectoryRelativePath);

  String get commentsFilePath =>
      path.join(reviewDirectoryPath, 'comments.json');

  String get feedbackFilePath => path.join(reviewDirectoryPath, 'feedback.md');

  /// Reads all stored comments from `.dash_review/comments.json`.
  List<ReviewComment> loadComments() {
    final file = File(commentsFilePath);
    if (!file.existsSync()) return <ReviewComment>[];

    try {
      final decoded = jsonDecode(file.readAsStringSync());
      if (decoded case {'comments': final List<Object?> rawComments}) {
        return [
          for (final item in rawComments)
            if (item is Map<String, Object?>)
              ReviewComment.fromJson(item)
            else if (item is Map)
              ReviewComment.fromJson(item.cast<String, Object?>()),
        ];
      }
    } on Exception {
      // Return empty list if file was empty or malformed.
    }
    return <ReviewComment>[];
  }

  /// Atomically writes `.dash_review/comments.json` and regenerates
  /// `.dash_review/feedback.md`.
  void saveComments(List<ReviewComment> comments, {DateTime? now}) {
    final timestamp = (now ?? DateTime.now()).toUtc().toIso8601String();
    final dir = Directory(reviewDirectoryPath);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    final jsonPayload = {
      'version': 1,
      'updatedAt': timestamp,
      'comments': [for (final item in comments) item.toJson()],
    };
    final encodedJson =
        '${const JsonEncoder.withIndent('  ').convert(jsonPayload)}\n';
    _writeAtomically(commentsFilePath, encodedJson);

    final markdown = renderFeedbackMarkdown(comments, updatedAt: timestamp);
    _writeAtomically(feedbackFilePath, markdown);
  }

  void _writeAtomically(String targetPath, String contents) {
    final nonce = ++_atomicCounter;
    final tempPath = '$targetPath.tmp.$pid.$nonce';
    final tempFile = File(tempPath);
    tempFile.writeAsStringSync(contents, flush: true);
    tempFile.renameSync(targetPath);
  }

  /// Generates the full `.dash_review/feedback.md` document for coding agents.
  String renderFeedbackMarkdown(
    List<ReviewComment> comments, {
    String? updatedAt,
  }) {
    final counts = computeCommentCounts(comments);
    final openComments = [
      for (final item in comments)
        if (item.status != 'resolved') item,
    ];
    final resolvedComments = [
      for (final item in comments)
        if (item.status == 'resolved') item,
    ];

    final buffer = StringBuffer()
      ..writeln('# Visual Review Feedback')
      ..writeln()
      ..writeln('- **Open comments**: ${counts['open']}')
      ..writeln('- **Resolved comments**: ${counts['resolved']}')
      ..writeln('- **Total comments**: ${counts['total']}')
      ..writeln(
        '- **Updated**: '
        '${updatedAt ?? DateTime.now().toUtc().toIso8601String()}',
      )
      ..writeln()
      ..writeln('## Agent Instructions')
      ..writeln()
      ..writeln(
        'Apply each open review comment below in its resolved repository file.',
      )
      ..writeln(
        'Once you address a comment, mark it resolved so the browser toolbar '
        'and `.dash_review/feedback.md` stay synchronized:',
      )
      ..writeln()
      ..writeln('```bash')
      ..writeln('dart run dash_site review resolve <comment-id>')
      ..writeln('```')
      ..writeln();

    buffer.writeln('## Open Comments');
    buffer.writeln();

    if (openComments.isEmpty) {
      buffer.writeln('_No open review comments._');
      buffer.writeln();
    } else {
      _writeGroupedOpenComments(buffer, openComments);
    }

    if (resolvedComments.isNotEmpty) {
      buffer
        ..writeln('## Resolved Comments')
        ..writeln();
      for (final item in resolvedComments) {
        final singleLineSummary = item.comment
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();
        buffer.writeln(
          '- `[${item.id}]` `${item.locationLabel}` '
          '(`${item.site}` `${item.pageUrl}`): $singleLineSummary',
        );
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  /// Formats a clean standalone prompt containing open comments for stdout or
  /// clipboard agent workflows.
  String renderAgentPrompt(List<ReviewComment> comments, {String? siteFilter}) {
    final openComments = [
      for (final item in comments)
        if (item.status != 'resolved' &&
            (siteFilter == null || item.site == siteFilter))
          item,
    ];

    if (openComments.isEmpty) {
      return siteFilter == null
          ? 'No open review comments.\n'
          : 'No open review comments for site "$siteFilter".\n';
    }

    final buffer = StringBuffer()
      ..writeln(
        'Please address the following ${openComments.length} open visual '
        'review comment${openComments.length == 1 ? '' : 's'}:',
      )
      ..writeln();

    _writeGroupedOpenComments(buffer, openComments);

    buffer
      ..writeln('After fixing each item, mark it resolved with:')
      ..writeln()
      ..writeln('```bash')
      ..writeln('dart run dash_site review resolve <comment-id>')
      ..writeln('```');

    return buffer.toString();
  }

  void _writeGroupedOpenComments(
    StringBuffer buffer,
    List<ReviewComment> openComments,
  ) {
    final grouped = <String, List<ReviewComment>>{};
    for (final item in openComments) {
      final key = item.resolvedFile.isNotEmpty
          ? item.resolvedFile
          : (item.sourceFile.isNotEmpty
                ? item.sourceFile
                : '(unresolved source file)');
      grouped.putIfAbsent(key, () => <ReviewComment>[]).add(item);
    }

    final sortedFiles = grouped.keys.toList()..sort();
    var itemNumber = 0;

    for (final fileKey in sortedFiles) {
      final items = grouped[fileKey]!
        ..sort(
          (a, b) => (a.startLine ?? 1 << 20).compareTo(b.startLine ?? 1 << 20),
        );

      buffer
        ..writeln('### `$fileKey`')
        ..writeln();

      for (final item in items) {
        itemNumber++;
        final lineSuffix = switch ((item.startLine, item.endLine)) {
          (final int s, final int e) when e != s => 'Lines $s-$e',
          (final int s, _) => 'Line $s',
          _ => 'Unresolved line',
        };
        final titlePart = item.pageTitle.isNotEmpty
            ? '${item.pageTitle} (`${item.pageUrl}`)'
            : '`${item.pageUrl}`';

        buffer
          ..writeln(
            '#### $itemNumber. `[${item.id}]` $lineSuffix '
            '(`${item.site}` · `${item.pageUrl}`)',
          )
          ..writeln()
          ..writeln('- **Comment ID**: `${item.id}`')
          ..writeln('- **Location**: `${item.locationLabel}`')
          ..writeln('- **Page**: $titlePart');

        final anchorDetails = <String>[
          'type: `${item.anchorType}`',
          if (item.elementTag.isNotEmpty) 'tag: `<${item.elementTag}>`',
          if (item.headingAnchor.isNotEmpty) 'heading: `${item.headingAnchor}`',
          if (item.selector.isNotEmpty) 'selector: `${item.selector}`',
        ];
        buffer.writeln('- **Target**: ${anchorDetails.join(', ')}');

        final highlightText = item.selectedText.isNotEmpty
            ? item.selectedText
            : item.elementText;
        if (highlightText.isNotEmpty) {
          buffer.writeln('- **Highlighted text**:');
          for (final quoteLine in highlightText.split('\n')) {
            buffer.writeln('  > ${quoteLine.trimRight()}');
          }
        }

        buffer.writeln('- **Reviewer instruction**:');
        for (final commentLine in item.comment.split('\n')) {
          buffer.writeln('  ${commentLine.trimRight()}');
        }

        if (item.codeSnippet case final String snippet
            when snippet.trim().isNotEmpty) {
          final fenceLang = _codeFenceLanguageForPath(fileKey);
          final fence = snippet.contains('```') ? '````' : '```';
          buffer
            ..writeln('- **Source snippet**:')
            ..writeln('  $fence$fenceLang');
          for (final snippetLine in snippet.split('\n')) {
            buffer.writeln('  $snippetLine');
          }
          buffer.writeln('  $fence');
        }

        buffer
          ..writeln(
            '- **Resolve command**: '
            '`dart run dash_site review resolve ${item.id}`',
          )
          ..writeln();
      }
    }
  }
}

String _codeFenceLanguageForPath(String filePath) {
  final ext = path.posix.extension(filePath).toLowerCase();
  return switch (ext) {
    '.dart' => 'dart',
    '.md' || '.markdown' => 'markdown',
    '.yaml' || '.yml' => 'yaml',
    '.json' => 'json',
    '.html' || '.liquid' => 'html',
    _ => 'text',
  };
}

/// Local HTTP server bound strictly to `127.0.0.1` that syncs browser visual
/// review highlights and comments with `.dash_review/comments.json` and
/// `.dash_review/feedback.md`.
final class ReviewLocalServer {
  static final RegExp _validHostPattern = RegExp(
    r'^(localhost|127\.0\.0\.1)(:\d+)?$',
    caseSensitive: false,
  );

  static final RegExp _validOriginPattern = RegExp(
    r'^https?://(localhost|127\.0\.0\.1)(:\d+)?$',
    caseSensitive: false,
  );

  static final math.Random _random = math.Random();

  final HttpServer _server;
  final String repoRoot;
  final String site;
  final ReviewStore store;

  Future<void> _serialChain = Future<void>.value();
  bool _isClosed = false;
  late final Future<void> _serveSubscriptionDone;

  ReviewLocalServer._({
    required this._server,
    required this.repoRoot,
    required this.site,
  }) : store = ReviewStore(repoRoot) {
    _serveSubscriptionDone = _listen();
  }

  /// Starts the local review server on `127.0.0.1`, trying [preferredPort]
  /// (`4099` by default) first and automatically falling back to an OS-assigned
  /// ephemeral port (`0`) if [preferredPort] is already occupied.
  static Future<ReviewLocalServer> start({
    required String repoRoot,
    required String site,
    int preferredPort = defaultReviewServerPort,
  }) async {
    HttpServer server;
    try {
      server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        preferredPort,
      );
    } on SocketException {
      if (preferredPort == 0) rethrow;
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    }

    return ReviewLocalServer._(server: server, repoRoot: repoRoot, site: site);
  }

  /// Bound TCP port on `127.0.0.1`.
  int get port => _server.port;

  /// Bound address (always `127.0.0.1`).
  InternetAddress get address => _server.address;

  /// Base loopback origin URL for this server.
  String get origin => 'http://127.0.0.1:$port';

  /// Stops accepting requests and closes the underlying [HttpServer].
  Future<void> close({bool force = false}) async {
    if (_isClosed) return;
    _isClosed = true;
    await _server.close(force: force);
    await _serveSubscriptionDone;
  }

  Future<void> _listen() async {
    await for (final request in _server) {
      await _handleRequestSafely(request);
    }
  }

  Future<T> _serialize<T>(FutureOr<T> Function() action) {
    final completer = Completer<T>();
    _serialChain = _serialChain.whenComplete(() async {
      try {
        completer.complete(await action());
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  Future<void> _handleRequestSafely(HttpRequest request) async {
    try {
      if (!_validateAndApplySecurityHeaders(request)) {
        return;
      }

      if (request.method == 'OPTIONS') {
        request.response.statusCode = HttpStatus.noContent;
        await request.response.close();
        return;
      }

      final normalizedPath = _normalizeApiPath(request.uri.path);

      if (normalizedPath == '/api/health' && request.method == 'GET') {
        await _writeJson(request.response, HttpStatus.ok, {
          'ok': true,
          'site': site,
          'repoRoot': repoRoot,
          'feedbackFile': reviewFeedbackRelativePath,
        });
        return;
      }

      if (normalizedPath == '/api/comments') {
        switch (request.method) {
          case 'GET':
            await _handleGetComments(request);
          case 'POST':
            await _handleCreateComment(request);
          case 'DELETE':
            await _handleBulkDeleteComments(request);
          default:
            await _writeJson(request.response, HttpStatus.methodNotAllowed, {
              'ok': false,
              'error': 'Method ${request.method} not allowed on /api/comments.',
            });
        }
        return;
      }

      if (normalizedPath.startsWith('/api/comments/')) {
        final rawId = normalizedPath.substring('/api/comments/'.length);
        if (rawId.isNotEmpty && !rawId.contains('/')) {
          final commentId = Uri.decodeComponent(rawId);
          switch (request.method) {
            case 'PATCH':
              await _handlePatchComment(request, commentId);
            case 'DELETE':
              await _handleDeleteSingleComment(request, commentId);
            default:
              await _writeJson(request.response, HttpStatus.methodNotAllowed, {
                'ok': false,
                'error':
                    'Method ${request.method} not allowed on '
                    '/api/comments/<id>.',
              });
          }
          return;
        }
      }

      await _writeJson(request.response, HttpStatus.notFound, {
        'ok': false,
        'error': 'Not found: ${request.uri.path}',
      });
    } on _BadRequestException catch (error) {
      await _writeJson(request.response, HttpStatus.badRequest, {
        'ok': false,
        'error': error.message,
      });
    } on Exception catch (error) {
      await _writeJson(request.response, HttpStatus.internalServerError, {
        'ok': false,
        'error': 'Internal server error: $error',
      });
    }
  }

  bool _validateAndApplySecurityHeaders(HttpRequest request) {
    final hostValues = request.headers[HttpHeaders.hostHeader];
    if (hostValues == null ||
        hostValues.length != 1 ||
        !_validHostPattern.hasMatch(hostValues.single.trim())) {
      unawaited(
        _writeJson(request.response, HttpStatus.forbidden, {
          'ok': false,
          'error': 'Forbidden Host header.',
        }),
      );
      return false;
    }

    final originValues = request.headers['origin'];
    if (originValues != null && originValues.isNotEmpty) {
      final candidateOrigin = originValues.single.trim();
      if (originValues.length != 1 ||
          !_validOriginPattern.hasMatch(candidateOrigin)) {
        unawaited(
          _writeJson(request.response, HttpStatus.forbidden, {
            'ok': false,
            'error': 'Forbidden Origin header.',
          }),
        );
        return false;
      }

      request.response.headers
        ..set('Access-Control-Allow-Origin', candidateOrigin)
        ..set('Vary', 'Origin')
        ..set(
          'Access-Control-Allow-Methods',
          'GET, POST, PATCH, DELETE, OPTIONS',
        )
        ..set('Access-Control-Allow-Headers', 'Content-Type, Accept');
    } else if (request.method == 'OPTIONS') {
      request.response.headers
        ..set(
          'Access-Control-Allow-Methods',
          'GET, POST, PATCH, DELETE, OPTIONS',
        )
        ..set('Access-Control-Allow-Headers', 'Content-Type, Accept');
    }

    return true;
  }

  Future<void> _handleGetComments(HttpRequest request) async {
    final statusFilter = request.uri.queryParameters['status'] ?? 'all';
    if (statusFilter != 'open' &&
        statusFilter != 'resolved' &&
        statusFilter != 'all') {
      throw const _BadRequestException(
        'Invalid status query parameter. Expected open, resolved, or all.',
      );
    }

    final pageUrlFilter = request.uri.queryParameters['pageUrl'];
    final normalizedPageFilter =
        pageUrlFilter != null && pageUrlFilter.trim().isNotEmpty
        ? normalizeReviewPageUrl(pageUrlFilter)
        : null;
    final siteFilter = request.uri.queryParameters['site'];

    final payload = await _serialize(() {
      final allComments = store.loadComments();
      final scoped = [
        for (final item in allComments)
          if ((siteFilter == null ||
                  siteFilter.isEmpty ||
                  item.site == siteFilter) &&
              (normalizedPageFilter == null ||
                  normalizeReviewPageUrl(item.pageUrl) == normalizedPageFilter))
            item,
      ];
      final filtered = [
        for (final item in scoped)
          if (statusFilter == 'all' || item.status == statusFilter) item,
      ];

      return <String, Object?>{
        'ok': true,
        'comments': [for (final item in filtered) item.toJson()],
        'counts': computeCommentCounts(scoped),
        'feedbackFile': reviewFeedbackRelativePath,
      };
    });

    await _writeJson(request.response, HttpStatus.ok, payload);
  }

  Future<void> _handleCreateComment(HttpRequest request) async {
    final body = await _readJsonObjectBody(request);
    final commentText = _asString(body['comment']).trim();
    if (commentText.isEmpty) {
      throw const _BadRequestException('Field "comment" must not be empty.');
    }

    final rawSite = _asString(body['site']).trim();
    final commentSite = (rawSite == 'docs' || rawSite == 'www')
        ? rawSite
        : site;
    final pageUrl = _asString(body['pageUrl'], fallback: '/').trim();
    final pageTitle = _asString(body['pageTitle']).trim();
    final rawSourceFile = _asNullableString(body['sourceFile']);
    final selectedText = _asString(body['selectedText']);
    final prefixContext = _asString(body['prefixContext']);
    final suffixContext = _asString(body['suffixContext']);
    final selector = _asString(body['selector']).trim();
    final elementTag = _asString(body['elementTag']).trim();
    final elementText = _asString(body['elementText']);
    final headingAnchor = _asString(body['headingAnchor']).trim();
    final author = _asString(body['author'], fallback: 'local').trim();

    final rawAnchorType = _asString(body['anchorType']).trim();
    final anchorType = switch (rawAnchorType) {
      'text' || 'element' || 'area' => rawAnchorType,
      _ => selectedText.trim().isNotEmpty ? 'text' : 'element',
    };

    Map<String, double>? rectPct;
    if (body['rectPct'] case final Map<Object?, Object?> rawRect) {
      final parsed = <String, double>{};
      for (final entry in rawRect.entries) {
        if (entry.key is String && entry.value is num) {
          final doubleVal = (entry.value as num).toDouble();
          if (doubleVal.isFinite) {
            parsed[entry.key as String] = doubleVal;
          }
        }
      }
      if (parsed.isNotEmpty) {
        rectPct = parsed;
      }
    }

    final payload = await _serialize(() {
      final safeSource =
          sanitizeRepoRelativePath(repoRoot, rawSourceFile) ?? '';
      final located = locateHighlightInRepo(
        repoRoot: repoRoot,
        site: commentSite,
        sourceFile: rawSourceFile,
        selectedText: selectedText,
        elementText: elementText,
        headingAnchor: headingAnchor,
        pageUrl: pageUrl,
      );

      final now = DateTime.now().toUtc();
      final nowIso = now.toIso8601String();
      final comments = store.loadComments();
      final existingIds = {for (final item in comments) item.id};
      var generatedId = _generateCommentId(now.millisecondsSinceEpoch);
      while (existingIds.contains(generatedId)) {
        generatedId = _generateCommentId(now.millisecondsSinceEpoch);
      }

      final created = ReviewComment(
        id: generatedId,
        site: commentSite,
        pageUrl: pageUrl.isEmpty ? '/' : pageUrl,
        pageTitle: pageTitle,
        sourceFile: safeSource,
        resolvedFile: located.resolvedFile,
        startLine: located.startLine,
        endLine: located.endLine,
        codeSnippet: located.codeSnippet,
        anchorType: anchorType,
        selectedText: selectedText,
        prefixContext: prefixContext,
        suffixContext: suffixContext,
        selector: selector,
        elementTag: elementTag,
        elementText: elementText,
        headingAnchor: headingAnchor,
        rectPct: rectPct,
        comment: commentText,
        author: author.isEmpty ? 'local' : author,
        status: 'open',
        createdAt: nowIso,
        updatedAt: nowIso,
      );

      comments.add(created);
      store.saveComments(comments, now: now);

      return <String, Object?>{
        'ok': true,
        'comment': created.toJson(),
        'counts': computeCommentCounts(comments),
        'feedbackFile': reviewFeedbackRelativePath,
      };
    });

    await _writeJson(request.response, HttpStatus.created, payload);
  }

  Future<void> _handlePatchComment(
    HttpRequest request,
    String commentId,
  ) async {
    final body = await _readJsonObjectBody(request);

    String? nextCommentText;
    if (body.containsKey('comment')) {
      final raw = body['comment'];
      if (raw is! String || raw.trim().isEmpty) {
        throw const _BadRequestException(
          'Field "comment" must be a non-empty string.',
        );
      }
      nextCommentText = raw.trim();
    }

    String? nextStatus;
    if (body.containsKey('status')) {
      final raw = body['status'];
      if (raw != 'open' && raw != 'resolved') {
        throw const _BadRequestException(
          'Field "status" must be "open" or "resolved".',
        );
      }
      nextStatus = raw as String;
    }

    if (nextCommentText == null && nextStatus == null) {
      throw const _BadRequestException(
        'PATCH body must include "comment" and/or "status".',
      );
    }

    final result = await _serialize(() {
      final comments = store.loadComments();
      final index = comments.indexWhere((item) => item.id == commentId);
      if (index < 0) return null;

      final now = DateTime.now().toUtc();
      final updated = comments[index].copyWith(
        comment: nextCommentText,
        status: nextStatus,
        updatedAt: now.toIso8601String(),
      );
      comments[index] = updated;
      store.saveComments(comments, now: now);

      return <String, Object?>{
        'ok': true,
        'comment': updated.toJson(),
        'counts': computeCommentCounts(comments),
        'feedbackFile': reviewFeedbackRelativePath,
      };
    });

    if (result == null) {
      await _writeJson(request.response, HttpStatus.notFound, {
        'ok': false,
        'error': 'Comment "$commentId" not found.',
      });
      return;
    }

    await _writeJson(request.response, HttpStatus.ok, result);
  }

  Future<void> _handleDeleteSingleComment(
    HttpRequest request,
    String commentId,
  ) async {
    final result = await _serialize(() {
      final comments = store.loadComments();
      final beforeLength = comments.length;
      comments.removeWhere((item) => item.id == commentId);
      final deleted = beforeLength - comments.length;
      if (deleted == 0) return null;

      store.saveComments(comments);
      return <String, Object?>{
        'ok': true,
        'deleted': deleted,
        'counts': computeCommentCounts(comments),
        'feedbackFile': reviewFeedbackRelativePath,
      };
    });

    if (result == null) {
      await _writeJson(request.response, HttpStatus.notFound, {
        'ok': false,
        'error': 'Comment "$commentId" not found.',
      });
      return;
    }

    await _writeJson(request.response, HttpStatus.ok, result);
  }

  Future<void> _handleBulkDeleteComments(HttpRequest request) async {
    final statusFilter = request.uri.queryParameters['status'];
    if (statusFilter != 'resolved' && statusFilter != 'all') {
      throw const _BadRequestException(
        'DELETE /api/comments requires ?status=resolved or ?status=all.',
      );
    }

    final pageUrlFilter = request.uri.queryParameters['pageUrl'];
    final normalizedPageFilter =
        pageUrlFilter != null && pageUrlFilter.trim().isNotEmpty
        ? normalizeReviewPageUrl(pageUrlFilter)
        : null;
    final siteFilter = request.uri.queryParameters['site'];

    final payload = await _serialize(() {
      final comments = store.loadComments();
      final beforeLength = comments.length;
      comments.removeWhere((item) {
        final matchesStatus =
            statusFilter == 'all' || item.status == statusFilter;
        final matchesSite =
            siteFilter == null || siteFilter.isEmpty || item.site == siteFilter;
        final matchesPage =
            normalizedPageFilter == null ||
            normalizeReviewPageUrl(item.pageUrl) == normalizedPageFilter;
        return matchesStatus && matchesSite && matchesPage;
      });
      final deleted = beforeLength - comments.length;
      store.saveComments(comments);

      return <String, Object?>{
        'ok': true,
        'deleted': deleted,
        'counts': computeCommentCounts(comments),
        'feedbackFile': reviewFeedbackRelativePath,
      };
    });

    await _writeJson(request.response, HttpStatus.ok, payload);
  }

  static Future<Map<String, Object?>> _readJsonObjectBody(
    HttpRequest request,
  ) async {
    final builder = BytesBuilder(copy: false);
    await for (final chunk in request) {
      if (builder.length + chunk.length > _maxRequestBodyBytes) {
        throw const _BadRequestException('Request body exceeds maximum size.');
      }
      builder.add(chunk);
    }

    final bytes = builder.takeBytes();
    if (bytes.isEmpty) {
      throw const _BadRequestException('Expected a JSON object request body.');
    }

    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(bytes));
    } on FormatException catch (error) {
      throw _BadRequestException('Invalid JSON body: ${error.message}');
    }

    if (decoded is Map<String, Object?>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.cast<String, Object?>();
    }
    throw const _BadRequestException('Expected a JSON object request body.');
  }

  static Future<void> _writeJson(
    HttpResponse response,
    int statusCode,
    Map<String, Object?> body,
  ) async {
    response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(body));
    await response.close();
  }

  static String _normalizeApiPath(String rawPath) {
    if (rawPath.length > 1 && rawPath.endsWith('/')) {
      return rawPath.substring(0, rawPath.length - 1);
    }
    return rawPath;
  }

  static String _generateCommentId(int epochMillis) {
    const alphabet = '0123456789abcdefghijklmnopqrstuvwxyz';
    final suffix = StringBuffer();
    for (var i = 0; i < 6; i++) {
      suffix.write(alphabet[_random.nextInt(alphabet.length)]);
    }
    return 'rv_${epochMillis}_$suffix';
  }
}

final class _BadRequestException implements Exception {
  final String message;
  const _BadRequestException(this.message);
}

String _asString(Object? value, {String fallback = ''}) =>
    value is String ? value : fallback;

String? _asNullableString(Object? value) => value is String ? value : null;

int? _asIntOrNull(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return null;
}
