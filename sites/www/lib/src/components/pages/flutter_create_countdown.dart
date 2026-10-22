// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// The local calendar date of the Flutter Create 2026 livestream.
final DateTime _eventDate = DateTime(2026, 11, 11);

const String _fallbackLabel = 'November 11 · Online';
const String _dayLabel = 'day to go';
const String _daysLabel = 'days to go';
const String _todayLabel = "It's today!";
const String _afterLabel = 'Thanks for watching';

/// A small inline script to place directly after [FlutterCreateCountdown].
///
/// It fills in the countdown before the page is first painted, using the
/// same calculation and labels as the component, so the static fallback
/// isn't briefly shown before the component hydrates.
const String flutterCreateCountdownScript =
    '(function(){'
    'var s=document.currentScript,e=s&&s.previousElementSibling;'
    "if(!e||!e.classList.contains('fc-countdown'))return;"
    'var n=new Date(),t=new Date(n.getFullYear(),n.getMonth(),n.getDate()),'
    'd=Math.round((new Date(2026,10,11)-t)/864e5),'
    "l=function(x){var c=document.createElement('span');"
    "c.className='fc-countdown-label';c.textContent=x;return c;};"
    'e.textContent="";'
    "if(d>0){var m=document.createElement('span');"
    "m.className='fc-countdown-number';m.textContent=String(d);"
    "e.append(m,l(d===1?'$_dayLabel':'$_daysLabel'));}"
    "else e.append(l(d===0?\"$_todayLabel\":'$_afterLabel'));"
    '})();';

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
        const span(classes: 'fc-countdown-label', [.text(_fallbackLabel)])
      else if (daysLeft > 0) ...[
        span(classes: 'fc-countdown-number', [.text('$daysLeft')]),
        span(classes: 'fc-countdown-label', [
          .text(daysLeft == 1 ? _dayLabel : _daysLabel),
        ]),
      ] else if (daysLeft == 0)
        const span(classes: 'fc-countdown-label', [.text(_todayLabel)])
      else
        const span(classes: 'fc-countdown-label', [.text(_afterLabel)]),
    ]);
  }
}
