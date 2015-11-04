---
layout: page
title: Getting Started with Flutter
nav_title: Getting Started
permalink: /getting-started/
---

Flutter currently supports developers on Mac and Linux,
with Windows support in the works.

To get started, we need to set up Dart SDK:

 - Install the [Dart SDK](https://www.dartlang.org/downloads/):
   - Mac: `brew tap dart-lang/dart && brew install dart --devel`
   - Linux: See [www.dartlang.org/downloads/linux.html](https://www.dartlang.org/downloads/linux.html)
   - Windows: Stay tuned, Windows support is in the works.
 - Ensure that the `pub` executable is in your `PATH`.

Once you have installed Dart SDK, activate the `flutter` command line
tool and add it to your path:

```
$ pub global activate flutter
$ export PATH=$HOME/.pub-cache/bin:$PATH
```

Now we can use the `flutter` command to create a project named `my_app`:

```
$ flutter init -o my_app
```

This command creates a `my_app` directory that contains a simple demo
app that uses [Material Design](https://www.google.com/design/spec/material-design/introduction.html).

The code for your app is in `my_app/lib/main.dart`. Execution starts in
the `main` function, which uses `runApp` to run a `MaterialApp` widget.
The `MaterialApp` widget is configured with a route map, with one entry
for every screen of your app. In this case, there's only one screen, the
home screen named `/`, which builds a `FlutterDemo` component.

To learn more about how to build apps with Flutter, please see the
[tutorial](/tutorial/).

Setting up your Android device
-------------------------

Currently Flutter requires an Android device running the KitKat (or newer)
version of the Android operating system.

 - Install the `adb` tool from the [Android SDK](https://developer.android.com/sdk/installing/index.html?pkg=tools):
  - Mac: `brew install android-platform-tools`
  - Linux: `sudo apt-get install android-tools-adb`
    - If the version of `adb` provided by your Linux distribution is too old,
      you might need to [install the Android SDK manually](https://developer.android.com/sdk/installing/index.html?pkg=tools).

 - Enable developer mode on your device by visiting `Settings > About phone` and
   tapping the `Build number` field seven times.

 - Enable `Android debugging` in `Settings > Developer options`.

 - Using a USB cable, plug your phone into your computer. If prompted on your
   device, authorize your computer to access your device.

Running a Flutter application
-----------------------------

You can use the `flutter` command to run Flutter apps on your devices. First,
change directories to the root of your apps (i.e., the same directory that
contains the `pubspec.yaml` file).

To start your app, use the `start` command:

```
$ flutter start --checked
$ flutter logs
```

The `--checked` flag turns on type checking and asserts, both of which are quite
useful during development. The `logs` command lets you see textual output from
your app, including `print` statements and unhandled exceptions. To avoid confusion
from old log messages, you might want to use `flutter logs --clear` to clear the
logs between runs.

To improve your iteration speed, you can use `flutter listen --checked` instead
of `flutter start`. The `listen` command watches the file system and automatically
reloads your app whenever you make a change to its code.

Debugging
---------

Flutter uses [Observatory](https://www.dartlang.org/tools/observatory/) for
debugging and profiling. While running your app, you can access Observatory
by navigating your web browser to [http://localhost:8181/](http://localhost:8181/).

Building a standalone APK
-------------------------

Although it is possible to build a standalone APK containing your application,
doing so right now is difficult. If you're feeling brave, you can see how we
build the `Stocks.apk` in
[examples/stocks](https://github.com/flutter/engine/tree/master/examples/stocks).
Eventually we plan to make this much easier and support platforms other than
Android, but that work still in progress.
