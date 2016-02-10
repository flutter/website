---
layout: page
title: Getting Started with Flutter
nav_title: Getting Started
permalink: /getting-started/
---

Flutter currently supports developers on Mac and Linux (64-bit).
Windows support is planned.

## Setting up your environment

### Downloading and installing the Dart SDK

To get started, you need to install the Dart SDK.
Flutter requires Dart SDK 1.12.2 or greater.

To install the [Dart SDK](https://www.dartlang.org/downloads/):

- Mac:
  - `brew tap dart-lang/dart && brew install dart`, or, if you don't use
    homebrew, grab the [latest stable channel build](https://www.dartlang.org/downloads/archive/)
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

We update the `alpha` branch periodically as we improve Flutter. To upgrade
your Flutter clone, we recommend using the `flutter upgrade` command rather
than using `git pull` directly.  (See the next section for how to set up
the `flutter` command.)

## Configuring your PATH

After you clone the Flutter repo, set the PATH so you can
use our scripts and tools.

```
$ cd <directory where you cloned the flutter repo>
$ export PATH=`pwd`/bin:$PATH
```

Run `flutter --version` to ensure the `flutter` command is on your PATH.

## Creating your first sample app

You can use the `flutter` command to create a starter project.

Here is an example:

```
$ flutter create -o my_app
```

The above command creates a `my_app` directory that contains a simple demo
app that uses [Material Design](https://www.google.com/design/spec/material-design/introduction.html).

The code for your app is in `my_app/lib/main.dart`.
To learn more about how to build apps with Flutter, please see the
[tutorial](/tutorial/).

## Setting up your Android device

(Don't have an Android device? You can skip down to
[Setting up your Mac for iOS development](#setting-up-your-mac-for-ios-development).)

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

By default, Flutter uses the version of the Android SDK where your `adb` tool is based. If
you want Flutter to use a different installation of the Android SDK, you must set the
`ANDROID_HOME` environment variable to that specific installation directory.

## Running a Flutter application on Android

You can use the `flutter start` command to run your Flutter app on your
device or simulator. For best results, ensure you have only one device
or simulator connected.

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

## Setting up your Mac for iOS development

You must use a Mac, with Xcode 7+ installed, to develop iOS apps with Flutter.

Install the following dependencies:

- Install [Xcode 7](https://developer.apple.com/xcode/)
- Install `ideviceinstaller`.
  - `$ brew install ideviceinstaller`
- Install the `ios-deploy` tool.
  - `$ brew tap flutter/flutter`
  - `$ brew install ios-deploy`

## Adding iOS support to your project

Inside of your Flutter app, run `flutter ios --init`
to add iOS configuration files.

## Running your app in the iOS simulator

We currently only support iOS development with the iOS simulator,
but you can deploy Flutter apps to iOS devices.

- Run `Simulator.app`
  - You can find Simulator.app in
_Applications/Xcode/Contents/Developer/Applications_ or via _Spotlight_
  - To ensure your simulator uses a device type of iPhone 5 or above,
check the Simulator.app's `Hardware -> Device` menu.
- Run `flutter start` from your app's directory.
  - This command detects the iOS simulator and starts the app.

## Getting Started with the Atom editor

Flutter recommends [Atom](https://atom.io/) for editing, running,
and debugging Flutter apps. However,
using our command-line tools, you can use
any editor to develop Flutter applications.

Download Atom from [atom.io](https://atom.io)
and then install the [Flutter package](https://atom.io/packages/flutter).
If you need help installing packages, consult the
[Atom documentation](https://atom.io/docs/v1.3.2/using-atom-atom-packages)
or [email us][mailinglist].

## Next steps

Please reach out to us at our [mailing list][mailinglist]. We'd love
to hear from you!

You might also want to check out our [Tutorial](/tutorial) and our
[Debugging guide](/debugging).

Happy Fluttering!


[mailinglist]: mailto:flutter-dev@googlegroups.com
