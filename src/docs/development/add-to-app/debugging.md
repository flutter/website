---
title: Running, debugging, and hot reload
short-title: Debugging
description: How to run, debug, and hot reload your add-to-app Flutter module.
---

## Running, debugging, and hot reload

Once you've integrated the Flutter module to your project and used Flutter's
platform APIs to run the Flutter engine and/or UI, you can then build and run
your Android or iOS app the same way you run normal Android or iOS apps.

However, Flutter is now powering the UI in places where you're showing a
`FlutterActivity` or `FlutterViewController`.

### Debugging

You may be used to having your suite of favorite Flutter debugging tools
available to you automatically when running `flutter run` or an equivalent
command from an IDE. But you can also use all your Flutter [debugging
functionalities](/docs/testing/debugging) such as hot reload, performance
overlays, DevTools, and setting breakpoints in add-to-app scenarios.

These functionalities are provided by the `flutter attach` mechanism. `flutter
attach` can be initiated through different pathways, such as through the SDK's
CLI tools, through VSCode or IntelliJ/Android Studio.

{% include app-figure.md image="development/add-to-app/debugging/cli-attach.png" caption="flutter attach via terminal" %}

{% include app-figure.md image="development/add-to-app/debugging/vscode-attach.png" caption="flutter attach via VSCode" %}

{% include app-figure.md image="development/add-to-app/debugging/intellij-attach.png" caption="flutter attach via IntelliJ" %}

`flutter attach` can connect as soon as you run your `FlutterEngine`, and will
remain attached until your `FlutterEngine` is disposed. But you can invoke
`flutter attach` before starting your engine. `flutter attach` will wait for
the next available Dart VM which will be hosted by your engine.

In IntelliJ or VSCode, you should select the device on which the Flutter
module will run so `flutter attach` filters for the right start signals.

### Debugging specific instances of Flutter

It's possible to add multiple instances of Flutter (`root isolates`) to an app.
`flutter attach` connects to all of the available isolates by default. Any
commands sent from the attached CLI are then forwarded to each of the attached
isolates.

You can list all the attached isolates by typing `l` from an attached `flutter`
CLI tool. If unspecified, then the isolate names are automatically generated
from the dart entrypoint file and function name.

Example `l` output for an application that is displaying two Flutter isolates
simultaneously:

```terminal
Connected views:
  main.dart$main-517591213 (isolates/517591213)
  main.dart$main-332962855 (isolates/332962855)
```

In order to attach to specific isolates instead, do the following:

1. Name the Flutter root isolate of interest in its Dart source.

    ```dart
    // main.dart
    import 'dart:ui' as ui;

    void main() {
      ui.window.setIsolateDebugName("debug isolate");
      // ...
    }
    ```

2. Run `flutter attach` with the `--isolate-filter` option.

    ```terminal
    $ flutter attach --isolate-filter='debug'
    Waiting for a connection from Flutter...
    Done.
    Syncing files to device...      1.1s

    🔥  To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R".
    An Observatory debugger and profiler is available at: http://127.0.0.1:43343/
    For a more detailed help message, press "h". To detach, press "d"; to quit, press "q".

    Connected view:
      debug isolate (isolates/642101161)
    ```
