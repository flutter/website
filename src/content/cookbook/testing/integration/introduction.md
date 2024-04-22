---
title: An introduction to integration testing
description: Learn about integration testing in Flutter.
short-title: Introduction
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
how to set up integration tests, how to verify specific text is displayed
by the app, how to tap specific widgets, and how to run integration tests.

This recipe uses the following steps:

  1. Create an app to test.
  2. Add the `integration_test` dependency.
  3. Create the test files.
  4. Write the integration test.
  5. Run the integration test.

## Create a new app to test

Integration testing requires an app to test.
This example uses the built-in **Counter App** example
that Flutter produces when you run the `flutter create` command.
The counter app allows a user to tap on a button to increase a counter.

1. To create an instance of the built-in Flutter app,
   run the following command in your terminal:

   ```console
   $ flutter create counter_app
   ```

1. Change into the `counter_app` directory.

1. Open `lib/main.dart` in your preferred IDE.

1. Add a `key` parameter to the `floatingActionButton()` widget
   with a value of a `Key` class with a string of `increment`.

   ```dart
    floatingActionButton: FloatingActionButton(
      [!key: const Key('increment'),!]
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),
   ```

1. Save your `lib/main.dart` file.

After these changes,
the `lib/main.dart` file should resemble the following code.

<?code-excerpt "lib/main.dart"?>
```dart title="lib/main.dart"
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Counter App',
      home: MyHomePage(title: 'Counter App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Provide a Key to this button. This allows finding this
        // specific button inside the test suite, and tapping it.
        [!key: const Key('increment'),!]
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Add the `integration_test` dependency

You need to add the testing packages to your new app.

To add `integration_test` and `flutter_test` packages as
`dev_dependencies` using `sdk: flutter`, run following command.

```console
$ flutter pub add 'dev:integration_test:{"sdk":"flutter"}'
```
Output
```console
Building flutter tool...
Resolving dependencies... 
Got dependencies.
Resolving dependencies... 
+ file 7.0.0
+ flutter_driver 0.0.0 from sdk flutter
+ fuchsia_remote_debug_protocol 0.0.0 from sdk flutter
+ integration_test 0.0.0 from sdk flutter
...
  test_api 0.6.1 (0.7.1 available)
  vm_service 13.0.0 (14.2.1 available)
+ webdriver 3.0.3
Changed 8 dependencies!
7 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
```

Updated `pubspec.yaml` file

```yaml title="pubspec.yaml"
# ...
dev_dependencies:
  # ... added depencies
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  [!integration_test:!]
    [!sdk: flutter!]
# ...
```

## Create the integration test files

1. Create a new directory named `integration_test`.
1. Add empty file named `app_test.dart` in that directory.

The resulting directory tree should resemble the following:

```plaintext
counter_app/
  lib/
    main.dart
  integration_test/
    app_test.dart
