---
title: Write and run a Patrol test
description: Learn how to write and run integration tests with Patrol
---

## Introduction

[Patrol][] is an open-source testing framework for Flutter that
extends the capabilities of `integration_test` with native
platform interaction support. With Patrol, you can:

* Interact with native platform UI, such as permission dialogs,
  notifications, and WebViews.
* Access device-level features like toggling Wi-Fi
  or adjusting system settings.
* Write more concise tests using [patrol finders][].
* Iterate faster with hot restart during test development.

This guide walks you through setting up, writing,
and running a Patrol test using the same Counter App example
from the [integration test guide][].

## Set up Patrol

For complete setup instructions, including installing the Patrol CLI,
adding dependencies, and configuring native platform integration,
see the [Patrol documentation][].

## Create a test app

This guide uses the same Counter App from the
[integration test guide][].
If you haven't already, follow the steps in that guide to
[create the Counter App][create app]
with a `Key` added to the floating action button.

## Create the test files

1. Create a directory named `patrol_test` in your project root.
1. Add a new file named `app_test.dart` in that directory.

The resulting directory tree should resemble the following:

```plaintext
counter_app/
  lib/
    main.dart
  patrol_test/
    app_test.dart
```

## Write a Patrol test

Open `patrol_test/app_test.dart` and add the following code:

```dart title="patrol_test/app_test.dart"
import 'package:counter_app/main.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('tap on the floating action button, verify counter', ($) async {
    // Load app widget.
    await $.pumpWidgetAndSettle(const MyApp());

    // Verify the counter starts at 0.
    await $('0').waitUntilVisible();

    // Tap the floating action button.
    await $(#increment).tap();

    // Verify the counter increments by 1.
    await $('1').waitUntilVisible();
  });
}
```

This example highlights the differences from a standard
`integration_test` test:

* **`patrolTest`** replaces `testWidgets` and sets up the
  Patrol test environment.
* **`$`** is the `PatrolIntegrationTester`, which provides
  access to both widget and native interactions.
* **`$.pumpWidgetAndSettle`** loads the app and waits for
  all animations to complete.
* **`$(#increment)`** finds a widget by its `Key` using
  Patrol's concise finder syntax.
  You can also find widgets by type (`$(FloatingActionButton)`)
  or by text (`$('some text')`).

:::warning
When initializing your app inside a Patrol test,
don't call `runApp()` or `WidgetsFlutterBinding.ensureInitialized()`
directly - Patrol handles this for you.
For the full list of requirements, see
[Initializing app inside a test][].
:::

## Patrol finders

Patrol provides its own finder system that is more concise
and readable than Flutter's default `find.*` API.
Instead of verbose calls like `find.byKey(const Key('login'))`,
Patrol lets you write `$(#login)`. Finders also support
chaining, so you can locate widgets nested inside other
widgets without complex predicates.

You can find widgets in several ways:

| Syntax | Description |
|---|---|
| `$('text')` | Find by text content |
| `$(Type)` | Find by widget type |
| `$(#key)` | Find by `Key` |
| `$(Icon)` | Find by icon |

{:.table .table-striped}

### Chaining finders

Nest finders to target widgets within other widgets:

```dart
// Find 'Subscribe' text inside a ListView
await $(ListView).$('Subscribe').tap();

// Find a widget by key inside a ListTile containing specific text
await $(ListTile).containing('Activated').$(#learnMore).tap();
```

### Common actions

```dart
// Tap on a widget
await $('Subscribe').tap();

// Tap on the third occurrence
await $('Subscribe').at(2).tap();

// Enter text
await $(#cityTextField).enterText('Warsaw, Poland');

// Scroll to a widget and tap
await $('Subscribe').scrollTo().tap();

// Wait for a widget to become visible
await $('Log in').waitUntilVisible();
```

For the full finder API, see the [patrol finders][] package.

## Platform interactions

Patrol lets you interact with platform features
directly from your Dart test code through the `$.platform` API.

### Example: Testing a location permission request

This example extends the Counter App with a button that
requests location permission, and a Patrol test that
handles the native permission dialog.

First, add the [`geolocator`][geolocator] package to your app:

```console
$ flutter pub add geolocator
```

For Android, add the required permission to your `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

For iOS, add the required permission to your `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location permission to show your location.</string>
```

Then, add a location permission button to your app:

```dart title="lib/main.dart"
import 'package:geolocator/geolocator.dart';

// ... inside _MyHomePageState ...

String _permissionStatus = 'unknown';

Future<void> _requestLocationPermission() async {
  final permission = await Geolocator.requestPermission();
  setState(() {
    _permissionStatus = permission.name;
  });
}

// ... inside build method, add to the Column children ...

