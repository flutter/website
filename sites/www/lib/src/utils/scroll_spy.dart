// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

final scroll = ScrollNotifier();

enum ScrollId { inContent, inHero }

class ScrollNotifier extends ChangeNotifier {
  Set<ScrollId> activeIds = {};

  int get headerOffset => -86;
  Map<String, String> spy(int offset, [ScrollId? id]) {
    return {'data-scroll-spy': '[$offset${id != null ? ',"${id.name}"' : ''}]'};
  }

  Map<String, String> get spyContent => spy(headerOffset, .inContent);

  /// Updates [activeIds] for [id] and returns whether the active state changed.
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
  void applyThresholds(
    double scrollY,
    Iterable<(int offsetTop, ScrollId? id)> thresholds,
  ) {
    var changed = false;
    for (final (offsetTop, id) in thresholds) {
      if (id != null && updateActiveId(id, isActive: scrollY > offsetTop)) {
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
    }
  }

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

typedef _ScrollTarget = (int offsetTop, web.Element node, ScrollId? id);

List<_ScrollTarget> _collectScrollTargets() {
  final nodes = web.document.querySelectorAll('[data-scroll-spy]');
  final targets = <_ScrollTarget>[];

  for (var i = 0; i < nodes.length; i++) {
    final node = nodes.item(i) as web.HTMLElement;
    final data = jsonDecode(
      node.getAttribute('data-scroll-spy') ?? '[]',
    ) as List<Object?>;

    final offset = data.firstOrNull as int? ?? 0;
    final id = data.skip(1).firstOrNull as String?;

    targets.add((
      node.offsetTop + offset,
      node,
      id != null ? ScrollId.values.byName(id) : null,
    ));
  }

  return targets;
}
