---
title: Developing for iOS 14
description: Describes a couple gotchas (and how to work around them) when developing for iOS14 on Flutter 1.22 beta.
---

The iOS 14 release, the new version of Apple's mobile operating system,
is here. This page describes some known issues when developing for
iOS 14.

But we have some tips to get you up and running&mdash;assuming
that you don't mind being on the leading edge.

## Using hot reload

When you run your app for the first time in debug mode,
iOS 14 presents a popup dialog asking you to allow local
network connections. If you choose **Don't Allow**, hot reload won't
work, because it prevents the app from talking to
Observatory.

![Screenshot of "allow network connections" dialog]({% asset development/ios14-network.png @path %})

**Solution**: Choose **OK** to allow local network connections.

Just to be clear: this only happens in debug mode.
Your users won't see this message in release mode.
Only the debug version of your app needs to access the local network.

For more information,
see [Issue 60634]({{site.github}}/flutter/flutter/issues/60634).


## Launching the app from the home screen

When you install a debug version of your app on a physical
iOS 14 device (by using `flutter run` or launching from Xcode),
then disconnect, and then try to open the app from the home
screen, it crashes.

**Solution**: Use `flutter run --release` (or `--profile`)
if you want to start your app from the home screen.

Once again, the crash only happens in debug mode,
and only when opening the app from the home screen on iOS 14.
This crash _doesn't_ happen when using the iOS simulator.


For more information,
see [Issue 62531]({{site.github}}/flutter/flutter/issues/62531).

## Launching Flutter with Flutter tools

Due to low-level changes in iOS’s debugger mechanisms,
developers using versions of Flutter earlier than 1.22 beta
won't be able to launch apps (by using `flutter run`
or a Flutter IDE plugin) on physical iOS devices
running iOS 14. This affects **debug**, **profile**, and
**release** builds. Simulator builds, add-to-app modules,
and running directly from Xcode are unaffected. 

Developers who have upgraded to Flutter 1.22 beta can build,
test, and deploy to iOS without issue.

## Debugging Flutter

Due to added security around local network permissions in
iOS 14, a permission dialog box must now be accepted for
each application in order to enable Flutter debugging
functionalities such as hot-reload and DevTools. 

![Screenshot of "allow network connections" dialog]({% asset development/device-connect.png @path %})

This affects debug and profile builds only and won't
appear in release builds. 

For add-to-app users, one additional step has been added
to the add-to-app project setup guide,
[Integrate a Flutter module into your iOS project][],
to re-enable flutter attach for debug builds on physical
devices on iOS 14. 

[Integrate a Flutter module into your iOS projecta]: /docs/development/add-to-app/ios/project-setup

## Launching debug Flutter without a host computer

Also due to changes in debugger mechanisms, once a Flutter
debug application is installed on the device
(either by using `flutter run` a Flutter enabled IDE,
or from Xcode), the application can no
longer be re-launched by tapping the application’s icon
in the home screen in iOS 14 on physical devices. 

Other launch paths without a host computer, such as deep links
or notifications, won't work on iOS 14 physical devices in debug mode. 

Add-to-app debug mode modules will crash on iOS 14
physical devices when running the [`FlutterEngine`][].

To launch the application in debug mode on a physical
device again, re-run the app (by using `flutter run`,
a Flutter-enabled IDE, or Xcode). 

You can also build the application or add-to-app module
in profile or release mode, which are not affected. 

See [Issue 60657][] for more details.


[`FlutterEngine`]: {{site.api}}/objcdoc/Classes/FlutterEngine.html
[Issue 60657]: {{site.github}}/flutter/flutter/issues/60657#issuecomment-688478590


## Conclusion

You might also be interested in the following tracking bugs:

* [Issue 60133: Support Xcode 12]({{site.github}}/flutter/flutter/issues/60133)
* [Issue 61047: Support iOS 14]({{site.github}}/flutter/flutter/issues/61047)

If you experience other bugs or unpolished edges when developing for iOS 14,
please [file a bug!]({{site.github}}/flutter/flutter/issues/new/choose)
