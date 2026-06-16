// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part 'events_content.mapper.dart';

/// Featured event card loaded from `events.data.featured`.
///
/// Expected data format:
/// - `title`: non-empty event title.
/// - `description`: non-empty description of the event.
/// - `image`: image asset path under `images/`.
/// - `link`: absolute HTTP(S) URL or root-relative path.
/// - `backgroundColor`: hex color in `#RRGGBB` or `#RRGGBBAA`.
@MappableClass()
class FeaturedEvent with FeaturedEventMappable {
  FeaturedEvent({
    required this.title,
    required this.description,
    required this.image,
    required this.link,
    required this.backgroundColor,
  }) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(
      isNotBlank(description),
      'description must be a non-empty string.',
    );
    checkFormat(isNotBlank(image), 'image must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(image),
      'image must be an image asset path under images/.',
    );
    checkFormat(isNotBlank(link), 'link must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(link),
      'link must be an absolute http(s) URL or a root-relative path.',
    );
    checkFormat(
      isNotBlank(backgroundColor),
      'backgroundColor must be a non-empty string.',
    );
    checkFormat(
      isHexColor(backgroundColor),
      'backgroundColor must be a hex color in #RRGGBB or #RRGGBBAA format.',
    );
  }

  /// Event title shown on the featured card.
  final String title;

  /// Description of the event.
  final String description;

  /// Card image asset path.
  final String image;

  /// Destination URL/path for the card.
  final String link;

  /// Background color value applied to the card.
  final String backgroundColor;

  /// Whether the [link] is an external link and should open in a new tab.
  bool get hasExternalLink => Uri.tryParse(link)?.host.isNotEmpty ?? false;

  /// Parses a featured event model from YAML/JSON data.
  static FeaturedEvent fromJson(Map<String, Object?> json) =>
      FeaturedEventMapper.fromMap(json);
}

/// Calendar event row loaded from `events.data.calendar`.
///
/// Expected data format:
/// - `title`: non-empty event title.
/// - `description`: non-empty description of the event.
/// - `startDate`: ISO8601 date string in `yyyy-mm-dd` format.
/// - `endDate`: ISO8601 date string in `yyyy-mm-dd` format,
///   on or after `startDate`.
/// - `link`: optional absolute HTTP(S) URL or root-relative path.
/// - `card`: image asset path under `images/`.
/// - `location`: one of the [EventLocation] labels
///    (`LATAM`, `NA`, `EMEA`, `APAC`, or `Virtual`).
/// - `host`: one of the [EventHost] labels
///    (`Industry`, `Google`, or `Community`).
@MappableClass()
class CalendarEvent with CalendarEventMappable {
  CalendarEvent({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.card,
    required this.location,
    required this.host,
    this.link,
    this.backgroundColor,
  }) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(
      startDate == DateTime(startDate.year, startDate.month, startDate.day),
      'startDate must be a date-only value.',
    );
    checkFormat(
      endDate == DateTime(endDate.year, endDate.month, endDate.day),
      'endDate must be a date-only value.',
    );
    checkFormat(
      !endDate.isBefore(startDate),
      'endDate must be on or after startDate.',
    );
    checkFormat(
      isNotBlank(description),
      'description must be a non-empty string.',
    );
    checkFormat(isNotBlank(card), 'card must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(card),
      'card must be an image asset path under images/.',
    );
    if (link case final link?) {
      checkFormat(isNotBlank(link), 'link must be a non-empty string.');
      checkFormat(
        isAbsoluteHttpUrlOrBaseHrefRelativePath(link),
        'link must be an absolute http(s) URL or a root-relative path.',
      );
    }
    if (backgroundColor case final color?) {
      checkFormat(
        isHexColor(color),
        'backgroundColor must be a valid hex color.',
      );
    }
  }

  /// Event title displayed in the calendar grid.
  final String title;

  /// The first date of the event.
  final DateTime startDate;

  /// The final date of the event.
  final DateTime endDate;

  /// Description of the event.
  final String description;

  /// Card image asset path.
  final String card;

  /// Filter value for event location.
  final EventLocation location;

  /// Filter value for event host.
  final EventHost host;

  /// The URL where users can learn more about the event.
  final String? link;

  /// Optional background color applied to the image container.
  final String? backgroundColor;

  /// Whether the [link] is an external link and should open in a new tab.
  bool get hasExternalLink {
    if (link case final link?) {
      return Uri.tryParse(link)?.host.isNotEmpty ?? false;
    }
    return false;
  }

  /// Parses a calendar event model from YAML/JSON data.
  static CalendarEvent fromJson(Map<String, Object?> json) {
    checkFormat(
      !json.containsKey('date'),
      'date is not supported. Use startDate and endDate instead.',
    );
    return CalendarEventMapper.fromMap(json);
  }
}

/// Supported regions used to filter events on the events page.
///
/// Serialized values match the abbreviations used in the YAML data and
/// the labels rendered in the events filter UI.
@MappableEnum(caseStyle: CaseStyle.upperCase)
enum EventLocation {
  /// Latin America.
  latam,

  /// North America.
  na,

  /// Europe, the Middle East, and Africa.
  emea,

  /// Asia-Pacific.
  apac,

  /// Online or virtual events not tied to a specific region.
  @MappableValue('Virtual')
  virtual;

  /// Human-readable label used in YAML and filter UIs.
  String get label => toValue() as String;
}

/// Supported event hosts used to filter events on the events page.
@MappableEnum(caseStyle: CaseStyle.pascalCase)
enum EventHost {
  /// Events hosted by industry partners or third-parties.
  industry,

  /// Events hosted by Google.
  google,

  /// Events hosted by the Flutter community.
  community;

  /// Human-readable label used in YAML and filter UIs.
  String get label => toValue();
}
