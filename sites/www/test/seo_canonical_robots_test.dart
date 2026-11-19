// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_website/main.server.options.dart';
import 'package:flutter_website/src/layouts/default_layout.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;
import 'package:site_shared/blog.dart';
import 'package:site_shared/layouts.dart';
import 'package:site_shared/seo.dart';
import 'package:test/test.dart';

final MemoryLoader _memoryLoader = MemoryLoader(pages: const []);
final AssetManager _testAssetManager = AssetManager(
  directory: 'content',
  outputPrefix: 'assets',
);

final RegExp _canonicalTagPattern = RegExp(
  r'<link\b[^>]*\brel="canonical"[^>]*>',
);
final RegExp _hrefAttrPattern = RegExp(r'\bhref="([^"]+)"');
final RegExp _robotsNoindexPattern = RegExp(
  r'<meta\b[^>]*\bname="robots"[^>]*\bcontent="noindex"[^>]*>',
);
final RegExp _ogUrlPattern = RegExp(
  r'<meta\b[^>]*\bproperty="og:url"[^>]*\bcontent="([^"]+)"[^>]*>',
);

final class _TestDashLayout extends DashLayout {
  const _TestDashLayout();

  @override
  String get name => 'test-doc';

  @override
  String get siteHost => 'docs.flutter.dev';

  @override
  String get iconUrl => '/favicon.png';

  @override
  String get iconUrlApple => '/apple-touch-icon.png';

  @override
  String get twitterSiteTag => '@flutterdev';

  @override
  String get twitterDefaultImageUrl => '/social.png';

  @override
  String get tagManagerId => 'GTM-TEST';

  @override
  Component buildBody(Page page, Component child) => div([child]);
}

Page _buildPage({
  required String pagePath,
  required String url,
  required String siteUrl,
  required Map<String, Object?> pageData,
  Map<String, Object?> extraData = const {},
  RouteLoader? loader,
}) => Page(
  path: pagePath,
  url: url,
  content: '',
  initialData: {
    ...extraData,
    'page': pageData,
    'site': {'url': siteUrl, 'title': 'Flutter'},
  },
  config: const PageConfig(),
  loader: loader ?? _memoryLoader,
);

String? _extractCanonical(String html) {
  final tag = _canonicalTagPattern.firstMatch(html)?.group(0);
  if (tag == null) return null;
  return _hrefAttrPattern.firstMatch(tag)?.group(1);
}

String? _extractOgUrl(String html) => _ogUrlPattern.firstMatch(html)?.group(1);

Future<String> _renderDashLayoutPage(Page page) async {
  const layout = _TestDashLayout();
  final response = await renderComponent(
    Page.wrap(page, [page], layout.buildLayout(page, const Component.empty())),
    standalone: true,
  );
  return utf8.decode(response.body);
}

Future<String> _renderDefaultLayoutPage(Page page) async {
  await _testAssetManager.dataLoader.loadData(page);
  final layout = DefaultLayout();
  final response = await renderComponent(
    Page.wrap(page, [page], layout.buildLayout(page, const Component.empty())),
  );
  return utf8.decode(response.body);
}

void main() {
  setUpAll(() {
    if (!Jaspr.isInitialized) {
      Jaspr.initializeApp(options: defaultServerOptions);
    }
  });

  _registerLayoutCanonicalTests();
  _registerSecondaryOutputTests();
  _registerLastModifiedTests();
}

