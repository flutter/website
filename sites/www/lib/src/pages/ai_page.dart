// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../components/common/carousel.dart';
import '../components/common/feature.dart';
import '../components/common/feature_grid.dart';
import '../components/common/icon.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/feature_columns_section.dart';
import '../components/sections/hero_section.dart';
import '../models/content/ai_content.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';
import '../utils/scroll_spy.dart';

class AiPage extends StatelessComponent {
  const AiPage({super.key});

  @override
  Component build(BuildContext context) {
    final samples = context.decodeJsonList('ai.samples', AiSample.fromJson);

    return main_([
      HeroSection(
        title: 'Build with AI',
        subtitle:
            'Build and deploy AI-powered features that reach users on any platform with Flutter and Google\'s AI capabilities',
        media: img(
          src: context.asset('images/build-with-ai/build-with-ai-hero.png'),
          alt: 'Build with AI',
        ),
      ),
      section(id: 'notification', classes: 'module', [
        div(classes: 'notification container', [
          div(classes: 'notification-message', [
            img(
              src: context.asset('/home/images/banner-megaphone.png'),
              alt: 'Notification',
            ),
            const a(
              href: 'https://dart.dev/tools/mcp-server',
              target: Target.blank,
              [
                .text('Try the new Dart and Flutter MCP server! '),
                RawText('&nbsp;'),
                Icon.linkArrow(large: true),
              ],
            ),
          ]),
          const div(classes: 'notification-nav', [
            span(classes: 'active', [a(href: '#', [])]),
          ]),
        ]),
      ]),
      section(classes: 'module', [
        FeatureColumnsSection([
          FeatureColumn(
            title: 'Expand your app\'s functionality',
            description:
                'Add AI-based features like text generation, chat, and more to your Dart or Flutter apps with minimal setup',
            image: context.asset(
              'images/build-with-ai/expand-functionality.png',
            ),
          ),
          FeatureColumn(
            title: 'Fast AI app development',
            description:
                'Focus on your app logic and user experience, let Google SDKs handle the intricacies of interacting with AI models',
            image: context.asset(
              'images/build-with-ai/fast-ai-development.png',
            ),
          ),
          FeatureColumn(
            title: 'The best of Google',
            description:
                'Tap into models built on Google\'s extensive research and development, or explore popular alternatives',
            image: context.asset('images/build-with-ai/the-best-of-google.png'),
          ),
        ]),
        section(id: 'tabs', classes: 'module', attributes: scroll.spy(-300), [
          //TODO: Add a section for GenUI here
          div(classes: 'build-features container', [
            ref(const h2([.text('Start building AI-driven features now.')])),
            // Firebase Section
            div(classes: 'alternating-item', [
              div(classes: 'media', [
                img(
                  src: context.asset('images/build-with-ai/vertex-tab.png'),
                  alt: 'Vertex AI Logo',
                ),
              ]),
              const div(classes: 'text', [
                h3([.text('Firebase AI Logic')]),
                p([
                  .text(
                    'Easily integrate generative AI into your apps - either directly via client-side access without setting up a backend, or through Genkit for robust server-side implementations.',
                  ),
                ]),
                a(
                  classes: 'btn',
                  href:
                      'https://firebase.google.com/docs/vertex-ai/get-started?platform=flutter',
                  target: Target.blank,
                  [.text('Get started')],
                ),
              ]),
            ]),
            // Genkit Section
            div(classes: 'alternating-item reversed', [
              div(classes: 'media', [
                img(
                  classes: 'genkit-logo',
                  src: context.asset('images/genkit.jpg'),
                  alt: 'Genkit Logo',
                ),
              ]),
              const div(classes: 'text', [
                h3([.text('Genkit')]),
                p([
                  .text(
                    'Genkit Dart is Google\'s open source AI framework that helps you easily build AI features into your app. It provides a single API to access your preferred model provider and features a Dev UI for debugging and rapid iterations.',
                  ),
                ]),
                a(
                  classes: 'btn',
                  href: 'https://genkit.dev/docs/dart/overview',
                  target: Target.blank,
                  [.text('Get started')],
                ),
              ]),
            ]),
          ]),
        ]),
        section(id: 'ai-toolkit', [
          div(classes: 'features container', [
            Feature(
              reverse: true,
              eyebrow: 'Supercharge your Flutter app with AI',
              title: 'The Flutter AI Toolkit',
              description:
                  'Quickly add intelligent chat experiences using the new Flutter AI Toolkit. Easily integrate with Google Gemini AI or Firebase Vertex AI to power multi-turn conversations, streaming responses, speech-to-text input, and more.',
              actions: const [
                FeatureAction(
                  label: 'Get started',
                  url: 'https://pub.dev/packages/flutter_ai_toolkit',
                ),
              ],
              media: img(
                src: context.asset(
                  'images/build-with-ai/flutter-ai-toolkit.png',
                ),
                alt: 'Flutter AI Toolkit',
              ),
              noSpy: true,
            ),
          ]),
        ]),
        section(id: 'feature-grid', classes: 'module', [
          FeatureGrid(
            eyebrow: 'Learn more about building with Flutter and generative AI',
            title: 'Learn how to...',
            items: [
              FeatureGridItem(
                title:
                    'Get started with Flutter, Dart, and Google AI in documentation',
                description:
                    'Documentation and tutorials for getting started with Flutter and Google AI.',
                url: 'https://docs.flutter.dev/ai/create-with-ai',
                icon: context.asset(
                  '/development/images/icons/get-started-in-docs.svg',
                ),
              ),
              FeatureGridItem(
                title: 'Use the Gemini API for Dart and Flutter apps',
                description:
                    'Follow along in this Solutions Pathway to learn how to use the Google AI Dart SDK to make your first generative AI call using Gemini, build an app using Dart and Flutter, and explore cross-platform sample applications.',
                url:
                    'https://developers.google.com/learn/pathways/solution-ai-gemini-getting-started-dart-flutter',
                icon: context.asset(
                  '/development/images/icons/see-the-samples.svg',
                ),
              ),
              FeatureGridItem(
                title:
                    'How to build agentic apps with Flutter and Firebase AI Logic',
                description:
                    'Multimodal AI is transforming how users interact with applications. '
                    'Join us for an exploration of how to build secure, scalable, and intelligent multiplatform and multimodal AI apps using Flutter, Firebase, and Gemini.',
                url: 'https://youtu.be/xo271p-Fl_4?si=VmGUTTFJvsSY9-vZ',
                icon: context.asset(
                  '/development/images/icons/watch-the-video.svg',
                ),
              ),
              FeatureGridItem(
                title:
                    'Build generative AI agents with Vertex AI Agent Builder and Flutter',
                description:
                    'Supercharge your generative AI development workflow with Vertex AI and Flutter. '
                    'Seamlessly integrate with your existing tools and leverage our pre-built components and architectures to accelerate prototyping and deploy production-grade gen AI agents in your apps.',
                url:
                    'https://io.google/2024/explore/6f1a4481-7b82-45c9-83eb-caa6e2391152/',
                icon: context.asset(
                  '/development/images/icons/follow-the-roadmap.svg',
                ),
              ),
              FeatureGridItem(
                title: 'Build AI-powered apps with Genkit Dart',
                description:
                    'Learn how to build AI-powered applications in Dart and Flutter using the Genkit framework.',
                url: 'https://genkit.dev/docs/dart/overview',
                icon: context.asset(
                  '/development/images/icons/get-started-in-docs.svg',
                ),
              ),
            ],
          ),
        ]),
        section(
          id: 'find-inspiration-carousel',
          classes: 'module carousel-section',
          [
            const div(classes: 'stacked-header container', [
              h4(classes: 'eyebrow', [.text('Find inspiration')]),
              h2([.text('Explore Flutter + AI samples')]),
            ]),
            Carousel(
              ref(
                .fragment([
                  for (final item in samples) _buildSampleItem(context, item),
                ]),
              ),
            ),
          ],
        ),
        const CTASection(),
      ]),
    ]);
  }

  Component _buildSampleItem(BuildContext context, AiSample item) {
    return div(classes: 'story-item', [
      a(href: item.href, target: Target.blank, [
        div([
          div(classes: 'image-container', [
            img(alt: item.title, src: context.asset(item.image)),
          ]),
          div(classes: 'text', [
            h3([.text(item.title)]),
          ]),
        ]),
        const span(classes: 'btn learn-more-button', [.text('Learn more')]),
      ]),
    ]);
  }
}
