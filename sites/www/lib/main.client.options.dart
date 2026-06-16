// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:flutter_website/src/components/common/carousel.dart'
    deferred as _carousel;
import 'package:flutter_website/src/components/common/newsletter_form.dart'
    deferred as _newsletter_form;
import 'package:flutter_website/src/components/common/tabs.dart'
    deferred as _tabs;
import 'package:flutter_website/src/components/layout/header.dart'
    deferred as _header;
import 'package:flutter_website/src/components/pages/consultants_cookie_snack.dart'
    deferred as _consultants_cookie_snack;
import 'package:flutter_website/src/components/pages/consultants_grid.dart'
    deferred as _consultants_grid;
import 'package:flutter_website/src/components/pages/events_grid.dart'
    deferred as _events_grid;
import 'package:flutter_website/src/components/pages/games_adaptive_media.dart'
    deferred as _games_adaptive_media;
import 'package:flutter_website/src/components/pages/showcase_grid.dart'
    deferred as _showcase_grid;
import 'package:flutter_website/src/models/content/banner_content.dart'
    as _banner_content;
import 'package:site_shared/components/utils/component_ref.dart'
    as _component_ref;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'carousel': ClientLoader(
      (p) => _carousel.Carousel(
        _component_ref.ComponentRef.fromId(p['items'] as String),
        prevBtn: p['prevBtn'] != null
            ? _component_ref.ComponentRef.fromId(p['prevBtn'] as String)
            : null,
        nextBtn: p['nextBtn'] != null
            ? _component_ref.ComponentRef.fromId(p['nextBtn'] as String)
            : null,
      ),
      loader: _carousel.loadLibrary,
    ),
    'newsletter_form': ClientLoader(
      (p) => _newsletter_form.NewsletterForm(),
      loader: _newsletter_form.loadLibrary,
    ),
    'tabs': ClientLoader(
      (p) => _tabs.Tabs(
        title: p['title'] != null
            ? _component_ref.ComponentRef.fromId(p['title'] as String)
            : null,
        header: p['header'] != null
            ? _component_ref.ComponentRef.fromId(p['header'] as String)
            : null,
        tabs: (p['tabs'] as List<Object?>)
            .map((i) => _tabs.Tab.fromMap(i as Map<String, Object?>))
            .toList(),
        noSpy: p['noSpy'] as bool,
      ),
      loader: _tabs.loadLibrary,
    ),
    'header': ClientLoader(
      (p) => _header.Header(
        contrastLogoSrc: p['contrastLogoSrc'] as String,
        defaultLogoSrc: p['defaultLogoSrc'] as String,
        banner: _banner_content.BannerContent.fromJson(
          p['banner'] as Map<String, Object?>,
        ),
        pageUrl: p['pageUrl'] as String,
      ),
      loader: _header.loadLibrary,
    ),
    'consultants_cookie_snack': ClientLoader(
      (p) => _consultants_cookie_snack.ConsultantsCookieSnack(),
      loader: _consultants_cookie_snack.loadLibrary,
    ),
    'consultants_grid': ClientLoader(
      (p) => _consultants_grid.ConsultantsGrid(
        data: (p['data'] as List<Object?>)
            .map((i) => (i as Map<String, Object?>))
            .toList(),
        items: (p['items'] as List<Object?>)
            .map((i) => _component_ref.ComponentRef.fromId(i as String))
            .toList(),
      ),
      loader: _consultants_grid.loadLibrary,
    ),
    'events_grid': ClientLoader(
      (p) => _events_grid.EventsGrid(
        data: (p['data'] as List<Object?>)
            .map((i) => (i as Map<String, Object?>))
            .toList(),
        items: (p['items'] as List<Object?>)
            .map((i) => _component_ref.ComponentRef.fromId(i as String))
            .toList(),
      ),
      loader: _events_grid.loadLibrary,
    ),
    'games_adaptive_media': ClientLoader(
      (p) => _games_adaptive_media.GamesAdaptiveMedia(
        mobileAssets: (p['mobileAssets'] as Map<String, Object?>)
            .cast<String, String>(),
        desktopAssets: (p['desktopAssets'] as Map<String, Object?>)
            .cast<String, String>(),
      ),
      loader: _games_adaptive_media.loadLibrary,
    ),
    'showcase_grid': ClientLoader(
      (p) => _showcase_grid.ShowcaseGrid(
        data: (p['data'] as List<Object?>)
            .map((i) => (i as Map<String, Object?>))
            .toList(),
        items: (p['items'] as List<Object?>)
            .map((i) => _component_ref.ComponentRef.fromId(i as String))
            .toList(),
      ),
      loader: _showcase_grid.loadLibrary,
    ),
  },
);
