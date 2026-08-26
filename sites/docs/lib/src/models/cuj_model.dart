// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:universal_web/web.dart' as web;

/// Prefix used for the DOM ID of each journey's card element.
const _elementIdPrefix = 'cuj-';

/// A critical user journey and its associated tasks.
final class Cuj {
  const Cuj._({
    required this.id,
    required this.goal,
    required this.persona,
    required this.tasks,
  });

  /// Creates a journey from YAML-backed page data.
  factory Cuj.fromMap(Map<String, Object?> map) {
    return Cuj._(
      id: map['id'] as int,
      goal: map['goal'] as String,
      persona: CujPersona.fromDataValue(map['persona'] as String),
      tasks: [
        for (final task in map['tasks'] as List<Object?>)
          CujTask.fromMap(task as Map<String, Object?>),
      ],
    );
  }

  /// Creates a journey from data attributes on [element].
  factory Cuj.fromElement(web.Element element) {
    final dataPersona =
        element.getAttribute('data-persona') ??
        (throw StateError('CUJ card ${element.id} has no persona.'));
    final dataGoal =
        element.getAttribute('data-goal') ??
        (throw StateError('CUJ card ${element.id} has no goal.'));
    final dataTasks =
        element.getAttribute('data-tasks') ??
        (throw StateError('CUJ card ${element.id} has no tasks.'));

    return Cuj._(
      id: int.parse(element.id.replaceFirst(_elementIdPrefix, '')),
      goal: dataGoal,
      persona: CujPersona.values.byName(dataPersona),
      tasks: [
        for (final task in jsonDecode(dataTasks) as List<Object?>)
          CujTask.fromMap(task as Map<String, Object?>),
      ],
    );
  }

  /// The stable numeric identifier for this journey.
  final int id;

  /// The developer goal that this journey represents.
  final String goal;

  /// The developer persona associated with this journey.
  final CujPersona persona;

  /// The tasks that contribute to [goal].
  final List<CujTask> tasks;

  /// The identifier of the card element that renders this journey.
  String get elementId => '$_elementIdPrefix$id';
}

/// A concrete task within a critical user journey.
final class CujTask {
  const CujTask({
    required this.id,
    required this.name,
    required this.task,
  });

  /// Creates a task from YAML-backed page data or decoded JSON.
  factory CujTask.fromMap(Map<String, Object?> map) {
    return CujTask(
      id: map['id'] as int,
      name: map['name'] as String,
      task: map['task'] as String,
    );
  }

  /// The stable numeric identifier for this task.
  final int id;

  /// The stable machine-readable name of this task.
  final String name;

  /// The reader-facing task description.
  final String task;

  /// A JSON-compatible representation of this task.
  Map<String, Object> toJson() => {
    'id': id,
    'name': name,
    'task': task,
  };
}

/// The developer personas a critical user journey can belong to.
///
/// [dataValue] must match the `persona` values used in `src/data/cujs.yaml`.
enum CujPersona {
  appDeveloper('App developer', 'The App Developer', 'flutter-blue'),
  techLead('Tech lead / architect', 'The Tech Lead / Architect', 'purple'),
  pluginDeveloper('Plugin developer', 'The Plugin Developer', 'teal'),
  fullStackDeveloper(
    'Full-stack developer',
    'The Full Stack Developer',
    'magenta',
  ),
  hybridDeveloper(
    'Hybrid (native + Flutter) developer',
    'The Hybrid (Native + Flutter) Developer',
    'amber',
  );

  const CujPersona(this.label, this.dataValue, this.pillClass);

  /// Returns the persona whose [dataValue] matches the YAML data.
  ///
  /// Throws an [ArgumentError] if the value is unknown.
  static CujPersona fromDataValue(String dataValue) {
    for (final persona in values) {
      if (persona.dataValue == dataValue) {
        return persona;
      }
    }
    throw ArgumentError.value(dataValue, 'dataValue', 'Unknown CUJ persona');
  }

  /// The reader-facing name of this persona.
  final String label;

  /// The persona value used in `cujs.yaml`.
  final String dataValue;

  /// The `.pill-sm` color modifier used for this persona's badge.
  final String pillClass;
}
