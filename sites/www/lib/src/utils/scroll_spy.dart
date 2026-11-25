// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

/// The shared [ScrollNotifier] for the page's scroll spy targets.
final scroll = ScrollNotifier();

/// Identifies a page region that components react to scrolling into.
enum ScrollId {
  /// The page is scrolled into its main content.
  inContent,

  /// The page is scrolled into the home page hero.
  inHero,
}

/// Tracks which [ScrollId] regions the page is scrolled into and
/// notifies listeners when that changes.
///
/// Elements opt in with the attributes from [spy] or [spyContent],
/// which [init] collects on the client.
class ScrollNotifier extends ChangeNotifier {
  /// The regions the page is currently scrolled into.
  Set<ScrollId> activeIds = {};

  /// The [spy] offset that activates a target once it
  /// scrolls under the site header,
  /// whose height is `--ui-header-navigation-height`.
  int get headerOffset => -86;

  /// Returns the attributes that make an element a scroll spy target.
  ///
  /// The target is active while the window's scroll position is
  /// past the element's top offset plus [offset].
  /// While active, the element has the `active` class and,
  /// if specified, [id] is in [activeIds].
  Map<String, String> spy(int offset, [ScrollId? id]) {
    return {'data-scroll-spy': '[$offset${id != null ? ',"${id.name}"' : ''}]'};
  }

  /// The [spy] attributes for a page's main content, which
  /// activate [ScrollId.inContent] once it scrolls under the header.
  Map<String, String> get spyContent => spy(headerOffset, .inContent);

  /// Updates [activeIds] for [id] and returns whether the active state changed.
  ///
  /// Doesn't notify listeners, so callers can batch multiple updates.
  /// On the web, a change to [ScrollId.inContent] also
  /// toggles the `in-content` class on the document body.
  bool updateActiveId(ScrollId id, {required bool isActive}) {
    final changed = isActive ? activeIds.add(id) : activeIds.remove(id);
    if (!changed) {
      return false;
    }

    if (kIsWeb && id == .inContent) {
      web.document.body?.classList.toggle('in-content', isActive);
    }
    return true;
  }

  /// Evaluates [thresholds] against [scrollY] and notifies listeners at most
  /// once when the active scroll state changes.
  ///
  /// An ID is active while [scrollY] is past the `offsetTop` of
  /// any of its thresholds. Thresholds without an ID are ignored.
  void applyThresholds(
    double scrollY,
    Iterable<(int offsetTop, ScrollId? id)> thresholds,
  ) {
    final ids = {for (final (_, id) in thresholds) ?id};
    final passedIds = {
      for (final (offsetTop, id) in thresholds)
        if (id != null && scrollY > offsetTop) id,
    };

    var changed = false;
    for (final id in ids) {
      if (updateActiveId(id, isActive: passedIds.contains(id))) {
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
    }
  }

  /// Gives each of [targets] the `active` class only while
  /// [offsetY] is past it, then updates [activeIds] to match.
  void _syncTargets(List<_ScrollTarget> targets, double offsetY) {
    for (final (offsetTop, node, _) in targets) {
      final isActive = offsetY > offsetTop;
      if (node.classList.contains('active') != isActive) {
        node.classList.toggle('active', isActive);
      }
    }

    applyThresholds(
      offsetY,
      targets.map((target) => (target.$1, target.$3)),
    );
  }

  /// Starts updating the page's scroll spy targets as the window scrolls,
  /// at most once per animation frame.
  ///
  /// Target positions are measured only once,
  /// so call this once on the client after the page is rendered.
  static void init() {
    final targets = _collectScrollTargets();
    if (targets.isEmpty) {
      return;
    }

    var frameScheduled = false;
    web.window.addEventListener(
      'scroll',
      ((web.Event _) {
        if (frameScheduled) return;
        frameScheduled = true;
        web.window.requestAnimationFrame(
          ((num _) {
            frameScheduled = false;
            scroll._syncTargets(targets, web.window.scrollY);
          }).toJS,
        );
      }).toJS,
      web.AddEventListenerOptions(passive: true),
    );
  }
}

/// An element tracked by the scroll spy,
/// with the scroll position past which it's active and
/// the [ScrollId] it controls, if any.
typedef _ScrollTarget = (int offsetTop, web.Element node, ScrollId? id);

/// Returns a scroll target for each element with
/// a `data-scroll-spy` attribute, as added by [ScrollNotifier.spy].
///
/// Each target's `offsetTop` is the element's current offset on the page
/// plus the offset from its attribute.
List<_ScrollTarget> _collectScrollTargets() {
  final nodes = web.document.querySelectorAll('[data-scroll-spy]');
  return [
    for (var i = 0; i < nodes.length; i++)
      _scrollTargetFor(nodes.item(i) as web.HTMLElement),
  ];
}

/// Returns the scroll target for [node] based on
/// its `data-scroll-spy` attribute.
_ScrollTarget _scrollTargetFor(web.HTMLElement node) {
  final data = jsonDecode(
    node.getAttribute('data-scroll-spy') ?? '[]',
  ) as List<Object?>;

  final offset = data.firstOrNull as int? ?? 0;
  final id = data.skip(1).firstOrNull as String?;

  return (
    node.offsetTop + offset,
    node,
    id != null ? ScrollId.values.byName(id) : null,
  );
}
