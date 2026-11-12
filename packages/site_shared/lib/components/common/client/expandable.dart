// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

export 'trigger.dart';

@client
class Expandable extends StatefulComponent {
  const Expandable({
    this.id,
    this.initiallyExpanded = true,
    required this.child,
    super.key,
  });

  final String? id;
  final bool initiallyExpanded;
  final Component child;

  @override
  State<Expandable> createState() => _ExpandableState();

  static ExpandableController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_InheritedExpandable>();
  }
}

class _ExpandableState extends State<Expandable> {
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    expanded = component.initiallyExpanded;

    if (kIsWeb) {
      var currentFragment = web.window.location.hash.trim().toLowerCase();
      if (currentFragment.startsWith('#')) {
        // Remove the leading '#' from the fragment.
        currentFragment = currentFragment.substring(1);
      }

      // If the card is the currently specified fragment, expand it.
      if (component.id case final id?
          when currentFragment.isNotEmpty &&
              id.toLowerCase() == currentFragment) {
        expanded = true;
        // Scroll the expanded card into view.
        context.binding.addPostFrameCallback(() {
          web.document.getElementById(id)?.scrollIntoView();
        });
      }
    }
  }

  void toggle() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Component build(BuildContext context) {
    return _InheritedExpandable(
      expanded: expanded,
      toggle: toggle,
      child: .apply(
        classes: expanded ? 'expanded' : null,
        child: component.child,
      ),
    );
  }
}

/// An interface for inspecting and controlling the state of an [Expandable].
abstract interface class ExpandableController {
  /// Whether the expandable container is currently expanded.
  bool get expanded;

  /// Toggles the expanded state of the container.
  VoidCallback get toggle;
}

class _InheritedExpandable extends InheritedComponent
    implements ExpandableController {
  _InheritedExpandable({
    required this.expanded,
    required this.toggle,
    required super.child,
  });

  @override
  final bool expanded;
  @override
  final VoidCallback toggle;

  @override
  bool updateShouldNotify(covariant _InheritedExpandable oldComponent) {
    return expanded != oldComponent.expanded;
  }
}
