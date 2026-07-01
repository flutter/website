// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../utils/asset_utils.dart';
import 'default_layout.dart';

class ShowcaseStoryExtension extends PageExtension {
  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    if (page.url.startsWith('/showcase/')) {
      page.apply(
        data: {
          'page': {
            'layout': 'showcase-story',
          },
        },
      );
    }
    return nodes;
  }
}

class ShowcaseStoryLayout extends DefaultLayout {
  @override
  Pattern get name => 'showcase-story';

  @override
  List<String> get defaultBodyTags => const [
    'interior',
    'showcase',
    'showcase-story',
  ];

  @override
  Component buildLayout(Page page, Component child) {
    final data = page.data.page;
    final headline = data['headline'] as String;
    final summary = data['summary'] as String;
    final logo = data['logo'] as String;
    final companyName = (data['companyName'] as String?)?.trim();
    final appName = (data['appName'] as String?)?.trim();
    final logoAlt = companyName != null && companyName.isNotEmpty
        ? companyName
        : headline;
    final mediaAlt = appName != null && appName.isNotEmpty ? appName : headline;

    return super.buildLayout(
      page,
      Builder(
        builder: (context) => main_([
          section(id: 'story', [
            div(classes: 'container', [
              article(classes: 'story-detail', [
                div(classes: 'story-logo', [
                  img(src: context.asset(logo, width: 128), alt: logoAlt),
                ]),
                h1([.text(headline)]),
                if (data['videoEmbedUrl'] case final String videoUrl
                    when videoUrl.isNotEmpty)
                  div(classes: 'embed-container', [
                    iframe(
                      src: videoUrl,
                      allow:
                          'accelerometer;autoplay;clipboard-write;'
                          'encrypted-media;gyroscope;picture-in-picture',
                      attributes: {
                        'title': '$mediaAlt video',
                        'allowfullscreen': '',
                        'frameborder': '0',
                      },
                      const [],
                    ),
                  ])
                else if (data['poster'] case final String posterUrl
                    when posterUrl.isNotEmpty)
                  img(
                    classes: 'poster',
                    src: context.asset(posterUrl, width: 1440),
                    alt: mediaAlt,
                  ),
                h2([.text(summary)]),
                if (data['successMetrics']
                    case final List<Object?> successMetrics
                    when successMetrics.isNotEmpty)
                  div(classes: 'success-metrics', [
                    const h2([.text('Success metrics')]),
                    div(classes: 'success-metrics-wrapper', [
                      for (final metric
                          in successMetrics.cast<Map<String, Object?>>())
                        div(classes: 'block-metric', [
                          div(classes: 'success-metric', [
                            h4([
                              .text(
                                metric['text']?.toString() ??
                                    (metric['perc'] != null
                                        ? '${metric['perc']}%'
                                        : ''),
                              ),
                            ]),
                            h3([.text(metric['desc'] as String)]),
                          ]),
                        ]),
                    ]),
                  ]),
                div(classes: 'story-body', [child]),
              ]),
            ]),
          ]),
        ]),
      ),
    );
  }
}
