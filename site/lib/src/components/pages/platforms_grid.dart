// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
      link,
    ) = switch (attributes) {
      {
        'name': final String name,
        'icon': final String icon,
        'arch': final String arch,
        'supported': final String supported,
        'ci-tested': final String ciTested,
        'unsupported': final String unsupported,
        'link': final String link,
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
          link,
        ),
      _ => throw ArgumentError(
        'PlatformCard must have a name, icon, arch, supported, '
        'ci-tested, unsupported, and link attribute.',
      ),
    };

    final deployName = switch (RegExp(r'^.*\((.+)\)$').firstMatch(name)) {
      final Match match => match.group(1)!,
      _ => name,
    };

    return div(classes: 'platform-card', [
      div(classes: 'platform-card-header', [
        span([
          MaterialIcon(icon),
        ]),
        h3([text(name)]),
        Button(
          content: 'Deploy to $deployName',
          href: link,
        ),
      ]),
      div(classes: 'platform-card-tags', [
        for (final a in arch) span([text(a)]),
      ]),

      div(classes: 'platform-card-details', [
        span([
          span(classes: 'platform-card-supported', [text('Supported')]),
          span([DashMarkdown(inline: true, content: supported)]),
        ]),
        span([
          span(classes: 'platform-card-ci-tested', [text('CI tested')]),
          span([text(ciTested)]),
        ]),
        span([
          span(classes: 'platform-card-unsupported', [text('Unsupported')]),
          span([text(unsupported)]),
        ]),
      ]),
    ]);
  }
}
