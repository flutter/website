// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/sections/cta_section.dart';
import '../components/sections/hero_section.dart';
import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class GoogleIntegrationsPage extends StatelessComponent {
  const GoogleIntegrationsPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      HeroSection(
        title: 'Build with the best of Google',
        text:
            'Seamless integrations to help you tap into the power of Google\'s services for building, launching, growing, and monetizing your Flutter apps across platforms',
        media: img(
          src: context.asset('images/google-integrations-dash.png'),
          alt: 'Google Integrations Dash',
        ),
      ),
      section(classes: 'module', attributes: scroll.spyContent, [
        div(classes: 'features container', [
          div(classes: 'feature reverse nospy', [
            const div(classes: 'text', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [.text('Google AI')]),
                  h3([.text('Build generative AI-based features')]),
                ],
              ),
              p([
                .text(
                  'Integrate features like advanced text generation, summarization, chat, and more to your Dart or Flutter apps with minimal setup, and deploy across multiple platforms',
                ),
              ]),
              div([
                a(classes: 'btn', href: '/ai', [.text('Learn more')]),
              ]),
            ]),
            div(classes: 'media', [
              img(src: context.asset('images/gemini.png'), alt: 'Gemini AI'),
            ]),
          ]),
          div(classes: 'feature nospy', [
            const div(classes: 'text', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [.text('Firebase')]),
                  h3([.text('Implement backend services')]),
                ],
              ),
              p([
                .text(
                  'Supercharge your Flutter app development with Firebase services, including databases, authentication, storage, and more. '
                  'Eliminate complex backend coding and let Firebase handle the heavy lifting.',
                ),
              ]),
              div([
                a(
                  classes: 'btn',
                  href: 'https://docs.flutter.dev/data-and-backend/firebase',
                  [.text('Learn more')],
                ),
              ]),
            ]),
            div(classes: 'media', [
              img(src: context.asset('images/firebase.png'), alt: 'Firebase'),
            ]),
          ]),
          div(classes: 'feature reverse nospy', [
            const div(classes: 'text', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [.text('Google Ads')]),
                  h3([.text('Monetize with Google Ads & AdMob')]),
                ],
              ),
              p([
                .text(
                  'Build your business with integrated ad formats that suit your app experience and help you maximize the earning potential of your Flutter app.',
                ),
              ]),
              div([
                a(
                  classes: 'btn',
                  href: 'https://docs.flutter.dev/resources/ads-overview',
                  [.text('Learn more')],
                ),
              ]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/google-ads-mob.png'),
                alt: 'Google Ads and Mob',
              ),
            ]),
          ]),
          div(classes: 'feature nospy', [
            const div(classes: 'text', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [.text('Google Play')]),
                  h3([.text('Diversify your app\'s revenue')]),
                ],
              ),
              p([
                .text(
                  'A single integration to monetize everything from premium features and digital goods to subscriptions.',
                ),
              ]),
              div([
                a(
                  classes: 'btn',
                  href:
                      'https://docs.flutter.dev/resources/in-app-purchases-overview',
                  [.text('Learn more')],
                ),
              ]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/google-play.png'),
                alt: 'Google Play',
              ),
            ]),
          ]),
          div(classes: 'feature reverse nospy', [
            const div(classes: 'text', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [
                    .text('Google Pay and Google Wallet'),
                  ]),
                  h3([.text('Enable smooth, secure payments')]),
                ],
              ),
              p([
                .text(
                  'Offer your users a seamless, secure payment experience that boosts conversion rates with Google Pay and Google Wallet.',
                ),
              ]),
              div([
                a(
                  classes: 'btn',
                  href: 'https://docs.flutter.dev/resources/payments-overview',
                  [.text('Learn more')],
                ),
              ]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/google-pay-wallet.png'),
                alt: 'Google Pay and Google Wallet',
              ),
            ]),
          ]),
          div(classes: 'feature nospy', [
            const div(classes: 'text', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [.text('Google Maps')]),
                  h3([.text('Add Maps functionality')]),
                ],
              ),
              p([
                .text(
                  'Embed Google Maps directly into your Flutter apps to enable location-based services, interactive maps, and rich geo-spatial features that elevate your app\'s functionality.',
                ),
              ]),
              div([
                a(
                  classes: 'btn',
                  href:
                      'https://developers.google.com/maps/flutter-package/overview',
                  [.text('Learn more')],
                ),
              ]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/google-maps.png'),
                alt: 'Google Maps',
              ),
            ]),
          ]),
        ]),
        const CTASection(),
      ]),
    ]);
  }
}
