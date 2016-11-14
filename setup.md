---
layout: page
title: Flutter Setup
sidebar: home_sidebar
permalink: /setup/
---

This guide describes how to set up your development environment to run Flutter apps on
iOS or Android.

* TOC Placeholder
{:toc}

## System requirements

To install and run Flutter, your development environment must meet these minimum requirements:

* **Operating Systems**: Mac or Linux (64-bit). Windows support is planned.
* **Tools**: Flutter depends on these command-line tools being available on your environment.
  * `bash`, `mkdir`, `rm`, `git`, `curl`, `unzip`

## Get the Flutter SDK

To get Flutter, use `git` to clone the repository and then add the `flutter` tool to your path:

<pre>
$ git clone https://github.com/flutter/flutter.git
$ export PATH=`pwd`/flutter/bin:$PATH
</pre>

Run the following command to see if there are any dependencies you need to install to complete
the setup:

```
$ flutter doctor
```

The first time your run the `flutter` command, it will download its dependencies and compile
itself. Subsequent runs should be much faster.

Once you have installed any missing dependencies, run the `flutter doctor` command again to
verify that you’ve set everything up correctly.

## Google Analytics

The Flutter tool uses Google Analytics to anonymously report feature usage statistics
and basic crash reports. This data is used to help improve Flutter tools over time.
In order to disable reporting, type `flutter config --no-analytics`, and to display the
current state of analytics reporting, type `flutter config`.

Analytics is not sent on the very first run or for any runs involving `flutter config`.
This lets users choose to opt-out of analytics without any data being sent. See Google's
privacy policy:
[www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/).

## iOS setup

_This step is optional, and can be performed at any time before
using Flutter to develop apps for iOS._

To develop Flutter apps for iOS, you need a Mac with Xcode 7.2 or newer:

1. Install Xcode 7.2 or newer (via [web download](https://developer.apple.com/xcode/) or
the [Mac App Store](https://itunes.apple.com/us/app/xcode/id497799835)).
2.  Make sure the Xcode EULA is signed by either opening Xcode once and confirming or
running `sudo xcodebuild -license` from the command-line.

With Xcode, you’ll be able to run Flutter apps on an iOS device or on the simulator.

### Set up the iOS simulator ###

To prepare to run and test your Flutter app on the iOS simulator, follow these steps:

1. On your Mac, find the Simulator via Spotlight or by using the following command:

    ```
    $ open -a Simulator
    ```

2. Make sure your simulator is using a 64-bit device (iPhone 5s or later) by checking the settings
in the simulator's **Hardware > Device** menu.
3. Depending on your development machine's screen size, simulated high-screen-density iOS devices
may overflow your screen. Set the device scale under the **Window > Scale** menu in the simulator.


### Deploy to iOS devices

To deploy your Flutter app to a physical iOS device, you’ll need some additional tools:

1. Install [homebrew](http://brew.sh/).
2. Open the terminal and run these command to install the tools for deploying Flutter apps to
iOS devices.

    <pre>
    $ brew tap flutter/flutter
    $ brew install ideviceinstaller ios-deploy
    </pre>

You'll also need to set up a provisioning profile for your developer account. To learn how to
set up your profile, see [Apple's official documentation](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/MaintainingProfiles/MaintainingProfiles.html).

## Android setup

_This step is optional, and can be performed at any time before
using Flutter to develop apps for Android._

To develop Flutter apps for Android, you can use either a Mac or a Linux (64-bit) machine:

1. Install [Android Studio](https://developer.android.com/sdk/index.html).
2. From Android Studio, install the latest Android SDK and Android SDK Platform-Tools, as described
in [Adding SDK Packages](https://developer.android.com/sdk/installing/adding-packages.html).

### Set up your Android device

To prepare to run and test your Flutter app on Android, you'll need an Android device running
Android 4.1 (API level 16) or higher.

1. Enable developer mode on your device by visiting **`Settings > About phone`** and
tapping the **`Build number`** line seven times.
2. In **`Settings > Developer options`**, enable **`USB debugging`**.
3. Using a USB cable, plug your phone into your computer. If prompted on your
device, authorize your computer to access your device.
4. In the terminal, run the `flutter devices` command to verify that Flutter recognizes your
connected Android device.

By default, Flutter uses the version of the Android SDK where your `adb` tool is based. If
you want Flutter to use a different installation of the Android SDK, you must set the
`ANDROID_HOME` environment variable to that specific installation directory.


<a name="plugins"/>

## Flutter IntelliJ IDE plugins

We recommend using our IntelliJ plug-ins for a [rich IDE
experience](/intellij-ide/) supporting editing, running, and debugging Flutter
apps. However, using our command-line tools, you can use any editor to develop
Flutter applications.

### Installing IntelliJ

The IntelliJ plug-ins require JetBrains [IntelliJ IDEA](https://www.jetbrains.com/idea/download/)
in the Community or Ultimate edition, version 2016.2 or later is supported.

The current version of the Flutter plugin for IntelliJ is not compatible with Android Studio and 
Webstorm (and various other JetBrains editors).

### Install the plugins

We provide two plugins:

  * The `Dart` plugin offers code analysis (code validation as you type, code completions, etc.)
  * The `Flutter` plugin powers flutter developer workflows (running, debugging, hot reload, etc.)

To install the plugins:

1. Open plugin preferences (**Preferences>Plugins** on macOS, **File>Settings>Plugins** on Linux)
1. Select **"Browse repositories…"**
1. search for `'dart'`; click `install` (do not click restart yet)
1. search for `'flutter'`; click `install`, and then click `Restart IntelliJ IDEA`

### Configure the plugins

1. Open preferences (**Preferences** on macOS, **File>Settings** on Linux)
1. Select **Languages & Frameworks>Flutter**
1. Enter, or browse to, your Flutter SDK directory path in **Flutter SDK path**
1. Click **OK**

## Next steps

Now, follow our [Getting Started guide](/getting-started/)
to run your first Flutter app on iOS and Android.
