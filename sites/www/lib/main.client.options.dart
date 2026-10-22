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
import 'package:flutter_website/src/components/sections/why_flutter_ai_era_section.dart'
    deferred as _why_flutter_ai_era_section;
import 'package:flutter_website/src/components/sections/why_flutter_cases_section.dart'
    deferred as _why_flutter_cases_section;
import 'package:flutter_website/src/components/sections/why_flutter_code_shared_section.dart'
    deferred as _why_flutter_code_shared_section;
import 'package:flutter_website/src/components/sections/why_flutter_features_section.dart'
    deferred as _why_flutter_features_section;
import 'package:flutter_website/src/components/sections/why_flutter_hero_section.dart'
    deferred as _why_flutter_hero_section;
import 'package:flutter_website/src/models/content/banner_content.dart'
    as _banner_content;
import 'package:site_shared/components/blog/client/blog_categories.dart'
    deferred as _blog_categories;
import 'package:site_shared/components/blog/client/share_button.dart'
    deferred as _share_button;
import 'package:site_shared/components/common/client/back_to_top_button.dart'
    deferred as _back_to_top_button;
import 'package:site_shared/components/common/client/collapse_button.dart'
    deferred as _collapse_button;
import 'package:site_shared/components/common/client/copy_button.dart'
    deferred as _copy_button;
