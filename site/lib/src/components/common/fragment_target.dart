// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

/// An empty anchor that can act as a fragment target.
///
/// Often useful when a header, or at least its ID, needs to be updated.
final class FragmentTarget extends StatelessComponent {
  const FragmentTarget(this.id);

  final String id;

  @override
  Component build(BuildContext context) => a(
    href: '',
    id: id,
    attributes: {'aria-hidden': 'true'},
    [],
  );
}
