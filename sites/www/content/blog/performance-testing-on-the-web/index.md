---
title: "Performance testing on the web"
description: "Overview"
publishDate: 2020-10-02
author: tianguang
image: images/0LitJY47Vl0J17C5V.webp
category: tutorial
layout: blog
---

*This article was updated on Nov 25, 2020 to use the* `web_benchmarks` *package.*

## Overview

During development, we often want to test an app’s performance in the browser. Performance testing is useful, as it reveals potential bugs that make an app slower.

This article describes a way to test an app’s performance in Chrome. This method is similar to how we test the [new Flutter Gallery](https://gallery.flutter.dev/#/)’s performance.

## Example app

We use a simple app that contains an appbar, a floating action button, and an infinite list of items. The list also shows the number of times the button is pushed.

<DashImage figure src="images/0adwmyiS509VwCCYl.webp" />


The app has a second page containing some information.

<DashImage figure src="images/0-d-mmdUUEW08ytWJ.webp" />


You can clone the app here:

* [https://github.com/material-components/material-components-flutter-experimental/tree/develop/web_benchmarks_example](https://github.com/material-components/material-components-flutter-experimental/tree/develop/web_benchmarks_example)

## What to test?

We want to test the app’s performance in Chrome under the following usage scenarios:

1. User scrolls through the infinite list.

1. User switches between the two pages.

1. User taps the floating action button.

## Setting up the framework

Add the following to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  web_benchmarks: ^0.0.2

```

This dependency pulls in [`web_benchmarks`](https://pub.dev/packages/web_benchmarks), a minimal package that implements performance testing in Chrome.

This package is adapted from [`macrobenchmarks`](https://github.com/flutter/flutter/tree/master/dev/benchmarks/macrobenchmarks) and [`devicelab`](https://github.com/flutter/flutter/tree/master/dev/devicelab), two packages used by Flutter for web performance testing on the Flutter Gallery. At the moment, these two packages are specialized for web performance testing within `flutter/flutter`, so it is easier to import the more general package, [`web_benchmarks`](https://pub.dev/packages/web_benchmarks).

Run `flutter pub get` to pull in this package.

## Writing the first test

Add a `benchmarks` directory under `lib`, and add a new dart file to it called `runner.dart`:

<DashImage figure src="images/0tsvQSKBjpWJWkiKM.webp" />


The contents of the file are as follows:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_benchmarks/client.dart';
import 'package:web_benchmarks_example/main.dart';
import 'package:web_benchmarks_example/homepage.dart' show textKey;

/// A recorder that measures frame building durations.
abstract class AppRecorder extends WidgetRecorder {
  AppRecorder({@required this.benchmarkName}) : super(name: benchmarkName);

  final String benchmarkName;

  Future<void> automate();

  @override
  Widget createWidget() {
    Future.delayed(Duration(milliseconds: 400), automate);
    return MyApp();
  }

  Future<void> animationStops() async {
    while (WidgetsBinding.instance.hasScheduledFrame) {
      await Future<void>.delayed(Duration(milliseconds: 200));
    }
  }
}

class ScrollRecorder extends AppRecorder {
  ScrollRecorder() : super(benchmarkName: 'scroll');

  Future<void> automate() async {
    final scrollable = Scrollable.of(find.byKey(textKey).evaluate().single);
    await scrollable.position.animateTo(
      30000,
      curve: Curves.linear,
      duration: Duration(seconds: 20),
    );
  }
}

Future<void> main() async {
  await runBenchmarks(
    {
      'scroll': () => ScrollRecorder(),
    },
  );
}

```

### What is this test doing?

* When this app runs, a `ScrollRecorder` object is created, which drives the app by automatically making gestures. In this case, shortly after the app starts, it starts scrolling down the infinite list.

* The `ScrollRecorder` class extends the `AppRecorder` class, which extends the `WidgetRecorder` class, which also records performance data as it drives the app.

* `runBenchmarks` is a function defined in `package:web_benchmarks/client.dart`, which allows the user to select which benchmark to run, and displays the results in the browser.

* The method `automate` uses the `flutter_test` package, which provides methods to make gestures or find certain widgets in an app.

## Running the first test

In the root directory of the project, run `flutter run -d chrome -t lib/benchmarks/runner.dart`. This tells Flutter to use `runner.dart` as the entry point, instead of `main.dart`.

<DashImage figure src="images/0imb9-c_LS4XF0xDX.webp" />


We only have one benchmark so far, so click “scroll” to start it.

<DashImage figure src="images/03aZa4m2GbsqHECNw.webp" />


The test begins, and the list automatically scrolls down.

The test ends in a few seconds, showing the following screen:

<DashImage figure src="images/0LitJY47Vl0J17C5V.webp" />


This chart shows the time it took for the app to draw each (recorded) frame. The horizontal axis represents the flow of time; the vertical axis, the duration each frame took.

The first 2/3 of the chart has a gray background; these frames are considered “warm-up frames”, and are omitted from the statistics. Warm-up frames typically give the JIT compiler time to compile the code, and populate various caches, so that the measured frames produce numbers that reflect the “eventual” performance of the app, rather than the first few seconds of it. The warm-up phase should not be always ignored — it can provide valuable information about your app’s performance during the first few seconds, which can still influence the perception of the app’s quality.

Red frames are “outliers” — they are frames which take significantly longer than other frames to draw. Some outliers can be nearly unnoticeable. For example, jank at the beginning or the end of an animation up to a certain point will not be visible. However, a janky frame in the *middle* of an animation will be very noticeable.

Outliers provide a good indicator of the jankiness of the app. By improving your app, you can lower the values of outliers or reduce the number of outliers, which shows that your app has become smoother.

## Collecting data from Chrome’s DevTools

This benchmark is entirely run from inside Chrome. Add the following file as `test/run_benchmarks.dart`:

```dart
import 'dart:convert' show JsonEncoder;
import 'dart:io';

import 'package:web_benchmarks/server.dart';

Future<void> main () async {
  final taskResult = await serveWebBenchmark(
    benchmarkAppDirectory: Directory('.'),
    entryPoint: 'lib/benchmarks/runner.dart',
    useCanvasKit: false,
  );
  print (JsonEncoder.withIndent('  ').convert(taskResult.toJson()));
}

```

Then, run `dart test/run_benchmarks.dart`.

After about one minute, you should see the following results:

```text
Received profile data
{
  "scroll": [
    {
      "metric": "preroll_frame.average",
      "value": 122.22105263157894
    },
    {
      "metric": "preroll_frame.outlierAverage",
      "value": 767.4
    },
    {
      "metric": "preroll_frame.outlierRatio",
      "value": 6.278787356816812
    },
    {
      "metric": "preroll_frame.noise",
      "value": 0.35245125929858917
    },
    {
      "metric": "apply_frame.average",
      "value": 529.8888888888889
    },
    {
      "metric": "apply_frame.outlierAverage",
      "value": 2696.5
    },
    {
      "metric": "apply_frame.outlierRatio",
      "value": 5.0888026840008385
    },
    {
      "metric": "apply_frame.noise",
      "value": 0.4154574507186871
    },
    {
      "metric": "drawFrameDuration.average",
      "value": 2562.0243902439024
    },
    {
      "metric": "drawFrameDuration.outlierAverage",
      "value": 6828.888888888889
    },
    {
      "metric": "drawFrameDuration.outlierRatio",
      "value": 2.66542696271474
    },
    {
      "metric": "drawFrameDuration.noise",
      "value": 0.4512335390240227
    },
    {
      "metric": "totalUiFrame.average",
      "value": 4971
    }
  ]
}

```

The exact benchmark values may vary depending on the machine.

### What is this test doing?

* Running `test/run_benchmarks.dart` builds the app for the web. Then, it starts a Chrome instance and runs the app in it.

* `test/run_benchmarks.dart` connects to Chrome’s DevTools port, and listens and collects relevant performance data from it.

### What do the results mean?

* When rendering a frame, the [layer tree](https://api.flutter.dev/flutter/rendering/Layer-class.html) is walked twice.

* “Preroll” is the first walk. It does not render anything, but it computes values that are later used for rendering. Examples include: transform matrices, the inverse of transforms, and clips.

* “Apply frame” is the second walk where the UI is actually rendered.

* “Draw frame” is the total time that the framework takes to render a frame. It includes “Preroll” and “Apply frame”, but it also includes the time spent on building and laying out the widgets.

* “Total UI frame” includes everything in “Draw frame”, but it also includes some hidden work that the browser performs, such as layer tree updates, style recalculations, and browser-side layout (not to be confused with Flutter’s own layout).

* When a dataset (a list of durations) is collected, the algorithm removes outliers.

* First, the mean and standard deviation of the data are computed, and any data point that is higher than (mean + 1 standard deviation) is considered an outlier.

* The mean and standard deviation of non-outliers (clean data) are used to compute the average and noise of the data set, which are then reported.

* The mean of all outliers, as well as the ratio of the “outlier mean” and the “non-outlier mean” are also reported.

* For each dataset, “outlierRatio” and “noise” are both good indicators of how much noise there is in the performance of the app. If the results are too noisy, it might indicate inconsistencies in performance (such as janky frames as GC pauses). By aiming to lower the noise, you can make your app perform more smoothly.

## Add more tests

Edit `lib/benchmarks/runner.dart` to add two more tests.

First, modify the `main` function:

```dart
Future<void> main() async {
  await runBenchmarks(
    {
      'scroll': () => ScrollRecorder(),
      'page': () => PageRecorder(),
      'tap': () => TapRecorder(),
    },
  );
}

```

Finally, add two more classes that extend `AppRecorder`:

```dart
class PageRecorder extends AppRecorder {
  PageRecorder() : super(benchmarkName: 'page');

  bool _completed = false;

  @override
  bool shouldContinue() => profile.shouldContinue() || !_completed;

  Future<void> automate() async {
    final controller = LiveWidgetController(WidgetsBinding.instance);
    for (int i = 0; i < 10; ++i) {
      print('Testing round $i...');
      await controller.tap(find.byKey(aboutPageKey));
      await animationStops();
      await controller.tap(find.byKey(backKey));
      await animationStops();
    }
    _completed = true;
  }
}

class TapRecorder extends AppRecorder {
  TapRecorder() : super(benchmarkName: 'tap');

  bool _completed = false;

  @override
  bool shouldContinue() => profile.shouldContinue() || !_completed;

  Future<void> automate() async {
    final controller = LiveWidgetController(WidgetsBinding.instance);
    for (int i = 0; i < 10; ++i) {
      print('Testing round $i...');
      await controller.tap(find.byIcon(Icons.add));
      await animationStops();
    }
    _completed = true;
  }
}

```

### What are these tests doing?

* We have added the two remaining benchmark tests: one for switching between pages, and the other for tapping on the floating action button.

* `animationStops` repeatedly checks whether an animation is happening, and stops when all animation has stopped. This ensures, for example, a successful transition to the “about” page.

* In the “page” and “tap” benchmarks, the `_completed` boolean tracks whether the automated gestures have finished.

* In the “page” and “tap” benchmarks, overriding the `shouldContinue` method causes the `AppRecorder` to stop recording frames **after** all gestures have finished.

### How to run these tests?

To run these tests (and see the animations) in Chrome, run:

* `flutter run -d chrome -t lib/benchmarks/runner.dart --profile`

To run these tests and collect DevTools data, run:

* `dart test/run_benchmarks.dart`

## What next?

Once you have a way to collect performance data, you can use it however you want:

* You can set up a job in CI that runs these benchmark tests whenever someone submits a PR, to avoid introducing performance-heavy changes.

* You can also set up a dashboard that keeps track of the trend of performance benchmarks. This is what we are doing for the Flutter Gallery (see [Flutter Dashboard](https://flutter-dashboard.appspot.com/#/build)).