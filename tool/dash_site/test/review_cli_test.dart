// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dash_site/dash_site.dart';
import 'package:dash_site/src/commands/build.dart';
import 'package:dash_site/src/commands/serve.dart';
import 'package:dash_site/src/commands/stage_preview.dart';
import 'package:dash_site/src/sites.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  late Directory tempRepo;

  setUp(() {
    tempRepo = Directory.systemTemp.createTempSync('dash_review_cli_test_');
  });

  tearDown(() {
    if (tempRepo.existsSync()) {
      tempRepo.deleteSync(recursive: true);
    }
  });

  ReviewComment sampleComment({
    required String id,
    required String site,
    required String pageUrl,
    required String resolvedFile,
    required int startLine,
    required String comment,
    String status = 'open',
  }) => ReviewComment(
    id: id,
    site: site,
    pageUrl: pageUrl,
    pageTitle: 'Sample page',
    sourceFile: resolvedFile,
    resolvedFile: resolvedFile,
    startLine: startLine,
    endLine: startLine,
    codeSnippet: 'Sample snippet line',
    anchorType: 'text',
    selectedText: 'Sample highlighted quote',
    prefixContext: '',
    suffixContext: '',
    selector: 'main p',
    elementTag: 'p',
    elementText: 'Sample highlighted quote',
    headingAnchor: '#intro',
    rectPct: null,
    comment: comment,
    author: 'local',
    status: status,
    createdAt: '2026-11-13T05:00:00.000Z',
    updatedAt: '2026-11-13T05:00:00.000Z',
  );

  Future<({int exitCode, String stdout, String stderr})> runCli(
    List<String> args,
  ) async {
    final out = StringBuffer();
    final err = StringBuffer();
    final runner = DashSiteCommandRunner(
      repoRoot: tempRepo.path,
      out: out,
      err: err,
    );
    final code = await runner.run(args) ?? 0;
    return (exitCode: code, stdout: out.toString(), stderr: err.toString());
  }

  group('dash_site review CLI subcommands', () {
    test('lists comments across both sites without --site and supports --site/--json', () async {
      final store = ReviewStore(tempRepo.path);
      store.saveComments([
        sampleComment(
          id: 'rv_100_docs01',
          site: 'docs',
          pageUrl: '/ui/layout/',
          resolvedFile: 'sites/docs/src/content/ui/layout/index.md',
          startLine: 14,
          comment: 'Tighten intro paragraph.',
        ),
        sampleComment(
          id: 'rv_200_www01',
          site: 'www',
          pageUrl: '/',
          resolvedFile: 'sites/www/lib/src/pages/home_page.dart',
          startLine: 156,
          comment: 'Update hero subheading.',
          status: 'resolved',
        ),
      ]);

      // Without --site, both docs and www comments are returned!
      final allResult = await runCli(['review', 'list']);
      expect(allResult.exitCode, 0);
      expect(allResult.stdout, contains('rv_100_docs01'));
      expect(allResult.stdout, contains('rv_200_www01'));

      // Filtering by --status=open and --json.
      final openJsonResult = await runCli([
        'review',
        'list',
        '--status=open',
        '--json',
      ]);
      expect(openJsonResult.exitCode, 0);
      final parsed = jsonDecode(openJsonResult.stdout) as Map<String, Object?>;
      expect(parsed['ok'], isTrue);
      expect(parsed['comments'] as List<Object?>, hasLength(1));

      // Explicit --site=www filter works both globally and on subcommand.
      final wwwGlobal = await runCli(['--site=www', 'review', 'list']);
      expect(wwwGlobal.exitCode, 0);
      expect(wwwGlobal.stdout, contains('rv_200_www01'));
      expect(wwwGlobal.stdout, isNot(contains('rv_100_docs01')));

      final wwwLocal = await runCli(['review', 'list', '--site=www']);
      expect(wwwLocal.exitCode, 0);
      expect(wwwLocal.stdout, contains('rv_200_www01'));
      expect(wwwLocal.stdout, isNot(contains('rv_100_docs01')));
    });

    test('prompt outputs clean agent instructions for open comments', () async {
      final store = ReviewStore(tempRepo.path);
      store.saveComments([
        sampleComment(
          id: 'rv_300_open',
          site: 'docs',
          pageUrl: '/get-started/',
          resolvedFile: 'sites/docs/src/content/get-started/index.md',
          startLine: 22,
          comment: 'Clarify SDK path step.',
        ),
        sampleComment(
          id: 'rv_301_done',
          site: 'docs',
          pageUrl: '/get-started/',
          resolvedFile: 'sites/docs/src/content/get-started/index.md',
          startLine: 30,
          comment: 'Already fixed.',
          status: 'resolved',
        ),
      ]);

      final promptRes = await runCli(['review', 'prompt']);
      expect(promptRes.exitCode, 0);
      expect(promptRes.stdout, contains('rv_300_open'));
      expect(
        promptRes.stdout,
        contains('sites/docs/src/content/get-started/index.md:22'),
      );
      expect(promptRes.stdout, contains('Clarify SDK path step.'));
      expect(
        promptRes.stdout,
        contains('dart run dash_site review resolve rv_300_open'),
      );
      expect(promptRes.stdout, isNot(contains('rv_301_done')));
    });

    test(
      'resolve, resolve --all, and clear sync comments.json and feedback.md',
      () async {
        final store = ReviewStore(tempRepo.path);
        store.saveComments([
          sampleComment(
            id: 'rv_401',
            site: 'docs',
            pageUrl: '/a/',
            resolvedFile: 'sites/docs/src/content/a.md',
            startLine: 5,
            comment: 'First item',
          ),
          sampleComment(
            id: 'rv_402',
            site: 'www',
            pageUrl: '/b/',
            resolvedFile: 'sites/www/content/b.md',
            startLine: 9,
            comment: 'Second item',
          ),
        ]);

        // Resolve a single comment by ID.
        final resolveOne = await runCli(['review', 'resolve', 'rv_401']);
        expect(resolveOne.exitCode, 0);
        expect(
          store.loadComments().firstWhere((c) => c.id == 'rv_401').status,
          'resolved',
        );
        final feedbackAfterOne = File(
          path.join(tempRepo.path, '.dash_review', 'feedback.md'),
        ).readAsStringSync();
        expect(feedbackAfterOne, contains('- **Open comments**: 1'));
        expect(feedbackAfterOne, contains('- **Resolved comments**: 1'));

        // Missing ID returns exit code 1.
        final missingRes = await runCli(['review', 'resolve', 'rv_unknown']);
        expect(missingRes.exitCode, 1);
        expect(missingRes.stderr, contains('rv_unknown'));

        // Clear resolved (default) removes rv_401 and keeps open rv_402.
        final clearResolved = await runCli(['review', 'clear']);
        expect(clearResolved.exitCode, 0);
        final remaining = store.loadComments();
        expect(remaining.map((c) => c.id).toList(), ['rv_402']);

        // Resolve --all then clear --all empties the store.
        final resolveAll = await runCli(['review', 'resolve', '--all']);
        expect(resolveAll.exitCode, 0);
        expect(store.loadComments().single.status, 'resolved');

        final clearAll = await runCli(['review', 'clear', '--all']);
        expect(clearAll.exitCode, 0);
        expect(store.loadComments(), isEmpty);
      },
    );

    test(
      'clear and resolve --all do not create .dash_review in a clean workspace',
      () async {
        final reviewDir = Directory(path.join(tempRepo.path, '.dash_review'));
        expect(reviewDir.existsSync(), isFalse);

        final resolveAllRes = await runCli(['review', 'resolve', '--all']);
        expect(resolveAllRes.exitCode, 0);
        expect(reviewDir.existsSync(), isFalse);

        final clearResolvedRes = await runCli(['review', 'clear']);
        expect(clearResolvedRes.exitCode, 0);
        expect(reviewDir.existsSync(), isFalse);

        final clearAllRes = await runCli(['review', 'clear', '--all']);
        expect(clearAllRes.exitCode, 0);
        expect(reviewDir.existsSync(), isFalse);
      },
    );
  });

  group('build, serve, and stage-preview --dart-define isolation', () {
    test(
      'plain build and production release emit zero DASH_REVIEW defines',
      () {
        final plainArgs = buildJasprBuildArgs(
          Site.docs,
          productionRelease: false,
        );
        expect(plainArgs, contains('--dart-define=PRODUCTION=false'));
        expect(plainArgs.any((arg) => arg.contains('DASH_REVIEW')), isFalse);

        final prodArgs = buildJasprBuildArgs(
          Site.www,
          productionRelease: true,
          extraDartDefines: const {
            'DASH_REVIEW_MODE': 'preview',
            'DASH_REVIEW_SITE': 'www',
          },
        );
        expect(prodArgs, contains('--dart-define=PRODUCTION=true'));
        expect(prodArgs.any((arg) => arg.contains('DASH_REVIEW')), isFalse);
      },
    );

    test('BuildSiteCommand rejects combining --release with --review-mode', () {
      final runner = DashSiteCommandRunner(repoRoot: tempRepo.path);
      expect(
        () => runner.run(['build', '--release', '--review-mode=local']),
        throwsA(isA<UsageException>()),
      );
    });

    test('serve passes local review defines unless --no-review is active', () {
      final withReview = buildJasprServeArgs(
        Site.docs,
        release: false,
        reviewServerPort: 4099,
      );
      expect(withReview, contains('--dart-define=PRODUCTION=false'));
      expect(withReview, contains('--dart-define=DASH_REVIEW_MODE=local'));
      expect(withReview, contains('--dart-define=DASH_REVIEW_SITE=docs'));
      expect(
        withReview,
        contains('--dart-define=DASH_REVIEW_SERVER_PORT=4099'),
      );

      final withoutReview = buildJasprServeArgs(Site.www, release: false);
      expect(withoutReview.any((arg) => arg.contains('DASH_REVIEW')), isFalse);
    });

    test('stage-preview builds preview defines and PR comment tip', () {
      final defines = buildStagePreviewDartDefines(
        Site.www,
        prNumber: '12345',
        repoFullName: 'flutter/website',
        commitSha: 'abc123def',
        headBranch: 'feat/highlight-review',
      );
      expect(defines, {
        'DASH_REVIEW_MODE': 'preview',
        'DASH_REVIEW_SITE': 'www',
        'DASH_REVIEW_PR_NUMBER': '12345',
        'DASH_REVIEW_REPO': 'flutter/website',
        'DASH_REVIEW_COMMIT_SHA': 'abc123def',
        'DASH_REVIEW_HEAD_BRANCH': 'feat/highlight-review',
      });

      final stageBuildArgs = buildJasprBuildArgs(
        Site.www,
        productionRelease: false,
        extraDartDefines: defines,
      );
      expect(
        stageBuildArgs,
        contains('--dart-define=DASH_REVIEW_MODE=preview'),
      );
      expect(
        stageBuildArgs,
        contains('--dart-define=DASH_REVIEW_PR_NUMBER=12345'),
      );

      final prComment = formatStagingPreviewCommentBody(
        site: Site.docs,
        stagingUrl: 'https://flutter-docs-prod--pr123-main.web.app',
        commitSha: 'abc123def',
      );
      expect(prComment, contains('<!-- flutter-preview-docs -->'));
      expect(
        prComment,
        contains('https://flutter-docs-prod--pr123-main.web.app'),
      );
      expect(prComment.toLowerCase(), contains('highlight'));
    });
  });
}
