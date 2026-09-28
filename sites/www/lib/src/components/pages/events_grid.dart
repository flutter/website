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
    required this.data,
    required this.items,
    this.past = false,
    super.key,
  });

  final List<Map<String, Object?>> data;
  final List<ComponentRef> items;

  /// Whether these events have already finished.
  ///
  /// The heading, empty state, and filter scope all follow from this,
  /// so the two grids the events page renders don't collide with each other.
  final bool past;

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
      title: h2([.text(past ? 'Past events' : 'Upcoming events')]),
      data: data,
      items: items,
      filters: _filters,
      scope: past ? 'past-' : '',
      emptyResultsMessage: 'No events match these filters.',
      emptyDataMessage: past
          ? 'No past events are listed right now.'
          : 'No upcoming events are listed right now. Check back soon.',
    );
  }
}
