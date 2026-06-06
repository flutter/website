// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../utils/asset_utils.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer(classes: 'site-footer', [
      div(classes: 'content footer-main', [
        div(classes: 'logo', [
          a(href: '/', [
            img(
              src: context.asset('/images/flutter-logo.svg'),
              width: 154,
              alt: 'Flutter',
            ),
          ]),
        ]),
        const div(classes: 'footer-links', [
          ul([
            li([.text('About Flutter')]),
            li([
              a(href: 'https://docs.flutter.dev/jobs', target: Target.blank, [
                .text('Careers'),
              ]),
            ]),
            li([
              a(href: 'https://blog.flutter.dev', target: Target.blank, [
                .text('News'),
              ]),
            ]),
            li([
              a(href: '/brand', [.text('Brand')]),
            ]),
            li([
              a(href: '/culture', [.text('Culture')]),
            ]),
          ]),
          ul([
            li([.text('Learn Flutter')]),
            li([
              a(href: 'https://docs.flutter.dev/learn', target: Target.blank, [
                .text('Learning journey'),
              ]),
            ]),
            li([
              a(
                href: 'https://docs.flutter.dev/codelabs',
                target: Target.blank,
                [.text('Codelabs')],
              ),
            ]),
            li([
              a(
                href: 'https://github.com/flutter/samples',
                target: Target.blank,
                [.text(' Samples ')],
              ),
            ]),
            li([
              a(
                href: 'https://docs.flutter.dev/cookbook',
                target: Target.blank,
                [.text('Cookbook')],
              ),
            ]),
          ]),
          ul([
            li([.text('Development')]),
            li([
              a(href: '/development/mobile', [.text('Mobile')]),
            ]),
            li([
              a(href: '/development/web', [.text('Web')]),
            ]),
            li([
              a(href: '/development/desktop', [.text('Desktop')]),
            ]),
            li([
              a(href: '/development/embedded', [.text('Embedded')]),
            ]),
            li([
              a(href: '/development/ios', [.text('iOS')]),
            ]),
          ]),
        ]),
      ]),
      const div(classes: 'content footer-social', [
        div([
          _SocialLink(
            href: 'https://www.youtube.com/flutterdev',
            label: 'Flutter\'s YouTube',
            pathData:
                'M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z',
          ),
          _SocialLink(
            href: 'https://twitter.com/flutterdev',
            label: 'Flutter\'s X (Twitter)',
            pathData:
                'M14.234 10.162 22.977 0h-2.072l-7.591 8.824L7.251 0H.258l9.168 13.343L.258 24H2.33l8.016-9.318L16.749 24h6.993zm-2.837 3.299-.929-1.329L3.076 1.56h3.182l5.965 8.532.929 1.329 7.754 11.09h-3.182z',
          ),
          _SocialLink(
            href: 'https://github.com/flutter',
            label: 'Flutter GitHub',
            pathData:
                'M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12',
          ),
          _SocialLink(
            href: 'https://blog.flutter.dev',
            label: 'Flutter Blog',
            pathData:
                'M4.21 0A4.201 4.201 0 0 0 0 4.21v15.58A4.201 4.201 0 0 0 4.21 24h15.58A4.201 4.201 0 0 0 24 19.79v-1.093c-.137.013-.278.02-.422.02-2.577 0-4.027-2.146-4.09-4.832a7.592 7.592 0 0 1 .022-.708c.093-1.186.475-2.241 1.105-3.022a3.885 3.885 0 0 1 1.395-1.1c.468-.237 1.127-.367 1.664-.367h.023c.101 0 .202.004.303.01V4.211A4.201 4.201 0 0 0 19.79 0Zm.198 5.583h4.165l3.588 8.435 3.59-8.435h3.864v.146l-.019.004c-.705.16-1.063.397-1.063 1.254h-.003l.003 10.274c.06.676.424.885 1.063 1.03l.02.004v.145h-4.923v-.145l.019-.005c.639-.144.994-.353 1.054-1.03V7.267l-4.745 11.15h-.261L6.15 7.569v9.445c0 .857.358 1.094 1.063 1.253l.02.004v.147H4.405v-.147l.019-.004c.705-.16 1.065-.397 1.065-1.253V6.987c0-.857-.358-1.094-1.064-1.254l-.018-.004zm19.25 3.668c-1.086.023-1.733 1.323-1.813 3.124H24V9.298a1.378 1.378 0 0 0-.342-.047Zm-1.862 3.632c-.1 1.756.86 3.239 2.204 3.634v-3.634z',
          ),
          _SocialLink(
            href: 'https://www.meetup.com/pro/flutter/',
            label: 'Flutter Meetup Network',
            pathData:
                'M6.98.555a.518.518 0 0 0-.105.011.53.53 0 1 0 .222 1.04.533.533 0 0 0 .409-.633.531.531 0 0 0-.526-.418zm6.455.638a.984.984 0 0 0-.514.143.99.99 0 1 0 1.02 1.699.99.99 0 0 0 .34-1.36.992.992 0 0 0-.846-.482zm-3.03 2.236a5.029 5.029 0 0 0-4.668 3.248 3.33 3.33 0 0 0-1.46.551 3.374 3.374 0 0 0-.94 4.562 3.634 3.634 0 0 0-.605 4.649 3.603 3.603 0 0 0 2.465 1.597c.018.732.238 1.466.686 2.114a3.9 3.9 0 0 0 5.423.992c.068-.047.12-.106.184-.157.987.881 2.47 1.026 3.607.24a2.91 2.91 0 0 0 1.162-1.69 4.238 4.238 0 0 0 2.584-.739 4.274 4.274 0 0 0 1.19-5.789 2.466 2.466 0 0 0 .433-3.308 2.448 2.448 0 0 0-1.316-.934 4.436 4.436 0 0 0-.776-2.873 4.467 4.467 0 0 0-5.195-1.656 5.106 5.106 0 0 0-2.773-.807zm-5.603.817a.759.759 0 0 0-.423.135.758.758 0 1 0 .863 1.248.757.757 0 0 0 .193-1.055.758.758 0 0 0-.633-.328zm15.994 2.37a.842.842 0 0 0-.47.151.845.845 0 1 0 1.175.215.845.845 0 0 0-.705-.365zm-8.15 1.028c.063 0 .124.005.182.014a.901.901 0 0 1 .45.187c.169.134.273.241.432.393.24.227.414.089.534.02.208-.122.369-.219.984-.208.633.011 1.363.237 1.514 1.317.168 1.199-1.966 4.289-1.817 5.722.106 1.01 1.815.299 1.96 1.22.186 1.198-2.136.753-2.667.493-.832-.408-1.337-1.34-1.12-2.26.16-.688 1.7-3.498 1.757-3.93.059-.44-.177-.476-.324-.484-.19-.01-.34.081-.526.362-.169.255-2.082 4.085-2.248 4.398-.296.56-.67.694-1.044.674-.548-.029-.798-.32-.72-.848.047-.31 1.26-3.049 1.323-3.476.039-.265-.013-.546-.275-.68-.263-.135-.572.07-.664.227-.128.215-1.848 4.706-2.032 5.038-.316.576-.65.76-1.152.784-1.186.056-2.065-.92-1.678-2.116.173-.532 1.316-4.571 1.895-5.599.389-.69 1.468-1.216 2.217-.892.387.167.925.437 1.084.507.366.163.759-.277.913-.412.155-.134.302-.276.49-.357.142-.06.343-.095.532-.094zm10.88 2.057a.468.468 0 0 0-.093.011.467.467 0 0 0-.36.555.47.47 0 0 0 .557.36.47.47 0 0 0 .36-.557.47.47 0 0 0-.464-.37zm-22.518.81a.997.997 0 0 0-.832.434 1 1 0 1 0 1.39-.258 1 1 0 0 0-.558-.176zm21.294 2.094a.635.635 0 0 0-.127.013.627.627 0 0 0-.48.746.628.628 0 0 0 .746.483.628.628 0 0 0 .482-.746.63.63 0 0 0-.621-.496zm-18.24 6.097a.453.453 0 0 0-.092.012.464.464 0 1 0 .195.908.464.464 0 0 0 .356-.553.465.465 0 0 0-.459-.367zm13.675 1.55a1.044 1.044 0 0 0-.583.187 1.047 1.047 0 1 0 1.456.265 1.044 1.044 0 0 0-.873-.451zM11.4 22.154a.643.643 0 0 0-.36.115.646.646 0 0 0-.164.899.646.646 0 0 0 .899.164.646.646 0 0 0 .164-.898.646.646 0 0 0-.54-.28z',
          ),
          _SocialLink(
            href: 'https://www.linkedin.com/showcase/flutterdevofficial/',
            label: 'Flutter\'s LinkedIn',
            pathData:
                'M 0,1.719 C 0,0.7695 0.789,0 1.7625,0 h 20.475 C 23.211,0 24,0.7695 24,1.719 V 22.281 C 24,23.2305 23.211,24 22.2375,24 H 1.7625 C 0.789,24 0,23.2305 0,22.281 Z M 7.4145,20.091 V 9.2535001 H 3.813 V 20.091 Z M 5.6145,7.7730001 C 6.8700001,7.7730001 7.6515001,6.942 7.6515001,5.901 7.6290001,4.8375 6.8715,4.0290001 5.6385001,4.0290001 4.4055,4.0290001 3.6,4.839 3.6,5.901 3.6,6.942 4.3815,7.7730001 5.5905,7.7730001 Z M 12.976499,20.091 v -6.0525 c 0,-0.324 0.024,-0.647999 0.120001,-0.879 0.2595,-0.6465 0.852,-1.317 1.848001,-1.317 1.303499,0 1.823999,0.993 1.823999,2.451 V 20.091 H 20.37 v -6.216 c 0,-3.33 -1.776001,-4.878 -4.146,-4.878 -1.911,0 -2.7675,1.05 -3.247501,1.7895 v 0.0375 h -0.024 l 0.024,-0.0375 V 9.2535001 H 9.3765001 c 0.045001,1.0169999 0,10.8374999 0,10.8374999 z',
          ),
          _SocialLink(
            href: 'https://bsky.app/profile/flutter.dev',
            label: 'Flutter\'s Bluesky',
            pathData:
                'M5.202 2.857C7.954 4.922 10.913 9.11 12 11.358c1.087-2.247 4.046-6.436 6.798-8.501C20.783 1.366 24 .213 24 3.883c0 .732-.42 6.156-.667 7.037-.856 3.061-3.978 3.842-6.755 3.37 4.854.826 6.089 3.562 3.422 6.299-5.065 5.196-7.28-1.304-7.847-2.97-.104-.305-.152-.448-.153-.327 0-.121-.05.022-.153.327-.568 1.666-2.782 8.166-7.847 2.97-2.667-2.737-1.432-5.473 3.422-6.3-2.777.473-5.899-.308-6.755-3.369C.42 10.04 0 4.615 0 3.883c0-3.67 3.217-2.517 5.202-1.026',
          ),
        ]),
      ]),
      const div(classes: 'content footer-tray', [
        div([
          .text('Except as otherwise noted, this site is licensed under a '),
          a(href: 'https://creativecommons.org/licenses/by/4.0/', [
            .text('Creative Commons Attribution 4.0 International License,'),
          ]),
          .text(' and code samples are licensed under the '),
          a(href: 'https://opensource.org/licenses/BSD-3-Clause', [
            .text('3-Clause BSD License.'),
          ]),
        ]),
        div([
          ul([
            li([
              a(href: 'https://docs.flutter.dev/tos', [.text('Terms')]),
            ]),
            li([
              a(
                href: 'https://policies.google.com/privacy?hl=en',
                target: Target.blank,
                [.text('Privacy')],
              ),
            ]),
            li([
              a(href: 'https://docs.flutter.dev/security', [.text('Security')]),
            ]),
          ]),
          a(
            classes: 'jaspr-badge-link',
            href: 'https://jaspr.site',
            target: Target.blank,
            attributes: {
              'rel': 'noopener',
              'title':
                  'This site is built with the Jaspr web framework for Dart.',
            },
            [
              span([JasprBadge.light()]),
              span([JasprBadge.lightTwoTone()]),
            ],
          ),
        ]),
      ]),
    ]);
  }
}

class _SocialLink extends StatelessComponent {
  const _SocialLink({
    required this.href,
    required this.label,
    required this.pathData,
  });

  final String href;
  final String label;
  final String pathData;

  @override
  Component build(BuildContext context) {
    return a(
      href: href,
      target: Target.blank,
      attributes: {'aria-label': label},
      [
        svg(
          classes: 'footer-social-icon',
          attributes: const {
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'xmlns': 'http://www.w3.org/2000/svg',
            'aria-hidden': 'true',
          },
          [
            path(
              d: pathData,
              attributes: const {'fill': 'currentColor'},
              const [],
            ),
          ],
        ),
      ],
    );
  }
}
