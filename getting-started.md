---
layout: page
title: Getting Started with Flutter
nav_title: Getting Started
permalink: /getting-started/
---

Flutter currently supports developers on Mac and Linux (64-bit).
Windows support is planned but currently incomplete.

## Dependencies

Flutter depends on the following tools being available in your environment. These are commonly already available on Mac and Linux.

* bash, mkdir, rm
* git
* curl
* unzip

## Getting the Flutter code

Clone the `alpha` branch from the Flutter repository:

```bash
$ git clone https://github.com/flutter/flutter.git -b alpha
```

We update the `alpha` branch periodically as we improve Flutter. To upgrade
your Flutter clone, we recommend using the `flutter upgrade` command rather
than using `git pull` directly.  (See the next section for how to set up
the `flutter` command.)

## Configuring your PATH

After you clone the Flutter repository, set your PATH so you can
use our scripts and tools.

`export PATH=` _directory where you cloned the flutter repo_ `/bin:$PATH`

Open a new shell and run `flutter --version` to ensure the `flutter` command is on your PATH.
The first time you do this will take a few seconds as Flutter will first
download the Dart SDK then compile itself. Subsequent runs should be much faster.

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

 - Install [Android Studio](https://developer.android.com/sdk/) and run through
   enough of the first-run experience to install the Android SDK. (You shouldn't
   need to install a JDK.)

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

You can use the `flutter run` command to run your Flutter app on all connected
devices and simulators.  `flutter devices` will list connected devices and
simulators.

First, change directories to the root of your app (the same directory that
contains the `pubspec.yaml` file for your project).

To run your app, use:

```
$ flutter run
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

- Install Xcode 7 (via [web download](https://developer.apple.com/xcode/) or [Mac App Store](https://itunes.apple.com/us/app/xcode/id497799835))
  - Make sure the Xcode EULA is signed by either opening Xcode once and confirming or running `sudo xcodebuild -license` from the command line.
- Install `ideviceinstaller` via [homebrew](http://brew.sh/)
  - `$ brew install ideviceinstaller`
- Install the `ios-deploy` tool.
  - `$ brew tap flutter/flutter`
  - `$ brew install ios-deploy`

## Running your app in the iOS simulator

We currently only support iOS development with the iOS simulator,
but you can deploy Flutter apps to iOS devices.

- Run `Simulator.app`
  - You can find Simulator.app in _Applications/Xcode/Contents/Developer/Applications_ or via _Spotlight_
  - Ensure your simulator is using a 64-bit device (iPhone 5s or later) by checking the Simulator.app's `Hardware -> Device` menu
- Run `flutter run` from your app's directory
  - This command detects the iOS simulator and starts the app

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