import 'package:site_shared/components/dartpad/dartpad_injector.dart'
    deferred as _dartpad_injector;

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
        p
            .get<List<Object?>>('items')
            .cast<String>()
            .map((i) => p.mount(i))
            .toList(),
        prevBtn: p.mountOrNull(p.get<String?>('prevBtn')),
        nextBtn: p.mountOrNull(p.get<String?>('nextBtn')),
      ),
      loader: _carousel.loadLibrary,
    ),
    'newsletter_form': ClientLoader(
      (p) => _newsletter_form.NewsletterForm(),
      loader: _newsletter_form.loadLibrary,
    ),
    'tabs': ClientLoader(
      (p) => _tabs.Tabs(
        title: p.mountOrNull(p.get<String?>('title')),
        header: p.mountOrNull(p.get<String?>('header')),
        labels: p.get<List<Object?>>('labels').cast<String>(),
        tabs: p
            .get<List<Object?>>('tabs')
            .cast<String>()
            .map((i) => p.mount(i))
            .toList(),
        noSpy: p.get<bool>('noSpy'),
      ),
      loader: _tabs.loadLibrary,
    ),
    'header': ClientLoader(
      (p) => _header.Header(
        contrastLogoSrc: p.get<String>('contrastLogoSrc'),
        defaultLogoSrc: p.get<String>('defaultLogoSrc'),
        banner: _banner_content.BannerContent.fromJson(
          p.get<Map<String, Object?>>('banner'),
        ),
        pageUrl: p.get<String>('pageUrl'),
      ),
      loader: _header.loadLibrary,
    ),
    'consultants_cookie_snack': ClientLoader(
      (p) => _consultants_cookie_snack.ConsultantsCookieSnack(),
      loader: _consultants_cookie_snack.loadLibrary,
    ),
    'consultants_grid': ClientLoader(
      (p) => _consultants_grid.ConsultantsGrid(
        data: p.get<List<Object?>>('data').cast<Map<String, Object?>>(),
        items: p
            .get<List<Object?>>('items')
            .cast<String>()
            .map((i) => p.mount(i))
            .toList(),
      ),
      loader: _consultants_grid.loadLibrary,
    ),
    'events_grid': ClientLoader(
      (p) => _events_grid.EventsGrid(
        data: p.get<List<Object?>>('data').cast<Map<String, Object?>>(),
        items: p
            .get<List<Object?>>('items')
            .cast<String>()
            .map((i) => p.mount(i))
            .toList(),
        past: p.get<bool>('past'),
      ),
      loader: _events_grid.loadLibrary,
    ),
    'games_adaptive_media': ClientLoader(
      (p) => _games_adaptive_media.GamesAdaptiveMedia(
        mobileAssets: p
            .get<Map<String, Object?>>('mobileAssets')
            .cast<String, String>(),
        desktopAssets: p
            .get<Map<String, Object?>>('desktopAssets')
            .cast<String, String>(),
      ),
      loader: _games_adaptive_media.loadLibrary,
    ),
    'showcase_grid': ClientLoader(
      (p) => _showcase_grid.ShowcaseGrid(
        data: p.get<List<Object?>>('data').cast<Map<String, Object?>>(),
        items: p
            .get<List<Object?>>('items')
            .cast<String>()
            .map((i) => p.mount(i))
            .toList(),
      ),
      loader: _showcase_grid.loadLibrary,
    ),
    'why_flutter_ai_era_section': ClientLoader(
      (p) => _why_flutter_ai_era_section.WhyFlutterAiEraSection(
        geminiSprite: p.get<String>('geminiSprite'),
      ),
      loader: _why_flutter_ai_era_section.loadLibrary,
    ),
    'why_flutter_cases_section': ClientLoader(
      (p) => _why_flutter_cases_section.WhyFlutterCasesSection(
        media: p.get<Map<String, Object?>>('media').cast<String, String>(),
      ),
      loader: _why_flutter_cases_section.loadLibrary,
    ),
    'why_flutter_code_shared_section': ClientLoader(
      (p) => _why_flutter_code_shared_section.WhyFlutterCodeSharedSection(
        laptopSprite: p.get<String>('laptopSprite'),
      ),
      loader: _why_flutter_code_shared_section.loadLibrary,
    ),
    'why_flutter_features_section': ClientLoader(
      (p) => _why_flutter_features_section.WhyFlutterFeaturesSection(),
      loader: _why_flutter_features_section.loadLibrary,
    ),
    'why_flutter_hero_section': ClientLoader(
      (p) => _why_flutter_hero_section.WhyFlutterHeroSection(
        typingSprite: p.get<String>('typingSprite'),
        screens: p.get<List<Object?>>('screens').cast<String>(),
        whitepaperUrl: p.get<String>('whitepaperUrl'),
        flutterLogo: p.get<String>('flutterLogo'),
      ),
      loader: _why_flutter_hero_section.loadLibrary,
    ),
    'site_shared:blog_categories': ClientLoader(
      (p) => _blog_categories.BlogCategories(
        categories: p
            .get<List<Object?>>('categories')
            .cast<Map<String, Object?>>()
            .map((i) => _blog_categories.BlogCategory.fromMap(i))
            .toList(),
      ),
      loader: _blog_categories.loadLibrary,
    ),
    'site_shared:share_button': ClientLoader(
      (p) => _share_button.ShareButton(
        url: p.get<String>('url'),
        title: p.get<String>('title'),
      ),
      loader: _share_button.loadLibrary,
    ),
    'site_shared:back_to_top_button': ClientLoader(
      (p) => _back_to_top_button.BackToTopButton(),
      loader: _back_to_top_button.loadLibrary,
    ),
    'site_shared:collapse_button': ClientLoader(
      (p) => _collapse_button.CollapseButton(
        classes: p.get<List<Object?>>('classes').cast<String>(),
        title: p.get<String?>('title'),
      ),
      loader: _collapse_button.loadLibrary,
    ),
    'site_shared:copy_button': ClientLoader(
      (p) => _copy_button.CopyButton(
        buttonText: p.get<String?>('buttonText'),
        toCopy: p.get<String?>('toCopy'),
        classes: p.get<List<Object?>>('classes').cast<String>(),
        title: p.get<String?>('title'),
      ),
      loader: _copy_button.loadLibrary,
    ),
    'site_shared:dartpad_injector': ClientLoader(
      (p) => _dartpad_injector.DartPadInjector(
        title: p.get<String>('title'),
        theme: p.get<String?>('theme'),
        height: p.get<String?>('height'),
        runAutomatically: p.get<bool>('runAutomatically'),
      ),
      loader: _dartpad_injector.loadLibrary,
    ),
  },
);
