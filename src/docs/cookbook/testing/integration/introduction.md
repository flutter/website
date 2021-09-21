---
title: An introduction to integration testing
description: Learn about integration testing in Flutter.
short-title: Introduction
prev:
  title: Take a picture using the camera
  path: /docs/cookbook/plugins/picture-using-camera
next:
  title: Performance profiling
  path: /docs/cookbook/testing/integration/scrolling
---

<?code-excerpt path-base="cookbook/testing/integration/introduction/"?>

Unit tests and widget tests are handy for testing individual classes,
functions, or widgets. However, they generally don't test how
individual pieces work together as a whole, or capture the performance
of an application running on a real device. These tasks are performed
with *integration tests*.

Integration tests are written using the [integration_test][] package, provided
by the SDK. 

In this recipe, learn how to test a counter app. It demonstrates
how to setup integration tests, how to verify specific text is displayed
by the app, how to tap specific widgets, and how to run integration tests.

This recipe uses the following steps:

  1. Create an app to test.
  2. Add the `integration_test` dependency.
  3. Create the test files.
  4. Write the integration test.
  5. Run the integration test.

### 1. Create an app to test

First, create an app for testing. In this example,
test the counter app produced by the `flutter create`
command. This app allows a user to tap on a button
to increase a counter.

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
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 2. Add the `integration_test` dependency

Next, use the `integration_test`, `flutter_driver`, and `flutter_test` packages
to write integration tests. Add these dependencies to the `dev_dependencies`
section of the app's `pubspec.yaml` file, specifying the Flutter SDK as the
location of the package.

```yaml
dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_driver:
    sdk: flutter
  flutter_test:
    sdk: flutter
```

### 3. Create the test files

Create a new directory, `integration_test`, with an empty `app_test.dart` file:

```
counter_app/
  lib/
    main.dart
  integration_test/
    app_test.dart
```

### 4. Write the integration test

Now that you have an instrumented app, you can write tests for it.
This involves four steps:

  1. Initialize `IntegrationTestWidgetsFlutterBinding`, a singleton service that
     executes tests on a physical device.
  2. Interact and tests widgets using the `WidgetTester` class.
  3. Test the important scenarios.

<?code-excerpt "integration_test/app_test.dart"?>
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:integration_test_experiments/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          // Verify the counter starts at 0.
          expect(find.text('0'), findsOneWidget);

          // Finds the floating action button to tap on.
          final Finder fab = find.byTooltip('Increment');

          // Emulate a tap on the floating action button.
          await tester.tap(fab);

          // Trigger a frame.
          await tester.pumpAndSettle();

          // Verify the counter increments by 1.
          expect(find.text('1'), findsOneWidget);
        });
  });
}
```

### 5. Run the integration test

The process of running the integration tests varies depending on the platform
you are testing against. You can test against a mobile platform or the web.

#### 5a. Mobile

To test on a real iOS / Android device, first connect the device and run the
following command from the root of the project:

```shell
flutter test integration_test/app_test.dart
```
 
This command runs the app and integration tests on the target device. For more
information, see the [Integration testing][] page.

---

#### 5b. Web

<!--
TODO(ryjohn): Add back after other WebDriver versions are supported:
https://github.com/flutter/flutter/issues/90158

To test for web,
determine which browser you want to test against
and download the corresponding web driver:

  * Chrome: [Download ChromeDriver][]
  * Firefox: [Download GeckoDriver][]
  * Safari: Safari can only be tested on a Mac;
    the SafariDriver is already installed on Mac machines.
  * Edge [Download EdgeDriver][]
-->

To get started testing in a web browser, [Download ChromeDriver][].

Next, create a new directory named `test_driver` containing a new file
named`integration_test.dart`:

```dart
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
```

Launch WebDriver, for example: 

```shell
chromedriver --port=4444
```

From the root of the project, run the following command:

```shell
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  -d web-server
```

[Download ChromeDriver]: https://chromedriver.chromium.org/downloads
[Download EdgeDriver]: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
[Download GeckoDriver]: https://github.com/mozilla/geckodriver/releases
[flutter_driver]: {{site.api}}/flutter/flutter_driver/flutter_driver-library.html
[integration_test]: {{site.github}}/flutter/flutter/tree/master/packages/integration_test
[Integration testing]: /docs/testing/integration-tests
[`SerializableFinders`]: {{site.api}}/flutter/flutter_driver/CommonFinders-class.html
[`ValueKey`]: {{site.api}}/flutter/foundation/ValueKey-class.html
