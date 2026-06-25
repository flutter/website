// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../utils/component_ref.dart';
import '../common/filters.dart';

@client
class ShowcaseGrid extends StatelessComponent {
  const ShowcaseGrid({required this.data, required this.items, super.key});

  final List<Map<String, Object?>> data;
  final List<ComponentRef> items;

  @override
  Component build(BuildContext context) {
    return Filters(
      title: const h2([.text('User showcase')]),
      data: data,
      items: items,
      filters: const [
        FilterType('platforms', 'Platform', [
          'Mobile',
          'Web',
          'Desktop',
          'Embedded',
        ]),
        FilterType('industries', 'Industry', [
          'Banking & Finance',
          'Education',
          'Games',
          'Health',
          'Media and Entertainment',
          'Productivity',
          'Social',
          'Travel & Lifestyle',
        ]),
        FilterType('locations', 'Location', [
          'Africa',
          'Asia',
          'Europe',
          'North America',
          'Oceania',
          'South America',
        ]),
      ],
    );
  }
}
