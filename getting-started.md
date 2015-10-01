---
layout: page
title: Getting Started with Flutter
nav_title: Getting Started
permalink: /getting-started/
---
To get started, we need to set up Dart SDK:

 - Install the [Dart SDK](https://www.dartlang.org/downloads/):
   - Mac: `brew tap dart-lang/dart && brew install dart --devel`
   - Linux: See [www.dartlang.org/downloads/linux.html](https://www.dartlang.org/downloads/linux.html)
 - Ensure that the `dart` and `pub` executables are on your `PATH`.

Once you have installed Dart SDK, create a new directory and add a
[pubspec.yaml](https://www.dartlang.org/tools/pub/pubspec.html):

```yaml
name: your_app_name
dependencies:
  sky: any
  sky_tools: any
```

Next, create a `lib` directory (which is where your Dart code will go) and use
the `pub` tool to fetch the Sky package and its dependencies:

 - `mkdir lib`
 - `pub upgrade`

Flutter assumes the entry point for your application is a `main` function in
`lib/main.dart`:

```dart
import 'package:sky/widgets.dart';
void main() => runApp(new Center(child: new Text('Hello, world!')));
```

Execution starts in `main`, which in this example shows the text "Hello, world!"
centered on the screen. To learn more about the widget system, please see the
[widgets tutorial](/tutorial).

Setting up your Android device
-------------------------

Currently Flutter requires an Android device running the Lollipop (or newer) version
of the Android operating system.

 - Install the `adb` tool from the [Android SDK](https://developer.android.com/sdk/installing/index.html?pkg=tools):
  - Mac: `brew install android-platform-tools`
  - Linux: `sudo apt-get install android-tools-adb`
    - If the version of `adb` provided by your Linux distribution is too old,
      you might need to [install the Android SDK manually](https://developer.android.com/sdk/installing/index.html?pkg=tools]).

 - Enable developer mode on your device by visiting `Settings > About phone` and
   tapping the `Build number` field five times.

 - Enable `Android debugging` in `Settings > Developer options`.

 - Using a USB cable, plug your phone into your computer. If prompted on your
   device, authorize your computer to access your device.

Running a Flutter application
-------------------------

The `sky` pub package includes a `sky_tool` script to assist in running Flutter
applications inside the `SkyShell.apk` harness.  The `sky_tool` script expects
to be run from the root directory of your application's package (i.e., the same
directory that contains the `pubspec.yaml` file).

To run your app with logging, run this command:

 - `./packages/sky/sky_tool start --checked && ./packages/sky/sky_tool logs`

The `sky_tool start` command starts the dev server and uploads your app to the
device, installing `SkyShell.apk` if needed. The `--checked` flag triggers
checked mode, in which types are checked and asserts are run. The
`sky_tool logs` command logs errors and Dart `print()` output
from the app, automatically limiting the output to just output from the Dart
code and the Sky Engine C++ code (which for historical reasons currently uses
the tag `chromium`.)

To avoid confusion from old log messages, you may wish to call
`sky_tool logs --clear` before calling `sky_tool start`, to clear the log
between runs.

Rapid iteration
---------------

As an alternative to running `./packages/sky/sky_tool start` every time you make
a change, you might prefer to have the `SkyShell` reload your app automatically
for you as you edit.  To do this, run the following command:

 - `./packages/sky/sky_tool listen`

This is a long-running command -- just press `ctrl-c` when you want to stop
listening for changes to the file system and automatically reloading your app.

Currently `sky_tool listen` only works for Android, but iOS device and iOS
simulator support are coming soon.

Debugging
---------

Flutter uses [Observatory](https://www.dartlang.org/tools/observatory/) for
debugging and profiling. While running your Flutter app using `sky_tool`, you can
access Observatory by navigating your web browser to [http://localhost:8181/](http://localhost:8181/).

Building a standalone APK
-------------------------

Although it is possible to build a standalone APK containing your application,
doing so right now is difficult. If you're feeling brave, you can see how we
build the `Stocks.apk` in
[examples/stocks](https://github.com/flutter/engine/tree/master/examples/stocks).
Eventually we plan to make this much easier and support platforms other than
Android, but that work still in progress.
