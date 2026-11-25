// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:convert';

import 'package:flutter_website/main.server.options.dart';
import 'package:flutter_website/src/layouts/default_layout.dart';
import 'package:html/parser.dart' as html;
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;
import 'package:site_shared/layouts.dart';
import 'package:site_shared/seo.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() => Jaspr.initializeApp(options: defaultServerOptions));

  for (final (name, layout) in [
    ('DashLayout', const _TestDashLayout()),
    ('DefaultLayout', DefaultLayout()),
  ]) {
    group('$name head', () {
      const pageUrl = '$_siteUrl/guide';
      final assets = AssetManager(directory: 'content', outputPrefix: 'assets');

      Future<void> expectHead(
        Map<String, Object?> metadata, {
        String? canonical,
        bool noIndex = false,
      }) async {
        final page = _page(
          url: '/guide',
          metadata: metadata,
          // The banner is required by the DefaultLayout header.
          extraData: const {
            'banner': {'text': 'Flutter release', 'link': '/blog'},
          },
        );
        await assets.dataLoader.loadData(page);
        final response = await renderComponent(
          Page.wrap(
            page,
            [page],
            layout.buildLayout(page, const Component.empty()),
          ),
          standalone: layout is DashLayout,
        );
        final head = html.parse(utf8.decode(response.body)).head!;

        expect(
          head
              .querySelectorAll('link[rel="canonical"]')
              .map((link) => link.attributes['href']),
          [?canonical],
        );
        expect(
          head.querySelector('meta[name="robots"]')?.attributes['content'],
          noIndex ? 'noindex' : isNull,
        );
        expect(
          head.querySelector('meta[property="og:url"]')?.attributes['content'],
          canonical ?? pageUrl,
        );
      }

      test('defaults the canonical to the page URL', () async {
        await expectHead(const {}, canonical: pageUrl);
      });

      test('omits the default canonical on noindex pages', () async {
        for (final flag in const <Object>[true, 'true']) {
          await expectHead({'noindex': flag}, noIndex: true);
        }
      });

      test('resolves an explicit canonical, even on noindex pages', () async {
        await expectHead(
          const {'noindex': true, 'canonical': '/preferred'},
          canonical: '$_siteUrl/preferred',
          noIndex: true,
        );
      });

      test('omits a disabled canonical', () async {
        for (final flag in const <Object>[false, 'false']) {
          await expectHead({'canonical': flag});
        }
      });
    });
  }

  group('robots.txt', () {
    final page = _page();

    test('allows crawling and links the sitemap in production', () {
      expect(
        const RobotsTxtOutput(isProductionBuild: true).renderRobotsTxt(page),
        'User-agent: *\nDisallow:\n\nSitemap: $_siteUrl/sitemap.xml\n',
      );
    });

    test('allows only linkcheck on staging', () {
      expect(
        const RobotsTxtOutput(isProductionBuild: false).renderRobotsTxt(page),
        'User-agent: linkcheck\nDisallow:\n\nUser-agent: *\nDisallow: /\n',
      );
    });
  });

  group('Git modification dates', () {
    final repoRoot = path.absolute('repo');
    final siteRoot = path.join(repoRoot, 'sites', 'www');

    GitLastModifiedIndex shallowIndex({
      required bool production,
    }) => GitLastModifiedIndex.forCurrentProject(
      projectRoot: siteRoot,
      isProductionBuild: production,
      runGit: (args, {workingDirectory}) => switch (args) {
        ['rev-parse', '--show-toplevel'] => repoRoot,
        ['rev-parse', '--is-shallow-repository'] => 'true',
        ['log', ...] =>
          'commit-date:2026-10-20T08:30:00Z\nsites/www/content/index.md\n'
              'commit-date:2026-09-01T00:00:00Z\nsites/www/content/index.md\n',
        _ => throw UnsupportedError('Unexpected git command: $args'),
      },
    );

    test('requires full history for production builds', () {
      expect(() => shallowIndex(production: true), throwsStateError);
    });

    test('applies the latest commit in a shallow development checkout', () {
      final page = _page(
        loader: FilesystemLoader(path.join(siteRoot, 'content')),
      );
      shallowIndex(production: false).applyToPage(page);

      final data = page.data.page;
      expect(data['inputPath'], 'sites/www/content/index.md');
      expect(data['dateModified'], DateTime.utc(2026, 10, 20, 8, 30));
      expect(data['date'], '2026-10-20');
      expect(data['sitemap'], {'lastmod': '2026-10-20'});
    });

    test('applies the latest commit within a directory source', () {
      final index = GitLastModifiedIndex(
        repositoryRoot: repoRoot,
        projectRoot: siteRoot,
        lastModifiedPerPath: {
          'content/blog/index.md': DateTime.utc(2026, 1, 5),
          'content/blog/new-post/index.md': DateTime.utc(2026, 11, 18),
          'content/blog.md': DateTime.utc(2026, 12, 1),
        },
      );
      final page = _page(
        pagePath: 'blog/index.md',
        url: '/blog',
        metadata: const {
          'dateModifiedSources': ['content/blog/'],
        },
        loader: FilesystemLoader(path.join(siteRoot, 'content')),
      );
      index.applyToPage(page);

      expect(page.data.page['sitemap'], {'lastmod': '2026-11-18'});
    });

    test('excludes noindex pages from the sitemap', () {
      final page = _page(
        metadata: const {
          'noindex': true,
          'sitemap': {'priority': 1},
        },
      );
      shallowIndex(production: false).applyToPage(page);
      expect(page.data.page['sitemap'], isFalse);
    });

    test('resolves relative loader paths and preserves case on Windows', () {
      final index = GitLastModifiedIndex(
        repositoryRoot: 'c:/users/dev/website',
        projectRoot: r'C:\Users\Dev\website\sites\docs',
        pathContext: path.Context(
          style: path.Style.windows,
          current: r'C:\Users\Dev\website',
        ),
        lastModifiedPerPath: {
          'src/content/checkbox-fillColor.md': DateTime.utc(2026, 11, 3),
        },
      );
      final page = _page(
        pagePath: 'checkbox-fillColor.md',
        loader: FilesystemLoader(r'src\content'),
      );
      index.applyToPage(page);

      expect(
        page.data.page['inputPath'],
        'sites/docs/src/content/checkbox-fillColor.md',
      );
      expect(page.data.page['sitemap'], {'lastmod': '2026-11-03'});
    });

    test('skips Git history outside a checkout in development', () {
      final result = loadProjectLastModifiedDates(
        projectRoot: siteRoot,
        isProductionBuild: false,
        runGit: (args, {workingDirectory}) {
          expect(args, ['rev-parse', '--show-toplevel']);
          return null;
        },
      );
      expect(result.repositoryRoot, isNull);
      expect(result.dates, isEmpty);
    });
  });
}

const _siteUrl = 'https://flutter.dev';

Page _page({
  String pagePath = 'index.md',
  String url = '/',
  Map<String, Object?> metadata = const {},
  Map<String, Object?> extraData = const {},
  RouteLoader? loader,
}) => Page(
  path: pagePath,
  url: url,
  content: '',
  initialData: {
    ...extraData,
    'site': {'url': _siteUrl},
    'page': {
      'title': 'Test page',
      'description': 'Test description.',
      ...metadata,
    },
  },
  config: const PageConfig(),
  loader: loader ?? MemoryLoader(pages: const []),
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
  Component buildBody(Page page, Component child) => child;
}
