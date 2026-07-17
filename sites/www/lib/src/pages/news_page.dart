// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class NewsPage extends StatelessComponent {
  const NewsPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      section(classes: 'hero', [
        div(classes: 'container', [
          div(classes: 'mantle', [
            const div(classes: 'text', [
              h1([.text('Flutter'), br(), .text('News Toolkit')]),
              h2([
                .text(
                  'Build a beautiful news mobile application in up to 80% less time',
                ),
              ]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/news-hero.png'),
                alt: 'Flutter News Toolkit',
              ),
            ]),
          ]),
        ]),
      ]),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        section(id: 'flutter-news-toolkit', [
          div(classes: 'features container', [
            div(classes: 'feature nospy toolkit', [
              const div(classes: 'text', [
                Component.element(tag: 'hgroup', children: []),
                p([
                  .text('VGV, Flutter, and the '),
                  a(
                    href: 'https://newsinitiative.withgoogle.com/',
                    target: Target.blank,
                    [.text('Google News Initiative')],
                  ),
                  .text(
                    ' have co-sponsored the development of a news application template, to help news publishers build mobile applications easily and quickly.',
                  ),
                  br(),
                  br(),
                  .text(
                    'The Flutter News Toolkit reduces mobile app development time by up to 80% with pre-built modules for critical features like user onboarding, content feeds and pages, analytics, notifications, social sharing, subscriptions, and ads.',
                  ),
                ]),
                a(
                  classes: 'btn',
                  target: Target.blank,
                  href: 'https://vgventures.github.io/news_toolkit/',
                  [.text('Learn more')],
                ),
              ]),
              div(classes: 'media', [
                img(
                  src: context.asset('images/flutter-news-toolkit-section.png'),
                  alt: 'Flutter News Toolkit',
                ),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}