void _registerLayoutCanonicalTests() {
  group('DashLayout canonical and noindex metadata', () {
    test('emits self-referencing canonical by default', () async {
      final html = await _renderDashLayoutPage(
        _buildPage(
          pagePath: 'ui/index.md',
          url: '/ui',
          siteUrl: 'https://docs.flutter.dev',
          pageData: const {'title': 'UI', 'description': 'UI docs.'},
        ),
      );

      expect(_extractCanonical(html), 'https://docs.flutter.dev/ui');
      expect(_extractOgUrl(html), 'https://docs.flutter.dev/ui');
      expect(_robotsNoindexPattern.hasMatch(html), isFalse);
    });

    test(
      'suppresses default canonical when noindex is true or "true"',
      () async {
        for (final flag in <Object>[true, 'true']) {
          final html = await _renderDashLayoutPage(
            _buildPage(
              pagePath: 'search.html',
              url: '/search',
              siteUrl: 'https://docs.flutter.dev',
              pageData: {'title': 'Search', 'noindex': flag},
            ),
          );

          expect(_robotsNoindexPattern.hasMatch(html), isTrue);
          expect(_extractCanonical(html), isNull);
          expect(_extractOgUrl(html), 'https://docs.flutter.dev/search');
        }
      },
    );

    test(
      'resolves relative canonical overrides and honors false suppression',
      () async {
        final overrideHtml = await _renderDashLayoutPage(
          _buildPage(
            pagePath: 'widgets/old.md',
            url: '/widgets/old',
            siteUrl: 'https://docs.flutter.dev',
            pageData: const {
              'title': 'Widgets',
              'canonical': '/ui/widgets',
              'noindex': true,
            },
          ),
        );
        expect(_robotsNoindexPattern.hasMatch(overrideHtml), isTrue);
        expect(
          _extractCanonical(overrideHtml),
          'https://docs.flutter.dev/ui/widgets',
        );

        for (final flag in <Object>[false, 'false']) {
          final suppressedHtml = await _renderDashLayoutPage(
            _buildPage(
              pagePath: 'custom.md',
              url: '/custom',
              siteUrl: 'https://docs.flutter.dev',
              pageData: {'title': 'Custom', 'canonical': flag},
            ),
          );
          expect(_extractCanonical(suppressedHtml), isNull);
        }
      },
    );
  });

  group('DefaultLayout canonical and noindex metadata', () {
    const bannerData = {
      'banner': {'text': 'Flutter release', 'link': '/blog'},
    };

    test('emits self-referencing canonical by default', () async {
      final html = await _renderDefaultLayoutPage(
        _buildPage(
          pagePath: 'ai/index.md',
          url: '/ai',
          siteUrl: 'https://flutter.dev',
          pageData: const {'title': 'AI', 'description': 'Build with AI.'},
          extraData: bannerData,
        ),
      );

      expect(_extractCanonical(html), 'https://flutter.dev/ai');
      expect(_extractOgUrl(html), 'https://flutter.dev/ai');
      expect(_robotsNoindexPattern.hasMatch(html), isFalse);
    });

    test(
      'renders robots noindex and omits canonical on 404 / noindex pages',
      () async {
        for (final flag in <Object>[true, 'true']) {
          final html = await _renderDefaultLayoutPage(
            _buildPage(
              pagePath: '404.html',
              url: '/404.html',
              siteUrl: 'https://flutter.dev',
              pageData: {
                'title': 'Not Found',
                'description': 'Page not found.',
                'noindex': flag,
              },
              extraData: bannerData,
            ),
          );

          expect(_robotsNoindexPattern.hasMatch(html), isTrue);
          expect(_extractCanonical(html), isNull);
          expect(_extractOgUrl(html), 'https://flutter.dev/404.html');
        }
      },
    );

    test(
      'resolves relative canonical overrides and honors canonical: false',
      () async {
        final overrideHtml = await _renderDefaultLayoutPage(
          _buildPage(
            pagePath: 'legacy.md',
            url: '/legacy',
            siteUrl: 'https://flutter.dev',
            pageData: const {
              'title': 'Legacy',
              'description': 'Legacy page.',
              'canonical': '/development/web',
            },
            extraData: bannerData,
          ),
        );
        expect(
          _extractCanonical(overrideHtml),
          'https://flutter.dev/development/web',
        );

        final suppressedHtml = await _renderDefaultLayoutPage(
          _buildPage(
            pagePath: 'embed.md',
            url: '/embed',
            siteUrl: 'https://flutter.dev',
            pageData: const {
              'title': 'Embed',
              'description': 'Embedded view.',
              'canonical': false,
            },
            extraData: bannerData,
          ),
        );
        expect(_extractCanonical(suppressedHtml), isNull);
      },
    );
  });
}

