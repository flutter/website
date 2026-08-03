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
import 'package:jaspr_content/components/file_tree.dart' as _file_tree;
import 'package:site_shared/components/blog/client/blog_categories.dart'
    as _blog_categories;
import 'package:site_shared/components/blog/client/share_button.dart'
    as _share_button;
import 'package:site_shared/components/common/client/collapse_button.dart'
    as _collapse_button;
import 'package:site_shared/components/common/client/copy_button.dart'
    as _copy_button;
import 'package:site_shared/components/dartpad/dartpad_injector.dart'
    as _dartpad_injector;

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
    _blog_categories.BlogCategories:
        ClientTarget<_blog_categories.BlogCategories>(
          'site_shared:blog_categories',
          params: __blog_categoriesBlogCategories,
        ),
    _share_button.ShareButton: ClientTarget<_share_button.ShareButton>(
      'site_shared:share_button',
      params: __share_buttonShareButton,
    ),
    _collapse_button.CollapseButton:
        ClientTarget<_collapse_button.CollapseButton>(
          'site_shared:collapse_button',
          params: __collapse_buttonCollapseButton,
        ),
    _copy_button.CopyButton: ClientTarget<_copy_button.CopyButton>(
      'site_shared:copy_button',
      params: __copy_buttonCopyButton,
    ),
    _dartpad_injector.DartPadInjector:
        ClientTarget<_dartpad_injector.DartPadInjector>(
          'site_shared:dartpad_injector',
          params: __dartpad_injectorDartPadInjector,
        ),
  },
  styles: () => [..._file_tree.FileTree.styles],
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
Map<String, Object?> __blog_categoriesBlogCategories(
  _blog_categories.BlogCategories c,
) => {'categories': c.categories.map((i) => i.toMap()).toList()};
Map<String, Object?> __share_buttonShareButton(_share_button.ShareButton c) => {
  'url': c.url,
  'title': c.title,
};
Map<String, Object?> __collapse_buttonCollapseButton(
  _collapse_button.CollapseButton c,
) => {'classes': c.classes, 'title': c.title};
Map<String, Object?> __copy_buttonCopyButton(_copy_button.CopyButton c) => {
  'buttonText': c.buttonText,
  'toCopy': c.toCopy,
  'classes': c.classes,
  'title': c.title,
};
Map<String, Object?> __dartpad_injectorDartPadInjector(
  _dartpad_injector.DartPadInjector c,
) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
