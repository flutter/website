// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../../models/video.dart';
import 'carousel.dart';

class VideoCarousel extends StatelessComponent {
  const VideoCarousel({required this.videos, super.key});

  final List<Video> videos;

  @override
  Component build(BuildContext context) => Carousel(
    ref(.fragment([for (final video in videos) _VideoCard(video)])),
  );
}

class _VideoCard extends StatelessComponent {
  const _VideoCard(this.video);

  final Video video;

  @override
  Component build(BuildContext context) {
    return div(classes: 'story-item video-item', [
      div(classes: 'media', [
        a(
          href: video.watchUrl,
          target: Target.blank,
          [img(src: video.thumbnailUrl, alt: video.title)],
        ),
        span(classes: 'play-btn', [
          a(
            href: video.watchUrl,
            target: Target.blank,
            const [_playButtonSvg],
          ),
        ]),
      ]),
      div(classes: 'text', [
        h3([.text(video.title)]),
        p([.text(video.description)]),
      ]),
    ]);
  }
}

const Component _playButtonSvg = svg(
  viewBox: '0 0 74 74',
  attributes: {
    'width': '74',
    'height': '74',
    'fill': 'none',
    'xmlns': 'http://www.w3.org/2000/svg',
  },
  [
    circle(cx: '37', cy: '37', r: '37', attributes: {'fill': '#027DFD'}, []),
    .element(
      tag: 'g',
      attributes: {'filter': 'url(#filter0_d)'},
      children: [
        path(
          d: 'M53 37.2608L29.9544 52.1089L29.9544 22.4127L53 37.2608Z',
          attributes: {'fill': 'white'},
          [],
        ),
      ],
    ),
    .element(
      tag: 'defs',
      children: [
        .element(
          tag: 'filter',
          attributes: {
            'id': 'filter0_d',
            'x': '19.9531',
            'y': '14.4128',
            'width': '39.0469',
            'height': '45.696',
            'color-interpolation-filters': 'sRGB',
            'filterUnits': 'userSpaceOnUse',
          },
          children: [
            .element(
              tag: 'feFlood',
              attributes: {
                'flood-opacity': '0',
                'result': 'BackgroundImageFix',
              },
            ),
            Component.element(
              tag: 'feColorMatrix',
              attributes: {
                'in': 'SourceAlpha',
                'type': 'matrix',
                'values': '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0',
                'result': 'hardAlpha',
              },
            ),
            .element(tag: 'feOffset', attributes: {'dx': '-2'}),
            .element(
              tag: 'feGaussianBlur',
              attributes: {'stdDeviation': '4'},
            ),
            .element(
              tag: 'feComposite',
              attributes: {'in2': 'hardAlpha', 'operator': 'out'},
            ),
            .element(
              tag: 'feColorMatrix',
              attributes: {
                'type': 'matrix',
                'values': '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.15 0',
              },
            ),
            .element(
              tag: 'feBlend',
              attributes: {
                'mode': 'normal',
                'in2': 'BackgroundImageFix',
                'result': 'effect1_dropShadow',
              },
            ),
            .element(
              tag: 'feBlend',
              attributes: {
                'mode': 'normal',
                'in': 'SourceGraphic',
                'in2': 'effect1_dropShadow',
                'result': 'shape',
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
