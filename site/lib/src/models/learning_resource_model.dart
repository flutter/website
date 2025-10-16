// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

final class LearningResource {
  final String name;
  final String description;
  final LearningResourceType type;
  final List<LearningResourceTag> tags;
  final ({String url, LearningResourceSource source}) link;
  final String? imageUrl;

  LearningResource({
    required this.name,
    required this.description,
    required this.type,
    required this.tags,
    required this.link,
    this.imageUrl,
  });
}

enum LearningResourceType {
  recipe('cookbook', 'Cookbook recipe'),
  sample('demo', 'Demo'),
  tutorial('codelab', 'Codelab'),
  workshop('workshop', 'Workshop');

  const LearningResourceType(this.id, this.formattedName);

  final String id;
  final String formattedName;
}

enum LearningResourceTag {
  ai('ai', 'AI'),
  animation('animation', 'Animation'),
  architecture('architecture', 'Architecture'),
  cupertino('cupertino', 'Cupertino'),
  dart('dart', 'Dart'),
  design('design', 'Design'),
  desktop('desktop', 'Desktop'),
  firebase('firebase', 'Firebase'),
  goodForBeginners('good-for-beginners', 'Good for beginners'),
  googleApis('google-apis', 'Google APIs'),
  ios('ios', 'iOS'),
  layout('layout', 'Layout'),
  material('material', 'Material'),
  routingAndNavigation('routing-and-navigation', 'Routing and navigation'),
  stateManagement('state-management', 'State management'),
  testing('testing', 'Testing'),
  web('web', 'Web'),
  widgets('widgets', 'Widgets');

  const LearningResourceTag(this.id, this.formattedName);

  final String id;
  final String formattedName;
}

enum LearningResourceSource {
  dartDocs,
  flutterDocs,
  gitHub,
  youTube,
  googleCodelab,
  medium,
}
