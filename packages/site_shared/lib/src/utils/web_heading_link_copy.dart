// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

bool _headingLinkCopyInitialized = false;
final _pendingHeadingLinkResets =
    <web.Element, ({String label, Timer timer})>{};

/// Sets up click handlers for `a.heading-link[href]` anchors to copy
/// the heading anchor URL to the clipboard without jumping the viewport.
void setUpHeadingLinkCopy() {
  if (_headingLinkCopyInitialized) return;
  _headingLinkCopyInitialized = true;

  web.document.addEventListener(
    'click',
    ((web.Event event) {
      final target = event.target;
      if (!target.isA<web.Element>()) return;

      final anchor = (target as web.Element).closest('a.heading-link[href]');
      if (anchor == null || !anchor.isA<web.HTMLAnchorElement>()) return;

      final htmlAnchor = anchor as web.HTMLAnchorElement;
      final fragment = htmlAnchor.hash;
      if (!fragment.startsWith('#')) return;

      final headingId = fragment.substring(1);
      if (headingId.isEmpty) return;

      event.preventDefault();

      final url = Uri.parse(
        web.window.location.href,
      ).replace(fragment: headingId).toString();

      // Update the URL hash without triggering a scroll jump.
      web.window.history.replaceState(null, '', '#$headingId');

      unawaited(_copyHeadingLinkToClipboard(htmlAnchor, url));
    }).toJS,
  );
}

Future<void> _copyHeadingLinkToClipboard(
  web.HTMLAnchorElement anchor,
  String url,
) async {
  final label =
      _pendingHeadingLinkResets[anchor]?.label ?? anchor.textContent ?? '';
  try {
    await web.window.navigator.clipboard.writeText(url).toDart;
    anchor.textContent = 'Link copied!';
  } catch (_) {
    anchor.textContent = 'Failed to copy';
  }

  _pendingHeadingLinkResets.remove(anchor)?.timer.cancel();
  _pendingHeadingLinkResets[anchor] = (
    label: label,
    timer: Timer(const Duration(milliseconds: 1200), () {
      _pendingHeadingLinkResets.remove(anchor);
      anchor.textContent = label;
    }),
  );
}
