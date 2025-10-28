// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:universal_web/web.dart' as web;

final class LearningResource {
  LearningResource({
    required this.name,
    required this.description,
    required this.type,
    required this.tags,
    this.link,
    this.imageUrl,
  });

  /// Creates a [LearningResource] from a Map, used on the server
  /// when parsing the yaml data files.
  factory LearningResource.fromMap(Map<String, Object?> map) {
    return LearningResource(
      name: map['name'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      tags: (map['tags'] as List<Object?>?)?.cast<String>() ?? [],
      link: (
        label: (map['link'] as Map<String, Object?>)['label'] as String,
        url: (map['link'] as Map<String, Object?>)['url'] as String,
      ),
      imageUrl: map['imageUrl'] as String?,
    );
  }

  /// Creates a [LearningResource] from a DOM Element, used on the client
  /// for recreating and filtering existing resources.
  factory LearningResource.fromElement(web.Element element) {
    final dataType = element.getAttribute('data-type') ?? '';
    final dataTags = element.getAttribute('data-tags') ?? '';
    final dataDescription = element.getAttribute('data-description') ?? '';

    return LearningResource(
      name: element.id,
      type: dataType,
      tags: dataTags.split(',').map((t) => t.trim().toLowerCase()).toList(),
      description: dataDescription,
    );
  }

  final String name;
  final String description;
  final String type;
  final List<String> tags;
  final ({String url, String label})? link;
  final String? imageUrl;
}

enum LearningResourceType {
  tutorial('Tutorial', ['codelab', 'tutorial']),
  sampleCode('Sample code', ['quickstart', 'demo', 'sample', 'sample code']),
  workshop('Workshop', ['workshop', 'video']),
  recipe('Recipe', ['recipe', 'how to', 'cookbook']);

  const LearningResourceType(this.label, this.tags);

  final String label;
  final List<String> tags;
}

enum LearningResourceTag {
  ai('AI', ['ai', 'gemini', 'llm']),
  animation('Animation', ['animations', 'animate', 'animation']),
  architecture('Architecture', [
    'state-management',
    'architecture',
    'provider',
    'bloc',
    'stream',
  ]),
  cupertino('Cupertino', ['cupertino', 'ios', 'macos']),
  design('Design', ['design', 'widgets']),
  desktop('Desktop', ['windows', 'macos', 'linux']),
  firebase('Firebase', ['firebase', 'firestore', 'cloud']),
  goodForBeginners('Good for beginners', ['beginner', 'beginners']),
  googleApis('Google APIs', ['google', 'gemini', 'maps', 'firebase', 'cloud']),
  ios('iOS', ['cupertino', 'ios']),
  layout('Layout', ['layout', 'lists', 'scrolling', 'widgets']),
  material('Material', ['material', 'android']),
  routingAndNavigation('Routing and navigation', [
    'routing',
    'route',
    'navigation',
    'navigator',
  ]),
  stateManagement('State management', [
    'state-management',
    'architecture',
    'provider',
    'bloc',
    'stream',
  ]),
  testing('Testing', ['testing', 'tests', 'test', 'perf', 'performance']),
  web('Web', ['web', 'wasm']),
  widgets('Widgets', ['widgets', 'layout']);

  const LearningResourceTag(this.label, this.tags);

  final String label;
  final List<String> tags;
}
