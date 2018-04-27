---
layout: page
title: "Report errors to a service"
permalink: /cookbook/maintenance/error-reporting/
---

While we always do our best to create apps that are free of bugs, they're sure 
to crop up from time to time. Since buggy apps lead to unhappy 
users and customers, it's important to understand how often our users experience
bugs and where those bugs occur. That way, we can prioritize the bugs with the
highest impact and work to fix them.
 
How can we determine how often our users experiences bugs? Whenever an error
occurs, we can create a report containing the error that occurred and the
associated stacktrace. We can then send the report to an error tracking service,
such as Sentry, Fabric, or Rollbar. 

The error tracking service will then aggregate all of the crashes our users 
experience and group them together for us. This allows us to know how often our
app fails and where our users run into trouble. 

In this recipe, we'll see how to report errors to the 
[Sentry](https://sentry.io/welcome/) crash reporting service.

## Directions

  1. Get a DSN from Sentry
  2. Import the Sentry package
  3. Create a `SentryClient`
  4. Create a function to report errors
  5. Catch and report Dart errors
  6. Catch and report Flutter errors

## 1. Get a DSN from Sentry

Before we can report errors to Sentry, we'll need a "DSN" to uniquely identify 
our app with the Sentry.io service.

To get a DSN, please: 

  1. [Create an account with Sentry](https://sentry.io/signup/)
  2. Log in to the account
  3. Create a new app
  4. Copy the DSN 

## 2. Import the Sentry package

Next, we'll need to import the 
[`sentry`](https://pub.dartlang.org/packages/sentry) package into our app. The 
sentry package will make it easier for us to send error reports to the Sentry
error tracking service.

```yaml
dependencies:
  sentry: <latest_version>
```

## 3. Create a `SentryClient`

We can now create a `SentryClient`. We will use the `SentryClient` to send 
error reports to the sentry service! 

<!-- skip -->
```dart
final SentryClient _sentry = new SentryClient(dsn: "App DSN goes Here");
```

## 4. Create a function to report errors

With Sentry all set up, we can begin to report errors! Since we don't want to 
report errors to Sentry during development, we'll first create a function that 
let's us know whether we're in debug or production mode.

<!-- skip -->
```dart
bool get isInDebugMode {
  // Assume we're in production mode
  bool inDebugMode = false;
  
  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code will only turn `inDebugMode` to true
  // in our development environments!
  assert(inDebugMode = true);
  
  return inDebugMode;
}
```   

Next, we can use this function in combination with the `SentryClient` to report 
errors when our app is in production mode.

<!-- skip -->
```dart
Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  // Print the exception to the console 
  print('Caught error: $error');
  if (isInDebugMode) {
    // Print the full stacktrace in debug mode
    print(stackTrace);
    return;
  } else {
    // Send the Exception and Stacktrace to Sentry in Production mode
    _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    ); 
  }
}
```

## 5. Catch and report Dart errors

Now that we have a function to report errors depending on the environment, we
need a way to capture Dart errors so we can report them! 

For this task, we will run our app inside a custom 
[`Zone`](https://docs.flutter.io/flutter/dart-async/Zone-class.html). Zones 
establish an execution context for our code. This provides a convenient way to 
capture all errors that occur within that context by providing an `onError`.

In this case, we'll run our app in a new `Zone` and capture all errors by 
providing an `onError` callback.

<!-- skip -->
```dart
runZoned<Future<Null>>(() async {
  runApp(new CrashyApp());
}, onError: (error, stackTrace) {
  // Whenever an error occurs, call the `_reportError` function. This will send
  // Dart errors to our dev console or Sentry depending on the environment.
  _reportError(error, stackTrace);
});
```

## 6. Catch and report Flutter errors

In addition to Dart errors, Flutter can throw additional errors, such as 
platform exceptions that occur when calling native code. We need to be sure to 
capture and report these types of errors as well!

To capture Flutter errors, we can override the 
[`FlutterError.onError`](https://docs.flutter.io/flutter/foundation/FlutterError/onError.html)
property. In this case, if we're in debug mode, we'll use a convenience function
from Flutter to properly format the error. If we're in production mode, we'll 
send the error to our `onError` callback defined in the previous step.  

<!-- skip -->
```dart
// This captures errors reported by the Flutter framework.
FlutterError.onError = (FlutterErrorDetails details) {
  if (isInDebugMode) {
    // In development mode simply print to console.
    FlutterError.dumpErrorToConsole(details);
  } else {
    // In production mode report to the application zone to report to
    // Sentry.
    Zone.current.handleUncaughtError(details.exception, details.stack);
  }
};
```

## Complete Example

To view a working example, please view the 
[Crashy](https://github.com/flutter/crashy) example app. 
