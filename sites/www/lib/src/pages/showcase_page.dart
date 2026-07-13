// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../components/common/carousel.dart';
import '../components/common/icon.dart';
import '../components/pages/showcase_grid.dart';
import '../components/sections/case_studies.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/hero_section.dart';
import '../components/sections/quote_section.dart';
import '../models/content/showcase_content.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';
import '../utils/scroll_spy.dart';
import '../utils/stories.dart';

class ShowcasePage extends StatelessComponent {
  const ShowcasePage({super.key});

  @override
  Component build(BuildContext context) {
    final stories = context
        .stories(excludeTag: 'developer-story', sort: true)
        .toList();

    final googleApps = context.decodeJsonList(
      'showcase.data.google_apps',
      ShowcaseGoogleApp.fromJson,
    );
    final demos = context.decodeJsonList(
      'showcase.data.demos',
      ShowcaseDemo.fromJson,
    );
    final companies = context.decodeJsonList(
      'showcase.data.companies',
      ShowcaseCompany.fromJson,
    );

    return main_([
      HeroSection(
        title: 'Flutter apps in production',
        subtitle:
            'Businesses of all sizes around the world are '
            'building with Flutter',
        media: img(
          src: context.asset('images/apps-in-production.gif'),
          alt: 'Flutter in production',
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        section(id: 'flutter-apps', classes: 'module carousel-section', [
          const div(classes: 'stacked-header container', [
            h2([.text('Flutter at Google')]),
          ]),
          Carousel(
            ref(
              .fragment([
                for (final app in googleApps) _buildStoryItem(context, app),
              ]),
            ),
          ),
        ]),
        section(id: 'stories', classes: 'module', [
          ShowcaseGrid(
            data: _extractFilterData(stories),
            items: [
              for (final page in stories)
                ref(_buildUserStoryGridItem(context, page)),
            ],
          ),
          const div(classes: 'container see-more', [
            a(href: 'https://itsallwidgets.com/', classes: 'btn quiet', [
              .text("See more Flutter apps on It's All Widgets "),
              RawText('&nbsp;'),
              Icon.linkArrow(),
            ]),
          ]),
        ]),
        const section(
          id: 'developer-stories',
          classes: 'module carousel-section',
          [CaseStudies(tag: 'developer-story', title: 'Developer stories')],
        ),
        QuoteSection(
          background: context.asset('images/showcase-quote-bg.png'),
          logo: context.asset('/images/third_party/logos/alibaba.svg'),
          logoAlt: 'Alibaba',
          quote:
              'Flutter significantly reduced the time we need to '
              'develop for new feature from 1 month down to 2 weeks.',
          author: 'Bruce Chen',
          company: 'Senior Development Engineer, Alibaba',
        ),
        section(id: 'demos', classes: 'module carousel-section', [
          const div(classes: 'container stacked-header', [
            h2(classes: 'push-left', [.text('Demos')]),
          ]),
          Carousel(
            ref(
              .fragment([
                for (final demo in demos) _buildDemoItem(context, demo),
              ]),
            ),
          ),
        ]),
        section(id: 'companies', classes: 'module', [
          div(classes: 'container', [
            const h2(classes: 'subheader push-left', [
              .text('Companies using Flutter'),
            ]),
            div(classes: 'logo-garden', [
              div(classes: 'inner-fixed', [
                _buildLogoRow(context, companies.take(8).toList()),
                _buildLogoRow(context, companies.skip(8).take(9).toList()),
                _buildLogoRow(context, companies.skip(17).toList()),
              ]),
            ]),
          ]),
        ]),
        const CTASection(),
      ]),
    ]);
  }

  Component _buildStoryItem(BuildContext context, ShowcaseGoogleApp app) {
    final child = div([
      img(
        alt: app.title,
        src: context.asset(app.image, width: 635),
        width: 480,
        height: 480,
      ),
      div(classes: 'text', [
        h3([.text(app.title)]),
      ]),
    ]);

    return div(classes: 'story-item', [
      if (app.url case final url?)
        a(href: url, [
          child,
          const span(classes: 'btn learn-more-button', [.text('Learn More')]),
        ])
      else
        child,
    ]);
  }

  List<Map<String, Object?>> _extractFilterData(List<Page> pages) {
    return pages.map((page) {
      final pageData = page.data.page;
      return {
        'platforms': pageData['platforms'],
        'industries': pageData['industries'],
        'locations': pageData['locations'],
      };
    }).toList();
  }

  Component _buildUserStoryGridItem(BuildContext context, Page page) {
    final pageData = page.data.page;
    final headline = pageData['headline'] as String;
    final summary = pageData['summary'] as String;
    final card = pageData['card'] as String;
    final date = _formatDate(pageData['publishDate'] as String);
    final appName = (pageData['appName'] as String?)?.trim();
    final cardAlt = appName != null && appName.isNotEmpty ? appName : headline;
    final pageUrl = page.url;

    return div(classes: 'story-item', [
      a(href: pageUrl, [
        div(classes: 'text showcase__story-content', [
          img(src: context.asset(card), alt: cardAlt),
          span([.text(date)]),
          h3([.text(headline)]),
          p([.text(summary)]),
        ]),
      ]),
    ]);
  }

  String _formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('MMM d, yyyy', 'en-US').format(parsedDate);
  }

  Component _buildDemoItem(BuildContext context, ShowcaseDemo demo) {
    return div(classes: 'story-item', [
      a(href: demo.url, target: Target.blank, [
        img(
          alt: demo.title,
          src: context.asset(demo.image, width: 635),
          width: 512,
          height: 288,
        ),
        div(classes: 'text', [
          h3([.text(demo.title)]),
          p([.text(demo.description)]),
        ]),
      ]),
    ]);
  }

  Component _buildLogoRow(BuildContext context, List<ShowcaseCompany> items) {
    return div(classes: 'logo-row', [
      for (final item in items)
        div([img(src: context.asset(item.logo), alt: item.name)]),
    ]);
  }
}
