// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:universal_web/web.dart' as web;

/// Calls [onVisible] once, the first time the element matching [selector] is
/// at least [threshold] visible in the viewport.
///
/// Used to start the scroll-triggered animations on the "Why us" page. Listens
/// through [web.EventStreamProviders] rather than `addEventListener` so the
/// file stays compilable for the server during pre-rendering.
void Function() observeOnce(
  String selector,
  void Function() onVisible, {
  double threshold = 0.5,
}) {
  StreamSubscription<web.Event>? scrollSubscription;
  StreamSubscription<web.Event>? resizeSubscription;
  Timer? initialCheckTimer;
  var hasFired = false;

  void cancel() {
    hasFired = true;
    unawaited(scrollSubscription?.cancel() ?? Future<void>.value());
    unawaited(resizeSubscription?.cancel() ?? Future<void>.value());
    initialCheckTimer?.cancel();
  }

  void check() {
    if (hasFired) return;

    final element = web.document.querySelector(selector);
    if (element == null) return;

    final rect = element.getBoundingClientRect();
    final height = rect.height;
    if (height <= 0) return;

    final viewportHeight = web.window.innerHeight;
    final visibleTop = rect.top.clamp(0, viewportHeight);
    final visibleBottom = rect.bottom.clamp(0, viewportHeight);

    if ((visibleBottom - visibleTop) / height >= threshold) {
      cancel();
      onVisible();
    }
  }

  scrollSubscription = web.EventStreamProviders.scrollEvent
      .forTarget(web.window)
      .listen((_) => check());
  resizeSubscription = web.EventStreamProviders.resizeEvent
      .forTarget(web.window)
      .listen((_) => check());

  // Catch elements that are already on screen when the page loads.
  initialCheckTimer = Timer(Duration.zero, check);

  return cancel;
}

/// Drives an ease-out-cubic tween over [duration], invoking [onTick] with the
/// eased fraction between 0 and 1 until it completes.
void Function() animateValue({
  required Duration duration,
  required void Function(double easedFraction) onTick,
}) {
  const frameInterval = Duration(milliseconds: 16);
  final elapsed = Stopwatch()..start();
  late Timer timer;

  timer = Timer.periodic(frameInterval, (t) {
    final fraction = (elapsed.elapsedMilliseconds / duration.inMilliseconds)
        .clamp(0.0, 1.0);
    final remaining = 1 - fraction;
    onTick(1 - (remaining * remaining * remaining));

    if (fraction >= 1) {
      t.cancel();
      elapsed.stop();
    }
  });

  return () {
    timer.cancel();
    elapsed.stop();
  };
}
