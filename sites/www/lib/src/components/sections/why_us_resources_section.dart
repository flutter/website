// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../utils/asset_utils.dart';
import '../common/icon.dart';

/// Describes a single third-party research report.
typedef _Resource = ({
  String href,
  String logo,
  String logoAlt,
  String title,
  String summary,
});

/// The "Don't take our word for it" section, linking out to third-party
/// research on Flutter's business value.
///
/// All hover behaviour is CSS, so this section stays server-rendered.
class WhyUsResourcesSection extends StatelessComponent {
  const WhyUsResourcesSection({super.key});

  static const List<_Resource> _resources = [
    (
      href: 'https://leancode.co/insights/flutter-cto-report',
      logo: 'leancode.svg',
      logoAlt: 'LeanCode',
      title: 'Flutter CTO Report by LeanCode',
      summary: 'What 300+ CTOs say about Flutter in production.',
    ),
    (
      href: 'https://verygood.ventures/whitepapers/business-value-of-flutter/',
      logo: 'vgvlogo.svg',
      logoAlt: 'Very Good Ventures',
      title: "VGV's Flutter Whitepaper by Very Good Ventures",
      summary: 'The ROI case, from the team behind top Flutter apps.',
    ),
  ];

  @override
  Component build(BuildContext context) {
    return section(id: 'resources', classes: 'module why-us-resources', [
      const div(classes: 'stacked-header container', [
        p(classes: 'why-us-kicker', [.text('Resources')]),
        h2([.text("Don't take our word for it.")]),
        p(classes: 'why-us-sub', [
          .text(
            'Discover reports, case studies, and research from organizations '
            'shaping the future of Flutter.',
          ),
        ]),
      ]),
      div(classes: 'why-us-resource-list container', [
        for (final resource in _resources) _ResourceRow(resource: resource),
      ]),
    ]);
  }
}

/// A single resource row linking out to an external report.
class _ResourceRow extends StatelessComponent {
  const _ResourceRow({required this.resource});

  final _Resource resource;

  @override
  Component build(BuildContext context) {
    return a(
      href: resource.href,
      target: Target.blank,
      attributes: const {'rel': 'noopener'},
      classes: 'why-us-resource',
      [
        img(
          src: context.asset('/why-us/images/${resource.logo}'),
          alt: resource.logoAlt,
          classes: 'why-us-resource-logo',
        ),
        div(classes: 'why-us-resource-copy', [
          h3([.text(resource.title)]),
          p(classes: 'why-us-body', [.text(resource.summary)]),
        ]),
        const div(classes: 'why-us-resource-tile', [
          Icon(symbol: 'arrow_outward'),
        ]),
        const div(classes: 'why-us-resource-button', [
          span([.text('Read more')]),
          Icon(symbol: 'north_east'),
        ]),
      ],
    );
  }
}
