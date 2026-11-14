// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/review.dart';
import 'package:test/test.dart';

Page _createTestPage({
  String path = 'ui/layout/index.md',
  String url = '/ui/layout',
  Map<String, Object?> pageData = const {'title': 'Layouts in Flutter'},
  Map<String, Object?> siteData = const {'title': 'Flutter Docs'},
}) {
  return Page(
    path: path,
    url: url,
    content: '# Test Page',
    initialData: {
      'page': pageData,
      'site': siteData,
    },
    config: const PageConfig(),
    loader: MemoryLoader(pages: const []),
  );
}

void main() {
  setUpAll(() {
    if (!Jaspr.isInitialized) {
      Jaspr.initializeApp();
    }
  });

  group('ReviewConfig and ReviewEnvironment safety gates', () {
    test('is disabled by default when DASH_REVIEW_MODE is unset', () {
      expect(ReviewConfig.mode, isEmpty);
      expect(ReviewConfig.isEnabled, isFalse);
      expect(ReviewConfig.repo, equals('flutter/website'));
      expect(ReviewConfig.serverOrigin, isEmpty);
    });

    test('enables only local and preview modes when not in production', () {
      const localEnv = ReviewEnvironment(mode: 'local', serverPort: '4099');
      expect(localEnv.isEnabled, isTrue);
      expect(localEnv.serverOrigin, equals('http://127.0.0.1:4099'));

      const previewEnv = ReviewEnvironment(
        mode: 'preview',
        prNumber: '14030',
        repo: 'flutter/website',
      );
      expect(previewEnv.isEnabled, isTrue);
      expect(previewEnv.serverOrigin, isEmpty);

      const emptyEnv = ReviewEnvironment();
      expect(emptyEnv.isEnabled, isFalse);

      const unknownEnv = ReviewEnvironment(mode: 'staging');
      expect(unknownEnv.isEnabled, isFalse);
    });

    test('hard blocks overlay whenever isProduction is true', () {
      const prodLocal = ReviewEnvironment(
        mode: 'local',
        isProduction: true,
        serverPort: '4099',
      );
      expect(prodLocal.isEnabled, isFalse);

      const prodPreview = ReviewEnvironment(
        mode: 'preview',
        isProduction: true,
        prNumber: '14030',
      );
      expect(prodPreview.isEnabled, isFalse);
    });

    test('falls back to flutter/website when repo is blank', () {
      const env = ReviewEnvironment(mode: 'preview', repo: '   ');
      expect(env.effectiveRepo, equals('flutter/website'));
    });
  });

  group('resolveReviewSourceFile and buildReviewPageConfigMap', () {
    test('prefers explicit page.data.page sourceFile when non-empty', () {
      final source = resolveReviewSourceFile(
        pageData: const {'sourceFile': '/sites/docs/src/data/glossary.yml'},
        pagePath: 'resources/glossary.md',
        contentRootPrefix: 'sites/docs/src/content',
      );
      expect(source, equals('sites/docs/src/data/glossary.yml'));
    });

    test('joins contentRootPrefix and page.path cleanly for docs and www', () {
      expect(
        resolveReviewSourceFile(
          pageData: const {},
          pagePath: 'ui/layout/index.md',
          contentRootPrefix: 'sites/docs/src/content/',
        ),
        equals('sites/docs/src/content/ui/layout/index.md'),
      );

      expect(
        resolveReviewSourceFile(
          pageData: const {'sourceFile': '   '},
          pagePath: '/index.md',
          contentRootPrefix: 'sites/www/content',
        ),
        equals('sites/www/content/index.md'),
      );
    });

    test('avoids duplicating prefix and handles empty paths', () {
      expect(
        resolveReviewSourceFile(
          pageData: const {},
          pagePath: 'sites/www/content/ai/index.md',
          contentRootPrefix: 'sites/www/content',
        ),
        equals('sites/www/content/ai/index.md'),
      );

      expect(
        resolveReviewSourceFile(
          pageData: const {},
          pagePath: '',
          contentRootPrefix: 'sites/www/content',
        ),
        isEmpty,
      );
    });

    test('builds complete per-page config map', () {
      final page = _createTestPage(
        path: 'ai/index.md',
        url: '/ai',
        pageData: const {'title': 'Flutter & AI'},
      );
      const env = ReviewEnvironment(
        mode: 'preview',
        prNumber: '99999',
        repo: 'flutter/website',
        commitSha: 'deadbeef',
        headBranch: 'feat/ai-update',
      );
      final map = buildReviewPageConfigMap(
        page,
        defaultSite: 'www',
        contentRootPrefix: 'sites/www/content',
        environment: env,
      );

      expect(
        map,
        equals({
          'mode': 'preview',
          'site': 'www',
          'pageUrl': '/ai',
          'pageTitle': 'Flutter & AI',
          'sourceFile': 'sites/www/content/ai/index.md',
          'serverOrigin': '',
          'prNumber': '99999',
          'repo': 'flutter/website',
          'commitSha': 'deadbeef',
          'headBranch': 'feat/ai-update',
        }),
      );
    });
  });

  group('encodeReviewJsonForHtml XSS escaping', () {
    test(
      'escapes closing script tags and HTML comments while staying valid JSON',
      () {
        final payload = <String, Object?>{
          'pageTitle':
              'Danger </script><script>alert(1)</script> <!-- comment -->',
          'pageUrl': '/test/</Title>',
        };
        final encoded = encodeReviewJsonForHtml(payload);

        expect(encoded, isNot(contains('</')));
        expect(encoded, isNot(contains('<!--')));
        expect(encoded, contains(r'<\/script>'));

        final decoded = jsonDecode(encoded) as Map<String, Object?>;
        expect(decoded, equals(payload));
      },
    );
  });

  group('buildReviewOverlayComponents rendering', () {
    test('returns empty list when disabled or in production build', () {
      final page = _createTestPage();

      expect(
        buildReviewOverlayComponents(
          page,
          defaultSite: 'www',
          contentRootPrefix: 'sites/www/content',
        ),
        isEmpty,
      );

      expect(
        buildReviewOverlayComponents(
          page,
          defaultSite: 'www',
          contentRootPrefix: 'sites/www/content',
          environment: const ReviewEnvironment(
            mode: 'local',
            isProduction: true,
            serverPort: '4099',
          ),
        ),
        isEmpty,
      );
    });

    test(
      'renders escaped JSON config and deferred client script when enabled',
      () async {
        final page = _createTestPage(
          path: 'index.md',
          url: '/',
          pageData: const {
            'title': 'Welcome </script><script>window.pwned=true</script>',
          },
        );
        final components = buildReviewOverlayComponents(
          page,
          defaultSite: 'docs',
          contentRootPrefix: 'sites/docs/src/content',
          environment: const ReviewEnvironment(
            mode: 'local',
            site: 'docs',
            serverPort: '4099',
          ),
        );

        expect(components, hasLength(2));

        final rendered = await renderComponent(
          .fragment(components),
          standalone: true,
        );
        final html = utf8.decode(rendered.body);

        expect(
          html,
          contains('<script id="dash-review-config" type="application/json">'),
        );
        expect(html, contains('<script id="dash-review-script" defer'));
        expect(html, isNot(contains('</script><script>window.pwned')));
        expect(
          html,
          contains(r'<\/script><script>window.pwned=true<\/script>'),
        );
        expect(html, contains('http://127.0.0.1:4099'));
        expect(html, contains('sites/docs/src/content/index.md'));
        expect(html, contains('dash-review-host'));
      },
    );
  });

  group('client script bundle security and syntax', () {
    test(
      'contains zero unsafe HTML sinks or raw script-breakout sequences',
      () {
        final scriptSource = buildReviewClientScript();

        expect(scriptSource, isNotEmpty);
        expect(scriptSource, isNot(contains('innerHTML')));
        expect(scriptSource, isNot(contains('outerHTML')));
        expect(scriptSource, isNot(contains('insertAdjacentHTML')));
        expect(scriptSource, isNot(contains('document.write')));
        expect(scriptSource, isNot(contains('eval(')));
        expect(scriptSource, isNot(contains('</')));
        expect(scriptSource, isNot(contains('<!--')));
      },
    );

    test('passes node syntax validation when node is installed', () async {
      late final ProcessResult whichNode;
      try {
        whichNode = await Process.run('node', const ['--version']);
      } on ProcessException {
        return;
      }
      if (whichNode.exitCode != 0) {
        return;
      }

      final tempDir = await Directory.systemTemp.createTemp('dash_review_js_');
      try {
        final jsFile = File('${tempDir.path}/review_bundle.js');
        await jsFile.writeAsString(buildReviewClientScript());
        final checkResult = await Process.run('node', ['--check', jsFile.path]);
        expect(
          checkResult.exitCode,
          equals(0),
          reason: 'node --check stderr: ${checkResult.stderr}',
        );

        final harnessFile = File('${tempDir.path}/harness.js');
        await harnessFile.writeAsString(r'''
const assert = require('node:assert');
const { execFileSync } = require('node:child_process');

global.window = {
  location: { hostname: 'flutter-docs--pr14030-9f8e7d.web.app', pathname: '/', origin: 'https://flutter-docs--pr14030-9f8e7d.web.app' },
  localStorage: { getItem: () => null, setItem: () => {}, removeItem: () => {} },
  addEventListener: () => {},
  requestAnimationFrame: (fn) => setTimeout(fn, 0)
};
global.document = {
  readyState: 'loading',
  getElementById: () => null,
  addEventListener: () => {}
};

require(process.argv[2]);
const api = global.window.__dashReviewInternals;
assert.ok(api, '__dashReviewInternals must be registered');

// 1. Firebase Hosting preview hostname PR number parser
assert.strictEqual(api.parsePrFromHostname('flutter-docs--pr14030-9f8e7d.web.app'), '14030');
assert.strictEqual(api.parsePrFromHostname('dash-www--pr-99999-abc.web.app'), '99999');
assert.strictEqual(api.parsePrFromHostname('docs.flutter.dev'), '');

// 2. Shell single-quote escaping against command injection
const hostile = " Fix 'single' quotes; $(echo INJECTED) `id` $HOME \nline2 ";
const quoted = api.shellQuote(hostile);
const echoed = execFileSync('/bin/sh', ['-c', 'printf %s ' + quoted], { encoding: 'utf8' });
assert.strictEqual(echoed, hostile);

// 3. Unified diff RIGHT-side hunk line mapping & Markdown-tolerant matching
const patch = [
  '@@ -10,4 +20,5 @@',
  ' ## Layout constraints {#constraints}',
  '-Old paragraph removed on left.',
  '+Use `StatelessWidget` when **state** never [changes](/ui).',
  '+Constraints go down. Sizes go up.',
  ' Trailing context line.'
].join('\n');

const rightLines = api.parseDiffRightSideLines(patch);
assert.deepStrictEqual(
  rightLines.map((r) => ({ line: r.line, kind: r.kind })),
  [
    { line: 20, kind: 'context' },
    { line: 21, kind: 'add' },
    { line: 22, kind: 'add' },
    { line: 23, kind: 'context' }
  ]
);

// Rendered prose without backticks/bold/links still maps to exact line 21!
const mdMatch = api.matchNeedleInRightLines(
  rightLines,
  'Use StatelessWidget when state never changes.',
  ''
);
assert.strictEqual(mdMatch.line, 21);

// Heading anchor fallback maps #constraints to line 20!
const headingMatch = api.matchNeedleInRightLines(rightLines, '', '#constraints');
assert.strictEqual(headingMatch.line, 20);

// 4. Open-redirect defense on hydrated dash-review-meta pageUrl values
const previewOrigin = 'https://flutter-docs--pr14030-9f8e7d.web.app';
assert.strictEqual(api.sanitizeSameOriginPath('/\\evil.example.com/phish', previewOrigin), null);
assert.strictEqual(api.sanitizeSameOriginPath('//evil.example.com/phish', previewOrigin), null);
assert.strictEqual(api.sanitizeSameOriginPath('https://evil.example.com/phish', previewOrigin), null);
assert.strictEqual(api.sanitizeSameOriginPath('javascript:alert(1)', previewOrigin), null);
assert.strictEqual(api.sanitizeSameOriginPath('', previewOrigin), null);
assert.strictEqual(
  api.sanitizeSameOriginPath('/ui/layout/?tab=web#constraints', previewOrigin),
  '/ui/layout/?tab=web#constraints'
);
''');

        final runResult = await Process.run('node', [
          harnessFile.path,
          jsFile.path,
        ]);
        expect(
          runResult.exitCode,
          equals(0),
          reason: 'JS harness failed: ${runResult.stderr}',
        );
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  });
}
