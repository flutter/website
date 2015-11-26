---
layout: page
title: Getting Started with Flutter
nav_title: Getting Started
permalink: /getting-started/
---

Flutter currently supports developers on Mac and Linux.
Windows support is planned.

## Setting up your environment

### Downloading and installing the Dart SDK

To get started, you need to install the Dart SDK.
Flutter requires Dart SDK 1.12.2 or greater.

To install the [Dart SDK](https://www.dartlang.org/downloads/):

- Mac: `brew tap dart-lang/dart && brew install dart`, or, if you don't
  use homebrew, grab the [latest stable channel build](https://www.dartlang.org/downloads/archive/)
- Linux: See [www.dartlang.org/downloads/linux.html](https://www.dartlang.org/downloads/linux.html)
- Windows: Stay tuned, Windows support is planned.

### Checking your PATH

Ensure that the `pub` executable is in your `PATH`.

Run `pub --version` on the command line. If that command
is not found, you will need to add `DIRECTORY_WHERE_DART_SDK_IS_LOCATED/bin`
to your PATH.

For example:

```
$ export PATH=<DART_SDK_DOWNLOAD_LOCATION>/bin:$PATH
```

## Getting the Flutter code

Clone the `alpha` branch from the Flutter repository:

```
$ git clone https://github.com/flutter/flutter.git -b alpha
```

We update the `alpha` branch periodically as we improve Flutter.

(See below for how to upgrade your flutter clone. We do not
recommend upgrading with `git pull`.)

## Configuring your PATH

After you clone the Flutter repo, set the PATH so you can
use our scripts and tools.

```
$ cd <directory where you cloned the flutter repo>
$ export PATH=`pwd`/bin:$PATH
```

Run `flutter --version` to ensure the `flutter`
command is on your PATH.

## Creating your first sample app

You can use the `flutter`
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
       Note that `adb` needs 32-bit libs (on Ubuntu 64-bit, make sure to install
       those libraries listed in _Troubleshooting Ubuntu_ section).
         - Launch `Android SDK Manager` with `tools/android sdk`.
         - Install `Android SDK Platform-tools` package that is the only required
           package to use `adb`.
         - Add `platform-tools/` to your `PATH`.

 - Enable developer mode on your device by visiting `Settings > About phone` and
   tapping the `Build number` field seven times.

 - Enable `Android debugging` in `Settings > Developer options`.

 - Using a USB cable, plug your phone into your computer. If prompted on your
   device, authorize your computer to access your device.

 - Check that `adb` lists your device with `adb devices -l`.

## Running a Flutter application

You can use the `flutter start` command to run Flutter apps on your devices.

First, change directories to the root of your app (the same directory that
contains the `pubspec.yaml` file for your project).

To start your app, run:

```
$ flutter start
```

If everything works, you should see your starter app
on your Android device.

![First Flutter app running on an Android phone](/images/flutter_starter_app_screenshot.png)

## Viewing the logs

Start streaming the logs from the device:

```
$ flutter logs
```

The `logs` command lets you see textual output from your app, including `print`
statements and unhandled exceptions. To avoid confusion from old log messages,
you might want to use `flutter logs --clear` to clear the logs between runs.

## Getting Started with the Atom editor

Flutter uses [Atom](https://atom.io/) as its IDE. However,
using our command-line tools, you can use
any editor to develop Flutter applications.

For instructions on installing Atom and our Flutter plugin, see
[dart-atom.github.io/dartlang](http://dart-atom.github.io/dartlang/).

## Debugging and profiling your app

Flutter uses [Observatory](https://www.dartlang.org/tools/observatory/) for
debugging and profiling. While running your app, you can access Observatory
by navigating your web browser to [http://localhost:8181/](http://localhost:8181/).

## Upgrading to a new version of Flutter

If you want to update your copy of Flutter, you use the `flutter upgrade`
command from the root of your app (the same directory that contains the
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
