// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

class SummaryCardModel {
  const SummaryCardModel({
    required this.title,
    this.subtitle,
    this.completed = false,
    required this.items,
  });

  final String title;
  final String? subtitle;
  final bool completed;
  final List<SummaryCardItem> items;

  @decoder
  factory SummaryCardModel.fromMap(Map<Object?, Object?> json) {
    return SummaryCardModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      completed: json['completed'] as bool? ?? false,
      items: (json['items'] as List<Object?>)
          .map((e) => SummaryCardItem.fromMap(e as Map<Object?, Object?>))
          .toList(),
    );
  }

  @encoder
  Map<Object?, Object?> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'completed': completed,
    'items': items.map((e) => e.toJson()).toList(),
  };
}

class SummaryCardItem {
  const SummaryCardItem({
    required this.title,
    required this.icon,
    this.details,
  });

  final String title;
  final String icon;
  final String? details;

  @decoder
  factory SummaryCardItem.fromMap(Map<Object?, Object?> json) {
    return SummaryCardItem(
      title: json['title'] as String,
      icon: json['icon'] as String,
      details: json['details'] as String?,
    );
  }

  @encoder
  Map<Object?, Object?> toJson() => {
    'title': title,
    'icon': icon,
    'details': details,
  };
}
