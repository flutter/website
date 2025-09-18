---
title: Networking
description: Internet network calls in Flutter.
---

## Cross-platform http networking

The [`http`][] package provides the simplest way to issue http requests. This
package is supported on Android, iOS, macOS, Windows, Linux and the web.

## Platform notes

Some platforms require additional steps, as detailed below.

### Android

Android apps must [declare their use of the internet][declare] in the Android
manifest (`AndroidManifest.xml`):

```xml
<manifest xmlns:android...>
 ...
 <uses-permission android:name="android.permission.INTERNET" />
 <application ...
</manifest>
```

### macOS

macOS apps must allow network access in the relevant `*.entitlements` files. 

```xml
<key>com.apple.security.network.client</key>
<true/>
```

Learn more about [setting up entitlements][].

[setting up entitlements]: /platform-integration/macos/building#setting-up-entitlements

## Samples

For a practical sample of various networking tasks (incl. fetching data,
WebSockets, and parsing data in the background) see the 
[networking cookbook recipes](/cookbook/networking).

[declare]: {{site.android-dev}}/training/basics/network-ops/connecting
[`http`]: {{site.pub-pkg}}/http
