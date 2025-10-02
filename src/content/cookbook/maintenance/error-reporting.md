---
title: Report errors to a service
description: How to keep track of errors that users encounter.
---

<?code-excerpt path-base="cookbook/maintenance/error_reporting/"?>

While one always tries to create apps that are free of bugs,
they're sure to crop up from time to time.
Since buggy apps lead to unhappy users and customers,
it's important to understand how often your users
experience bugs and where those bugs occur.
That way, you can prioritize the bugs with the
highest impact and work to fix them.

How can you determine how often your users experiences bugs?
Whenever an error occurs, create a report containing the
error that occurred and the associated stacktrace.
You can then send the report to an error tracking
service, such as [Bugsnag][], [Datadog][],
[Firebase Crashlytics][], [Rollbar][], or Sentry.

The error tracking service aggregates all of the crashes your users
experience and groups them together. This allows you to know how often your
app fails and where the users run into trouble.

In this recipe, learn how to report errors to the
[Sentry][] crash reporting service using
the following steps:

  1. Get a DSN from Sentry.
  2. Import the Flutter Sentry package
  3. Initialize the Sentry SDK
  4. Capture errors programmatically

## 1. Get a DSN from Sentry

Before reporting errors to Sentry, you need a "DSN" to uniquely identify
your app with the Sentry.io service.

To get a DSN, use the following steps:

  1. [Create an account with Sentry][].
  2. Log in to the account.
  3. Create a new Flutter project.
  4. Copy the code snippet that includes the DSN.

## 2. Import the Sentry package

Import the [`sentry_flutter`][] package into the app.
The sentry package makes it easier to send
error reports to the Sentry error tracking service.

To add the `sentry_flutter` package as a dependency,
run `flutter pub add`:

```console
$ flutter pub add sentry_flutter
```

## 3. Initialize the Sentry SDK

Initialize the SDK to capture different unhandled errors automatically:

<?code-excerpt "lib/main.dart (InitializeSDK)"?>
```dart
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) => options.dsn = 'https://example@sentry.io/example',
    appRunner: () => runApp(const MyApp()),
  );
}
```

Alternatively, you can pass the DSN to Flutter using the `dart-define` tag:

```sh
--dart-define SENTRY_DSN=https://example@sentry.io/example
```

### What does that give me?

This is all you need for Sentry to
capture unhandled errors in Dart and native layers.
This includes Swift, Objective-C, C, and C++ on iOS, and
Java, Kotlin, C, and C++ on Android.

## 4. Capture errors programmatically

Besides the automatic error reporting that Sentry generates by
importing and initializing the SDK,
you can use the API to report errors to Sentry:

<?code-excerpt "lib/main.dart (CaptureException)"?>
```dart
await Sentry.captureException(exception, stackTrace: stackTrace);
```

For more information, see the [Sentry API][] docs on pub.dev.

## Learn more

Extensive documentation about using the Sentry SDK can be found on [Sentry's site][].

## Complete example

To view a working example,
see the [Sentry flutter example][] app.


[Sentry flutter example]: {{site.github}}/getsentry/sentry-dart/tree/main/flutter/example
[Create an account with Sentry]: https://sentry.io/signup/
[Bugsnag]: https://www.bugsnag.com/platforms/flutter
[Datadog]: https://docs.datadoghq.com/real_user_monitoring/flutter/
[Rollbar]: https://rollbar.com/
[Sentry]: https://sentry.io/welcome/
[`sentry_flutter`]: {{site.pub-pkg}}/sentry_flutter
[Sentry API]: {{site.pub-api}}/sentry_flutter/latest/sentry_flutter/sentry_flutter-library.html
[Sentry's site]: https://docs.sentry.io/platforms/flutter/
[Firebase Crashlytics]: {{site.firebase}}/docs/crashlytics
