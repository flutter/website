---
title: iOS debugging
description: iOS-specific debugging techniques for Flutter apps
---

{{site.alert.note}}
  To ensure correct font rendering,
  you should build your production apps with
  Flutter 1.22 or later.
{{site.alert.end}}

Due to security around [local network permissions][],
you must accept a permission dialog box to enable
Flutter debugging functionalities such as hot-reload
and DevTools.

![Screenshot of "allow network connections" dialog]({{site.url}}/assets/images/docs/development/device-connect.png)

This affects debug and profile builds only and won't
appear in release builds. You can also allow this
permission by enabling
**Settings > Privacy > Local Network > Your App**.

[local network permissions]: {{site.apple-dev}}/news/?id=0oi77447
