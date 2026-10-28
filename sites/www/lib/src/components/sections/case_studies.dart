// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../../utils/asset_utils.dart';
import '../../utils/stories.dart';
import '../common/carousel.dart';

class CaseStudies extends StatelessComponent {
  const CaseStudies({
    required this.tag,
    this.title = 'Case studies',
    super.key,
  });

  final String tag;
  final String title;

  @override
  Component build(BuildContext context) {
    final stories = context.stories(tag: tag, sort: true);

    return .fragment([
      div(classes: 'stacked-header container', [
        h2([.text(title)]),
      ]),
      Carousel(
        ref(
          .fragment([
            for (final story in stories) _buildStoryItem(context, story),
          ]),
        ),
      ),
    ]);
  }

  Component _buildStoryItem(BuildContext context, Page story) {
    final pageData = story.data.page;
    final headline = pageData['headline'] as String;
    final summary = pageData['summary'] as String;
    final appName = (pageData['appName'] as String?)?.trim();
    final cardAlt = appName != null && appName.isNotEmpty ? appName : headline;

    return div(classes: 'story-item', [
      a(href: story.url, [
        img(
          alt: cardAlt,
          src: context.asset(
            '/showcase/${pageData['card'] as String}',
            width: 635,
          ),
          width: 635,
          height: 472,
        ),
        div(classes: 'text', [
          h3([.text(headline)]),
          p([.text(summary)]),
        ]),
      ]),
    ]);
  }
}