```

## Write the integration test

1. Open your `integration_test/app_test.dart` file in your preferred IDE.

1. Copy the following code and paste it into your
   `integration_test/app_test.dart` file.
   The last import should point to the `main.dart` file of your
   `counter_app`.

   <?code-excerpt "integration_test/app_test.dart (IntegrationTest)"?>
   ```dart title="integration_test/app_test.dart"
   import 'package:flutter/material.dart';
   import 'package:flutter_test/flutter_test.dart';
   import 'package:integration_test/integration_test.dart';
   [!import 'package:counter_app/main.dart';!]
   
   void main() {
     IntegrationTestWidgetsFlutterBinding.ensureInitialized();
   
     group('end-to-end test', () {
       testWidgets('tap on the floating action button, verify counter',
           (tester) async {
         // Load app widget.
         await tester.pumpWidget(const MyApp());
   
         // Verify the counter starts at 0.
         expect(find.text('0'), findsOneWidget);
   
         // Finds the floating action button to tap on.
         final fab = find.byKey(const Key('increment'));
   
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

This example goes through three steps:

1. Initialize `IntegrationTestWidgetsFlutterBinding`.
   This singleton service executes tests on a physical device.

2. Interact and test widgets using the `WidgetTester` class.

3. Test the important scenarios.

## Run integration tests

The integration tests that run vary depending on the platform on which you test.
You can test against a mobile platform or the web.

### Test on a mobile device

To test on a real iOS or Android device

1. Connect the device.

1. Run the following command from the root of the project.

   ```console
   $ flutter test integration_test/app_test.dart
   ```

   The result should resemble the following output:

   ```console
   $ flutter test integration_test/app_test.dart
   00:04 +0: loading /path/to/counter_app/integration_test/app_test.dart
   00:15 +0: loading /path/to/counter_app/integration_test/app_test.dart
   00:18 +0: loading /path/to/counter_app/integration_test/app_test.dart   2,387ms
   Xcode build done.                                           13.5s
   00:21 +1: All tests passed!
   ```

1. Verify that the test removed the Counter App when it finished.
   If not, subsequent tests fail. If needed, press on the app and choose
   **Remove App** from the context menu.

To learn more, consult the [Integration testing][] page.

---

### Test in a web browser

{% comment %}
TODO(ryjohn): Add back after other WebDriver versions are supported:
https://github.com/flutter/flutter/issues/90158

To test for web,
determine which browser you want to test against
and download the corresponding web driver:

* Chrome: Download [ChromeDriver][]
* Firefox: [Download GeckoDriver][]
* Safari: Safari can only be tested on a Mac;
  the SafariDriver is already installed on Mac machines.
* Edge [Download EdgeDriver][]
{% endcomment -%}

To test in a web browser, perform the following steps.

1. Install [ChromeDriver][] into the directory of your choice.

   ```console
   $ npx @puppeteer/browsers install chromedriver@stable
   ```

   To simplify the install, this command uses the
   [`@puppeteer/browsers`][puppeteer] Node library.

   [puppeteer]: https://www.npmjs.com/package/@puppeteer/browsers

1. Add the path to ChromeDriver to your `$PATH` environment variable.

1. Verify the ChromeDriver install succeeded.

   ```console
   $ chromedriver --version
   ChromeDriver 124.0.6367.60 (8771130bd84f76d855ae42fbe02752b03e352f17-refs/branch-heads/6367@{#798})
   ```

1. In your `counter_app` project directory,
   create a new directory named `test_driver`.

   ```console
   $ mkdir test_driver
   ```

1. In this directory, create a new file named `integration_test.dart`.

1. Copy the following code and paste it into your `integration_test.dart` file.

   <?code-excerpt "test_driver/integration_test.dart"?>
   ```dart title="test_driver/integration_test.dart"
   import 'package:integration_test/integration_test_driver.dart';
   
   Future<void> main() => integrationDriver();
   ```

1. Launch `chromedriver` as follows:

   ```console
   $ chromedriver --port=4444
   ```

1. From the root of the project, run the following command:

   ```console
   $ flutter drive \
     --driver=test_driver/integration_test.dart \
     --target=integration_test/app_test.dart \
     -d chrome
   ```

   The response should resemble the following output:

   ```console
   Resolving dependencies...
     leak_tracker 10.0.0 (10.0.5 available)
     leak_tracker_flutter_testing 2.0.1 (3.0.5 available)
     leak_tracker_testing 2.0.1 (3.0.1 available)
     material_color_utilities 0.8.0 (0.11.1 available)
     meta 1.11.0 (1.14.0 available)
     test_api 0.6.1 (0.7.1 available)
     vm_service 13.0.0 (14.2.1 available)
   Got dependencies!
   7 packages have newer versions incompatible with dependency constraints.
   Try `flutter pub outdated` for more information.
   Launching integration_test/app_test.dart on Chrome in debug mode...
   Waiting for connection from debug service on Chrome...             10.9s
   This app is linked to the debug service: ws://127.0.0.1:51523/3lofIjIdmbs=/ws
   Debug service listening on ws://127.0.0.1:51523/3lofIjIdmbs=/ws
   00:00 +0: end-to-end test tap on the floating action button, verify counter
   00:01 +1: (tearDownAll)
   00:01 +2: All tests passed!
   All tests passed.
   Application finished.
   ```

   To run this as a headless test, run `flutter drive`
   with `-d web-server` option:

   ```console
   $ flutter drive \
     --driver=test_driver/integration_test.dart \
     --target=integration_test/app_test.dart \
     -d web-server
   ```

[ChromeDriver]: https://googlechromelabs.github.io/chrome-for-testing/
[Download EdgeDriver]: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
[Download GeckoDriver]: {{site.github}}/mozilla/geckodriver/releases
[flutter_driver]: {{site.api}}/flutter/flutter_driver/flutter_driver-library.html
[integration_test]: {{site.repo.flutter}}/tree/main/packages/integration_test
[Integration testing]: /testing/integration-tests
