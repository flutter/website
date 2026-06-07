// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/sections/cta_section.dart';
import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class BrandPage extends StatelessComponent {
  const BrandPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      const section(classes: 'hero', [
        div(classes: 'container', [
          div(classes: 'mantle full', [
            div(classes: 'text', [
              h4(classes: 'eyebrow', [.text('Brand Guidelines')]),
              h1([.text('Representing the Flutter brand')]),
              div(classes: 'stacked-centered', [
                a(classes: 'btn white', href: '/flutter-brand-assets.zip', [
                  .text('Download all assets'),
                ]),
                a(
                  classes: 'btn quiet',
                  href: 'https://docs.flutter.dev/brand',
                  target: Target.blank,
                  [
                    .text('''
                Flutter Trademark Guidelines
              '''),
                  ],
                ),
              ]),
            ]),
          ]),
        ]),
      ]),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        section(id: 'logo', [
          div(classes: 'container features', [
            div(classes: 'stacked-feature brand-feature', [
              const Component.element(
                tag: 'hgroup',
                children: [
                  h2([.text('Flutter logo')]),
                  p([
                    .text(
                      '''Do not use the Flutter mark or any variant of the Flutter mark in 
                  conjunction with the overall name of your application, product, service, 
                  or website. Do not alter or use the Flutter mark in a way that may be 
                  confusing or misleading, and never use Flutter branding as the most 
                  prominent element on your page.
                ''',
                    ),
                  ]),
                ],
              ),
              div(classes: 'feature nospy', [
                const div(classes: 'text', [
                  div([
                    h3([.text('Standard lockup')]),
                    p([
                      .text(
                        '''The standard lockup can be used in slide decks and blog posts. It 
                      should never be used in-product or in a way that implies that 
                      Flutter is endorsing or has built the product.
                    ''',
                      ),
                    ]),
                  ]),
                ]),
                div(classes: 'media', [
                  div(classes: 'downloadable-image-harness', [
                    div(classes: 'downloadable-image', [
                      img(
                        src: context.asset(
                          'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal.svg',
                        ),
                        alt: 'Standard horizontal lockup',
                      ),
                    ]),
                    div(classes: 'downloadable-options', [
                      a(
                        href: context.asset(
                          'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal.svg',
                        ),
                        download: '',
                        const [.text('SVG')],
                      ),
                      a(
                        href: context.asset(
                          'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal.png',
                        ),
                        download: '',
                        const [.text('PNG')],
                      ),
                    ]),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        section(id: 'logo-color-variations', [
          div(classes: 'container variations', [
            const Component.element(
              tag: 'hgroup',
              children: [
                h3([.text('Color variations')]),
              ],
            ),
            div(classes: 'variation-grid', [
              div([
                const h4([.text('Light')]),
                const p([
                  .text(
                    'For lighter backgrounds with overlapping shapes or varied patterns.',
                  ),
                ]),
                div(classes: 'downloadable-image-harness', [
                  div(classes: 'downloadable-image', [
                    img(
                      src: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal.svg',
                      ),
                      alt: 'Standard horizontal lockup',
                    ),
                  ]),
                  div(classes: 'downloadable-options', [
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal.svg',
                      ),
                      download: '',
                      const [.text('SVG')],
                    ),
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal.png',
                      ),
                      download: '',
                      const [.text('PNG')],
                    ),
                  ]),
                ]),
              ]),
              div([
                const h4([.text('Dark')]),
                const p([
                  .text(
                    '''For darker background with overlapping shapes or varied patterns when 
                  transparency is not available.
                ''',
                  ),
                ]),
                div(classes: 'downloadable-image-harness', [
                  div(classes: 'downloadable-image', [
                    img(
                      src: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_wht.svg',
                      ),
                      alt: 'Flutter white horizontal lockup',
                    ),
                  ]),
                  div(classes: 'downloadable-options', [
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_wht.svg',
                      ),
                      download: '',
                      const [.text('SVG')],
                    ),
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_wht.png',
                      ),
                      download: '',
                      const [.text('PNG')],
                    ),
                  ]),
                ]),
              ]),
              div([
                const h4([.text('Transparency')]),
                const p([
                  .text(
                    'For darker background backgrounds with overlapping shapes or varied patterns.',
                  ),
                ]),
                div(classes: 'downloadable-image-harness', [
                  div(classes: 'downloadable-image', [
                    img(
                      src: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_wht_shaded.svg',
                      ),
                      alt: 'Flutter horizontal transparent lockup',
                    ),
                  ]),
                  div(classes: 'downloadable-options', [
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_wht_shaded.svg',
                      ),
                      download: '',
                      const [.text('SVG')],
                    ),
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_wht_shaded.png',
                      ),
                      download: '',
                      const [.text('PNG')],
                    ),
                  ]),
                ]),
              ]),
              div([
                const h4([.text('Knockout')]),
                const p([
                  .text('For solid darker backgrounds with high contrasts'),
                ]),
                div(classes: 'downloadable-image-harness', [
                  div(classes: 'downloadable-image', [
                    img(
                      src: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_solid.svg',
                      ),
                      alt: 'Flutter knockout lockup',
                    ),
                  ]),
                  div(classes: 'downloadable-options', [
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_solid.svg',
                      ),
                      download: '',
                      const [.text('SVG')],
                    ),
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_solid.png',
                      ),
                      download: '',
                      const [.text('PNG')],
                    ),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        section(id: 'logo-variations', [
          div(classes: 'container variations', [
            const Component.element(
              tag: 'hgroup',
              children: [
                h3([.text('Logo variations')]),
              ],
            ),
            div(classes: 'variation-grid', [
              div([
                const h4([.text('Vertical lockup')]),
                const p([
                  .text(
                    'When there is limited horizontal space, a vertical lockup can be used',
                  ),
                ]),
                div(classes: 'downloadable-image-harness', [
                  div(classes: 'downloadable-image', [
                    img(
                      src: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_vertical/lockup_flutter_vertical.svg',
                      ),
                      alt: 'Flutter vertical lockup',
                    ),
                  ]),
                  div(classes: 'downloadable-options', [
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_vertical/lockup_flutter_vertical.svg',
                      ),
                      download: '',
                      const [.text('SVG')],
                    ),
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_flutter_vertical/lockup_flutter_vertical.png',
                      ),
                      download: '',
                      const [.text('PNG')],
                    ),
                  ]),
                ]),
              ]),
              div([
                const h4([.text('Logomark')]),
                const p([
                  .text(
                    '''When there is limited vertical and horizontal space, the logomark can be used by 
                  itself without the logotype.
                ''',
                  ),
                ]),
                div(classes: 'downloadable-image-harness', [
                  div(classes: 'downloadable-image', [
                    img(
                      src: context.asset(
                        'assets/flutter-brand-assets/icon_flutter/icon_flutter.svg',
                      ),
                      alt: 'Flutter logomark',
                    ),
                  ]),
                  div(classes: 'downloadable-options', [
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/icon_flutter/icon_flutter.svg',
                      ),
                      download: '',
                      const [.text('SVG')],
                    ),
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/icon_flutter/icon_flutter.png',
                      ),
                      download: '',
                      const [.text('PNG')],
                    ),
                  ]),
                ]),
              ]),
              div([
                const h4([.text('Build with Flutter')]),
                const p([
                  .text(
                    '''When referring in the context of another app. This includes in blog posts, press 
                  interviews, and in the app itself.
                ''',
                  ),
                ]),
                div(classes: 'downloadable-image-harness', [
                  div(classes: 'downloadable-image', [
                    img(
                      src: context.asset(
                        'assets/flutter-brand-assets/lockup_built-w-flutter/lockup_built-w-flutter.svg',
                      ),
                      alt: 'Flutter build with horizontal lockup',
                    ),
                  ]),
                  div(classes: 'downloadable-options', [
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_built-w-flutter/lockup_built-w-flutter.svg',
                      ),
                      download: '',
                      const [.text('SVG')],
                    ),
                    a(
                      href: context.asset(
                        'assets/flutter-brand-assets/lockup_built-w-flutter/lockup_built-w-flutter.png',
                      ),
                      download: '',
                      const [.text('PNG')],
                    ),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        section(id: 'logo-sizing-spacing', classes: 'subsection', [
          div(classes: 'container', [
            const Component.element(
              tag: 'hgroup',
              children: [
                h3([.text('Sizing & Spacing')]),
                p([
                  .text(
                    '''To ensure legibility, the Flutter lockup and icon should sit within 
                an open space. A minimum margin of space equivalent to the height 
                of a single 'F' should always be maintained around the lockup or icon. 
                A greater margin of space should be proved when possible. The logo 
                should never be overlapped or crowded by text or artwork. Additionally 
                the logo should not be linked to other logos or labels. Only approved 
                brand lockups should be used.
              ''',
                  ),
                ]),
              ],
            ),
            div(classes: 'compare-cols', [
              div([
                img(
                  src: context.asset('assets/sizing-spacing-1.png'),
                  alt: 'Sizing and Spacing 1',
                ),
              ]),
              div([
                img(
                  src: context.asset('assets/sizing-spacing-2.png'),
                  alt: 'Sizing and Spacing 2',
                ),
              ]),
            ]),
          ]),
        ]),
        section(id: 'logo-alignment', classes: 'subsection', [
          div(classes: 'container', [
            const Component.element(
              tag: 'hgroup',
              children: [
                h3([.text('Alignment')]),
                p([
                  .text(
                    '''The Flutter icon appears off balance when center aligned. When center 
                aligning the icon, use the upper and lower left corners as reference 
                points to provide optical balance.
              ''',
                  ),
                ]),
              ],
            ),
            div(classes: 'compare-cols', [
              div([
                div(classes: 'image-harness', [
                  img(
                    src: context.asset('assets/alignment-good.png'),
                    alt: 'Good logo alignment',
                  ),
                ]),
                const h4(classes: 'compare-label good', [
                  span([.text('Do:')]),
                  .text(
                    ''' Optically center align the Flutter icon using the upper and lower corners as reference points
                ''',
                  ),
                ]),
              ]),
              div([
                div(classes: 'image-harness', [
                  img(
                    src: context.asset('assets/alignment-bad.png'),
                    alt: 'Bad logo alignment',
                  ),
                ]),
                const h4(classes: 'compare-label bad', [
                  span([.text('Don\'t:')]),
                  .text(''' Geometrically center align the Flutter icon
                '''),
                ]),
              ]),
            ]),
          ]),
        ]),
        section(id: 'logo-contrast', classes: 'subsection', [
          div(classes: 'container', [
            const Component.element(
              tag: 'hgroup',
              children: [
                h3([.text('Contrast')]),
                p([
                  .text(
                    '''When using the knockout version of the logo, always ensure foreground and background 
                colors pass ''',
                  ),
                  a(href: 'https://webaim.org/resources/contrastchecker', [
                    .text('WCAG AA accessibility'),
                  ]),
                  .text(''' 
                standards. WCAG 2.0 level AA requires a contrast ratio of at least 4.5:1 for normal 
                text and 3:1 for large text. WCAG 2.1 requires a contrast ratio of at least 3:1 for 
                graphics and user interface components.
              '''),
                ]),
              ],
            ),
            div(classes: 'compare-cols', [
              div([
                div(classes: 'image-harness', [
                  img(
                    src: context.asset(
                      'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_solid.svg',
                    ),
                    alt: 'Good accessibility',
                  ),
                ]),
                const h4(classes: 'compare-label good', [
                  span([.text('Do:')]),
                  .text(''' Contrast ratio - 5.29:1, meets WCAG AA standards
                '''),
                ]),
              ]),
              div([
                div(classes: 'image-harness', [
                  img(
                    src: context.asset(
                      'assets/flutter-brand-assets/lockup_flutter_horizontal/lockup_flutter_horizontal_solid.svg',
                    ),
                    alt: 'Bad accessibility',
                  ),
                ]),
                const h4(classes: 'compare-label bad', [
                  span([.text('Don\'t:')]),
                  .text(
                    ''' Contrast ratio - 2.23:1, does not meet WCAG AA standards
                ''',
                  ),
                ]),
              ]),
            ]),
          ]),
        ]),
        section(id: 'logo-ligatures', classes: 'subsection', [
          div(classes: 'container', [
            const Component.element(
              tag: 'hgroup',
              children: [
                h3([.text('Ligatures')]),
                p([
                  .text(
                    '''Turn standard ligatures off when rendering the name 'Flutter' in a 
                headline format. The two 't' characters should remain distinct. 
              ''',
                  ),
                ]),
              ],
            ),
            div(classes: 'compare-cols', [
              div([
                div(classes: 'image-harness', [
                  img(
                    src: context.asset('assets/ligatures-good.png'),
                    alt: 'Good logo alignment',
                  ),
                ]),
                const h4(classes: 'compare-label good', [
                  span([.text('Do:')]),
                  .text(''' Standard ligatures off
                '''),
                ]),
              ]),
              div([
                div(classes: 'image-harness', [
                  img(
                    src: context.asset('assets/ligatures-bad.png'),
                    alt: 'Bad logo alignment',
                  ),
                ]),
                const h4(classes: 'compare-label bad', [
                  span([.text('Don\'t:')]),
                  .text(''' Standard ligatures on
                '''),
                ]),
              ]),
            ]),
          ]),
        ]),
        const section(id: 'color', classes: 'subsection', [
          div(classes: 'container', [
            Component.element(
              tag: 'hgroup',
              children: [
                h2([.text('Colors')]),
              ],
            ),
            div(classes: 'colors-row colors-primary', [
              div(classes: 'colors-grid col-3', [
                div(classes: 'color', [
                  div(classes: 'color-chip', []),
                  div(classes: 'color-desc', [
                    h4([.text('Flutter Navy')]),
                    h5([.text('#042B59')]),
                  ]),
                ]),
                div(classes: 'color', [
                  div(classes: 'color-chip', []),
                  div(classes: 'color-desc', [
                    h4([.text('Flutter Blue')]),
                    h5([.text('#0553B1')]),
                  ]),
                ]),
                div(classes: 'color', [
                  div(classes: 'color-chip', []),
                  div(classes: 'color-desc', [
                    h4([.text('Flutter Sky')]),
                    h5([.text('#027DFD')]),
                  ]),
                ]),
              ]),
              div(classes: 'colors-desc', [
                h3([.text('Primary colors')]),
                p([
                  .text(
                    'The logo consists of one primary blue and two accent blue colors.',
                  ),
                ]),
              ]),
            ]),
            div(classes: 'colors-row colors-secondary', [
              div(classes: 'colors-grid col-4', [
                div(classes: 'color', [
                  div(classes: 'color-chip', []),
                  div(classes: 'color-desc', [
                    h4([.text('Red')]),
                    h5([.text('#F25D50')]),
                  ]),
                ]),
                div(classes: 'color', [
                  div(classes: 'color-chip', []),
                  div(classes: 'color-desc', [
                    h4([.text('Yellow')]),
                    h5([.text('#FFF275')]),
                  ]),
                ]),
                div(classes: 'color', [
                  div(classes: 'color-chip', []),
                  div(classes: 'color-desc', [
                    h4([.text('Purple')]),
                    h5([.text('#6200EE')]),
                  ]),
                ]),
                div(classes: 'color', [
                  div(classes: 'color-chip', []),
                  div(classes: 'color-desc', [
                    h4([.text('Green')]),
                    h5([.text('#1CDAC5')]),
                  ]),
                ]),
              ]),
              div(classes: 'colors-desc', [
                h3([.text('Secondary colors')]),
                p([
                  .text(
                    'Flutter also has an extended palette used for background colors and other visualizations.',
                  ),
                ]),
              ]),
            ]),
          ]),
        ]),
        section(id: 'dash', [
          div(classes: 'features container', [
            div(classes: 'feature nospy', [
              div(classes: 'text', [
                const Component.element(
                  tag: 'hgroup',
                  children: [
                    h3([.text('Dash')]),
                  ],
                ),
                const p([
                  .text(
                    'Dash is the mascot for the Dart language and the Flutter framework.',
                  ),
                ]),
                a(
                  classes: 'btn',
                  href: context.asset('assets/dashatar-dash.png'),
                  download: '',
                  const [.text('Download Dash')],
                ),
              ]),
              div(classes: 'media', [
                div(classes: 'downloadable-image-harness', [
                  div(classes: 'downloadable-image', [
                    img(
                      src: context.asset('assets/shadow-dash.png'),
                      alt: 'Dashatar Dash',
                    ),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        const CTASection(),
      ]),
    ]);
  }
}
