// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:universal_web/web.dart' as web;

/// Separator used to join task descriptions into a single `data-tasks`
/// attribute, so they can be recovered on the client.
const _taskSeparator = '|';

/// Prefix used for the DOM id of each journey's card element.
const _elementIdPrefix = 'cuj-';

final class Cuj {
  Cuj({
    required this.id,
    required this.goal,
    required this.persona,
    required this.tasks,
  });

  /// Creates a [Cuj] from a Map, used on the server
  /// when parsing the yaml data files.
  factory Cuj.fromMap(Map<String, Object?> map) {
    return Cuj(
      id: '${map['id']}',
      goal: map['goal'] as String,
      persona: CujPersona.fromDataValue(map['persona'] as String?),
      tasks: [
        for (final task in (map['tasks'] as List<Object?>?) ?? const [])
          CujTask.fromMap(task as Map<String, Object?>),
      ],
    );
  }

  /// Creates a [Cuj] from a DOM Element, used on the client
  /// for recreating and filtering existing journeys.
  factory Cuj.fromElement(web.Element element) {
    final dataPersona = element.getAttribute('data-persona') ?? '';
    final dataGoal = element.getAttribute('data-goal') ?? '';
    final dataTasks = element.getAttribute('data-tasks') ?? '';

    return Cuj(
      id: element.id.replaceFirst(_elementIdPrefix, ''),
      goal: dataGoal,
      persona: CujPersona.fromName(dataPersona),
      tasks: [
        for (final task in dataTasks.split(_taskSeparator))
          if (task.trim().isNotEmpty) CujTask(id: '', name: '', task: task),
      ],
    );
  }

  final String id;
  final String goal;
  final CujPersona? persona;
  final List<CujTask> tasks;

  /// The identifier of the card element that renders this journey.
  String get elementId => '$_elementIdPrefix$id';

  /// The task descriptions, joined for storage in a `data-tasks` attribute.
  String get taskData => tasks.map((task) => task.task).join(_taskSeparator);
}

final class CujTask {
  CujTask({required this.id, required this.name, required this.task});

  factory CujTask.fromMap(Map<String, Object?> map) {
    return CujTask(
      id: '${map['id']}',
      name: map['name'] as String? ?? '',
      task: map['task'] as String? ?? '',
    );
  }

  final String id;
  final String name;
  final String task;
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

  /// Looks up a persona by the value used in the yaml data file.
  static CujPersona? fromDataValue(String? dataValue) {
    for (final persona in values) {
      if (persona.dataValue == dataValue) {
        return persona;
      }
    }
    return null;
  }

  /// Looks up a persona by its enum name, as stored in the DOM.
  static CujPersona? fromName(String name) {
    for (final persona in values) {
      if (persona.name == name) {
        return persona;
      }
    }
    return null;
  }

  final String label;
  final String dataValue;

  /// The `.pill-sm` color modifier used for this persona's badge.
  final String pillClass;
}
