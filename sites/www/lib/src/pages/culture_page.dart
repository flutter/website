// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/sections/cta_section.dart';
import '../components/sections/feature_columns_section.dart';
import '../components/sections/quote_section.dart';
import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class CulturePage extends StatelessComponent {
  const CulturePage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      section(classes: 'hero', [
        div(classes: 'container', [
          div(classes: 'mantle', [
            const div(classes: 'text', [
              h1([.text('Flutter\'s Culture of Inclusivity')]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/flutter-culture-of-inclusivity.png'),
                alt: 'Beautiful Apps',
              ),
            ]),
          ]),
          const h2([.text('Building an inclusive community')]),
          const p([
            .text(
              'At our core as a project is the idea that everyone is welcome:',
            ),
            br(),
            .text('whether you’re a beginner or a seasoned expert; '),
            br(),
            .text('no matter what you’re trying to build;'),
            br(),
            .text('whoever you are.'),
          ]),
          const h3([.text('You\'re welcome in the Flutter Community.')]),
        ]),
      ]),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        FeatureColumnsSection([
          FeatureColumn(
            title: 'Be open',
            description:
                'Three senses of openness: Open as in open minded, open as in accessible, and open as in Open Source.',
            image: context.asset('images/be-open.png'),
          ),
          FeatureColumn(
            title: 'Be modest',
            description:
                'Flutter developers are helpful and never look down on others. '
                'Together, we are building an inclusive community.',
            image: context.asset('images/be-modest.png'),
          ),
          FeatureColumn(
            title: 'Be respectful',
            description:
                'Inclusive to the core. '
                'Our community is respectful of individuals and all of their choices.',
            image: context.asset('images/be-respectful.png'),
          ),
        ]),
        const section(id: 'code', classes: 'module', [
          div(classes: 'container', [
            div(classes: 'stacked-header', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [
                    .text('Professional and respectful'),
                  ]),
                  h2([.text('Our values')]),
                ],
              ),
            ]),
            article(classes: 'story-detail', [
              p([
                .text(
                  'We expect our community to act professionally and respectfully to one another, and we expect our social spaces to be safe and dignified environments. From our ',
                ),
                a(
                  href:
                      'https://github.com/flutter/flutter/blob/main/CODE_OF_CONDUCT.md',
                  [.text('code of conduct')],
                ),
                .text(':'),
              ]),
              p([
                .text(
                  'Respect people, their identities, their culture, and their work.',
                ),
                br(),
                .text('Be kind. Be courteous. Be welcoming.'),
                br(),
                .text(
                  'Listen. Consider and acknowledge people\'s points before responding.',
                ),
              ]),
              p([
                .text('We recognize that we are a work in progress, and that '),
                a(
                  href:
                      'https://blog.flutter.dev/black-lives-matter-a8824c8cc245',
                  [.text('we all have much to learn about how to be allies')],
                ),
                .text(
                  '. Many Flutter contributors are based in the US, where there is plenty of work remaining to improve ',
                ),
                a(
                  href:
                      'https://docs.google.com/presentation/d/e/2PACX-1vRZ0x82ziFIBdHeqvz2VKh218CoxhxLPBNo657GAPkN34CYKbzrPdaLOsmAdUXEAj7xEmmTEFp-xBaJ/pub?start=false&loop=false&delayms=3000&slide=id.gc0d8ac0a20_0_0',
                  [.text('racial equity')],
                ),
                .text(' in particular.'),
              ]),
              p([
                .text(
                  'We also recognize that many programming communities under-represent the broader community that we aim to build for, and so for Flutter we want to acknowledge the gap and specifically affirm that our desire to be a welcoming and safe place where we elevate and cherish our full community.',
                ),
              ]),
              p([
                strong([.text('Some of our actions include:')]),
              ]),
              ul([
                li([
                  .text(
                    'Making sure that our events include a diverse representation of our community;',
                  ),
                ]),
                li([
                  .text(
                    'Sponsoring tickets and travel for events like Google I/O for underrepresented communities;',
                  ),
                ]),
                li([
                  .text(
                    'Sponsoring events and communities that focus on diverse audiences;',
                  ),
                ]),
                li([
                  .text(
                    'Being careful to promote the work of our full community, and raising up new leaders of color, as well as those who identify as female or non-binary.',
                  ),
                ]),
              ]),
              p([
                .text(
                  'This is a journey, but we commit ourselves to it, and '
                  'we hope you’ll join us in making that commitment.',
                ),
              ]),
            ]),
          ]),
        ]),
        section([
          div(classes: 'features container', [
            div(classes: 'feature nospy', [
              const div(classes: 'text', [
                Component.element(
                  tag: 'hgroup',
                  children: [
                    h4(classes: 'eyebrow', [.text('Flutter community')]),
                    h3([.text('Preserving this culture')]),
                  ],
                ),
                p([
                  .text(
                    'One of the things we\'re proudest of about Flutter is how '
                    'people often comment on how open and welcoming the community is. '
                    'No matter what your story is, you\'re welcome here.',
                  ),
                ]),
                a(
                  classes: 'btn',
                  href:
                      'https://blog.flutter.dev/flutter-culture-and-how-to-preserve-it-436b4ed1031d',
                  [.text('Learn more')],
                ),
              ]),
              div(classes: 'media', [
                img(
                  src: context.asset('images/flutter-community.png'),
                  alt: 'Preserving this culture',
                ),
              ]),
            ]),
          ]),
        ]),
        QuoteSection(
          background: context.asset('images/culture-quote-bg.png'),
          logo: context.asset('/images/flutter-logo-mark-320x.png'),
          logoAlt: 'Flutter',
          quote:
              'What makes Flutter so delightful and productive is the community. '
              'The idea that everyone is welcome is core to the growth and vibrance of the product.',
          author: 'Flutter Team, Google',
          company: '',
        ),
        const CTASection(),
      ]),
    ]);
  }
}
