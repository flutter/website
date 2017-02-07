---
layout: page
title: Testing Flutter Apps
sidebar: home_sidebar
permalink: /testing/
---

* TOC
{:toc}

## Introduction

The more features your app has, the harder it is to test it manually. A
good set of automated tests will help you make sure your app performs
correctly before you publish it while retaining your feature and bug fix
velocity.

There are many kinds of automated testing. These are summarized below:

- A _unit test_ tests a single function, method, or class. External dependencies
  of the unit under test are generally mocked out using, for example,
  [`package:mockito`](https://github.com/fibulwinter/dart-mockito/blob/master/README.md).
  Unit tests generally do not read from/write to disk, render to screen and do
  not receive user actions from outside the process running the test. The goal
  of a unit test is to verify the correctness of a unit of logic under a
  variety of conditions.
- A _widget test_ (in other UI frameworks referred to as _component test_) tests
  a single widget. Testing a widget involves multiple classes and requires a
  test environment that provides the appropriate widget lifecycle context. For
  example, it should be able to receive and respond to user actions and events,
  perform layout, and instantiate child widgets. A widget test is
  therefore more comprehensive than a unit test. However, like a unit test, a
  widget test's environment is replaced with an implementation much simpler than
  a full-blown UI system. The goal of a widget test is to verify that the
  widget's UI looks and interacts as expected.
- An [_integration test_](https://en.wikipedia.org/wiki/Integration_testing)
  tests a complete app or a large part of an app. Generally, an
  _integration test_ runs on a real device or an OS emulator, such as iOS
  Simulator or Android Emulator. The app under test is typically isolated from
  the test driver code to avoid skewing the results. The goal of an integration
  test is to verify that the app functions correctly as a whole, that all the
  widgets it is composed of integrate with each other as expected. You can also
  use your integration tests to verify your app's performance.

Here is a table summarizing the tradeoffs concerning the choice between
different kinds of tests:

|                      | Unit   | Widget | Integration |
|----------------------|--------|--------|-------------|
| **Confidence**       | Low    | Higher | Highest     |
| **Maintenance cost** | Low    | Higher | Highest     |
| **Dependencies**     | Few    | More   | Lots        |
| **Execution speed**  | Quick  | Slower | Slowest     |
|                      |        |        |             |

**Tip**: As a rule of thumb a well-tested app has a very high number of unit
and widget tests, tracked by [code coverage](https://en.wikipedia.org/wiki/Code_coverage),
and a good number of integration tests covering all the important usage
scenarios.


## Unit testing

Some Flutter libraries, such as `dart:ui`, are not available in the standalone
Dart VM that ships with the default Dart SDK. The `flutter test` command lets
you run your tests in a local Dart VM with a headless version of the Flutter
Engine, which supplies these libraries. Using this command you can run any test,
whether it depends on Flutter libraries or not.

Write a Flutter unit test as a normal `package:test` test. Writing unit tests
using `package:test` is documented [here](https://github.com/dart-lang/test/blob/master/README.md).

Example:

Add this file to `test/unit_test.dart`:

{% prettify dart %}
import 'package:test/test.dart';

void main() {
  test('my first unit test', () {
    /**highlight*/var answer = 42;/*-highlight*/
    expect(answer, 42);
  });
}
{% endprettify %}

In addition, you must add the following block to your `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

(This is needed even if your test does not itself explicitly import
`flutter_test`, because the test framework itself uses it behind the
scenes.)

To run the test, run `flutter test test/unit_test.dart` from your
project directory (not from the `test` subdirectory).

To run all your tests, run `flutter test` from your project directory.


## Widget testing

You implement a widget test in a similar way as a unit test. To perform an
interaction with a widget in your test, use the
[`WidgetTester`](https://docs.flutter.io/flutter/flutter_test/WidgetTester-class.html)
utility that Flutter provides. For example, you can send tap and scroll
gestures. You can also use
[`WidgetTester`](https://docs.flutter.io/flutter/flutter_test/WidgetTester-class.html)
to find child widgets in the widget tree, read text, and verify that the values
of widget properties are correct.

Example:

Add this file to `test/widget_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('my first widget test', (WidgetTester tester) async {
    // You can use keys to locate the widget you need to test
    var sliderKey = new UniqueKey();
    var value = 0.0;

    // Tells the tester to build a UI based on the widget tree passed to it
    await tester.pumpWidget(
      new StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return new Material(
            child: new Center(
              child: new Slider(
                key: sliderKey,
                value: value,
                onChanged: (double newValue) {
                  setState(() {
                    value = newValue;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
    expect(value, equals(0.0));

    // Taps on the widget found by key
    await tester.tap(find.byKey(sliderKey));

    // Verifies that the widget updated the value correctly
    expect(value, equals(0.5));
  });
}
```

Run `flutter test test/widget_test.dart`.

Check out [`package:flutter_test` API](https://docs.flutter.io/flutter/flutter_test/flutter_test-library.html)
for all the utilities available for widget testing.


## Integration testing

A Flutter integration test is also written using `package:test`. A full test is a
pair - a test script and a Flutter app instrumented to receive commands
from the test. Unlike unit and widget tests, integration test code does not run
in the same process as the app that's being tested. Instead, the tested
app is launched on a _real device_ or in an _emulator_ (e.g. Android
simulator or iOS Simulator). The test script runs on your computer. It connects
to the app and issues commands to the app to perform various
user actions. This is known as "driving" the app. Flutter provides tools
and APIs, collectively referred to as _Flutter Driver_, to do just that.

> If you are familiar with Selenium/WebDriver (web), Espresso (Android) or UI
> Automation (iOS), then Flutter Driver is Flutter's equivalent to those
> integration testing tools. In addition, Flutter Driver provides API for
> recording performance traces (a.k.a. the _timeline_) from actions performed
> by the test.

Flutter Driver is:

* a command-line tool `flutter drive`
* a package `package:flutter_driver` ([API](https://docs.flutter.io/flutter/flutter_driver/FlutterDriver-class.html))

Together, the two allow you to:

* create instrumented app for integration testing
* write a test
* run the test

### Adding the flutter_driver dependency

To use `flutter_driver`, you must add the following block to your `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_driver:
    sdk: flutter
```

### Creating instrumented Flutter apps

An instrumented app is a Flutter app that has the Flutter Driver
_extension_ enabled. To enable the extension call
`enableFlutterDriverExtension()` from
`package:flutter_driver/driver_extension.dart`.

Example:

Let's assume you have an app with the entry point in
`my_app/lib/main.dart`. To create an instrumented version of it, create a Dart
file under `my_app/test_driver/`. Name it after the feature you are testing;
let's go for `my_app/test_driver/user_list_scrolling.dart`:

```dart
// This line imports the extension
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` of your app or call `runApp` with whatever widget
  // you are interested in testing.
}
```

### Writing integration tests

An integration test is a plain `package:test` test that uses the Flutter Driver
API to tell the app what to do and then verifies that the app
did it.

Example:

Just for fun let's also make our test record the performance timeline. Let's
create a test file `my_app/test_driver/user_list_scrolling_test.dart`:

```dart
import 'dart:async';

// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('scrolling performance test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Connects to the app
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        // Closes the connection
        driver.close();
      }
    });

    test('measure', () async {
      // Record the performance timeline of things that happen inside the closure
      Timeline timeline = await driver.traceAction(() async {
        // Find the scrollable user list
        SerializableFinder userList = find.byValueKey('user-list');

        // Scroll down 5 times
        for (int i = 0; i < 5; i++) {
          // Scroll 300 pixels down, for 300 millis
          await driver.scroll(
              userList, 0.0, -300.0, new Duration(milliseconds: 300));

          // Emulate a user's finger taking its time to go back to the original
          // position before the next scroll
          await new Future<Null>.delayed(new Duration(milliseconds: 500));
        }

        // Scroll up 5 times
        for (int i = 0; i < 5; i++) {
          await driver.scroll(
              userList, 0.0, 300.0, new Duration(milliseconds: 300));
          await new Future<Null>.delayed(new Duration(milliseconds: 500));
        }
      });

      // The `timeline` object contains all the performance data recorded during
      // the scrolling session. It can be digested into a handful of useful
      // aggregate numbers, such as "average frame build time".
      TimelineSummary summary = new TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('stocks_scroll_perf', pretty: true);
      summary.writeTimelineToFile('stocks_scroll_perf', pretty: true);
    });
  });
}
```

### Running integration tests

To run the test on an Android device, connect the device via USB to your
computer and enable USB debugging. Then run the following command:

```
flutter drive --target=my_app/test_driver/user_list_scrolling.dart
```

This command will:

* build the `--target` app and install it on the device
* launch the app
* run the `my_app/test_driver/user_list_scrolling_test.dart` test

You might be wondering how the command finds the correct test file. The
`flutter drive` command uses a convention to look for the test file in the same
directory as the instrumented `--target` app that has the same file name
but for the `_test` suffix in it.
