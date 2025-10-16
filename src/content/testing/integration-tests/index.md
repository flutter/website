---
title: Check app functionality with an integration test
description: Learn how to write integration tests
---

<?code-excerpt path-base="testing/integration_tests/how_to"?>

## Introduction

This guide describes how to run integration tests with your Flutter app. With
it, you'll learn how to do the following:

* Set up integration tests.
* Verify if an app displays specific text.
* Tap specific widgets.
* Run integration tests.

The guide references the `counter_app` project that comes with
Flutter and the Flutter [`integration_test`][] package. The
`integration_test` package lets you:

* Use the `flutter drive` command to run tests on a physical device or emulator.
* Run on [Firebase Test Lab][], to automate testing on a variety of devices.
* Use [flutter_test][] APIs to write tests in a style similar to
  [widget tests][].

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
   with an instance of a `Key` class with a string value of `increment`.

   ```dart
    floatingActionButton: FloatingActionButton(
      [!key: const ValueKey('increment'),!]
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
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
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
        key: const Key('increment'),
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

Output:

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

Updated `pubspec.yaml` file:

```yaml title="pubspec.yaml"
# ...
dev_dependencies:
  # ... added dependencies
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  [!integration_test:!]
    [!sdk: flutter!]
# ...
```

## Create the integration test files

Integration tests reside in a separate directory inside
your Flutter project.

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

The integration test file consists of a Dart code file
with dependencies on `integration_test`, `flutter_test`,
and your app's Dart file.

1. Open your `integration_test/app_test.dart` file in your preferred IDE.

1. Copy the following code and paste it into your
   `integration_test/app_test.dart` file.
   The last import should point to the `main.dart` file
   of your `counter_app`.
   (This `import` points to the example app called `introduction`.)

    <?code-excerpt "integration_test/counter_test.dart (initial)" replace="/introduction/counter_app/g"?>
    ```dart title="integration_test/counter_test.dart"
    import 'package:flutter/material.dart';
    import 'package:flutter_test/flutter_test.dart';
    import 'package:how_to/main.dart';
    import 'package:integration_test/integration_test.dart';
    
    void main() {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    
      group('end-to-end test', () {
        testWidgets('tap on the floating action button, verify counter', (
          tester,
        ) async {
          // Load app widget.
          await tester.pumpWidget(const MyApp());
    
          // Verify the counter starts at 0.
          expect(find.text('0'), findsOneWidget);
    
          // Finds the floating action button to tap on.
          final fab = find.byKey(const ValueKey('increment'));
    
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

The integration tests that run vary depending on the
platform on which you test.

* To test a desktop platform, use the command line or a CI system.
* To test a mobile platform, use the command line or Firebase Test Lab.
* To test in a web browser, use the command line.

---

### Test on a desktop platform

<details markdown="1">
<summary>Expand if you test Linux apps using a CI system</summary>

To test a Linux app, your CI system must invoke an X server first.
In the GitHub Action, GitLab Runner, or similar configuration file,
set the integration test to work _with_ the `xvfb-run` tool.

Doing this invokes an X Window system into which Flutter can
launch and test your Linux app.

As an example using GitHub Actions, your `jobs.setup.steps` should
include a step resembling the following:

```yaml
      - name: Run Integration Tests
        uses: username/xvfb-action@v1.1.2
        with:
          run: flutter test integration_test -d linux -r github
```

This starts the integration test within an X Window.

If you don't configure your integration in this way,
Flutter returns an error.

```console
Building Linux application...
Error waiting for a debug connection: The log reader stopped unexpectedly, or never started.
```

</details>

To test on a macOS, Windows, or Linux platform,
complete the following tasks.

1. Run the following command from the root of the project.

   ```console
   $ flutter test integration_test/app_test.dart
   ```

1. If offered a choice of platform to test,
   choose the desktop platform.
   Type `1` to choose the desktop platform.

Based on platform, the command result should resemble the following output.

<Tabs key="dev-os">
<Tab name="Windows">

{% render "docs/test/integration/windows-example.md" %}

</Tab>
<Tab name="macOS">

{% render "docs/test/integration/macos-example.md" %}

</Tab>
<Tab name="Linux">

{% render "docs/test/integration/linux-example.md" %}

</Tab>
</Tabs>

---

### Test on an Android device

To test on a real Android device,
complete the following tasks.

1.  Connect the Android device.

1.  Run the following command from the root of the project.

    ```console
    $ flutter test integration_test/app_test.dart
    ```

    The result should resemble the following output.

    ```console
    $ flutter test integration_test/app_test.dart
    00:04 +0: loading /path/to/counter_app/integration_test/app_test.dart
    00:15 +0: loading /path/to/counter_app/integration_test/app_test.dart
    00:18 +0: loading /path/to/counter_app/integration_test/app_test.dart   2,387ms
    Installing build/app/outputs/flutter-apk/app.apk...  612ms
    00:21 +1: All tests passed!
    ```

1.  Verify that the test removed the Counter App when it finished.
    If not, subsequent tests fail. If needed, press on the app and choose
    **Remove App** from the context menu.

---

### Test on an iOS device

To test on a real iOS device, complete the following tasks.

1. Connect the iOS device.

1. Run the following command from the root of the project.

   ```console
   $ flutter test integration_test/app_test.dart
   ```

   The result should resemble the following output.

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

To learn more, see the
[Running Flutter driver tests with web][] wiki page.

---

### Test in Firebase Test Lab (Android)

You can use Firebase Test Lab to test Android targets.

#### Android setup

Follow the instructions in the [Android Device Testing][]
section of the README.

#### Test Lab project setup

1. Launch your [Firebase Console][].

1. Create a new Firebase project if necessary.

1. Navigate to **Quality > Test Lab**.

   <img src='/assets/images/docs/integration-test/test-lab-1.png' alt="Firebase Test Lab Console">

#### Upload an Android APK

Complete the following steps to upload an Android APK.

1.  Create an APK using Gradle.

    ```console
    // Go to the Android directory which contains the gradlew script
    $ pushd android

    // Build a debug APK for Flutter with gradlew
    // Note that a standard --release build will not include package:integration_test
    $ flutter build apk --debug

    // Build an Android test APK
    $ ./gradlew app:assembleAndroidTest

    // Build a debug APK by passing in an integration test
    $ ./gradlew app:assembleDebug -Ptarget=integration_test/<name>_test.dart
    ```

    *  `<name>_test.dart`: The file created in the **Project Setup** section.

  1.  If needed, pass parameters into the integration test as a comma-separated
      list. Encode all parameters as `base64`.

      ```console
      $ ./gradlew project:task -Pdart-defines="{base64 (key=value)}[, ...]"
      ```

      * `(key=value)}[, ...]`: Replace this with a comma-separated list of
        key value pairs.

  1.  Return to your previous directory.

      ```console
      $ popd
      ```

For additional instructions, see the
[Firebase Test Lab section of the README][].

#### Start Robo test

To use Robo test to run integration tests, complete the following steps.

1.  Drag the debug APK from
    `<flutter_project_directory>/build/app/outputs/apk/debug`
    into the **Android Robo Test** target on the web page. For example:

    <img src='/assets/images/docs/integration-test/test-lab-2.png' alt="Firebase Test Lab upload">

1.  Click **Run a test**.

1.  Select the **Instrumentation** test type.

1.  Add the App APK to the **App APK or AAB** box.

    `<flutter_project_directory>/build/app/outputs/apk/debug/<file>.apk`

1.  Add the Test APK to the **Test APK** box.

    `<flutter_project_directory>/build/app/outputs/apk/androidTest/debug/<file>.apk`

    <img src='/assets/images/docs/integration-test/test-lab-3.png' alt="Firebase Test Lab upload two APKs">

1.  If a failure occurs, click the red icon to view the output:

    <img src='/assets/images/docs/integration-test/test-lab-4.png' alt="Firebase Test Lab test results">

---

### Test in Firebase Test Lab (iOS)

You can use Firebase Test Lab to test iOS targets.

#### iOS setup

Follow the [iOS Device Testing instructions][].

#### Test Lab project setup

1. Launch your [Firebase Console][].

1. Create a new Firebase project if necessary.

1. Navigate to **Quality > Test Lab**.

   <img src='/assets/images/docs/integration-test/test-lab-1.png' alt="Firebase Test Lab Console">

#### Upload Xcode tests through the Firebase Console

To learn how to upload tests from a ZIP file, using the
Firebase Test Lab Console, consult the [Firebase Test Lab iOS instructions][].

#### Upload Xcode tests to Firebase Console with the command line

To learn how to upload tests from a ZIP file from the command line to the
Firebase Test Lab Console, consult the [iOS Device Testing instructions][].

[`integration_test`]: {{site.repo.flutter}}/tree/main/packages/integration_test#integration_test
[Android Device Testing]: {{site.repo.flutter}}/tree/main/packages/integration_test#android-device-testing
[ChromeDriver]: https://googlechromelabs.github.io/chrome-for-testing/
[Download EdgeDriver]: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
[Download GeckoDriver]: {{site.github}}/mozilla/geckodriver/releases
[Firebase Console]: https://console.firebase.google.com/
[Firebase Test Lab section of the README]: {{site.repo.flutter}}/tree/main/packages/integration_test#firebase-test-lab
[Firebase Test Lab]: {{site.firebase}}/docs/test-lab
[Firebase Test Lab iOS instructions]: {{site.firebase}}/docs/test-lab/ios/firebase-console
[flutter_test]: {{site.api}}/flutter/flutter_test/flutter_test-library.html
[Integration testing]: /testing/integration-tests
[iOS Device Testing instructions]: {{site.repo.flutter}}/tree/main/packages/integration_test#ios-device-testing
[Running Flutter driver tests with web]: {{site.repo.flutter}}/blob/main/docs/contributing/testing/Running-Flutter-Driver-tests-with-Web.md
[widget tests]: /testing/overview#widget-tests
[flutter_driver]: {{site.api}}/flutter/flutter_driver/flutter_driver-library.html
[integration_test usage]: {{site.repo.flutter}}/tree/main/packages/integration_test#usage
[samples]: {{site.repo.samples}}
[testing_app]: {{site.repo.samples}}/tree/main/testing_app/integration_test
[testWidgets]: {{site.api}}/flutter/flutter_test/testWidgets.html
