---
title: iOS debugging
description: iOS-specific debugging techniques for Flutter apps
---

Due to security around
[local network permissions in iOS 14 or later][],
you must accept a permission dialog box to enable
Flutter debugging functionalities such as hot-reload
and DevTools.

![Screenshot of "allow network connections" dialog]({{site.url}}/assets/images/docs/development/device-connect.png)

This affects debug and profile builds only and won't
appear in release builds. You can also allow this
permission by enabling
**Settings > Privacy > Local Network > Your App**.

[local network permissions in iOS 14 or later]: {{site.apple-dev}}/news/?id=0oi77447

