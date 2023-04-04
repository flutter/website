---
title: Debugging your add-to-app module
short-title: Debugging
description: How to run, debug, and hot reload your add-to-app Flutter module.
---

## Debugging your add-to-app module

Once you've integrated the Flutter module to your project and used Flutter's
platform APIs to run the Flutter engine and/or UI,
you can then build and run your Android or iOS app the same way
you run normal Android or iOS apps.

However, Flutter is now powering the UI in places where you're showing a
`FlutterActivity` or `FlutterViewController`.

### Debugging

You may be used to having your suite of favorite Flutter debugging tools
available to you automatically when running `flutter run` or an equivalent
command from an IDE. But you can also use all your Flutter
[debugging functionalities][] such as hot reload, performance
overlays, DevTools, and setting breakpoints in add-to-app scenarios.

These functionalities are provided by the `flutter attach` mechanism.
`flutter attach` can be initiated through different pathways,
such as through the SDK's CLI tools,
through VS Code or IntelliJ/Android Studio.

`flutter attach` can connect as soon as you run your `FlutterEngine`, and
remains attached until your `FlutterEngine` is disposed. But you can invoke
`flutter attach` before starting your engine. `flutter attach` waits for
the next available Dart VM that is hosted by your engine.

#### Terminal

Run `flutter attach` or `flutter attach -d deviceId` to attach from the terminal.

{% include docs/app-figure.md image="development/add-to-app/debugging/cli-attach.png" caption="flutter attach via terminal" %}

#### VS Code

Select the correct device using the status bar in VS Code, then run the **Flutter: Attach to Flutter on Device** command from the command palette.

{% include docs/app-figure.md image="development/add-to-app/debugging/vscode-attach.png" caption="flutter attach via VS Code" %}

Alternatively, create a `.vscode/launch.json` file in your Flutter module project to enable attaching using the **Run > Start Debugging** command or `F5`:

```js
{
  name: "Flutter: Attach",
  request: "attach",
  type: "dart",
}
```

#### IntelliJ / Android Studio

Select the device on which the Flutter module runs so `flutter attach` filters for the right start signals.

{% include docs/app-figure.md image="development/add-to-app/debugging/intellij-attach.png" caption="flutter attach via IntelliJ" %}


[debugging functionalities]: {{site.url}}/testing/debugging

### Wireless debugging

You can debug your app wirelessly on an iOS or Android device 
using `flutter attach`.


#### iOS

On iOS, you must follow the steps below: 

<ol markdown="1">
<li markdown="1">

Ensure that your device is wirelessly connected to Xcode 
as described in the [iOS setup guide][].

</li>
<li markdown="1">

Open **Xcode > Product > Scheme > Edit Scheme**

</li>
<li markdown="1">

Select the **Arguments** tab 

</li>
<li markdown="1">

Add either `--vm-service-host=0.0.0.0` for IPv4, 
or `--vm-service-host=::0` for IPv6 as a launch argument

You can determine if you're on an IPv6 network by opening your Mac's 
**Settings > Wi-Fi > Details (of the network you're connected to) > TCP/IP** 
and check to see if there is an **IPv6 address** section.

<img src="/assets/images/docs/development/add-to-app/debugging/wireless-port.png" alt="Check the box that says 'connect via network' from the devices and simulators page">

</li>
</ol>

#### Android

Ensure that your device is wirelessly connected to Android Studio 
as described in the [Android setup guide][].

[iOS setup guide]: {{site.url}}/get-started/install/macos#deploy-to-ios-devices
[Android setup guide]: {{site.url}}/get-started/install/macos#set-up-your-android-device
