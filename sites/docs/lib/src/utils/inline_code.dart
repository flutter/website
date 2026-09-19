// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Renders text with optional inline code segments delimited by backticks.
Component renderDescriptionWithCode(String text) {
  if (!text.contains('`')) {
    return .text(text);
  }
  final parts = text.split('`');
  final children = <Component>[];
  for (var i = 0; i < parts.length; i++) {
    if (i.isOdd) {
      children.add(code([.text(parts[i])]));
    } else if (parts[i].isNotEmpty) {
      children.add(.text(parts[i]));
    }
  }
  return .fragment(children);
}
