// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:dash_site/src/review_server.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  late Directory tempRepo;
  late HttpClient client;

  setUp(() {
    tempRepo = Directory.systemTemp.createTempSync('dash_review_server_test_');
    client = HttpClient();
  });

  tearDown(() {
    client.close(force: true);
    if (tempRepo.existsSync()) {
      tempRepo.deleteSync(recursive: true);
    }
  });

  void writeRepoFile(String relativePath, String contents) {
    final file = File(
      path.joinAll([tempRepo.path, ...path.posix.split(relativePath)]),
    );
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(contents);
  }

  Future<({int status, Map<String, Object?> json, HttpHeaders headers})>
  sendJsonRequest(
    int port,
    String method,
    String requestPath, {
    Object? body,
    String? hostOverride,
    String? origin,
  }) async {
    final request = await client.open(
      method,
      InternetAddress.loopbackIPv4.address,
      port,
      requestPath,
    );
    if (hostOverride != null) {
      request.headers.set(HttpHeaders.hostHeader, hostOverride);
    }
    if (origin != null) {
      request.headers.set('Origin', origin);
    }
    if (body != null) {
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(body));
    }
    final response = await request.close();
    final rawText = await utf8.decoder.bind(response).join();
    final decoded = rawText.isEmpty
        ? <String, Object?>{}
        : (jsonDecode(rawText) as Map).cast<String, Object?>();
    return (
      status: response.statusCode,
      json: decoded,
      headers: response.headers,
    );
  }

  group('ReviewLocalServer binding and security', () {
    test(
      'binds strictly to 127.0.0.1 and falls back when preferredPort is busy',
      () async {
        final blocker = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(() => blocker.close(force: true));

        final server = await ReviewLocalServer.start(
          repoRoot: tempRepo.path,
          site: 'docs',
          preferredPort: blocker.port,
        );
        addTearDown(server.close);

        expect(server.address, InternetAddress.loopbackIPv4);
        expect(server.port, isNot(equals(blocker.port)));
        expect(server.port, greaterThan(0));

        final health = await sendJsonRequest(server.port, 'GET', '/api/health');
        expect(health.status, HttpStatus.ok);
        expect(health.json['ok'], isTrue);
        expect(health.json['site'], 'docs');
        expect(health.json['feedbackFile'], '.dash_review/feedback.md');
      },
    );

    test('rejects DNS-rebinding Host headers with 403', () async {
      final server = await ReviewLocalServer.start(
        repoRoot: tempRepo.path,
        site: 'docs',
        preferredPort: 0,
      );
      addTearDown(server.close);

      final evilHost = await sendJsonRequest(
        server.port,
        'GET',
        '/api/health',
        hostOverride: 'attacker-rebind.example.com:${server.port}',
      );
      expect(evilHost.status, HttpStatus.forbidden);
      expect(evilHost.json['ok'], isFalse);

      final localhostHost = await sendJsonRequest(
        server.port,
        'GET',
        '/api/health',
        hostOverride: 'localhost:${server.port}',
      );
      expect(localhostHost.status, HttpStatus.ok);
      expect(localhostHost.json['ok'], isTrue);
    });

    test('survives abrupt client socket disconnects during 403 and error responses', () async {
      final server = await ReviewLocalServer.start(
        repoRoot: tempRepo.path,
        site: 'docs',
        preferredPort: 0,
      );
      addTearDown(server.close);

      final rawSocket = await Socket.connect(
        InternetAddress.loopbackIPv4,
        server.port,
      );
      rawSocket.write(
        'GET /api/health HTTP/1.1\r\n'
        'Host: attacker.example.com\r\n\r\n',
      );
      rawSocket.destroy();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final afterAbort = await sendJsonRequest(
        server.port,
        'GET',
        '/api/health',
      );
      expect(afterAbort.status, HttpStatus.ok);
      expect(afterAbort.json['ok'], isTrue);
    });

    test(
      'enforces strict localhost/127.0.0.1 CORS and handles OPTIONS preflight',
      () async {
        final server = await ReviewLocalServer.start(
          repoRoot: tempRepo.path,
          site: 'www',
          preferredPort: 0,
        );
        addTearDown(server.close);

        final allowedPreflight = await sendJsonRequest(
          server.port,
          'OPTIONS',
          '/api/comments',
          origin: 'http://localhost:8082',
        );
        expect(allowedPreflight.status, HttpStatus.noContent);
        expect(
          allowedPreflight.headers.value('access-control-allow-origin'),
          'http://localhost:8082',
        );
        expect(
          allowedPreflight.headers.value('access-control-allow-methods'),
          contains('PATCH'),
        );

        final evilPreflight = await sendJsonRequest(
          server.port,
          'OPTIONS',
          '/api/comments',
          origin: 'https://evil.example.org',
        );
        expect(evilPreflight.status, HttpStatus.forbidden);
        expect(
          evilPreflight.headers.value('access-control-allow-origin'),
          isNull,
        );

        final evilPost = await sendJsonRequest(
          server.port,
          'POST',
          '/api/comments',
          origin: 'https://evil.example.org',
          body: {'comment': 'Should be blocked'},
        );
        expect(evilPost.status, HttpStatus.forbidden);
        expect(
          File(path.join(tempRepo.path, '.dash_review', 'comments.json'))
              .existsSync(),
          isFalse,
        );
      },
    );
  });

  group('ReviewLocalServer CRUD and Markdown sync', () {
    test('supports full CRUD and syncs comments.json + feedback.md', () async {
      writeRepoFile('sites/docs/src/content/ui/layout/index.md', '''
---
title: Build layouts
---

## Row and Column

Use [`Row`](/ui/row) and `Column` to position widgets
horizontally or vertically.
''');

      final server = await ReviewLocalServer.start(
        repoRoot: tempRepo.path,
        site: 'docs',
        preferredPort: 0,
      );
      addTearDown(server.close);

      // 1. Create a comment via POST /api/comments.
      final createRes = await sendJsonRequest(
        server.port,
        'POST',
        '/api/comments',
        origin: 'http://127.0.0.1:8081',
        body: {
          'site': 'docs',
          'pageUrl': '/ui/layout/',
          'pageTitle': 'Build layouts',
          'sourceFile': 'sites/docs/src/content/ui/layout/index.md',
          'anchorType': 'text',
          'selectedText':
              'Use Row and Column to position widgets '
              'horizontally or vertically.',
          'selector': 'main article p',
          'elementTag': 'p',
          'headingAnchor': '#row-and-column',
          'comment': 'Mention Flex and Wrap as responsive alternatives.',
        },
      );

      expect(createRes.status, HttpStatus.created);
      expect(
        createRes.headers.value('access-control-allow-origin'),
        'http://127.0.0.1:8081',
      );
      expect(createRes.json['ok'], isTrue);
      expect(createRes.json['feedbackFile'], '.dash_review/feedback.md');

      final createdComment = (createRes.json['comment'] as Map)
          .cast<String, Object?>();
      final commentId = createdComment['id'] as String;
      expect(commentId, startsWith('rv_'));
      expect(createdComment['status'], 'open');
      expect(
        createdComment['resolvedFile'],
        'sites/docs/src/content/ui/layout/index.md',
      );
      expect(createdComment['startLine'], 7);
      expect(createdComment['endLine'], 8);
      expect(createdComment['codeSnippet'], contains('[`Row`](/ui/row)'));

      // Verify files on disk.
      final commentsFile = File(
        path.join(tempRepo.path, '.dash_review', 'comments.json'),
      );
      final feedbackFile = File(
        path.join(tempRepo.path, '.dash_review', 'feedback.md'),
      );
      expect(commentsFile.existsSync(), isTrue);
      expect(feedbackFile.existsSync(), isTrue);

      final feedbackMd = feedbackFile.readAsStringSync();
      expect(feedbackMd, contains('- **Open comments**: 1'));
      expect(feedbackMd, contains(commentId));
      expect(
        feedbackMd,
        contains('sites/docs/src/content/ui/layout/index.md:7-8'),
      );
      expect(
        feedbackMd,
        contains('Mention Flex and Wrap as responsive alternatives.'),
      );
      expect(
        feedbackMd,
        contains('dart run dash_site review resolve $commentId'),
      );

      // 2. Create a second comment on another page (with malicious sourceFile).
      final secondRes = await sendJsonRequest(
        server.port,
        'POST',
        '/api/comments',
        body: {
          'pageUrl': '/get-started/',
          'sourceFile': '../../../../etc/passwd',
          'anchorType': 'area',
          'rectPct': {'x': 12.5, 'y': 20.0, 'w': 40.0, 'h': 15.0},
          'comment': 'Fix spacing in hero banner.',
        },
      );
      expect(secondRes.status, HttpStatus.created);
      final secondComment = (secondRes.json['comment'] as Map)
          .cast<String, Object?>();
      final secondId = secondComment['id'] as String;
      expect(secondComment['sourceFile'], isEmpty);
      expect(secondComment['resolvedFile'], isEmpty);

      // 3. Filter GET /api/comments by pageUrl and status.
      final pageFiltered = await sendJsonRequest(
        server.port,
        'GET',
        '/api/comments?pageUrl=/ui/layout',
      );
      expect(pageFiltered.status, HttpStatus.ok);
      final pageComments = pageFiltered.json['comments'] as List<Object?>;
      expect(pageComments, hasLength(1));

      // 4. PATCH comment status -> resolved and update text.
      final patchRes = await sendJsonRequest(
        server.port,
        'PATCH',
        '/api/comments/$commentId',
        body: {'status': 'resolved', 'comment': 'Added Flex and Wrap callout.'},
      );
      expect(patchRes.status, HttpStatus.ok);
      final patched = (patchRes.json['comment'] as Map).cast<String, Object?>();
      expect(patched['status'], 'resolved');
      expect(patched['comment'], 'Added Flex and Wrap callout.');
      expect(patchRes.json['counts'], {'open': 1, 'resolved': 1, 'total': 2});

      final updatedFeedbackMd = feedbackFile.readAsStringSync();
      expect(updatedFeedbackMd, contains('- **Open comments**: 1'));
      expect(updatedFeedbackMd, contains('- **Resolved comments**: 1'));
      expect(updatedFeedbackMd, contains('## Resolved Comments'));

      // 5. Bulk DELETE resolved comments.
      final bulkDelete = await sendJsonRequest(
        server.port,
        'DELETE',
        '/api/comments?status=resolved',
      );
      expect(bulkDelete.status, HttpStatus.ok);
      expect(bulkDelete.json['deleted'], 1);
      expect(bulkDelete.json['counts'], {'open': 1, 'resolved': 0, 'total': 1});

      // 6. Single DELETE remaining comment.
      final singleDelete = await sendJsonRequest(
        server.port,
        'DELETE',
        '/api/comments/$secondId',
      );
      expect(singleDelete.status, HttpStatus.ok);
      expect(singleDelete.json['deleted'], 1);
      expect(singleDelete.json['counts'], {
        'open': 0,
        'resolved': 0,
        'total': 0,
      });
    });
  });
}
