// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../markdown/markdown_parser.dart';
import '../common/button.dart';
import '../common/material_icon.dart';

class PlatformsGrid extends CustomComponentBase {
  const PlatformsGrid();

  @override
  Pattern get pattern => 'PlatformsGrid';

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    return div(classes: 'platforms-grid', [
      ?child,
    ]);
  }
}

class PlatformCard extends CustomComponentBase {
  const PlatformCard();

  @override
  Pattern get pattern => 'PlatformCard';

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    final (
      name,
      icon,
      arch,
      supported,
      ciTested,
      unsupported,
      deployToLink,
    ) = switch (attributes) {
      {
        'name': final String name,
        'icon': final String icon,
        'arch': final String arch,
        'supported': final String supported,
        'ci-tested': final String ciTested,
        'unsupported': final String unsupported,
        'deploy-to-link': final String deployToLink,
      } =>
        (
          name,
          icon,
          arch
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList(),
          supported,
          ciTested,
          unsupported,
          deployToLink,
        ),
      _ => throw ArgumentError(
        'PlatformCard must have a name, icon, arch, supported, '
        'ci-tested, unsupported, and deploy-to-link attribute.',
      ),
    };

    final deployTo = attributes['deploy-to'] ?? name;

    return div(classes: 'platform-card', [
      div(classes: 'platform-card-header', [
        span([
          MaterialIcon(icon),
        ]),
        h3([.text(name)]),
        Button(
          content: 'Deploy to $deployTo',
          href: deployToLink,
        ),
      ]),
      div(classes: 'platform-card-tags', [
        for (final a in arch) span([.text(a)]),
      ]),

      div(classes: 'platform-card-details', [
        span([
          const span(classes: 'platform-card-supported', [.text('Supported')]),
          span([DashMarkdown(inline: true, content: supported)]),
        ]),
        span([
          const span(classes: 'platform-card-ci-tested', [.text('CI tested')]),
          span([.text(ciTested)]),
        ]),
        span([
          const span(classes: 'platform-card-unsupported', [
            .text('Unsupported'),
          ]),
          span([.text(unsupported)]),
        ]),
      ]),
    ]);
  }
}