void _registerSecondaryOutputTests() {
  group('RobotsTxtOutput and BlogAtomFeedOutput secondary outputs', () {
    test(
      'emits production Sitemap for site.url and marks sitemap=false',
      () async {
        final page = _buildPage(
          pagePath: 'index.md',
          url: '/',
          siteUrl: 'https://flutter.dev',
          pageData: const {'title': 'Flutter', 'description': 'Home'},
        );
        const output = RobotsTxtOutput(isProductionBuild: true);
        expect(output.pattern.matchAsPrefix('index.md'), isNotNull);
        expect(output.pattern.matchAsPrefix('blog/index.md'), isNull);

        final response = await renderComponent(
          Page.wrap(page, [page], output.build(page)),
          standalone: true,
        );
        expect(response.statusCode, 200);
        final contentType =
            response.headers['Content-Type'] ??
            response.headers['content-type'];
        expect(contentType, contains('text/plain; charset=utf-8'));
        expect(response.headers['jaspr-sitemap-data'], contains('false'));
        expect(
          utf8.decode(response.body),
          'User-agent: *\nDisallow:\n\nSitemap: https://flutter.dev/sitemap.xml\n',
        );
      },
    );

    test(
      'disallows indexing on non-production builds while allowing linkcheck',
      () {
        final page = _buildPage(
          pagePath: 'index.md',
          url: '/',
          siteUrl: 'https://docs.flutter.dev',
          pageData: const {'title': 'Flutter'},
        );
        final body = const RobotsTxtOutput(isProductionBuild: false)
            .renderRobotsTxt(page);
        expect(body, contains('User-agent: linkcheck\nDisallow:'));
        expect(body, contains('User-agent: *\nDisallow: /'));
        expect(body, isNot(contains('Sitemap:')));
      },
    );

    test('throws StateError in production when site.url is missing', () {
      final page = Page(
        path: 'index.md',
        url: '/',
        content: '',
        initialData: const {
          'page': <String, Object?>{},
          'site': <String, Object?>{},
        },
        config: const PageConfig(),
        loader: _memoryLoader,
      );
      expect(
        () =>
            const RobotsTxtOutput(isProductionBuild: true)
                .renderRobotsTxt(page),
        throwsA(isA<StateError>()),
      );
    });

    test('BlogAtomFeedOutput sets jaspr-sitemap-data to false', () async {
      final blogIndex = _buildPage(
        pagePath: 'blog/index.md',
        url: '/blog',
        siteUrl: 'https://flutter.dev',
        pageData: const {'title': 'Flutter Blog', 'description': 'Updates.'},
        extraData: const {
          'blog': {
            'data': {
              'atom': {'feedAuthor': 'Flutter Team'},
              'categories': <Object?>[],
            },
            'authors': <String, Object?>{},
          },
        },
      );
      final response = await renderComponent(
        Page.wrap(blogIndex, [
          blogIndex,
        ], const BlogAtomFeedOutput().build(blogIndex)),
        standalone: true,
      );
      expect(response.statusCode, 200);
      expect(response.headers['jaspr-sitemap-data'], contains('false'));
    });
  });
}

void _registerLastModifiedTests() {
  group('GitLastModifiedIndex and shallow-clone guard', () {
    test('throws StateError on shallow clone when isProductionBuild is true', () {
      expect(
        () => loadProjectLastModifiedDates(
          projectRoot: '/repo/sites/www',
          isProductionBuild: true,
          runGit: (args, {workingDirectory}) => switch (args) {
            ['rev-parse', '--show-toplevel'] => '/repo\n',
            ['rev-parse', '--is-shallow-repository'] => 'true\n',
            _ =>
              'commit-date:2026-10-15T12:00:00Z\nsites/www/content/index.md\n',
          },
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('git fetch --unshallow'),
          ),
        ),
      );
    });

    test('allows shallow clone on non-production builds', () {
      final result = loadProjectLastModifiedDates(
        projectRoot: '/repo/sites/www',
        isProductionBuild: false,
        runGit: (args, {workingDirectory}) => switch (args) {
          ['rev-parse', '--show-toplevel'] => '/repo\n',
          ['rev-parse', '--is-shallow-repository'] => 'true\n',
          _ =>
            'commit-date:2026-10-20T08:30:00Z\n'
                'sites/www/content/ai/index.md\n'
                'commit-date:2026-09-01T00:00:00Z\n'
                'sites/www/content/ai/index.md\n',
        },
      );

      expect(
        result.dates['content/ai/index.md'],
        DateTime.utc(2026, 10, 20, 8, 30),
      );
    });

    test(
      'populates sitemap lastmod and forces sitemap: false on noindex pages',
      () {
        final tempDir = Directory.systemTemp.createTempSync(
          'seo_lastmod_test_',
        );
        addTearDown(() => tempDir.deleteSync(recursive: true));
        final siteDir = Directory(path.join(tempDir.path, 'sites', 'www'))
          ..createSync(recursive: true);
        final fsLoader = FilesystemLoader(path.join(siteDir.path, 'content'));

        final index = GitLastModifiedIndex(
          repositoryRoot: path.canonicalize(tempDir.path),
          projectRoot: path.canonicalize(siteDir.path),
          lastModifiedPerPath: {
            'content/ai/index.md': DateTime.utc(2026, 11, 2, 15, 0),
            'content/search.html': DateTime.utc(2026, 11, 5, 10, 0),
          },
        );

        final aiPage = _buildPage(
          pagePath: 'ai/index.md',
          url: '/ai',
          siteUrl: 'https://flutter.dev',
          pageData: const {'title': 'AI'},
          loader: fsLoader,
        );
        index.applyToPage(aiPage);
        expect(aiPage.data.page['date'], '2026-11-02');
        expect(aiPage.data.page['sitemap'], {'lastmod': '2026-11-02'});

        final noIndexPage = _buildPage(
          pagePath: 'search.html',
          url: '/search',
          siteUrl: 'https://docs.flutter.dev',
          pageData: const {'title': 'Search', 'noindex': true},
          loader: fsLoader,
        );
        index.applyToPage(noIndexPage);
        expect(noIndexPage.data.page['sitemap'], isFalse);
      },
    );
  });
}
