---
title: An introduction to integration testing
description: Learn about integration testing in Flutter.
short-title: Introduction
prev:
  title: Take a picture using the camera
  path: /docs/cookbook/plugins/picture-using-camera
next:
  title: Handle scrolling
  path: /docs/cookbook/testing/integration/scrolling
---

<?code-excerpt path-base="../null_safety_examples/cookbook/testing/integration/introduction/"?>

{{site.alert.note}}
  The integration_test package is now the recommended way to write integration
  tests. See the [Integration testing](/docs/testing/integration-tests/) page
  for details.
{{site.alert.end}}


Unit tests and widget tests are handy for testing individual classes,
functions, or widgets. However, they generally don't test how
individual pieces work together as a whole, or capture the performance
of an application running on a real device. These tasks are performed
with *integration tests*.

Integration tests work as a pair: first, deploy an instrumented application
to a real device or emulator and then "drive" the application from a
separate test suite, checking to make sure everything is correct along
the way.

To create this test pair, use the [flutter_driver][] package.
It provides tools to create instrumented apps and drive those apps
from a test suite.

In this recipe, learn how to test a counter app. It demonstrates
how to setup integration tests, how to verify specific text is displayed
by the app, how to tap specific widgets, and how to run integration tests.

This recipe uses the following steps:

  1. Create an app to test.
  2. Add the `flutter_driver` dependency.
  3. Create the test files.
  4. Instrument the app.
  5. Write the integration tests.
  6. Run the integration test.

### 1. Create an app to test

First, create an app for testing. In this example,
test the counter app produced by the `flutter create`
command. This app allows a user to tap on a button
to increase a counter.

Furthermore, provide a [`ValueKey`][] to
the `Text` and `FloatingActionButton` widgets.
This allows identifying and interacting with these
specific widgets inside the test suite.

<?code-excerpt "lib/main.dart"?>
```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Counter App',
      home: MyHomePage(title: 'Counter App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              // Provide a Key to this specific Text widget. This allows
              // identifying the widget from inside the test suite,
              // and reading the text.
              key: const Key('counter'),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Provide a Key to this button. This allows finding this
        // specific button inside the test suite, and tapping it.
        key: const Key('increment'),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 2. Add the `flutter_driver` dependency

Next, use the `flutter_driver` package to write integration tests.
Add the `flutter_driver` dependency to the `dev_dependencies` section of
the app's `pubspec.yaml` file.

Also add the `test` dependency in order to use actual test functions and
assertions.

```yaml
dev_dependencies:
  flutter_driver:
    sdk: flutter
  test: any
```

### 3. Create the test files

Unlike unit and widget tests, integration test suites do not run in the same
process as the app being tested. Therefore, create two files that
reside in the same directory. By convention, the directory is named
`test_driver`.

  1. The first file contains an "instrumented" version of the app.
     The instrumentation allows you to "drive" the app and record
     performance profiles from a test suite. This file can have any
     name that makes sense. For this example, create a file called
    `test_driver/app.dart`.
  2. The second file contains the test suite, which drives the app and
     verifies that it works as expected. The test suite also records
     performance profiles. The name of the test file must correspond
     to the name of the file that contains the instrumented app,
     with `_test` added at the end. Therefore,
     create a second file called `test_driver/app_test.dart`.

This creates the following directory structure:

```
counter_app/
  lib/
    main.dart
  test_driver/
    app.dart
    app_test.dart
```

### 4. Instrument the app

Now, instrument the app. This involves two steps:

  1. Enable the flutter driver extensions.
  2. Run the app.

Add the following code inside the
`test_driver/app.dart` file.

<?code-excerpt "test_driver/app.dart"?>
```dart
import 'package:flutter_driver/driver_extension.dart';
import 'package:introduction/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
```

### 5. Write the tests

Now that you have an instrumented app, you can write tests for it.
This involves four steps:

  1. Create [`SerializableFinders`][]
     to locate specific widgets.
  2. Connect to the app before our tests run in the `setUpAll()` function.
  3. Test the important scenarios.
  4. Disconnect from the app in the `teardownAll()` function after the tests
     complete.

<?code-excerpt "test_driver/app_test.dart"?>
```dart
// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');

    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(counterTextFinder), "0");
    });

    test('increments the counter', () async {
      // First, tap the button.
      await driver.tap(buttonFinder);

      // Then, verify the counter text is incremented by 1.
      expect(await driver.getText(counterTextFinder), "1");
    });

    test('increments the counter during animation', () async {
      await driver.runUnsynchronized(() async {
        // First, tap the button.
        await driver.tap(buttonFinder);

        // Then, verify the counter text is incremented by 1.
        expect(await driver.getText(counterTextFinder), "1");
      });
    });
  });
}
```

By default, `flutter_driver` waits until there are no pending frames,
and tests similar to the example above fail with a timeout if,
for example, you have a continuous animation running.  In that case, wrap
the driver actions in `runUnsynchronized` as follows:

<?code-excerpt "test_driver/app_test.dart (Unsynchronized)"?>
```dart
test('increments the counter during animation', () async {
  await driver.runUnsynchronized(() async {
    // First, tap the button.
    await driver.tap(buttonFinder);

    // Then, verify the counter text is incremented by 1.
    expect(await driver.getText(counterTextFinder), "1");
  });
});
```

### 6. Run the tests

Now that you have an instrumented app _and_ a test suite,
run the tests. The process of running the integration
tests varies depending on the platform you are testing
against. You can test against a mobile platform or the web.

#### 6a. Mobile

To test on iOS or Android,
launch an Android Emulator, iOS Simulator,
or connect your computer to a real iOS / Android device.

Then, run the following command from the root of the project:

```shell
flutter drive --target=test_driver/app.dart
```

This command performs the following:

* Builds the `--target` app and installs
  it on the emulator / device.
* Launches the app.
* Runs the `app_test.dart` test suite located
  in `test_driver/` folder.

---

#### 6b. Web

To test for web,
determine which browser you want to test against
and download the corresponding web driver:

  * Chrome: [Download ChromeDriver][]
  * Firefox: [Download GeckoDriver][]
  * Safari: Safari can only be tested on a Mac;
    the SafariDriver is already installed on Mac machines.
  * Edge [Download EdgeDriver][]

Launch the WebDriver, for example: 

```shell
./chromedriver --port=4444
```
From the root of the project,
run the following command:

```shell
flutter drive --target=test_driver/app.dart --browser-name=[browser name] --release
```

To simulate different screen dimensions, you can use the `--browser-dimension` argument,
for example:

```shell
flutter drive --target=test_driver/app.dart --browser-name=chrome --browser-dimension 300,550 --release
```

Will run the tests in the `chrome` browser in a window with dimensions 300 by 550.

[Download ChromeDriver]: https://chromedriver.chromium.org/downloads
[Download EdgeDriver]: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
[Download GeckoDriver]: https://github.com/mozilla/geckodriver/releases
[flutter_driver]: {{site.api}}/flutter/flutter_driver/flutter_driver-library.html
[`SerializableFinders`]: {{site.api}}/flutter/flutter_driver/CommonFinders-class.html
[`ValueKey`]: {{site.api}}/flutter/foundation/ValueKey-class.html
