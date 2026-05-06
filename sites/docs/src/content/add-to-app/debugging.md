---
title: Debug your add-to-app module
shortTitle: Debugging
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

```console
$ flutter attach
```

The command should print output resembling the following:

```console
Syncing files to device iPhone 15 Pro...
 7,738ms (!)

To hot reload the changes while running, press "r".
To hot restart (and rebuild state). press "R".
```

## Debug iOS extension in Xcode and VS Code

{% render "docs/debug/debug-flow-ios.md", add:'launch' %}

## Debug Android extension in Android Studio

{% render "docs/debug/debug-flow-androidstudio-as-start.md" %}

[debugging functionalities]: /testing/debugging

## Debug without USB connection {:#wireless-debugging}

To debug your app over Wi-Fi on an iOS or Android device,
use `flutter attach`.

### Debug over Wi-Fi on iOS devices

For an iOS target, complete the follow steps:

1. Verify your device connects to Xcode over Wi-Fi
   as described in the [iOS setup guide][].

1. On your macOS development machine,
   open **Xcode** <span aria-label="and then">></span>
   **Product** <span aria-label="and then">></span>
   **Scheme** <span aria-label="and then">></span>
   **Edit Scheme...**.

   You can also press <kbd>Cmd</kbd> + <kbd><</kbd>.

1. Click **Run**.

1. Click **Arguments**.

1. In **Arguments Passed On Launch**, Click **+**.

   {:type="a"}
   1. If your dev machine uses IPv4, add `--vm-service-host=0.0.0.0`.

   1. If your dev machine uses IPv6, add `--vm-service-host=::0`.

   <DashImage figure img-class="site-mobile-screenshot border" image="development/add-to-app/debugging/wireless-port.png" caption="Arguments Passed On Launch with an IPv4 network added", width="100%" />

#### To determine if you're on an IPv6 network

1. Open **Settings** <span aria-label="and then">></span> **Wi-Fi**.

1. Click on your connected network.

1. Click **Details...**

1. Click **TCP/IP**.

1. Check for an **IPv6 address** section.

   <DashImage figure img-class="site-mobile-screenshot border" image="development/add-to-app/ipv6.png" caption="WiFi dialog box for macOS System Settings" width="60%" />

### Debug over Wi-Fi on Android devices

Verify your device connects to Android Studio over Wi-Fi
as described in the [Android setup guide][].

[iOS setup guide]: /platform-integration/ios/setup
[Android setup guide]: /platform-integration/android/setup#set-up-devices
