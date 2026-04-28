// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

CustomComponent defineComponent(String name, Component child) {
  return CustomComponent(
    pattern: RegExp(name, caseSensitive: false),
    builder: (_, _, _) => child,
  );
}

CustomComponent defineComponentWithAttrs(
  String name,
  Component Function(Map<String, String> attributes) factory,
) {
  return CustomComponent(
    pattern: RegExp(name, caseSensitive: false),
    builder: (_, attrs, _) => factory(attrs),
  );
}

CustomComponent defineComponentWithChild(
  String name,
  Component Function(Map<String, String> attributes, Component? child) factory,
) {
  return CustomComponent(
    pattern: RegExp(name, caseSensitive: false),
    builder: (_, attrs, child) => factory(attrs, child),
  );
}
