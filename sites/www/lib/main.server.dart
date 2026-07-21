// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';
import 'package:site_shared/components/utils/define_component.dart';

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
    ContentApp.custom(
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
          defineComponent('HomePage', const HomePage()),
          defineComponent('DevelopmentPage', const DevelopmentPage()),
          defineComponent('MobilePage', const MobilePage()),
          defineComponent('IosPage', const IosPage()),
          defineComponent('WebPage', const WebPage()),
          defineComponent('DesktopPage', const DesktopPage()),
          defineComponent('EmbeddedPage', const EmbeddedPage()),
          defineComponent('AiPage', const AiPage()),
          defineComponent(
            'GoogleIntegrationsPage',
            const GoogleIntegrationsPage(),
          ),
          defineComponent('MonetizationPage', const MonetizationPage()),
          defineComponent('GamesPage', const GamesPage()),
          defineComponent('EcosystemPage', const EcosystemPage()),
          defineComponent('CommunityPage', const CommunityPage()),
          defineComponent('EventsPage', const EventsPage()),
          defineComponent('CulturePage', const CulturePage()),
          defineComponent('ConsultantsPage', const ConsultantsPage()),
          defineComponent('ShowcasePage', const ShowcasePage()),
          defineComponent('BrandPage', const BrandPage()),
          defineComponent('FlipPage', const FlipPage()),
          defineComponent('NewsPage', const NewsPage()),
          defineComponentWithAttrs('Image', Image.fromAttrs),
        ],
        layouts: [
          DefaultLayout(),
          ConsultantsTosLayout(),
          ShowcaseStoryLayout(),
        ],
        theme: const ContentTheme.none(),
      ),
    ),
  );
}
