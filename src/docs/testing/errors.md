---
title: Handling errors in Flutter
description: How to control error messages and logging of errors
---

The Flutter framework catches errors that occur during callbacks
triggered by the framework itself, including during build, layout, and
paint.

All these errors are routed to the [FlutterError.onError][] handler. 
By default, this calls [FlutterError.dumpErrorToConsole][],
which, as you might guess, dumps the error to the device logs. When
running from an IDE, the inspector overrides this so that errors can
also be routed to the IDE's console, allowing you to inspect the
objects mentioned in the message.

When an error occurs during the build phase, the [ErrorWidget.builder][]
callback is invoked to build the widget that is used instead of the
one that failed. By default, in debug mode this shows an error message
in red, and in release mode this shows a gray background.

You can override each of these, typically by setting them to values in
your `void main()` function.

For example, to make your application quit immediately any time an
error is shown in release mode, you could use the following handler:

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
  Use the top-level [`kReleaseMode`][] constant to determine whether the
  app was compiled in release mode.
{{site.alert.end}}

This handler can also be used to report errors to a logging service.
For more details, see our cookbook chapter for 
[reporting errors to a service][].


[FlutterError.onError]: {{site.api}}/flutter/foundation/FlutterError/onError.html
[FlutterError.dumpErrorToConsole]: {{site.api}}/flutter/foundation/FlutterError/dumpErrorToConsole.html
[ErrorWidget.builder]: {{site.api}}/flutter/widgets/ErrorWidget/builder.html
[reporting errors to a service]: /docs/cookbook/maintenance/error-reporting
[`kReleaseMode`]:  {{site.api}}/flutter/foundation/kReleaseMode-constant.html
