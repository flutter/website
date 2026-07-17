// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'icon.dart';

class FeatureInfo extends StatelessComponent {
  const FeatureInfo({
    this.eyebrow,
    this.eyebrowClass,
    required this.title,
    required this.description,
    this.actions = const [],
    super.key,
  });

  final String? eyebrow;
  final String? eyebrowClass;
  final String title;
  final String description;
  final List<Component> actions;

  @override
  Component build(BuildContext context) {
    return .fragment([
      Component.element(
        tag: 'hgroup',
        children: [
          if (eyebrow case final eyebrow?)
            h4(
              classes: 'eyebrow${eyebrowClass != null ? ' $eyebrowClass' : ''}',
              [.text(eyebrow)],
            ),
          h3([.text(title)]),
        ],
      ),
      p([.text(description)]),
      if (actions.length > 1) div([...actions]) else ...actions,
    ]);
  }
}

class Feature extends StatelessComponent {
  Feature({
    String? eyebrow,
    String? eyebrowClass,
    required String title,
    required String description,
    List<Component> actions = const [],
    this.media,
    this.reverse = false,
    this.noSpy = false,
    this.active = false,
    this.full = false,
    super.key,
  }) : topInfo = null,
       features = [
         FeatureInfo(
           eyebrow: eyebrow,
           eyebrowClass: eyebrowClass,
           title: title,
           description: description,
           actions: actions,
         ),
       ];

  Feature.stacked({
    String? eyebrow,
    required String title,
    required this.features,
    this.media,
    this.reverse = false,
    this.noSpy = false,
    this.active = false,
    this.full = false,
    super.key,
  }) : topInfo = FeatureInfo(eyebrow: eyebrow, title: title, description: '');

  final FeatureInfo? topInfo;
  final List<FeatureInfo> features;
  final Component? media;
  final bool reverse;
  final bool noSpy;
  final bool active;
  final bool full;

  @override
  Component build(BuildContext context) {
    Component child = div(
      classes: [
        'feature',
        if (reverse) 'reverse',
        if (noSpy) 'nospy',
        if (active) 'active',
        if (full) 'full',
      ].join(' '),
      [
        div(classes: 'text', [
          if (topInfo != null)
            for (final feature in features) div([feature])
          else
            ...features,
        ]),
        if (media != null) div(classes: 'media', [media!]),
      ],
    );
    if (topInfo case final info?) {
      child = div(classes: 'stacked-feature', [
        Component.element(
          tag: 'hgroup',
          children: [
            if (info.eyebrow case final eyebrow?)
              h4(classes: 'eyebrow', [.text(eyebrow)]),
            h2(
              info.title
                  .split('\n')
                  .fold(
                    [],
                    (l, t) => [...l, if (l.isNotEmpty) const br(), .text(t)],
                  ),
            ),
          ],
        ),
        child,
      ]);
    }
    return child;
  }
}

class FeatureAction extends StatelessComponent {
  const FeatureAction({
    super.key,
    required this.label,
    required this.url,
    this.solid = false,
  }) : link = false,
       collapsed = false;

  const FeatureAction.link({
    super.key,
    required this.label,
    required this.url,
    this.collapsed = true,
  }) : link = true,
       solid = false;

  final String label;
  final String url;
  final bool link;
  final bool collapsed;
  final bool solid;

  @override
  Component build(BuildContext context) {
    return a(
      classes: [
        'btn',
        if (link) 'quiet',
        if (collapsed) 'collapsed',
        if (solid) 'solid',
      ].join(' '),
      href: url,
      [
        .text(label),
        if (link) ...[
          const RawText('&nbsp;'),
          const Icon.linkArrow(),
        ],
      ],
    );
  }
}
