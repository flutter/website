---
title: Developing for iOS 14 beta
description: Describes a couple gotchas (and how to work around them) when developing for iOS14 on Flutter 1.20.
---

The iOS 14 release, the new version of Apple's mobile operating system,
is coming. As it's not yet stable, we don't fully support it yet.

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
iOS 14 device (using `flutter run` or from Xcode), then disconnect,
and then try to open the app from the home screen, it crashes.

**Solution**: Use `flutter run --release` (or `--profile`)
if you want to start your app from the home screen.

Once again, the crash only happens in debug mode,
and only when opening the app from the home screen on iOS 14.
This crash _doesn't_ happen when using the iOS simulator.


For more information,
see [Issue 62531]({{site.github}}/flutter/flutter/issues/62531).


## Conclusion

You might also be interested in the following tracking bugs:

* [Issue 60133: Support Xcode 12]({{site.github}}/flutter/flutter/issues/60133)
* [Issue 61047: Support iOS 14]({{site.github}}/flutter/flutter/issues/61047)

If you experience other bugs or unpolished edges when developing for iOS 14,
please [file a bug!]({{site.github}}/flutter/flutter/issues/new/choose)
