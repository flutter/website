// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../components/common/carousel.dart';
import '../components/common/icon.dart';
import '../components/pages/events_grid.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/hero_section.dart';
import '../components/sections/newsletter_section.dart';
import '../models/content/events_content.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';
import '../utils/scroll_spy.dart';

class EventsPage extends StatelessComponent {
  const EventsPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      HeroSection(
        title: 'Attend Flutter Events',
        media: img(
          src: context.asset('images/attend-flutter-events.png'),
          alt: 'Attend events',
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        _buildFeaturedEventsSection(context),
        _buildStoriesSection(context),
        const NewsletterSection(),
        const CTASection(),
      ]),
    ]);
  }

  Component _buildFeaturedEventsSection(BuildContext context) {
    final featuredEvents = context.decodeJsonList(
      'events.data.featured',
      FeaturedEvent.fromJson,
    );

    return section(id: 'featured-events', classes: 'module carousel-section', [
      const div(classes: 'container', [
        h2([.text('Featured events')]),
      ]),
      Carousel(
        ref(
          .fragment([
            for (final event in featuredEvents)
              _buildCarouselCard(context, event),
          ]),
        ),
      ),
    ]);
  }

  Component _buildCarouselCard(BuildContext context, FeaturedEvent event) {
    return div(classes: 'carousel-featured-card', [
      div(
        classes: 'media',
        attributes: {
          'style': [
            'background-image:url(${context.asset(event.image, width: 680)})',
            'background-color: ${event.backgroundColor}',
          ].join(';'),
        },
        const [],
      ),
      div(
        classes: 'text dark',
        attributes: {'style': 'background-color: ${event.backgroundColor}'},
        [
          h3([.text(event.title)]),
          if (event.description.isNotEmpty) p([.text(event.description)]),
          a(
            href: event.link,
            classes: 'btn quiet',
            target: event.hasExternalLink ? Target.blank : null,
            const [
              .text('Learn more '),
              RawText('&nbsp;'),
              Icon.linkArrow(),
            ],
          ),
        ],
      ),
    ]);
  }

  Component _buildStoriesSection(BuildContext context) {
    final rawEvents = context.decodeJsonList(
      'events.data.calendar',
      CalendarEvent.fromJson,
    );

    // Keep events listed for a few extra days after their end date
    // because recently ended events might still be relevant.
    const visibleAfterDays = 3;
    final now = DateTime.now().toUtc();
    final cutoff = DateTime.utc(
      now.year,
      now.month,
      now.day - visibleAfterDays,
    );
    final events = rawEvents
        .where(
          (event) => !DateTime.utc(
            event.endDate.year,
            event.endDate.month,
            event.endDate.day,
          ).isBefore(cutoff),
        )
        .toList(growable: false);

    return section(id: 'stories', [
      EventsGrid(
        data: _extractFilterData(events),
        items: [
          for (final event in events) ref(_buildEventItem(context, event)),
        ],
      ),
    ]);
  }

  List<Map<String, Object?>> _extractFilterData(List<CalendarEvent> data) {
    return data.map((item) {
      return {'locations': item.location.label, 'hosts': item.host.label};
    }).toList();
  }

  Component _buildEventItem(BuildContext context, CalendarEvent event) {
    final itemContent = [
      div(
        classes: 'event_image_container',
        attributes: {
          if (event.backgroundColor != null)
            'style': 'background-color: ${event.backgroundColor}',
        },
        [
          img(src: context.asset(event.card), alt: event.title),
        ],
      ),
      div(classes: 'text', [
        div([
          span([
            img(src: context.asset('/images/common/calendar.svg')),
            const RawText('&nbsp;'),
            label([.text(_formatDateRange(event.startDate, event.endDate))]),
          ]),
          span([
            img(src: context.asset('/images/common/gps-location.svg')),
            const RawText('&nbsp;'),
            label([.text(event.location.label)]),
          ]),
        ]),
        h3([.text(event.title)]),
        p([.text(event.description)]),
      ]),
    ];

    return div(classes: 'story-item', [
      if (event.link case final eventLink?)
        a(
          href: eventLink,
          target: event.hasExternalLink ? Target.blank : null,
          itemContent,
        )
      else
        div(itemContent),
    ]);
  }

  static final DateFormat _eventDateFormat = .new('MMM d, yyyy', 'en-US');
  static final DateFormat _eventRangeStartFormat = .new('MMM d', 'en-US');

  /// Formats a single calendar date for display on event cards.
  static String _formatDate(DateTime date) => _eventDateFormat.format(date);

  /// Formats an event date span, collapsing same-day events to one date.
  static String _formatDateRange(DateTime startDate, DateTime endDate) {
    if (_isSameDate(startDate, endDate)) return _formatDate(startDate);

    if (startDate.year == endDate.year) {
      return '${_eventRangeStartFormat.format(startDate)} - '
          '${_formatDate(endDate)}';
    }

    return '${_formatDate(startDate)} - ${_formatDate(endDate)}';
  }

  /// Determines whether two [DateTime] values occur on the same calendar date.
  static bool _isSameDate(DateTime startDate, DateTime endDate) =>
      startDate.year == endDate.year &&
      startDate.month == endDate.month &&
      startDate.day == endDate.day;
}
