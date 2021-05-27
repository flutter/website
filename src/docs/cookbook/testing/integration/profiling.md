---
title: Performance profiling
description: How to profile performance for a Flutter app.
prev:
  title: Handle scrolling
  path: /docs/cookbook/testing/integration/scrolling
next:
  title: An introduction to unit testing
  path: /docs/cookbook/testing/unit/introduction
---

{{site.alert.note}}
  The integration_test package is now the recommended way to write integration
  tests. See the [Integration testing](/docs/testing/integration-tests/) page
  for details.
{{site.alert.end}}

When it comes to mobile apps, performance is critical to user experience.
Users expect apps to have smooth scrolling and meaningful animations free of
stuttering or skipped frames, known as "jank." How to ensure that your app
is free of jank on a wide variety of devices?

There are two options: first, manually test the app on different devices.
While that approach might work for a smaller app, it becomes more
cumbersome as an app grows in size. Alternatively, run an integration
test that performs a specific task and records a performance timeline.
Then, examine the results to determine whether a specific section of
the app needs to be improved.

In this recipe, learn how to write a test that records a performance
timeline while performing a specific task and saves a summary of the
results to a local file.

This recipe uses the following steps:

  1. Write a test that scrolls through a list of items.
  2. Record the performance of the app.
  3. Save the results to disk.
  4. Run the test.
  5. Review the results.

### 1. Write a test that scrolls through a list of items

In this recipe, record the performance of an app as it scrolls through a
list of items. To focus on performance profiling, this recipe builds
on the [Scrolling][] recipe in integration tests.

Follow the instructions in that recipe to create an app, instrument the
app, and write a test to verify that everything works as expected.

### 2. Record the performance of the app

Next, record the performance of the app as it scrolls through the
list. Perform this task using the [`traceAction()`][]
method provided by the [`FlutterDriver`][] class.

This method runs the provided function and records a [`Timeline`][]
with detailed information about the performance of the app. This example
provides a function that scrolls through the list of items,
ensuring that a specific item is displayed. When the function completes,
the `traceAction()` method returns a `Timeline`.

<!-- skip -->
```dart
// Record a performance timeline as the app scrolls through the list of items.
final timeline = await driver.traceAction(() async {
  await driver.scrollUntilVisible(
    listFinder,
    itemFinder,
    dyScroll: -300.0,
  );

  expect(await driver.getText(itemFinder), 'Item 50');
});
```

### 3. Save the results to disk

Now that you've captured a performance timeline, you need a way to review it.
The `Timeline` object provides detailed information about all of the events
that took place, but it doesn't provide a convenient way to review the results.

Therefore, convert the `Timeline` into a [`TimelineSummary`][].
The `TimelineSummary` can perform two tasks that make it easier
to review the results:

  1. Writing a json document on disk that summarizes the data contained
     within the `Timeline`. This summary includes information about the
     number of skipped frames, slowest build times, and more.
  2. Saving the complete `Timeline` as a json file on disk.
     This file can be opened with the Chrome browser's
     tracing tools found at [chrome://tracing][].

<!-- skip -->
```dart
// Convert the Timeline into a TimelineSummary that's easier to read and
// understand.
final summary = new TimelineSummary.summarize(timeline);

// Then, save the summary to disk.
await summary.writeSummaryToFile('scrolling_summary', pretty: true);

// Optionally, write the entire timeline to disk in a json format. This
// file can be opened in the Chrome browser's tracing tools found by
// navigating to chrome://tracing.
await summary.writeTimelineToFile('scrolling_timeline', pretty: true);
```

### 4. Run the test

After configuring the test to capture a performance `Timeline` and save a
summary of the results to disk, run the test with the following command:

```
flutter drive --target=test_driver/app.dart --profile
```

The `--profile` option means to compile the app for the "profile mode" 
rather than the "debug mode", so that the benchmark result is closer to 
what will be experienced by end users. 

### 5. Review the results

After the test completes successfully, the `build` directory at the root of
the project contains two files:

  1. `scrolling_summary.timeline_summary.json` contains the summary. Open
     the file with any text editor to review the information contained
     within.  With a more advanced setup, you could save a summary every
     time the test runs and create a graph of the results.
  2. `scrolling_timeline.timeline.json` contains the complete timeline data.
     Open the file using the Chrome browser's tracing tools found at
     [chrome://tracing][]. The tracing tools provide a
     convenient interface for inspecting the timeline data to discover
     the source of a performance issue.

#### Summary example

```json
{
  "average_frame_build_time_millis": 4.2592592592592595,
  "worst_frame_build_time_millis": 21.0,
  "missed_frame_build_budget_count": 2,
  "average_frame_rasterizer_time_millis": 5.518518518518518,
  "worst_frame_rasterizer_time_millis": 51.0,
  "missed_frame_rasterizer_budget_count": 10,
  "frame_count": 54,
  "frame_build_times": [
    6874,
    5019,
    3638
  ],
  "frame_rasterizer_times": [
    51955,
    8468,
    3129
  ]
}
```

### Complete example

<!-- skip -->
```dart
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable App', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('verifies the list contains a specific item', () async {
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');

      // Record a performance profile as the app scrolls through
      // the list of items.
      final timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(
          listFinder,
          itemFinder,
          dyScroll: -300.0,
        );

        expect(await driver.getText(itemFinder), 'Item 50');
      });

      // Convert the Timeline into a TimelineSummary that's easier to
      // read and understand.
      final summary = new TimelineSummary.summarize(timeline);

      // Then, save the summary to disk.
      await summary.writeSummaryToFile('scrolling_summary', pretty: true);

      // Optionally, write the entire timeline to disk in a json format.
      // This file can be opened in the Chrome browser's tracing tools
      // found by navigating to chrome://tracing.
      await summary.writeTimelineToFile('scrolling_timeline', pretty: true);
    });
  });
}
```


[chrome://tracing]: chrome://tracing
[`FlutterDriver`]: {{site.api}}/flutter/flutter_driver/FlutterDriver-class.html
[Scrolling]: /docs/cookbook/testing/integration/scrolling
[`Timeline`]: {{site.api}}/flutter/flutter_driver/Timeline-class.html
[`TimelineSummary`]: {{site.api}}/flutter/flutter_driver/TimelineSummary-class.html
[`traceAction()`]: {{site.api}}/flutter/flutter_driver/FlutterDriver/traceAction.html
