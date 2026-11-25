// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:flutter_website/src/utils/scroll_spy.dart';
import 'package:test/test.dart';

void main() {
  test('notifies once per change to the set of active scroll IDs', () {
    const thresholds = [
      (100, ScrollId.inHero),
      (200, ScrollId.inContent),
      (300, ScrollId.inContent),
    ];
    final notifier = ScrollNotifier();
    var notifications = 0;
    notifier.addListener(() => notifications++);

    notifier.applyThresholds(250, thresholds);
    expect(notifier.activeIds, {ScrollId.inHero, ScrollId.inContent});
    expect(notifications, 1);

    notifier.applyThresholds(260, thresholds);
    expect(notifications, 1);

    notifier.applyThresholds(150, thresholds);
    expect(notifier.activeIds, {ScrollId.inHero});
    expect(notifications, 2);
  });
}
