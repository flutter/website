// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A placeholder for a panel whose data FlutterBench doesn't collect yet.
///
/// Keeps the layout of a section intact so the page doesn't reflow once the
/// real data lands.
class DataComingSoon extends StatelessComponent {
  const DataComingSoon({this.note, super.key});

  /// Optional detail about what will eventually appear here.
  final String? note;

  @override
  Component build(BuildContext context) {
    return div(classes: 'bench-coming-soon', [
      const span(classes: 'bench-coming-soon__label', [
        .text('Data coming soon'),
      ]),
      if (note case final note?)
        span(classes: 'bench-coming-soon__note', [.text(note)]),
    ]);
  }
}
