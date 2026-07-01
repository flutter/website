// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:flutter_website/src/components/common/carousel.dart'
    as _carousel;
import 'package:flutter_website/src/components/common/newsletter_form.dart'
    as _newsletter_form;
import 'package:flutter_website/src/components/common/tabs.dart' as _tabs;
import 'package:flutter_website/src/components/layout/header.dart' as _header;
import 'package:flutter_website/src/components/pages/consultants_cookie_snack.dart'
    as _consultants_cookie_snack;
import 'package:flutter_website/src/components/pages/consultants_grid.dart'
    as _consultants_grid;
import 'package:flutter_website/src/components/pages/events_grid.dart'
    as _events_grid;
import 'package:flutter_website/src/components/pages/games_adaptive_media.dart'
    as _games_adaptive_media;
import 'package:flutter_website/src/components/pages/showcase_grid.dart'
    as _showcase_grid;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _carousel.Carousel: ClientTarget<_carousel.Carousel>(
      'carousel',
      params: __carouselCarousel,
    ),
    _newsletter_form.NewsletterForm:
        ClientTarget<_newsletter_form.NewsletterForm>('newsletter_form'),
    _tabs.Tabs: ClientTarget<_tabs.Tabs>('tabs', params: __tabsTabs),
    _header.Header: ClientTarget<_header.Header>(
      'header',
      params: __headerHeader,
    ),
    _consultants_cookie_snack.ConsultantsCookieSnack:
        ClientTarget<_consultants_cookie_snack.ConsultantsCookieSnack>(
          'consultants_cookie_snack',
        ),
    _consultants_grid.ConsultantsGrid:
        ClientTarget<_consultants_grid.ConsultantsGrid>(
          'consultants_grid',
          params: __consultants_gridConsultantsGrid,
        ),
    _events_grid.EventsGrid: ClientTarget<_events_grid.EventsGrid>(
      'events_grid',
      params: __events_gridEventsGrid,
    ),
    _games_adaptive_media.GamesAdaptiveMedia:
        ClientTarget<_games_adaptive_media.GamesAdaptiveMedia>(
          'games_adaptive_media',
          params: __games_adaptive_mediaGamesAdaptiveMedia,
        ),
    _showcase_grid.ShowcaseGrid: ClientTarget<_showcase_grid.ShowcaseGrid>(
      'showcase_grid',
      params: __showcase_gridShowcaseGrid,
    ),
  },
  styles: () => [],
);

Map<String, Object?> __carouselCarousel(_carousel.Carousel c) => {
  'items': c.items.toId(),
  'prevBtn': c.prevBtn?.toId(),
  'nextBtn': c.nextBtn?.toId(),
};
Map<String, Object?> __tabsTabs(_tabs.Tabs c) => {
  'title': c.title?.toId(),
  'header': c.header?.toId(),
  'tabs': c.tabs.map((i) => i.toMap()).toList(),
  'noSpy': c.noSpy,
};
Map<String, Object?> __headerHeader(_header.Header c) => {
  'contrastLogoSrc': c.contrastLogoSrc,
  'defaultLogoSrc': c.defaultLogoSrc,
  'banner': c.banner.toMap(),
  'pageUrl': c.pageUrl,
};
Map<String, Object?> __consultants_gridConsultantsGrid(
  _consultants_grid.ConsultantsGrid c,
) => {'data': c.data, 'items': c.items.map((i) => i.toId()).toList()};
Map<String, Object?> __events_gridEventsGrid(_events_grid.EventsGrid c) => {
  'data': c.data,
  'items': c.items.map((i) => i.toId()).toList(),
};
Map<String, Object?> __games_adaptive_mediaGamesAdaptiveMedia(
  _games_adaptive_media.GamesAdaptiveMedia c,
) => {'mobileAssets': c.mobileAssets, 'desktopAssets': c.desktopAssets};
Map<String, Object?> __showcase_gridShowcaseGrid(
  _showcase_grid.ShowcaseGrid c,
) => {'data': c.data, 'items': c.items.map((i) => i.toId()).toList()};
