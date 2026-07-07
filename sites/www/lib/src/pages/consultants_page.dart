// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../components/common/carousel.dart';
import '../components/common/icon.dart';
import '../components/pages/consultants_grid.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/newsletter_section.dart';
import '../models/content/consultants_content.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';
import '../utils/scroll_spy.dart';

class ConsultantsPage extends StatelessComponent {
  const ConsultantsPage({super.key});

  @override
  Component build(BuildContext context) {
    final partners = context.decodeJsonList(
      'consultants.data.partners',
      ConsultantPartner.fromJson,
    );

    return main_([
      section(classes: 'hero', [
        div(classes: 'container', [
          div(classes: 'mantle', [
            const div(classes: 'text', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h1([.text('Flutter Consultants')]),
                  h2([
                    .text(
                      'Consultancies designing and building successful Flutter applications.',
                    ),
                  ]),
                ],
              ),
              div([
                a(
                  classes: 'btn primary',
                  href:
                      'https://docs.google.com/forms/d/1CS1Ysbwyeya4o0kzu1acPFie8ozHrUgEmAK4kx0_MZM/edit?usp=drive_open&resourcekey=0-Qi5RvEWxp_WT86zHombxgg',
                  [.text('Become a Flutter Consultant')],
                ),
              ]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/implementation-consultants.png'),
                alt: 'Implementation Consultants',
              ),
            ]),
          ]),
        ]),
      ]),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        section(id: 'stories', classes: 'module', [
          ConsultantsGrid(
            data: _extractFilterData(partners),
            items: [
              for (final (index, partner) in partners.indexed)
                ref(_buildPartnerItem(context, index, partner)),
            ],
          ),
        ]),
        _buildFeaturedResourcesSection(context),
        const NewsletterSection(),
        const CTASection(),
      ]),
    ]);
  }

  Component _buildFeaturedResourcesSection(BuildContext context) {
    final featuredResources = context.decodeJsonList(
      'consultants.data.resources',
      ConsultantResource.fromJson,
    );

    return section(id: 'featured-events', classes: 'module carousel-section', [
      const h1([.text('Resources for Flutter '), br(), .text(' Consultants')]),
      Carousel(
        ref(
          .fragment([
            for (final resource in featuredResources)
              _buildFeaturedCard(context, resource),
          ]),
        ),
      ),
    ]);
  }

  Component _buildFeaturedCard(
    BuildContext context,
    ConsultantResource resource,
  ) {
    return div(classes: 'carousel-featured-card', [
      div(
        classes: 'media',
        attributes: {
          'style':
              'background-image:url(${context.asset(resource.card, width: 680)})',
        },
        const [],
      ),
      div(
        classes: 'text ',
        attributes: {'style': 'background-color: ${resource.backgroundColor}'},
        [
          h3([.text(resource.title)]),
          p([.text(resource.summary)]),
          a(
            href: resource.externalUrl,
            target: Target.blank,
            classes: 'btn quiet',
            [
              .text('${resource.buttonText} '),
              const RawText('&nbsp;'),
              const Icon.linkArrow(),
            ],
          ),
        ],
      ),
    ]);
  }

  List<Map<String, Object?>> _extractFilterData(List<ConsultantPartner> data) {
    return data.map((item) {
      return {
        'locations': item.locationLabels,
        'customer_sizes': item.customerSizeLabels,
        'gcp_partners': item.gcpPartnerLabel,
      };
    }).toList();
  }

  Component _buildPartnerItem(
    BuildContext context,
    int index,
    ConsultantPartner partner,
  ) {
    return div(classes: 'story-item', [
      a(href: partner.externalUrl, target: Target.blank, [
        img(src: context.asset(partner.card)),
        div(classes: 'text', [
          h3([.text(partner.title)]),
          p([.text(partner.summary)]),
        ]),
      ]),
    ]);
  }
}
