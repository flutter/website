// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/common/feature.dart';
import '../components/common/icon.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/feature_columns_section.dart';
import '../components/sections/hero_section.dart';
import '../components/sections/quote_section.dart';
import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class WhyFlutterPage extends StatelessComponent {
  const WhyFlutterPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      _buildHero(context),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        _buildBusinessValue(context),
        _buildMultiPlatform(context),
        _buildProductivity(context),
        _buildCaseStudies(context),
        QuoteSection(
          background: context.asset(
            'images/multi-platform-testimonials-bg.jpg',
          ),
          logo: context.asset('/images/third_party/logos/bmw.svg'),
          logoAlt: 'BMW',
          quote:
              'Flutter allowed us to build a high-performance, beautiful app for our customers in record time.',
          author: 'Dr. Nicolai Krämer',
          company: 'Vice President Offboard Platform, BMW Group',
        ),
        const CTASection(),
      ]),
    ]);
  }

  Component _buildHero(BuildContext context) {
    return HeroSection(
      title: 'The Business Case for Flutter',
      text:
          'Discover how Flutter transforms development speed, reduces costs, and delivers high-quality experiences across every screen.',
      media: .fragment([
        img(
          src: context.asset('images/beautiful-apps-for-every-screen.png'),
          alt: 'Why Flutter',
        ),
        div(classes: 'hero-actions', [
          a(
            href: '#whitepaper',
            classes: 'btn white',
            const [.text('Download Whitepaper')],
          ),
        ]),
      ]),
    );
  }

  Component _buildBusinessValue(BuildContext context) {
    return section(id: 'business-value', classes: 'module', [
      div(classes: 'container', [
        const h2([.text('Maximize Business Value')]),
        const p([
          .text(
            'Flutter is more than a framework; it\'s a strategic choice that impacts your bottom line. '
            'By unifying your development team and codebase, you can reach more users with less effort.',
          ),
        ]),
        div(id: 'whitepaper', classes: 'whitepaper-box module', [
          div(classes: 'text', [
            const h3([.text('Whitepaper: The ROI of Flutter')]),
            const p([
              .text(
                'Download our comprehensive guide on how Flutter impacts time-to-market, '
                'maintenance costs, and user engagement for modern enterprises.',
              ),
            ]),
            const a(
              href: '#', // Placeholder for actual PDF link
              classes: 'btn',
              [.text('Download PDF (Coming Soon)')],
            ),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildMultiPlatform(BuildContext context) {
    return FeatureColumnsSection([
      FeatureColumn(
        title: 'Speed to Market',
        description:
            'Ship to iOS, Android, Web, and Desktop simultaneously from a single codebase.',
        image: context.asset('images/single-codebase.png'),
      ),
      FeatureColumn(
        title: 'Reduced Costs',
        description:
            'Halve your development and maintenance costs by eliminating platform-specific silos.',
        image: context.asset('images/performant-by-design.png'),
      ),
      FeatureColumn(
        title: 'Unmatched Quality',
        description:
            'Deliver "jank-free" 60fps performance and beautiful, bespoke UIs that wow your users.',
        image: context.asset('images/customize-every-pixel.svg'),
      ),
    ]);
  }

  Component _buildProductivity(BuildContext context) {
    return section(id: 'productivity', [
      div(classes: 'features container', [
        Feature(
          eyebrow: 'Productivity',
          title: 'Unleash Developer Potential',
          description:
              'With features like Hot Reload, developers can see changes in milliseconds, '
              'drastically reducing the feedback loop and increasing innovation.',
          media: img(
            src: context.asset('home/images/feature-productive.png'),
            alt: 'Developer Productivity',
          ),
          active: true,
        ),
      ]),
    ]);
  }

  Component _buildCaseStudies(BuildContext context) {
    return section(id: 'case-studies', classes: 'module', [
      div(classes: 'container', [
        const h2([.text('Trusted by Global Leaders')]),
        div(classes: 'logo-garden', [
          // Simplified logo garden for this page
          div(classes: 'logo-col', [
            img(
              src: context.asset('images/third_party/logos/bmw.svg'),
              alt: 'BMW',
            ),
            img(
              src: context.asset('images/third_party/logos/ebay.svg'),
              alt: 'eBay',
            ),
            img(
              src: context.asset('images/third_party/logos/google.svg'),
              alt: 'Google',
            ),
          ]),
        ]),
        const br(),
        const a(href: '/showcase', classes: 'btn quiet', [
          .text('Explore Case Studies '),
          RawText('&nbsp;'),
          Icon(symbol: 'arrow_forward'),
        ]),
      ]),
    ]);
  }
}
