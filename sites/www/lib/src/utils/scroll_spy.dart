// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/jaspr.dart';
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

  void _add(ScrollId id) {
    activeIds.add(id);
    notifyListeners();

    if (id == .inContent) {
      web.document.body!.classList.add('in-content');
    }
  }

  void _remove(ScrollId id) {
    activeIds.remove(id);
    notifyListeners();

    if (id == .inContent) {
      web.document.body!.classList.remove('in-content');
    }
  }

  static void init() {
    final nodes = web.document.querySelectorAll('[data-scroll-spy]');

    final targets = <(int, web.Element, ScrollId?)>[];

    for (var i = 0; i < nodes.length; i++) {
      final node = nodes.item(i) as web.HTMLElement;
      final data =
          jsonDecode(node.getAttribute('data-scroll-spy') ?? '[]')
              as List<Object?>;

      final offset = data.firstOrNull as int? ?? 0;
      final id = data.skip(1).firstOrNull as String?;

      targets.add((
        node.offsetTop + offset,
        node,
        id != null ? ScrollId.values.byName(id) : null,
      ));
    }

    web.EventStreamProviders.scrollEvent.forTarget(web.window).listen((event) {
      final offsetY = web.window.scrollY;
      for (final (offsetTop, node, id) in targets) {
        if (offsetY > offsetTop) {
          if (!node.classList.contains('active')) {
            node.classList.add('active');
          }
          if (id != null && !scroll.activeIds.contains(id)) {
            scroll._add(id);
          }
        } else {
          if (node.classList.contains('active')) {
            node.classList.remove('active');
          }
          if (id != null && scroll.activeIds.contains(id)) {
            scroll._remove(id);
          }
        }
      }
    });
  }
}
