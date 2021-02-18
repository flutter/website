---
title: Developing for iOS 14
description: Describes a couple gotchas (and how to work around them) when developing for iOS 14.
---

The iOS 14 release, the new version of Apple's mobile operating system,
is here. This page describes some known issues when developing for
iOS 14.

## Launching Flutter with Flutter tools

Due to low-level changes in iOS’s debugger mechanisms,
developers using versions of Flutter earlier than 1.20.4 stable
won't be able to launch apps (by using `flutter run`
or a Flutter-enabled IDE) on physical iOS devices
running iOS 14. This affects **debug**, **profile**, and
**release** builds. Simulator builds, add-to-app modules,
and running directly from Xcode are unaffected.

Upgrading to Flutter 1.22 beta allows you to build,
test, and deploy to iOS without issue. Upgrading to
1.20.4 stable allows you to build and deploy to iOS 14,
but not debug.

## Clipboard notifications

If your iOS 14 app uses text fields, you should build your
production apps with Flutter 1.20 or the 1.22 beta to
ensure that clipboard access notifications are not spuriously
shown when building text fields.

## System font rendering

If your iOS 14 app uses system fonts such as San Francisco (used by default
by Cupertino widgets), text will be incorrectly rendered in a condensed letter
spacing due to changes in iOS's font loading mechanism. This affects debug and
production apps on iOS 14.

To ensure correct font rendering, you should build your production apps with
Flutter 1.22 beta.

## Debugging Flutter

Due to added security around [local network permissions in
iOS 14][], a permission dialog box must now be accepted for
each application in order to enable Flutter debugging
functionalities such as hot-reload and DevTools.

![Screenshot of "allow network connections" dialog]({% asset development/device-connect.png @path %})

This affects debug and profile builds only and won't
appear in release builds. The permission can also be allowed
by enabling **Settings > Privacy > Local Network > Your App**.

For add-to-app users, one additional step has been added
to the [add-to-app project setup guide][],
to re-enable flutter attach for debug builds on physical
devices on iOS 14.

[local network permissions in iOS 14]: {{site.apple-dev}}/news/?id=0oi77447
[add-to-app project setup guide]: /docs/development/add-to-app/ios/project-setup#local-network-privacy-permissions

## Launching debug Flutter without a host computer

Also due to changes in debugger mechanisms, once a Flutter
debug application is installed on the device
(either by using `flutter run` a Flutter-enabled IDE,
or from Xcode), the application can no
longer be re-launched by tapping the application’s icon
in the home screen in iOS 14 on physical devices.

Other launch paths without a host computer, such as deep links
or notifications, won't work on iOS 14 physical devices in debug mode.

Add-to-app debug mode modules will crash on iOS 14
physical devices when running the [`FlutterEngine`][]
if the host application is launched from the home screen.

To launch the application in debug mode on a physical
device again, re-run the app from the host computer
(by using `flutter run`, a Flutter-enabled IDE, or Xcode).

You can also build the application or add-to-app module in profile
or release mode, or on a simulator, which are not affected.

See [Issue 60657][] for more details.


[`FlutterEngine`]: {{site.api}}/objcdoc/Classes/FlutterEngine.html
[Issue 60657]: {{site.github}}/flutter/flutter/issues/60657#issuecomment-688478590


## Conclusion

You might also be interested in the following tracking bugs:

* [Issue 60133: Support Xcode 12]({{site.github}}/flutter/flutter/issues/60133)
* [Issue 61047: Support iOS 14]({{site.github}}/flutter/flutter/issues/61047)

If you experience other bugs or unpolished edges when developing for iOS 14,
please [file a bug!]({{site.github}}/flutter/flutter/issues/new/choose)
