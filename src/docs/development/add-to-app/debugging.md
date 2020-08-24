---
title: Debugging your add-to-app module
short-title: Debugging
description: How to run, debug, and hot reload your add-to-app Flutter module.
---

## Debugging your add-to-app module

Once you've integrated the Flutter module to your project and used Flutter's
platform APIs to run the Flutter engine and/or UI,
you can then build and run your Android or iOS app the same way
you run normal Android or iOS apps.

However, Flutter is now powering the UI in places where you're showing a
`FlutterActivity` or `FlutterViewController`.

### Debugging

You may be used to having your suite of favorite Flutter debugging tools
available to you automatically when running `flutter run` or an equivalent
command from an IDE. But you can also use all your Flutter
[debugging functionalities][] such as hot reload, performance
overlays, DevTools, and setting breakpoints in add-to-app scenarios.

These functionalities are provided by the `flutter attach` mechanism.
`flutter attach` can be initiated through different pathways,
such as through the SDK's CLI tools,
through VS Code or IntelliJ/Android Studio.

`flutter attach` can connect as soon as you run your `FlutterEngine`, and
remains attached until your `FlutterEngine` is disposed. But you can invoke
`flutter attach` before starting your engine. `flutter attach` waits for
the next available Dart VM that is hosted by your engine.

#### Terminal

Run `flutter attach` or `flutter attach -d deviceId` to attach from the terminal.

{% include app-figure.md image="development/add-to-app/debugging/cli-attach.png" caption="flutter attach via terminal" %}

#### VS Code

Select the correct device using the status bar in VS Code, then run the **Flutter: Attach to Flutter on Device** command from the command palette.

{% include app-figure.md image="development/add-to-app/debugging/vscode-attach.png" caption="flutter attach via VS Code" %}

Alternatively, create a `.vscode/launch.json` file in your Flutter module project to enable attaching using the **Run > Start Debugging** command or `F5`:

```js
{
  name: "Flutter: Attach",
  request: "attach",
  type: "dart",
}
```

#### IntelliJ / Android Studio

Select the device on which the Flutter module runs so `flutter attach` filters for the right start signals.

{% include app-figure.md image="development/add-to-app/debugging/intellij-attach.png" caption="flutter attach via IntelliJ" %}

### Debugging specific instances of Flutter

It's possible to add multiple instances of Flutter
(`root isolates`) to an app.  `flutter attach`
connects to all of the available isolates by default.
Any commands sent from the attached CLI are then forwarded
to each of the attached isolates.

You can list all the attached isolates by typing `l`
from an attached `flutter` CLI tool.
If unspecified, then the isolate names are automatically generated
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

    <!-- skip -->
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

    🔥  To hot reload changes while running, press "r".
    To hot restart (and rebuild state), press "R".
    An Observatory debugger and profiler is available
    at: http://127.0.0.1:43343/.
    For a more detailed help message,
    press "h". To detach, press "d"; to quit, press "q".

    Connected view:
      debug isolate (isolates/642101161)
    ```


[debugging functionalities]: /docs/testing/debugging
