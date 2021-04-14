---
title: Handling errors in Flutter
description: How to control error messages and logging of errors
---

The Flutter framework catches errors that occur during callbacks
triggered by the framework itself, including errors encountered
during the build, layout, and paint phases. Errors that don't occur
within Flutter's callbacks can't be caught by the framework,
but you can handle them by setting up a [`Zone`][].

All errors caught by Flutter are routed to the
[`FlutterError.onError`][] handler. By default,
this calls [`FlutterError.dumpErrorToConsole`][],
which, as you might guess, dumps the error to the device logs.
When running from an IDE, the inspector overrides this so
that errors can also be routed to the IDE's console,
allowing you to inspect the
objects mentioned in the message.

When an error occurs during the build phase,
the [`ErrorWidget.builder`][] callback is
invoked to build the widget that is used
instead of the one that failed. By default,
in debug mode this shows an error message in red,
and in release mode this shows a gray background.

When errors occur without a Flutter callback on the call stack,
they are handled by the `Zone` where they occur. By default,
a `Zone` only prints errors and does nothing else.

You can customize these behaviors,
typically by setting them to values in
your `void main()` function.

Below each error type handling is explained. At the bottom
there's a code snippet which handles all types of errors. Even
though you can just copy-paste the snippet, we recommend you
to first get acquainted with each of the error types.

## Errors caught by Flutter

For example, to make your application quit immediately any time an
error is caught by Flutter in release mode, you could use the
following handler:

<!-- skip -->
```dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(MyApp());
}

// rest of `flutter create` code...
```
{{site.alert.note}}
  The top-level [`kReleaseMode`][] constant indicates
  whether the app was compiled in release mode.
{{site.alert.end}}

This handler can also be used to report errors to a logging service.
For more details, see our cookbook chapter for 
[reporting errors to a service][].

## Define a custom error widget for build phase errors

To define a customized error widget that displays whenever
the builder fails to build a widget, use [`MaterialApp.builder`][].

<!-- skip -->
```dart
class MyApp extends StatelessWidget {
...
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ...
      builder: (BuildContext context, Widget widget) {
        Widget error = Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator)
          error = Scaffold(body: Center(child: error));
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
        return widget;
      },
    );
  }
}
```

## Errors not caught by Flutter

Consider an `onPressed` callback that invokes an asynchronous function,
such as `MethodChannel.invokeMethod` (or pretty much any plugin).
For example:

<!-- skip -->
```dart
OutlinedButton(
  child: Text('Click me!'),
  onPressed: () async {
    final channel = const MethodChannel('crashy-custom-channel');
    await channel.invokeMethod('blah');
  },
),
```

If `invokeMethod` throws an error, it won't be forwarded to `FlutterError.onError`.
Instead, it's forwarded to the `Zone` where `runApp` was run.

To catch such an error, use [`runZonedGuarded`][].

<!-- skip -->
```dart
import 'dart:async';

void main() {
  runZonedGuarded(() {
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    myBackend.sendError(error, stack);
  });
}
```

Note that if in your app you call `WidgetsFlutterBinding.ensureInitialized()`
manually to perform some initialization before calling `runApp` (e.g.
`Firebase.initializeApp()`), you **must** call
`WidgetsFlutterBinding.ensureInitialized()` inside `runZonedGuarded`:

<!-- skip -->
```dart
runZonedGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

{{site.alert.note}}
    Error handling wouldn't work if `WidgetsFlutterBinding.ensureInitialized()`
    was called from the outside.
{{site.alert.end}}

## Handling all types of errors

Say you want to exit application on any exception and to display
a custom error widget whenever a widget building fails - you can base
your errors handling on next code snippet:

<!-- skip -->
```dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await myErrorsHandler.initialize();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      myErrorsHandler.onError(details);
      exit(1);
    };
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    myErrorsHandler.onError(error, stack);
    exit(1);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget widget) {
        Widget error = Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator)
          error = Scaffold(body: Center(child: error));
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
        return widget;
      },
    );
  }
}
```

[`ErrorWidget.builder`]: {{site.api}}/flutter/widgets/ErrorWidget/builder.html
[`FlutterError.onError`]: {{site.api}}/flutter/foundation/FlutterError/onError.html
[`FlutterError.dumpErrorToConsole`]: {{site.api}}/flutter/foundation/FlutterError/dumpErrorToConsole.html
[`kReleaseMode`]:  {{site.api}}/flutter/foundation/kReleaseMode-constant.html
[`MaterialApp.builder`]: {{site.api}}/flutter/material/MaterialApp/builder.html
[reporting errors to a service]: /docs/cookbook/maintenance/error-reporting
[`runZonedGuarded`]: {{site.api}}/flutter/dart-async/runZonedGuarded.html
[`Zone`]: {{site.api}}/flutter/dart-async/Zone-class.html
