// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/sections/cta_section.dart';
import '../components/sections/why_us_ai_era_section.dart';
import '../components/sections/why_us_cases_section.dart';
import '../components/sections/why_us_code_shared_section.dart';
import '../components/sections/why_us_features_section.dart';
import '../components/sections/why_us_hero_section.dart';
import '../components/sections/why_us_resources_section.dart';
import '../utils/asset_utils.dart';

/// The "Why us" page, making the business case for adopting Flutter.
///
/// The site's `DefaultLayout` supplies the header and footer, and the closing
/// call to action reuses the shared [CTASection].
///
/// Asset URLs are resolved here and handed to the sections that hydrate on the
/// client. Those sections must not resolve assets themselves: the asset
/// helpers import `dart:io`, which would pull the server-only SDK into the
/// client bundle and stop it compiling.
class WhyUsPage extends StatelessComponent {
  const WhyUsPage({super.key});

  /// Number of app screenshots cycling in the hero.
  static const _heroScreenCount = 12;

  @override
  Component build(BuildContext context) {
    String image(String name) => context.asset('/why-us/images/$name');

    return main_(classes: 'why-us', [
      WhyUsHeroSection(
        typingSprite: image('dash-typing-sprite.webp'),
        screens: [
          for (var index = 1; index <= _heroScreenCount; index++)
            image('hero-screens/s${index.toString().padLeft(2, '0')}.webp'),
        ],
        whitepaperUrl: context.asset('/why-us/flutter-whitepaper-2026.pdf'),
      ),
      WhyUsCodeSharedSection(
        laptopSprite: image('dash-laptop-sprite-v2.webp'),
      ),
      const WhyUsFeaturesSection(),
      WhyUsAiEraSection(geminiSprite: image('dash-gemini-sprite.webp')),
      WhyUsCasesSection(
        media: {
          'headspace': image('headspace-app.png'),
          'universal': image('universal-app.png'),
          'phoneFrame': image('phone-frame.png'),
          'earth': image('google-earth-desktop.png'),
          'lg': image('lg-tv.png'),
        },
      ),
      const WhyUsResourcesSection(),
      const CTASection(),
    ]);
  }
}
