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

* **Operating Systems**: Mac or Linux (64-bit). Windows support is [in progress](https://github.com/flutter/flutter/issues/138).
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

The first time you run the `flutter` command, it will download its dependencies and compile
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
2. Configure the Xcode command-line tools to use the newly-installed version of Xcode by
running `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer` from
the command line.

  This is the correct path for most cases, when you want to use the latest version of Xcode.
  If you need to use a different version, specify that path instead.
2. Make sure the Xcode license agreement is signed by either opening Xcode once and confirming or
running `sudo xcodebuild -license` from the command line.

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
4. Start your app by running `flutter run`.


### Deploy to iOS devices

To deploy your Flutter app to a physical iOS device, you’ll need some additional tools:

1. Install [homebrew](http://brew.sh/).
2. Open the terminal and run this command to install the tools for deploying Flutter apps to
iOS devices.

 ```
  $ brew install ideviceinstaller ios-deploy
```

3. Follow the steps defined by Apple to configure Xcode with your Apple Developer account and enable deploying with provisioning profiles. To learn how to set up your profile, see [Apple's official documentation](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/MaintainingProfiles/MaintainingProfiles.html).
4. Select your Development Team for the Flutter project.
  1. Open the default Xcode workspace in your project under `ios/Runner.xcworkspace`. 
  2. Select the `Runner` project in the left navigation panel.
  3. In the Target Settings page, make sure your Development Team is selected under **General > Signing > Team**.
5. Start your app by running `flutter run`.

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
tapping the **Build number** line seven times.
2. In **Settings > Developer options**, enable **USB debugging**.
3. Using a USB cable, plug your phone into your computer. If prompted on your
device, authorize your computer to access your device.
4. In the terminal, run the `flutter devices` command to verify that Flutter recognizes your
connected Android device.
5. Start your app by running `flutter run`.

By default, Flutter uses the version of the Android SDK where your `adb` tool is based. If
you want Flutter to use a different installation of the Android SDK, you must set the
`ANDROID_HOME` environment variable to that installation directory.

Using our command-line tools, you can use any editor to develop Flutter applications.
If you prefer working in an IDE, we recommend using our IntelliJ plug-ins for a 
[rich IDE experience](/intellij-ide/) supporting editing, running, and debugging 
Flutter apps. See [IntelliJ Setup](/intellij-setup/) for detailed steps.

## Next steps

Now, follow our [Getting Started guide](/getting-started/)
to run your first Flutter app on iOS and Android.
