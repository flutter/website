// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/flutterbench/cuj_catalog.dart';
import '../../models/content/flutterbench_content.dart';
import '../../utils/data_utils.dart';
import 'flutterbench_nav.dart';

/// FlutterBench critical user journey (CUJ) catalog page.
///
/// Mounted by `/ai/flutterbench/cujs/index.md`.
class FlutterBenchCujsPage extends StatelessComponent {
  const FlutterBenchCujsPage({super.key});

  @override
  Component build(BuildContext context) {
    final cujsData = context.decodeJsonObject(
      'data.flutterbench.cujs',
      FlutterBenchCujsData.fromJson,
    );

    final cujMaps = cujsData.cujs.map((c) => c.toMap()).toList();

    return main_(classes: 'bench-page cujs-page', [
      // Hero Header with Navigation Tabs
      section(classes: 'bench-hero-header', [
        div(classes: 'bench-container', [
          div(classes: 'hero-badge-row', [
            const span(classes: 'hero-category-tag', [.text('CUJ CATALOG')]),
            span(classes: 'job-id-tag', [
              .text('${cujsData.cujs.length} Journeys'),
            ]),
          ]),
          const h1(classes: 'bench-hero-title', [
            .text('Flutter Critical User Journeys'),
          ]),
          const p(classes: 'bench-hero-subtitle', [
            .text(
              'Browse the catalog of canonical Flutter and Dart critical '
              'user journeys that the FlutterBench evaluations test.',
            ),
          ]),

          const FlutterBenchNav(current: FlutterBenchNavItem.cujs),
        ]),
      ]),

      div(classes: 'bench-container content-area cujs-content', [
        const p(classes: 'methodology-lead', [
          .text(
            'A critical user journey (CUJ) is a goal that a developer sets '
            'out to accomplish, such as "make an application accessible to '
            'all users" or "diagnose and resolve layout overflow errors". '
            'Each CUJ is broken down into the concrete tasks required to '
            'complete it. The Flutter team uses CUJs to derive evaluation '
            'tasks and prompts for FlutterBench.',
          ),
        ]),
        CujCatalog(cujs: cujMaps),
      ]),
    ]);
  }
}
