// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

import 'diff_entry.dart';

/// The complete visual regression manifest summarizing all compared routes.
@immutable
final class DiffManifest {
  /// The site identifier, e.g. `docs` or `www`.
  final String site;

  /// When the diff run completed.
  final DateTime timestamp;

  /// The baseline git branch or ref used.
  final String baseRef;

  /// Total number of screenshot pairs evaluated.
  final int totalCount;

  /// Number of screenshots with visual differences.
  final int changedCount;

  /// Number of screenshots with header metadata differences
  /// (such as title, canonical URL, or meta tags).
  final int metadataChangedCount;

  /// Number of newly introduced screenshots.
  final int addedCount;

  /// Number of removed screenshots.
  final int removedCount;

  /// Number of identical screenshots.
  final int unchangedCount;

  /// All compared screenshot entries.
  final List<DiffEntry> entries;

  /// Whether any visual differences, metadata changes, additions, or removals
  /// were detected.
  bool get hasDiff =>
      changedCount > 0 ||
      addedCount > 0 ||
      removedCount > 0 ||
      metadataChangedCount > 0;

  const DiffManifest({
    required this.site,
    required this.timestamp,
    required this.baseRef,
    required this.totalCount,
    required this.changedCount,
    this.metadataChangedCount = 0,
    required this.addedCount,
    required this.removedCount,
    required this.unchangedCount,
    required this.entries,
  });

  factory DiffManifest.fromEntries({
    required String site,
    required String baseRef,
    required List<DiffEntry> entries,
    DateTime? timestamp,
  }) {
    var changed = 0;
    var metadataChanged = 0;
    var added = 0;
    var removed = 0;
    var unchanged = 0;

    for (final entry in entries) {
      if (entry.hasHeaderDiff) {
        metadataChanged++;
      }
      switch (entry.status) {
        case DiffStatus.changed:
          changed++;
        case DiffStatus.added:
          added++;
        case DiffStatus.removed:
          removed++;
        case DiffStatus.unchanged:
          unchanged++;
      }
    }

    return DiffManifest(
      site: site,
      timestamp: timestamp ?? DateTime.now(),
      baseRef: baseRef,
      totalCount: entries.length,
      changedCount: changed,
      metadataChangedCount: metadataChanged,
      addedCount: added,
      removedCount: removed,
      unchangedCount: unchanged,
      entries: entries,
    );
  }

  Map<String, dynamic> toJson() => {
    'site': site,
    'timestamp': timestamp.toIso8601String(),
    'baseRef': baseRef,
    'totalCount': totalCount,
    'changedCount': changedCount,
    'metadataChangedCount': metadataChangedCount,
    'addedCount': addedCount,
    'removedCount': removedCount,
    'unchangedCount': unchangedCount,
    'entries': entries.map((e) => e.toJson()).toList(),
  };

  factory DiffManifest.fromJson(Map<String, dynamic> json) => DiffManifest(
    site: json['site'] as String? ?? 'docs',
    timestamp: json['timestamp'] != null
        ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
        : DateTime.now(),
    baseRef: json['baseRef'] as String? ?? 'main',
    totalCount: json['totalCount'] as int? ?? 0,
    changedCount: json['changedCount'] as int? ?? 0,
    metadataChangedCount: json['metadataChangedCount'] as int? ?? 0,
    addedCount: json['addedCount'] as int? ?? 0,
    removedCount: json['removedCount'] as int? ?? 0,
    unchangedCount: json['unchangedCount'] as int? ?? 0,
    entries:
        (json['entries'] as List<dynamic>?)
            ?.map((e) => DiffEntry.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
  );

  /// Saves this manifest as JSON to [file].
  void saveToFile(File file) {
    if (!file.parent.existsSync()) {
      file.parent.createSync(recursive: true);
    }
    const encoder = JsonEncoder.withIndent('  ');
    file.writeAsStringSync(encoder.convert(toJson()));
  }

  /// Loads a [DiffManifest] from [file].
  static DiffManifest loadFromFile(File file) {
    final contents = file.readAsStringSync();
    final json = jsonDecode(contents) as Map<String, dynamic>;
    return DiffManifest.fromJson(json);
  }
}
