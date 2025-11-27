// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

class TutorialModel {
  const TutorialModel({
    required this.title,
    required this.units,
  });

  final String title;
  final List<TutorialUnit> units;

  @decoder
  factory TutorialModel.fromMap(Map<Object?, Object?> json) {
    return TutorialModel(
      title: json['title'] as String,
      units: (json['units'] as List<Object?>)
          .map((e) => TutorialUnit.fromMap(e as Map<Object?, Object?>))
          .toList(),
    );
  }

  @encoder
  Map<Object?, Object?> toJson() => {
    'title': title,
    'units': units.map((e) => e.toJson()).toList(),
  };
}

class TutorialUnit {
  const TutorialUnit({
    required this.title,
    required this.chapters,
  });

  final String title;
  final List<TutorialChapter> chapters;

  @decoder
  factory TutorialUnit.fromMap(Map<Object?, Object?> json) {
    return TutorialUnit(
      title: json['title'] as String,
      chapters: (json['chapters'] as List<Object?>)
          .map((e) => TutorialChapter.fromMap(e as Map<Object?, Object?>))
          .toList(),
    );
  }

  @encoder
  Map<Object?, Object?> toJson() => {
    'title': title,
    'chapters': chapters.map((e) => e.toJson()).toList(),
  };
}

class TutorialChapter {
  const TutorialChapter({
    required this.title,
    required this.url,
  });

  final String title;
  final String url;

  @decoder
  factory TutorialChapter.fromMap(Map<Object?, Object?> json) {
    return TutorialChapter(
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }

  @encoder
  Map<Object?, Object?> toJson() => {
    'title': title,
    'url': url,
  };
}
