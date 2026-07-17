// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class FlipPage extends StatelessComponent {
  const FlipPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      section(
        id: 'banner',
        attributes: {
          'style':
              'background: center / cover no-repeat url(\'${context.asset('/flip/flip-banner.png')}\')',
        },
        const [
          div(classes: 'embed-container', [
            iframe(
              src: 'https://www.youtube.com/embed/ZKp6TQCW2qQ',
              allow:
                  'accelerometer;autoplay;clipboard-write;encrypted-media;gyroscope;picture-in-picture',
              attributes: {'allowfullscreen': '', 'frameborder': '0'},
              [],
            ),
          ]),
          div(classes: 'hero-details', [
            a(
              classes: 'btn secondary',
              href: 'https://flip.withgoogle.com',
              target: Target.blank,
              [.text('Play now')],
            ),
            p([
              .text(
                'I/O FLIP, an AI-designed card game powered by Google, built for I/O 2023',
              ),
            ]),
          ]),
        ],
      ),
      section(id: 'story', [
        article(classes: 'story-detail', [
          section(id: 'tabs', classes: 'module', attributes: scroll.spy(-300), [
            div(classes: 'tabs container', [
              div(classes: 'tabs-content', [
                div(classes: 'tab-content active', [
                  section(id: 'home', classes: 'module', [
                    div(classes: 'features container', [
                      div(classes: 'stacked-feature', [
                        div(classes: 'overview', [
                          img(
                            src: context.asset(
                              '/games/images/flip/icon_how.png',
                              width: 515,
                            ),
                            alt: 'games/flip/icon_how.png',
                            width: 515,
                          ),
                          const div(classes: 'overview-content', [
                            Component.element(
                              tag: 'hgroup',
                              children: [
                                h4(classes: 'eyebrow faqs', [
                                  .text('Building FLIP'),
                                ]),
                                h1([.text('How we built it')]),
                              ],
                            ),
                            p([
                              .text(
                                'I/O FLIP is an example of a seamless integration between Google’s new AI tools and tools you already know and love. Character images are generated with DreamBooth on Muse, and descriptions were generated using the PaLM API. The game UI, and animations are created in Flutter and the backend is written in Dart. It uses a suite of Firebase and Google Cloud tools for hosting and sharing.',
                              ),
                            ]),
                            a(
                              classes: 'btn',
                              href:
                                  'https://developers.googleblog.com/2023/05/how-its-made-io-flip-adds-twist-to.html',
                              target: Target.blank,
                              [.text('Learn more')],
                            ),
                          ]),
                        ]),
                        div(classes: 'overview', [
                          img(
                            src: context.asset(
                              '/games/images/flip/icon_code.png',
                              width: 515,
                            ),
                            alt: 'games/flip/icon_code.png',
                            width: 515,
                          ),
                          const div(classes: 'overview-content', [
                            Component.element(
                              tag: 'hgroup',
                              children: [
                                h4(classes: 'eyebrow faqs', [
                                  .text('The Code'),
                                ]),
                                h1([.text('Get into the code')]),
                              ],
                            ),
                            p([
                              .text(
                                'Access the code that makes up I/O FLIP and let it inspire you to use all the tools in I/O FLIP and more to create even more fun and delightful innovations of your own.',
                              ),
                            ]),
                            a(
                              classes: 'btn',
                              href: 'https://github.com/flutter/io_flip',
                              target: Target.blank,
                              [.text('Dive in')],
                            ),
                          ]),
                        ]),
                      ]),
                    ]),
                  ]),
                  const section(id: 'faqs', classes: 'module', [
                    div(classes: 'features container', [
                      div(classes: 'stacked-feature', [
                        Component.element(
                          tag: 'hgroup',
                          children: [
                            h4(classes: 'eyebrow faqs', [.text('FAQs')]),
                            h2([
                              .text('Frequently Asked '),
                              br(),
                              .text('Questions'),
                            ]),
                          ],
                        ),
                        div(classes: 'feature full nospy', [
                          h3([.text('What is this?')]),
                          p([
                            .text(
                              'I/O FLIP is an AI-designed card game powered by Google, built for Google I/O 2023.',
                            ),
                          ]),
                        ]),
                        div(classes: 'feature full nospy', [
                          h3([
                            .text(
                              'How were the images and descriptions created?',
                            ),
                          ]),
                          p([
                            .text(
                              'Images were generated using Muse, a text-to-image Transformer model developed by Google Research, and trained using artwork we created. The text was generated using the PaLM API based on text inputs created by Google. To ensure a positive experience for all users, images and text were generated offline so that they could be vetted by human reviewers to ensure they adhere to ',
                            ),
                            a(href: 'https://ai.google/principles/', [
                              .text('Google AI Principles'),
                            ]),
                            .text('.'),
                          ]),
                        ]),
                        div(classes: 'feature full nospy', [
                          h3([.text('How was AI used?')]),
                          p([
                            .text(
                              'AI was used to create the images and descriptions on each card.',
                            ),
                          ]),
                        ]),
                        div(classes: 'feature full nospy', [
                          h3([.text('Are there prizes for the winners?')]),
                          p([
                            .text('There are no prizes as part of the game.'),
                          ]),
                        ]),
                        div(classes: 'feature full nospy', [
                          h3([
                            .text(
                              'What data is stored and publicly available when sharing?',
                            ),
                          ]),
                          p([
                            .text(
                              'If you choose to share, your initials, cards and score will be made available at a unique URL for 30 days and then automatically deleted.',
                            ),
                          ]),
                        ]),
                      ]),
                    ]),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}
