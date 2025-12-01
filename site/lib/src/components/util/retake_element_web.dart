// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/browser.dart';
// ignore: implementation_imports
import 'package:jaspr/src/foundation/type_checks.dart';
import 'package:universal_web/web.dart' as web;

/// Retakes the element matching [predicate] during hydration.
web.Element? retakeElement(
  BuildContext context,
  bool Function(web.Element element) predicate,
) {
  final r = (context as Element).parentRenderObjectElement?.renderObject;
  if (r == null) return null;
  final node = (r as DomRenderObject).retakeNode((node) {
    return node.isElement && predicate(node as web.Element);
  });
  return node as web.Element?;
}

Component wrapNode(web.Node node) {
  return RawNode(node);
}
