// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

/// Represents HTML header metadata captured for a route
/// (e.g. title, canonical URL, and meta tags).
@immutable
final class HeaderMetadata {
  /// The `<title>` content of the page.
  final String title;

  /// The `<link rel="canonical" href="...">` value, if present.
  final String? canonical;

  /// All captured `<meta>` tags mapped by name or property to content.
  ///
  /// Examples:
  /// - `description`: `'Learn Flutter...'`
  /// - `og:title`: `'Flutter'`
  /// - `og:image`: `'https://flutter.dev/image.png'`
  /// - `twitter:card`: `'summary_large_image'`
  final Map<String, String> meta;

  const HeaderMetadata({
    this.title = '',
    this.canonical,
    this.meta = const {},
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    if (canonical != null) 'canonical': canonical,
    'meta': meta,
  };

  factory HeaderMetadata.fromJson(Map<String, dynamic> json) => HeaderMetadata(
    title: json['title'] as String? ?? '',
    canonical: json['canonical'] as String?,
    meta:
        (json['meta'] as Map<String, dynamic>?)?.map(
          (k, v) => MapEntry(k, v.toString()),
        ) ??
        const {},
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeaderMetadata &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          canonical == other.canonical &&
          _mapsEqual(meta, other.meta);

  @override
  int get hashCode => Object.hash(
    title,
    canonical,
    Object.hashAllUnordered(
      meta.entries.map((e) => Object.hash(e.key, e.value)),
    ),
  );

  static bool _mapsEqual(Map<String, String> a, Map<String, String> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (b[key] != a[key]) return false;
    }
    return true;
  }
}

/// The type of change detected for a specific header or meta property.
enum HeaderPropertyChangeType {
  added,
  removed,
  modified,
}

/// The diff detail for a single meta or header property.
@immutable
final class HeaderPropertyDiff {
  final HeaderPropertyChangeType type;
  final String? baseline;
  final String? current;

  const HeaderPropertyDiff({
    required this.type,
    this.baseline,
    this.current,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    if (baseline != null) 'baseline': baseline,
    if (current != null) 'current': current,
  };

  factory HeaderPropertyDiff.fromJson(Map<String, dynamic> json) =>
      HeaderPropertyDiff(
        type: HeaderPropertyChangeType.values.byName(
          json['type'] as String? ?? 'modified',
        ),
        baseline: json['baseline'] as String?,
        current: json['current'] as String?,
      );
}

/// The complete diff summary between baseline and current header metadata.
@immutable
final class HeaderDiff {
  final bool titleChanged;
  final String? baselineTitle;
  final String? currentTitle;

  final bool canonicalChanged;
  final String? baselineCanonical;
  final String? currentCanonical;

  final Map<String, HeaderPropertyDiff> metaChanges;

  const HeaderDiff({
    this.titleChanged = false,
    this.baselineTitle,
    this.currentTitle,
    this.canonicalChanged = false,
    this.baselineCanonical,
    this.currentCanonical,
    this.metaChanges = const {},
  });

  bool get hasDiff =>
      titleChanged || canonicalChanged || metaChanges.isNotEmpty;

  Map<String, dynamic> toJson() => {
    'hasDiff': hasDiff,
    'titleChanged': titleChanged,
    if (baselineTitle != null) 'baselineTitle': baselineTitle,
    if (currentTitle != null) 'currentTitle': currentTitle,
    'canonicalChanged': canonicalChanged,
    if (baselineCanonical != null) 'baselineCanonical': baselineCanonical,
    if (currentCanonical != null) 'currentCanonical': currentCanonical,
    'metaChanges': metaChanges.map((k, v) => MapEntry(k, v.toJson())),
  };

  factory HeaderDiff.fromJson(Map<String, dynamic> json) => HeaderDiff(
    titleChanged: json['titleChanged'] as bool? ?? false,
    baselineTitle: json['baselineTitle'] as String?,
    currentTitle: json['currentTitle'] as String?,
    canonicalChanged: json['canonicalChanged'] as bool? ?? false,
    baselineCanonical: json['baselineCanonical'] as String?,
    currentCanonical: json['currentCanonical'] as String?,
    metaChanges:
        (json['metaChanges'] as Map<String, dynamic>?)?.map(
          (k, v) => MapEntry(
            k,
            HeaderPropertyDiff.fromJson(v as Map<String, dynamic>),
          ),
        ) ??
        const {},
  );

  /// Compares [baseline] and [current] metadata and returns a [HeaderDiff].
  static HeaderDiff compare(HeaderMetadata? baseline, HeaderMetadata? current) {
    if (baseline == null && current == null) {
      return const HeaderDiff();
    }

    final bTitle = baseline?.title ?? '';
    final cTitle = current?.title ?? '';
    final titleChanged =
        (baseline != null || current != null) && bTitle != cTitle;

    final bCanonical = baseline?.canonical;
    final cCanonical = current?.canonical;
    final canonicalChanged = bCanonical != cCanonical;

    final metaChanges = <String, HeaderPropertyDiff>{};
    final allMetaKeys = <String>{
      ...?baseline?.meta.keys,
      ...?current?.meta.keys,
    }..toList().sort();

    for (final key in allMetaKeys) {
      final bVal = baseline?.meta[key];
      final cVal = current?.meta[key];

      if (bVal == null && cVal != null) {
        metaChanges[key] = HeaderPropertyDiff(
          type: HeaderPropertyChangeType.added,
          current: cVal,
        );
      } else if (bVal != null && cVal == null) {
        metaChanges[key] = HeaderPropertyDiff(
          type: HeaderPropertyChangeType.removed,
          baseline: bVal,
        );
      } else if (bVal != cVal) {
        metaChanges[key] = HeaderPropertyDiff(
          type: HeaderPropertyChangeType.modified,
          baseline: bVal,
          current: cVal,
        );
      }
    }

    return HeaderDiff(
      titleChanged: titleChanged,
      baselineTitle: baseline?.title,
      currentTitle: current?.title,
      canonicalChanged: canonicalChanged,
      baselineCanonical: baseline?.canonical,
      currentCanonical: current?.canonical,
      metaChanges: metaChanges,
    );
  }
}
