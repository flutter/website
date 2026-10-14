// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// The local calendar date of the Flutter Create 2026 livestream.
final DateTime _eventDate = DateTime(2026, 11, 11);

/// A count of the days remaining until the Flutter Create livestream.
@client
class FlutterCreateCountdown extends StatefulComponent {
  const FlutterCreateCountdown({super.key});

  @override
  State<FlutterCreateCountdown> createState() => _FlutterCreateCountdownState();
}

class _FlutterCreateCountdownState extends State<FlutterCreateCountdown> {
  int? _daysLeft;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    _update();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _update());
  }

  void _update() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    setState(() => _daysLeft = _eventDate.difference(today).inDays);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    final daysLeft = _daysLeft;
    return div(classes: 'fc-countdown', [
      if (daysLeft == null)
        const span(classes: 'fc-countdown-label', [
          .text('November 11 · Online'),
        ])
      else if (daysLeft > 0) ...[
        span(classes: 'fc-countdown-number', [.text('$daysLeft')]),
        span(classes: 'fc-countdown-label', [
          .text(daysLeft == 1 ? 'day to go' : 'days to go'),
        ]),
      ] else if (daysLeft == 0)
        const span(classes: 'fc-countdown-label', [.text("It's today!")])
      else
        const span(classes: 'fc-countdown-label', [
          .text('Thanks for watching'),
        ]),
    ]);
  }
}
