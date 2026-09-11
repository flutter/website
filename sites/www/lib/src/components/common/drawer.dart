// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import 'icon.dart';

/// The viewport edge a [Drawer] slides in from.
enum DrawerSide {
  /// The leading edge, which is the left edge in left-to-right locales.
  start,

  /// The trailing edge, which is the right edge in left-to-right locales.
  end,
}

/// A panel that slides in from an edge of the viewport,
/// covering the page behind a dimmed scrim.
///
/// The drawer stays mounted while closed so both the enter
/// and exit transitions can run, and so the content remains
/// visible while the drawer animates away.
/// Control its visibility with [isOpen] and
/// react to dismissals — the scrim, the close button,
/// or the <kbd>Escape</kbd> key — with [onClose].
class Drawer extends StatefulComponent {
  const Drawer(
    this.children, {
    required this.id,
    required this.isOpen,
    required this.onClose,
    required this.title,
    this.subtitle,
    this.titleVisible = true,
    this.side = DrawerSide.end,
    this.classes,
    super.key,
  });

  /// The contents of the scrollable region below the header.
  final List<Component> children;

  /// A page-unique identifier used to derive the drawer's element IDs.
  ///
  /// Supplied by the caller rather than generated, so the IDs
  /// rendered on the server match the ones the client hydrates with.
  final String id;

  /// Whether the drawer is currently shown.
  final bool isOpen;

  /// Called when the user dismisses the drawer.
  ///
  /// The drawer doesn't close itself, so the owner
  /// must set [isOpen] to `false` in response.
  final void Function() onClose;

  /// The heading shown in the drawer header,
  /// which also labels the dialog for screen readers.
  final String title;

  /// Optional supporting text shown beneath the [title].
  final String? subtitle;

  /// Whether to render [title] and [subtitle] in the header.
  ///
  /// Set this to `false` when [children] already provide a heading. The
  /// [title] still names the dialog for screen readers.
  final bool titleVisible;

  /// The viewport edge the drawer slides in from.
  final DrawerSide side;

  /// Extra classes to apply to the drawer's root element.
  final String? classes;

  @override
  State<Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  String get _titleId => '${component.id}-title';
  String get _panelId => '${component.id}-panel';
  String get _closeButtonId => '${component.id}-close';

  StreamSubscription<web.KeyboardEvent>? _keyDownSubscription;

  /// The element focused before the drawer opened, restored on close.
  web.Element? _previouslyFocused;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    _keyDownSubscription = web.EventStreamProviders.keyDownEvent
        .forTarget(web.document)
        .listen(_onKeyDown);

    if (component.isOpen) _handleOpened();
  }

  @override
  void didUpdateComponent(covariant Drawer oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (!kIsWeb || oldComponent.isOpen == component.isOpen) return;

    if (component.isOpen) {
      _handleOpened();
    } else {
      _handleClosed();
    }
  }

  @override
  void dispose() {
    if (_keyDownSubscription case final subscription?) {
      unawaited(subscription.cancel());
    }
    if (kIsWeb && component.isOpen) {
      _unlockPageScroll();
    }
    super.dispose();
  }

  void _onKeyDown(web.KeyboardEvent event) {
    if (!component.isOpen) return;

    switch (event.key) {
      case 'Escape':
        event.preventDefault();
        component.onClose();
      case 'Tab':
        _trapFocus(event);
    }
  }

  /// Keeps tabbing inside the dialog, as required for a modal.
  void _trapFocus(web.KeyboardEvent event) {
    final focusable = _focusableElements();
    if (focusable.isEmpty) return;

    final first = focusable.first;
    final last = focusable.last;
    final active = web.document.activeElement;

    if (event.shiftKey && (active == null || active == first)) {
      event.preventDefault();
      last.focus();
    } else if (!event.shiftKey && active == last) {
      event.preventDefault();
      first.focus();
    }
  }

  List<web.HTMLElement> _focusableElements() {
    final panel = web.document.getElementById(_panelId);
    if (panel == null) return const [];

    final nodes = panel.querySelectorAll(
      'a[href], button:not([disabled]), input:not([disabled]), '
      'select:not([disabled]), textarea:not([disabled]), [tabindex="0"]',
    );

    return [
      for (var i = 0; i < nodes.length; i++)
        if (nodes.item(i) case final web.HTMLElement element) element,
    ];
  }

  void _handleOpened() {
    _previouslyFocused = web.document.activeElement;
    _lockPageScroll();
    // The close button is only focusable once the drawer
    // is no longer inert, which happens after the DOM updates.
    Timer.run(() {
      if (!component.isOpen) return;
      (web.document.getElementById(_closeButtonId) as web.HTMLElement?)
          ?.focus();
    });
  }

  void _handleClosed() {
    _unlockPageScroll();
    (_previouslyFocused as web.HTMLElement?)?.focus();
    _previouslyFocused = null;
  }

  void _lockPageScroll() {
    web.document.body?.style.overflow = 'hidden';
  }

  void _unlockPageScroll() {
    web.document.body?.style.removeProperty('overflow');
  }

  @override
  Component build(BuildContext context) {
    final isOpen = component.isOpen;

    return div(
      classes: [
        'drawer',
        'drawer--${component.side.name}',
        if (isOpen) 'drawer--open',
        ...?component.classes?.split(' '),
      ].join(' '),
      [
        div(
          classes: 'drawer__scrim',
          attributes: const {'aria-hidden': 'true'},
          events: {'click': (_) => component.onClose()},
          const [],
        ),
        aside(
          id: _panelId,
          classes: 'drawer__panel',
          attributes: {
            'role': 'dialog',
            'aria-modal': 'true',
            if (component.titleVisible)
              'aria-labelledby': _titleId
            else
              'aria-label': component.title,
            'tabindex': '-1',
            // Keeps the offscreen drawer out of the tab order
            // and hidden from assistive technology.
            if (!isOpen) 'inert': '',
          },
          [
            div(
              classes: [
                'drawer__header',
                if (!component.titleVisible) 'drawer__header--bare',
              ].join(' '),
              [
                if (component.titleVisible)
                  div(classes: 'drawer__heading-group', [
                    h2(id: _titleId, classes: 'drawer__title', [
                      .text(component.title),
                    ]),
                    if (component.subtitle case final subtitle?)
                      p(classes: 'drawer__subtitle', [.text(subtitle)]),
                  ]),
                button(
                  id: _closeButtonId,
                  classes: 'drawer__close',
                  attributes: const {
                    'type': 'button',
                    'aria-label': 'Close panel',
                  },
                  onClick: component.onClose,
                  const [Icon(symbol: 'close')],
                ),
              ],
            ),
            div(classes: 'drawer__body', component.children),
          ],
        ),
      ],
    );
  }
}
