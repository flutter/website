// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../common/filters.dart';

@client
class ConsultantsGrid extends StatelessComponent {
  const ConsultantsGrid({required this.data, required this.items, super.key});

  final List<Map<String, Object?>> data;
  final List<ComponentRef> items;

  @override
  Component build(BuildContext context) {
    return Filters(
      data: data,
      items: items,
      filters: const [
        FilterType('locations', 'Company Location', [
          'Africa',
          'Asia',
          'Europe',
          'North America',
          'Oceania',
          'South America',
        ]),
        FilterType('customer_sizes', 'Customer Size', [
          'Startup',
          'Small-to-medium Business',
          'Enterprise',
        ]),
        FilterType('gcp_partners', 'GCP Partner', ['Yes', 'No']),
      ],
    );
  }
}
