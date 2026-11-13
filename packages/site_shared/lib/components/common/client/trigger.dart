// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import 'expandable.dart';

/// A component that attaches toggle behavior and accessibility attributes
/// to its [child] for an enclosing [Expandable].
///
/// When clicked, this component prevents the default click action and toggles
/// the expanded state of the nearest ancestor [Expandable].
@client
class Trigger extends StatelessComponent {
  /// Creates a trigger that toggles the enclosing [Expandable] when [child]
  /// is clicked.
  const Trigger({required this.child, super.key});

  /// The interactive component that receives click events and accessibility
  /// attributes.
  final Component child;

  @override
  Component build(BuildContext context) {
    final expandable = Expandable.maybeOf(context);
    if (expandable == null) return child;

    return .apply(
      attributes: {
        if (kIsWeb) 'aria-expanded': expandable.expanded ? 'true' : 'false',
      },
      events: {
        'click': (e) {
          e.preventDefault();
          expandable.toggle();
        },
      },
      child: child,
    );
  }
}
