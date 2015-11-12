---
layout: page
title: Getting Started with Flutter
nav_title: Getting Started
permalink: /getting-started/
---

Flutter currently supports developers on Mac and Linux.
Windows support is in the works.

## Setting up your environment

To get started, you need to set up the Dart SDK.
Flutter requires Dart SDK 1.12.2 or greater.

To install the [Dart SDK](https://www.dartlang.org/downloads/):

- Mac: `brew tap dart-lang/dart && brew install dart`, or, if you don't
  use homebrew, grab the [latest stable channel build](https://www.dartlang.org/downloads/archive/)
- Linux: See [www.dartlang.org/downloads/linux.html](https://www.dartlang.org/downloads/linux.html)
- Windows: Stay tuned, Windows support is in the works.

Ensure that the `pub` executable is in your `PATH`.

## Getting the code

Clone the `alpha` branch from the Flutter repository:

```
$ git clone https://github.com/flutter/flutter.git -b alpha
```

We update the `alpha` branch periodically as we improve Flutter. You can update
your copy of Flutter by running `git pull` in the `flutter` directory created
above.

## Configuring your PATH

After you clone the Flutter repo, set the PATH so you can
use our scripts and tools.

```
$ export PATH=`pwd`/flutter/bin:$PATH
```

## Creating your first sample app

Now that you've added the `bin` directory to your path, you can use the `flutter`
command to create a starter project.

Here is an example of creating a new Flutter app called `my_app`
in the current directory:

```
$ flutter init -o my_app
```

The above command creates a `my_app` directory that contains a simple demo
app that uses [Material Design](https://www.google.com/design/spec/material-design/introduction.html).

The code for your app is in `my_app/lib/main.dart`.
To learn more about how to build apps with Flutter, please see the
[tutorial](/tutorial/).

## Setting up your Android device

Currently Flutter requires an Android device running
Jelly Bean, v16, 4.1.x or later.

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

## Running a Flutter application

You can use the `flutter` command to run Flutter apps on your devices. First,
change directories to the root of your app (i.e., the same directory that
contains the `pubspec.yaml` file).

To start your app, use the `start` command:

```
$ flutter start
$ flutter logs
```

The `logs` command lets you see textual output from your app, including `print`
statements and unhandled exceptions. To avoid confusion from old log messages,
you might want to use `flutter logs --clear` to clear the logs between runs.

## Getting Started with Atom

Flutter uses [Atom](https://atom.io/) as its IDE. You can use any editor with
our command-line tools to develop Flutter applications. However, we're also
developing Flutter specific plugins for Atom in order to deliver a top-of-the
line development experience.

For instructions on installing Atom and our Flutter plugin, see
[dart-atom.github.io/dartlang](http://dart-atom.github.io/dartlang/).

## Debugging and profiling your app

Flutter uses [Observatory](https://www.dartlang.org/tools/observatory/) for
debugging and profiling. While running your app, you can access Observatory
by navigating your web browser to [http://localhost:8181/](http://localhost:8181/).

## Upgrading to a new version of Flutter

If you want to update your copy of Flutter, you use the `flutter upgrade`
command from the root of your app (i.e., the same directory that contains the
`pubspec.yaml` file):

```
$ flutter upgrade
```

(If you have an older version of `flutter` that doesn't have the `upgrade`
command, you might need to first run `git pull` in your clone of the Flutter
repository.)

## Building a standalone APK

Although it is possible to build a standalone APK containing your application,
doing so right now is difficult. If you're feeling brave, you can see how we
build the `Stocks.apk` in
[examples/stocks](https://github.com/flutter/flutter/tree/master/examples/stocks).
Eventually we plan to make this much easier and support platforms other than
Android, but that work is still in progress.
