// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:js_interop';

import 'package:jaspr/browser.dart';
import 'package:universal_web/web.dart' as web;

/// Extracts the content of a <pre><code> block inside the given
/// [element] during hydration.
String extractContent(Element element) {
  final r = element.parentRenderObjectElement?.renderObject as DomRenderObject?;
  if (r == null) return '';

  final code = r.retakeNode((node) {
    return node.instanceOfString('Element') &&
        (node as web.Element).tagName.toLowerCase() == 'pre';
  });

  if (code == null) return '';

  code.parentNode?.removeChild(code);
  return (code as web.Element).textContent ?? '';
}
