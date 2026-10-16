// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A reusable component representing an errored trial state.
///
/// Ensures error styling is visually distinct (hatched/amber/red borders,
/// clear warning icon) everywhere it appears (leaderboard, heatmap, detail page),
/// so errors are never misread as zero scores.
class ErrorStateBadge extends StatelessComponent {
  const ErrorStateBadge({
    this.exceptionType,
    this.message,
    this.compact = false,
    super.key,
  });

  /// The exception type name, e.g. "AgentTimeoutError".
  final String? exceptionType;

  /// Optional detail message.
  final String? message;

  /// Whether to render in a compact pill format for dense table cells.
  final bool compact;

  @override
  Component build(BuildContext context) {
    final label = exceptionType ?? 'Error';

    return span(
      classes: ['bench-error-badge', if (compact) 'compact'].join(' '),
      attributes: {
        'title': message ?? label,
        'role': 'status',
      },
      [
        const span(classes: 'bench-error-icon', [.text('⚠')]),
        span(classes: 'bench-error-label', [.text(label)]),
      ],
    );
  }
}
