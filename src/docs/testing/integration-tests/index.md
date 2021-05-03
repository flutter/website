---
title: Integration testing
description: Learn how to write integration tests
---

This page describes how to use the `integration_test` package to run
integration tests. Tests written using this package have the following
properties:
 
* Compatibility with the `flutter drive` command,
  for running tests on a physical device or emulator.
* The ability to be run on [Firebase Test Lab][],
  enabling automated testing on a variety of devices.
* Compatibility with [flutter_test][] APIs,
  enabling tests to be written in a similar style as [widget tests][]

{{site.alert.note}}
  As of Flutter 2, the `integration_test` package
  was moved into the Flutter SDK. Going forward,
  use the [`integration_test`][] package docs,
  rather than the docs on pub.dev. **Also,
  make sure that you update your app's pubspec file
  to include this package as one of your
  `dev_dependencies`.** For an example,
  see the [Project setup](#project-setup) section below.
{{site.alert.end}}

## Overview

**Unit tests, widget tests, and integration tests**

There are three types of tests that Flutter supports.
A **unit** test verifies the behavior of a method or class.
A **widget test** verifies the behavior of Flutter widgets
without running the app itself. An **integration test** (also
called end-to-end testing or GUI testing) runs the full app.

**Hosts and targets**

During development, you are probably writing the code
on a desktop computer, called the **host** machine,
and running the app on a mobile device, browser,
or desktop application, called the **target** device.
(If you are using a web
browser or desktop application,
the host machine is also the target device.)

**flutter_driver** 

The `flutter_driver` package runs integration tests
written in Dart on a target device and reports the
results to the host. Tests written with `flutter_driver`
run from the host and drive the app running on a real
or virtual device. The `flutter drive` command is used
to run tests written with this package.

**integration_test**

Tests written with the `integration_test` package can:
 
1. Run directly on the target device, allowing you to test on
   multiple Android or iOS devices using Firebase Test Lab.
2. Run using `flutter_driver`. 
3. Use `flutter_test` APIs, making integration tests more
   like writing [widget tests][].

## Project setup

Add `integration_test`, `flutter_test`,
and optionally `flutter_driver` to your pubspec.yaml file:

```yaml
dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_test:
    sdk: flutter
  flutter_driver:
    sdk: flutter
```

In your project, create a new directory
`integration_test/` with a new file, `<name>_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    expect(2 + 2, equals(5));
  });
}
```

{{site.alert.note}}
  Note: You should only use `testWidgets`
  to declare your tests, or errors won't
  be reported correctly.
{{site.alert.end}}


To run tests with `flutter drive`,
create a new directory containing a new file,
`test_driver/integration_test.dart`:

```dart
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
```

### Directory structure

```yaml
lib/
  ...
integration_test/
  foo_test.dart
  bar_test.dart
test/
  # Other unit tests go here.
test_driver/
  integration_test.dart
```

See also:

 * [integration_test usage][]

## Running using Flutter driver

These tests can be launched with the
`flutter drive` command, where `<DEVICE_ID>`:
is the optional device ID or pattern displayed
in the output of the `flutter devices` command:

```bash
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/foo_test.dart \
  -d <DEVICE_ID>
```

This runs the tests in `foo_test.dart` using the adapter in
`test_driver/integration_test.dart`.


### Running in a browser 

First, [Download and install ChromeDriver][]
and run it on port 4444:


```
chromedriver --port=4444
```

In a separate process, run `flutter_drive`:

```
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/counter_test.dart \
  -d web-server
```

To learn more, see the
[Running Flutter driver tests with web][] wiki page.

## Testing on Firebase Test Lab 

You can use the Firebase Test Lab with both Android
and iOS targets.

### Android setup
Follow the instructions in the [Android Device Testing][]
section of the README.

### iOS setup
Follow the instructions in the [iOS Device Testing][]
section of the README.

### Test Lab project setup

Go to the [Firebase Console][],
and create a new project if you don't have one
already. Then navigate to **Quality > Test Lab**:

{% asset integration-test/test-lab-1.png class="mw-100" alt="Firebase Test Lab Console" %}

### Uploading an Android APK

Create an APK using Gradle:

```bash
pushd android
# flutter build generates files in android/ for building the app
flutter build apk
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug -Ptarget=integration_test/<name>_test.dart
popd
```

Where `<name>_test.dart` is the file created in the
**Project Setup** section.

Drag the "debug" APK from
`<flutter_project_directory>/build/app/outputs/apk/debug`
into the **Android Robo Test** target on the web page.
This starts a Robo test and allows you to run
other tests:

{% asset integration-test/test-lab-2.png class="mw-100" alt="Firebase Test Lab upload" %}

Click **Run a test**,
select the **Instrumentation** test type and drag
the following two files:
 
 * `<flutter_project_directory>/build/app/outputs/apk/debug/<file>.apk`
 * `<flutter_project_directory>/build/app/outputs/apk/androidTest/debug/<file>.apk`

{% asset integration-test/test-lab-3.png class="mw-100" alt="Firebase Test Lab upload two APKs" %}

If a failure occurs,
you can view the output by selecting the red icon:

{% asset integration-test/test-lab-4.png class="mw-100" alt="Firebase Test Lab test results" %}

### Uploading an Android APK from the command line

See the [Firebase Test Lab section of the README][]
for instructions on uploading the APKs from the command line.

## Migrating from flutter_driver

To migrate from flutter_driver,
use the following steps:
 
1. Remove any calls to `enableFlutterDriverExtension()`
   in your application. 
2. Migrate any `test_driver` scripts to use
   `package:integration_test` and `WidgetTester`
   instead of package:flutter_driver.

Code before migration:

<?code-excerpt "integration_test/test_driver/before.dart"?>
```dart
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('end-to-end test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) driver.close();
    });

    test('tap on the floating action button; verify counter', () async {
      // Finds the floating action button to tap on.
      SerializableFinder fab = find.byTooltip('Increment');

      // Wait for the floating action button to appear.
      await driver.waitFor(fab);

      // Emulate a tap on the floating action button.
      await driver.tap(fab);

      // Wait for text to change to the desired value.
      await driver.waitFor(find.text('1'));
    });
  });
}
```

Code after migration:

<?code-excerpt "integration_test/integration_test/counter_test.dart"?>
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// The application under test.
import 'package:integration_test_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button; verify counter',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('Increment');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });
  });
}
```

Instead of calling `driver.wait*` API,
use `WidgetTester.pumpAndSettle()` or
equivalent methods.

[Android Device Testing]: {{site.github}}/flutter/flutter/tree/master/packages/integration_test#android-device-testing
[Download and install ChromeDriver]: https://chromedriver.chromium.org/downloads
[Firebase Console]: http://console.firebase.google.com/
[Firebase Test Lab]: https://firebase.google.com/docs/test-lab
[Firebase Test Lab section of the README]: {{site.github}}/flutter/flutter/tree/master/packages/integration_test#firebase-test-lab
[flutter_test]: {{site.api}}/flutter/flutter_test/flutter_test-library.html
[`integration_test`]: {{site.github}}/flutter/flutter/tree/master/packages/integration_test#integration_test
[integration_test usage]: {{site.github}}/flutter/flutter/tree/master/packages/integration_test#usage
[iOS Device Testing]: {{site.github}}/flutter/flutter/tree/master/packages/integration_test#ios-device-testing
[Running Flutter driver tests with web]: {{site.github}}/flutter/flutter/wiki/Running-Flutter-Driver-tests-with-Web
[widget tests]: /docs/testing#widget-tests
