// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../../models/content/events_content.dart';
import '../common/filters.dart';

@client
class EventsGrid extends StatelessComponent {
  const EventsGrid({required this.data, required this.items, super.key});

  final List<Map<String, Object?>> data;
  final List<ComponentRef> items;

  @override
  Component build(BuildContext context) {
    return Filters(
      title: const h3([.text('Flutter Events Public Calendar')]),
      data: data,
      items: items,
      filters: [
        FilterType('locations', 'Event Location', [
          for (final location in EventLocation.values) location.label,
        ]),
        FilterType('hosts', 'Event Host', [
          for (final host in EventHost.values) host.label,
        ]),
      ],
    );
  }
}
