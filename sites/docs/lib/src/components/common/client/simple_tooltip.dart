// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../util/component_ref.dart';
import '../tooltip.dart';

@client
class SimpleTooltip extends StatelessComponent {
  const SimpleTooltip({
    required this.target,
    required this.content,
    super.key,
  });

  final ComponentRef target;
  final ComponentRef content;

  @override
  Component build(BuildContext context) {
    return Tooltip(
      target: target.component,
      content: content.component,
    );
  }
}
