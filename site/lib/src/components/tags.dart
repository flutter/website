// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import 'material_icon.dart';

/// A display of multiple categorical or descriptive tags.
class Tags extends StatelessComponent {
  const Tags(this.tags);

  final List<Tag> tags;

  @override
  Component build(BuildContext context) =>
      div(classes: 'tags', [for (final tag in tags) tag]);
}

/// An individual tag to categorize an item,
/// such as the type of an individual lint.
///
/// Generally displayed within a [Tags] component.
class Tag extends StatelessComponent {
  const Tag(this.content, {this.icon, this.title, this.label, this.color});

  final String content;
  final String? icon;
  final String? title;
  final String? label;
  final String? color;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'tag-label',
      attributes: {
        'title': ?title,
        'aria-label': ?(label ?? title),
      },
      [
        if (icon case final iconId?) MaterialIcon(iconId),
        span([text(content)]),
      ],
    );
  }
}
