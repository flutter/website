// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';

import 'main.server.options.dart';
import 'src/components/common/image.dart';
import 'src/layouts/consultants_tos_layout.dart';
import 'src/layouts/default_layout.dart';
import 'src/layouts/showcase_story_layout.dart';
import 'src/pages/ai_page.dart';
import 'src/pages/brand_page.dart';
import 'src/pages/community_page.dart';
import 'src/pages/consultants_page.dart';
import 'src/pages/culture_page.dart';
import 'src/pages/desktop_page.dart';
import 'src/pages/development_page.dart';
import 'src/pages/ecosystem_page.dart';
import 'src/pages/embedded_page.dart';
import 'src/pages/events_page.dart';
import 'src/pages/flip_page.dart';
import 'src/pages/games_page.dart';
import 'src/pages/google_integrations_page.dart';
import 'src/pages/home_page.dart';
import 'src/pages/ios_page.dart';
import 'src/pages/mobile_page.dart';
import 'src/pages/monetization_page.dart';
import 'src/pages/news_page.dart';
import 'src/pages/not_found_page.dart';
import 'src/pages/showcase_page.dart';
import 'src/pages/web_page.dart';
import 'src/utils/asset_utils.dart';
import 'src/utils/component_ref.dart';

void main() async {
  Jaspr.initializeApp(options: defaultServerOptions);

  final assetManager = AssetManager(
    directory: 'content',
    outputPrefix: 'assets',
    assetTransformers: [
      TrackingAssetTransformer(),
      ResizingAssetTransformer(),
      const HashingAssetTransformer(),
    ],
  );

  ServerApp.addMiddleware(assetManager.middleware);

  runApp(
    ComponentRefScope(
      child: ContentApp.custom(
        loaders: [
          FilesystemLoader('content', filterExtensions: {'.md'}),
          MemoryLoader(
            pages: [
              MemoryPage.builder(
                path: '404.html',
                keepSuffix: true,
                builder: (context) => const NotFoundPage(),
                initialData: {
                  'page': {
                    'title': 'Not Found',
                    'slug': '404',
                    'bodyTags': 'interior notfound',
                    'description': 'Page not found.',
                  },
                },
              ),
            ],
          ),
        ],
        eagerlyLoadAllPages: true,
        configResolver: PageConfig.all(
          dataLoaders: [
            FilesystemDataLoader('content'),
            assetManager.dataLoader,
          ],
          parsers: [const MarkdownParser()],
          extensions: [ShowcaseStoryExtension(), assetManager.pageExtension],
          components: [
            CustomComponent(
              pattern: 'HomePage',
              builder: (_, _, _) => const HomePage(),
            ),
            CustomComponent(
              pattern: 'DevelopmentPage',
              builder: (_, _, _) => const DevelopmentPage(),
            ),
            CustomComponent(
              pattern: 'MobilePage',
              builder: (_, _, _) => const MobilePage(),
            ),
            CustomComponent(
              pattern: 'IosPage',
              builder: (_, _, _) => const IosPage(),
            ),
            CustomComponent(
              pattern: 'WebPage',
              builder: (_, _, _) => const WebPage(),
            ),
            CustomComponent(
              pattern: 'DesktopPage',
              builder: (_, _, _) => const DesktopPage(),
            ),
            CustomComponent(
              pattern: 'EmbeddedPage',
              builder: (_, _, _) => const EmbeddedPage(),
            ),
            CustomComponent(
              pattern: 'AiPage',
              builder: (_, _, _) => const AiPage(),
            ),
            CustomComponent(
              pattern: 'GoogleIntegrationsPage',
              builder: (_, _, _) => const GoogleIntegrationsPage(),
            ),
            CustomComponent(
              pattern: 'MonetizationPage',
              builder: (_, _, _) => const MonetizationPage(),
            ),
            CustomComponent(
              pattern: 'GamesPage',
              builder: (_, _, _) => const GamesPage(),
            ),
            CustomComponent(
              pattern: 'EcosystemPage',
              builder: (_, _, _) => const EcosystemPage(),
            ),
            CustomComponent(
              pattern: 'CommunityPage',
              builder: (_, _, _) => const CommunityPage(),
            ),
            CustomComponent(
              pattern: 'EventsPage',
              builder: (_, _, _) => const EventsPage(),
            ),
            CustomComponent(
              pattern: 'CulturePage',
              builder: (_, _, _) => const CulturePage(),
            ),
            CustomComponent(
              pattern: 'ConsultantsPage',
              builder: (_, _, _) => const ConsultantsPage(),
            ),
            CustomComponent(
              pattern: 'ShowcasePage',
              builder: (_, _, _) => const ShowcasePage(),
            ),
            CustomComponent(
              pattern: 'BrandPage',
              builder: (_, _, _) => const BrandPage(),
            ),
            CustomComponent(
              pattern: 'FlipPage',
              builder: (_, _, _) => const FlipPage(),
            ),
            CustomComponent(
              pattern: 'NewsPage',
              builder: (_, _, _) => const NewsPage(),
            ),
            CustomComponent(
              pattern: 'Image',
              builder: (_, attrs, _) => Image.fromAttrs(attrs),
            ),
          ],
          layouts: [
            DefaultLayout(),
            ConsultantsTosLayout(),
            ShowcaseStoryLayout(),
          ],
          theme: const ContentTheme.none(),
        ),
      ),
    ),
  );
}
