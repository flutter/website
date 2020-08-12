---
title: Report errors to a service
description: How to keep track of errors that users encounter.
prev:
  title: Work with long lists
  path: /docs/cookbook/lists/long-lists
next:
  title: Animate a widget across screens
  path: /docs/cookbook/navigation/hero-animations
---

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
service, such as Sentry, Fabric, or [Rollbar][].

The error tracking service aggregates all of the crashes your users
experience and groups them together. This allows you to know how often your
app fails and where the users run into trouble.

In this recipe, learn how to report errors to the
[Sentry][] crash reporting service using
the following steps:

  1. Get a DSN from Sentry.
  2. Import the Sentry package.
  3. Create a `SentryClient`.
  4. Create a function to report errors.
  5. Catch and report Dart errors.
  6. Catch and report Flutter errors.

## 1. Get a DSN from Sentry

Before reporting errors to Sentry, you need a "DSN" to uniquely identify
your app with the Sentry.io service.

To get a DSN, use the following steps:

  1. [Create an account with Sentry][].
  2. Log in to the account.
  3. Create a new app.
  4. Copy the DSN.

## 2. Import the Sentry package

Import the [`sentry`][] package into the app.
The sentry package makes it easier to send
error reports to the Sentry error tracking service.

```yaml
dependencies:
  sentry: <latest_version>
```

## 3. Create a `SentryClient`

Create a `SentryClient`. Use the `SentryClient` to send
error reports to the sentry service.

<!-- skip -->
```dart
final SentryClient _sentry = SentryClient(dsn: "App DSN goes Here");
```

## 4. Create a function to report errors

With Sentry set up, you can begin to report errors. Since you don't want to
report errors to Sentry during development, first create a function that
lets you know whether you're in debug or production mode.

<!-- skip -->
```dart
bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}
```

Next, use this function in combination with the `SentryClient` to report
errors when the app is in production mode.

<!-- skip -->
```dart
Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  // Print the exception to the console.
  print('Caught error: $error');
  if (isInDebugMode) {
    // Print the full stacktrace in debug mode.
    print(stackTrace);
  } else {
    // Send the Exception and Stacktrace to Sentry in Production mode.
    _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}
```

## 5. Catch and report Dart errors

Now that you have a function to report errors depending on the environment,
you need a way to capture Dart errors.

For this task, run your app inside a custom [`Zone`][].
Zones establish an execution context for the code.
This provides a convenient way to capture all errors
that occur within that context by providing an `onError()`
function.

In this case, run the app in a new `Zone` and capture all errors.
With Flutter older than 1.17, you can do that by
providing an `onError()` callback.

<!-- skip -->
```dart
runZoned<Future<void>>(() async {
  runApp(CrashyApp());
}, onError: (error, stackTrace) {
  // Whenever an error occurs, call the `_reportError` function. This sends
  // Dart errors to the dev console or Sentry depending on the environment.
  _reportError(error, stackTrace);
});
```

With Flutter 1.17 which includes Dart 2.8, use `runZonedGuarded` instead:

<!-- skip -->
```dart
runZonedGuarded<Future<void>>(() async {
  runApp(CrashyApp());
}, (Object error, StackTrace stackTrace) {
  // Whenever an error occurs, call the `_reportError` function. This sends
  // Dart errors to the dev console or Sentry depending on the environment.
  _reportError(error, stackTrace);
});
```

## 6. Catch and report Flutter errors

In addition to Dart errors, Flutter can throw errors such as
platform exceptions that occur when calling native code. Be sure to
capture and report these types of errors as well.

To capture Flutter errors,
override the [`FlutterError.onError`][] property.
If you're in debug mode, use a convenience function
from Flutter to properly format the error.
If you're in production mode, send the error to the
`onError` callback defined in the previous step.

<!-- skip -->
```dart
// This captures errors reported by the Flutter framework.
FlutterError.onError = (FlutterErrorDetails details) {
  if (isInDebugMode) {
    // In development mode, simply print to console.
    FlutterError.dumpErrorToConsole(details);
  } else {
    // In production mode, report to the application zone to report to
    // Sentry.
    Zone.current.handleUncaughtError(details.exception, details.stack);
  }
};
```

## Complete example

To view a working example,
see the [Crashy][] example app.


[Crashy]: {{site.github}}/flutter/crashy
[Create an account with Sentry]: https://sentry.io/signup/
[`FlutterError.onError`]: {{site.api}}/flutter/foundation/FlutterError/onError.html
[Rollbar]: https://rollbar.com/
[Sentry]: https://sentry.io/welcome/
[`sentry`]: {{site.pub-pkg}}/sentry
[`Zone`]: {{site.api}}/flutter/dart-async/Zone-class.html
