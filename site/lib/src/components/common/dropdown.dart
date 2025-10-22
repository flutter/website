// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import 'package:universal_web/web.dart' as web;

import '../util/global_event_listener.dart';

/// The root component of a dropdown in a client component.
///
/// Should include a [DropdownToggle] and [DropdownContent]
/// as children.
final class Dropdown extends StatefulComponent {
  const Dropdown({required this.id, required this.children});

  final String id;
  final List<Component> children;

  @override
  State<Dropdown> createState() => _DropdownState();
}

final class _DropdownState extends State<Dropdown> {
  bool _expanded = false;

  void toggle({bool? to}) {
    setState(() {
      _expanded = to ?? !_expanded;
    });
  }

  @override
  Component build(BuildContext _) {
    return GlobalEventListener(
      onClick: (event) {
        if (!_expanded) return;
        final target = event.target as web.HTMLElement?;
        if (target == null || target.closest('#${component.id}') == null) {
          toggle(to: false);
        }
      },
      _DropdownRoot(
        id: component.id,
        expanded: _expanded,
        toggle: toggle,
        child: div(
          id: component.id,
          classes: 'dropdown',
          attributes: {'data-expanded': _expanded.toString()},
          events: {
            'keydown': (e) {
              final keydownEvent = e as web.KeyboardEvent;
              if (_expanded && keydownEvent.key == 'Escape') {
                toggle(to: false);
              }
            },
            'focusout': (e) {
              final relatedTarget =
                  (e as web.FocusEvent).relatedTarget as web.HTMLElement?;
              if (relatedTarget != null &&
                  relatedTarget.closest('#${component.id}') == null) {
                toggle(to: false);
              }
            },
          },
          component.children,
        ),
      ),
    );
  }
}

final class DropdownToggle extends StatelessComponent {
  const DropdownToggle(this.child);

  final Component child;

  @override
  Component build(BuildContext context) {
    final root = _DropdownRoot.of(context);

    return Component.wrapElement(
      child: child,
      classes: 'dropdown-button',
      events: {
        'click': (e) {
          root.toggle();
        },
      },
      attributes: {
        'aria-controls': root.contentId,
        'aria-expanded': root.expanded.toString(),
      },
    );
  }
}

final class DropdownContent extends StatelessComponent {
  const DropdownContent(this.child);

  final Component child;

  @override
  Component build(BuildContext context) => div(
    id: _DropdownRoot.of(context).contentId,
    classes: 'dropdown-content',
    [child],
  );
}

final class _DropdownRoot extends InheritedComponent {
  const _DropdownRoot({
    required this.id,
    required this.toggle,
    this.expanded = false,
    required super.child,
  });

  final String id;
  final bool expanded;
  final void Function({bool? to}) toggle;

  String get contentId => '$id-content';

  @override
  bool updateShouldNotify(_DropdownRoot oldRoot) =>
      expanded != oldRoot.expanded;

  static _DropdownRoot of(BuildContext context) =>
      context.dependOnInheritedComponentOfExactType<_DropdownRoot>()!;
}
