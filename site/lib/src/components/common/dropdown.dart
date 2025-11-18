// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'package:universal_web/web.dart' as web;

import '../util/global_event_listener.dart';

/// A dropdown with a toggle button and expandable content.
final class Dropdown extends StatefulComponent {
  const Dropdown({
    required this.id,
    required this.toggle,
    required this.content,
    this.expanded,
    super.key,
  });

  final String id;
  final Component toggle;
  final Component content;
  final bool? expanded;

  @override
  State<Dropdown> createState() => DropdownState();
}

final class DropdownState extends State<Dropdown> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    if (component.expanded != null) {
      _expanded = component.expanded!;
    }
  }

  @override
  void didUpdateComponent(Dropdown oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.expanded != null) {
      _expanded = component.expanded!;
    }
  }

  void toggle({bool? to}) {
    setState(() {
      _expanded = to ?? !_expanded;
    });
  }

  @override
  Component build(BuildContext _) {
    return GlobalEventListener(
      onClick: component.expanded == null
          ? (event) {
              if (!_expanded) return;
              final target = event.target as web.HTMLElement?;
              if (target == null ||
                  target.closest('#${component.id}') == null) {
                toggle(to: false);
              }
            }
          : null,
      div(
        id: component.id,
        classes: 'dropdown',
        attributes: {'data-expanded': _expanded.toString()},
        events: component.expanded == null
            ? {
                'keydown': (e) {
                  final keydownEvent = e as web.KeyboardEvent;
                  if (_expanded && keydownEvent.key == 'Escape') {
                    toggle(to: false);
                  }
                },
                'focusout': (e) {
                  final relatedTarget =
                      (e as web.FocusEvent).relatedTarget as web.HTMLElement?;
                  if (relatedTarget == null ||
                      relatedTarget.closest('#${component.id}') == null) {
                    toggle(to: false);
                  }
                },
              }
            : null,
        [
          Component.wrapElement(
            classes: 'dropdown-button',
            events: component.expanded == null
                ? {
                    'click': (e) {
                      toggle();
                    },
                  }
                : null,
            attributes: {
              'aria-controls': '${component.id}-content',
              'aria-expanded': _expanded.toString(),
            },
            child: component.toggle,
          ),
          div(id: '${component.id}-content', classes: 'dropdown-content', [
            component.content,
          ]),
        ],
      ),
    );
  }
}