ElevatedButton(
  key: const Key('requestLocation'),
  onPressed: _requestLocationPermission,
  child: const Text('Request location'),
),
Text('Permission: $_permissionStatus'),
```

Now, write a Patrol test that handles the native
permission dialog:

```dart title="patrol_test/permission_test.dart"
import 'package:counter_app/main.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('grants location permission', ($) async {
    await $.pumpWidgetAndSettle(const MyApp());

    // Tap the button that triggers the permission request.
    await $(#requestLocation).tap();

    // Handle the native permission dialog.
    if (await $.platform.mobile.isPermissionDialogVisible()) {
      await $.platform.mobile.grantPermissionWhenInUse();
    }

    // Verify that the permission was granted.
    await $('Permission: whileInUse').waitUntilVisible();
  });
}
```

### Other platform actions

Beyond permissions, the `$.platform` API provides access to
many other platform features:

```dart
// Interact with notifications
await $.platform.mobile.openNotifications();
await $.platform.mobile.tapOnNotificationByIndex(0);

// Navigate the device
await $.platform.mobile.pressHome();

// Platform-specific actions
await $.platform.android.pressBack();
await $.platform.ios.swipeBack();
```

For detailed information on all available platform interactions,
see the [Patrol native automation documentation][].

For more examples of native interaction tutorials,
see the [Patrol feature guide][].

## Run Patrol tests

```console
$ patrol test -t patrol_test/app_test.dart
```

### Test on an Android device

Make sure that you followed all the Android setup steps from the
[setup guide][Patrol documentation].

Connect an Android device or start an emulator, then run:

```console
$ patrol test -t patrol_test/app_test.dart
```

---

### Test on an iOS device

Connect an iOS device or start a simulator, then run:

```console
$ patrol test -t patrol_test/app_test.dart
```

To target a specific iOS version on the simulator,
use the `--ios` flag (for example, `--ios=17.5`).
If omitted, `latest` is used.
This flag only works with the iOS simulator and is supported by both
`test` and `develop` commands.

:::note
Running on a physical iOS device requires additional setup.
See [Physical iOS devices setup][] for more information.
:::

---

### Test in a web browser

Patrol supports web testing using [Playwright][].
You need [Node.js][] installed before running web tests.

```console
$ patrol test --device chrome -t patrol_test/app_test.dart
```

To run headless (for CI environments):

```console
$ patrol test --device chrome -t patrol_test/app_test.dart --web-headless true
```

---

### Development mode with hot restart

For faster iteration while writing tests,
use the `develop` command:

```console
$ patrol develop -t patrol_test/app_test.dart
```

In this mode, press `r` in the terminal to re-run tests
without rebuilding the entire app.

:::note
`patrol develop` is not supported on web due to
[a Flutter issue](https://github.com/flutter/flutter/issues/175318).
:::

---

### Test results

After a test run, Patrol generates native test reports:

* **Android**: An HTML report is saved to
  `build/app/reports/androidTests/connected/debug/index.html`.
  Note that this path may differ depending on the build flavor used.
  For more details, see the [Patrol native test reports documentation][].
* **iOS**: An `.xcresult` bundle is saved to
  `build/ios_results_<timestamp>.xcresult`.
  Open it in Xcode to view logs and test recordings.

For more details on logs and configuration options,
see the [Patrol logs documentation][].

---

## Learn more

* [Patrol documentation][]
* [patrol package on pub.dev][Patrol]
* [patrol_finders package on pub.dev][patrol finders]
* [Patrol on GitHub][]

[create app]: /testing/integration-tests#create-a-new-app-to-test
[patrol finders]: {{site.pub-pkg}}/patrol_finders
[geolocator]: {{site.pub-pkg}}/geolocator
[Initializing app inside a test]: https://patrol.leancode.co/documentation#initializing-app-inside-a-test
[integration test guide]: /testing/integration-tests
[Node.js]: https://nodejs.org/
[Patrol]: {{site.pub-pkg}}/patrol
[Patrol documentation]: https://patrol.leancode.co/documentation
[Patrol Firebase Test Lab documentation]: https://patrol.leancode.co/documentation/integrations/firebase-test-lab
[Patrol logs documentation]: https://patrol.leancode.co/documentation/logs
[Patrol native test reports documentation]: https://patrol.leancode.co/documentation/logs#native-test-reports
[Patrol feature guide]: https://patrol.leancode.co/feature-guide
[Patrol native automation documentation]: https://patrol.leancode.co/documentation/native/usage
[Patrol supported platforms]: https://patrol.leancode.co/documentation/supported-platforms
[Physical iOS devices setup]: https://patrol.leancode.co/documentation/physical-ios-devices-setup
[Patrol on GitHub]: {{site.github}}/leancodepl/patrol
[Playwright]: https://playwright.dev/
