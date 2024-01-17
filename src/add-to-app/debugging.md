---
title: Debug your add-to-app module
short-title: Debugging
description: How to run, debug, and hot reload your add-to-app Flutter module.
---

Once you've integrated the Flutter module to your project and used
Flutter's platform APIs to run the Flutter engine and/or UI,
you can then build and run your Android or iOS app the same way
you run normal Android or iOS apps.

Flutter now powers the UI wherever your code includes
`FlutterActivity` or `FlutterViewController`.

## Overview

You might be used to having your suite of favorite Flutter debugging tools
available when running `flutter run` or an equivalent command from an IDE.
But you can also use all your Flutter [debugging functionalities][] such as
hot reload, performance overlays, DevTools, and setting breakpoints in
add-to-app scenarios.

The `flutter attach` command provides these functionalities.
To run this command, you can use the SDK's CLI tools, VS Code
or IntelliJ IDEA or Android Studio.

The `flutter attach` command connects once you run your `FlutterEngine`.
It remains attached until you dispose your `FlutterEngine`.
You can invoke `flutter attach` before starting your engine.
The `flutter attach` command waits for the next available Dart VM that
your engine hosts.

## Debug from the Terminal

To attach from the terminal, run `flutter attach`.
To select a specific target device, add `-d <deviceId>`.

```terminal
$ flutter attach
```

The command should print output resembling the following:

```terminal
Syncing files to device iPhone 15 Pro...
 7,738ms (!)

To hot reload the changes while running, press "r".
To hot restart (and rebuild state). press "R".
An Observatory debugger and profiler on iPhone 15 Pro is available at:
http://127.0.0.1:65525/EXmCgco5zjo=/
For a more detailed help message, press "h".
To detach, press "d"; to quit, press "q".
```

## Debug iOS extension in Xcode and VS Code

{% include docs/debug/debug-flow-ios.md add='launch' %}

## Debug Android extension in Android Studio

{% include docs/debug/debug-flow-androidstudio-as-start.

[debugging functionalities]: {{site.url}}/testing/debugging

## Debug without USB connection

To debug your app over Wi-Fi on an iOS or Android device,
use `flutter attach`.

### Debug over Wi-Fi on iOS devices

On iOS, complete the follow steps:

1. Verify your device connects to Xcode over Wi-Fi
   as described in the [iOS setup guide][].

1. Open **Xcode** <span aria-label="and then">></span>
   **Product** <span aria-label="and then">></span>
   **Scheme** <span aria-label="and then">></span>
   **Edit Scheme**

1. Click the **Arguments** tab

1. Add either `--vm-service-host=0.0.0.0` for IPv4,
   or `--vm-service-host=::0` for IPv6 as a launch argument.

   To determine if you're on an IPv6 network:

   {:type="a"}
   1. Open
      **Settings** <span aria-label="and then">></span>
      **Wi-Fi** <span aria-label="and then">></span>
      **Details (of the network you're connected to)**
      <span aria-label="and then">></span>
      **TCP/IP**.

   1. Check for an **IPv6 address** section.

<img src="/assets/images/docs/development/add-to-app/debugging/wireless-port.png" alt="Check the box that says 'connect via network' from the devices and simulators page">

### Debug over Wi-Fi on Android devices

Verify your device connects to Android Studio over Wi-Fi
as described in the [Android setup guide][].

[iOS setup guide]: {{site.url}}/get-started/install/macos/mobile-ios
[Android setup guide]: {{site.url}}/get-started/install/macos/mobile-android?tab=physical#configure-your-target-android-device
