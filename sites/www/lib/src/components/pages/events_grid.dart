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
  const EventsGrid({
    required this.title,
    required this.data,
    required this.items,
    required this.emptyDataMessage,
    this.filterScope = '',
    super.key,
  });

  /// The heading displayed above the grid of events.
  final String title;
  final List<Map<String, Object?>> data;
  final List<ComponentRef> items;

  /// Message displayed when the grid has no events.
  final String emptyDataMessage;

  /// Prefix for the filter URL parameters and dropdown element IDs.
  ///
  /// Use a unique value when multiple event grids appear on one page.
  final String filterScope;

  /// The dimensions every event grid can be filtered by.
  static final List<FilterType> _filters = [
    FilterType('locations', 'Event Location', [
      for (final location in EventLocation.values) location.label,
    ]),
    FilterType('hosts', 'Event Host', [
      for (final host in EventHost.values) host.label,
    ]),
  ];

  @override
  Component build(BuildContext context) {
    return Filters(
      title: h2([.text(title)]),
      data: data,
      items: items,
      filters: _filters,
      scope: filterScope,
      emptyResultsMessage: 'No events match these filters.',
      emptyDataMessage: emptyDataMessage,
    );
  }
}
