// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class InteractiveProgressRing extends StatelessComponent {
  const InteractiveProgressRing({required this.progress, required this.size})
    : assert(progress >= 0.0 && progress <= 1.0);

  final double progress;
  final double size;

  @override
  Component build(BuildContext context) {
    // The radius of the ring.
    const r = 24;
    // The stroke width of the ring.
    const strokeWidth = 4;
    // The full circumference of the ring.
    const full = pi * r * 2;
    // Offset to start drawing at 12 o'clock, since default strokes
    // start at 3 o'clock.
    const quarter = full / 4;
    // The absolute gap between active and inactive tracks.
    const gap = strokeWidth * 2;
    // The relative gap as a factor of the full circumference.
    const rGap = gap / full;

    // Adjust progress to precicely align with each quarter of the ring
    // while accounting for the visual gap (reversing the stroke offset logic)
    // and keeping a continuous curve to each limit (0 and 1).
    final adjustedProgress =
        progress -
        switch (progress) {
          //        (== 0 for prog -> 0; == gap for prog -> 0.25)
          < 0.25 => (progress * 4 * rGap),
          //        (== gap for prog -> 0.75; == 0 for prog -> 1)
          > 0.75 => (1 - progress) * 4 * rGap,
          _ => rGap,
        };

    // Absolute lengths of the active and inactive portions of the ring.
    final inactiveLength = (1 - adjustedProgress) * full - gap * 2;
    final activeLength = adjustedProgress * full;

    return svg(
      classes: 'progress-ring',
      width: size.px,
      height: size.px,
      viewBox: '0 0 ${r * 2 + strokeWidth} ${r * 2 + strokeWidth}',
      [
        // For values close to 1, inactiveLength can become <=0 due to gap.
        if (inactiveLength > 0)
          // Inactive portion, drawn from (progress)° to (0)°
          circle(
            classes: 'ring-inactive',
            cx: '${r + strokeWidth / 2}',
            cy: '${r + strokeWidth / 2}',
            r: '$r',
            strokeWidth: strokeWidth.toString(),
            attributes: {
              'stroke-dasharray': '$inactiveLength ${full - inactiveLength}',
              'stroke-dashoffset': '${quarter - activeLength - gap * 1.5}',
            },
            [],
          ),

        // Active portion, drawn from 0° to (progress)°
        circle(
          classes: 'ring-active',
          cx: '${r + strokeWidth / 2}',
          cy: '${r + strokeWidth / 2}',
          r: '$r',
          strokeWidth: strokeWidth.toString(),
          attributes: {
            'stroke-dasharray': '$activeLength ${full - activeLength}',
            'stroke-dashoffset': '${quarter - gap / 2}',
          },
          [],
        ),
      ],
    );
  }
}
