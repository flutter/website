---
title: Networking
description: Internet network calls in Flutter.
---

## Cross-platform http networking

The [`http`][] package provides the simplest way to issue http requests. This
package is supported on Android, iOS, and the web.

## Platform notes

Some platforms require additional steps, as detailed below.

### Android

Android apps must [declare their use of the internet][declare] in the Android
manifest (`AndroidManifest.xml `):

```
<manifest xmlns:android...>
 ...
 <uses-permission android:name="android.permission.INTERNET" />
 <application ...
</manifest>
```

### macOS
macOS apps must allow network access in the relevant `.entitlements` files. 

```
<key>com.apple.security.network.client</key>
<true/>
```

Learn more about
[setting up entitlements]({{site.url}}/desktop/macos#setting-up-entitlements).

## Samples

For a practical sample of various networking tasks (incl. fetching data,
WebSockets, and parsing data in the background) see the 
[networking cookbook]({{site.url}}/cookbook#networking).

[declare]: {{site.android-dev}}/training/basics/network-ops/connecting
[`http`]: {{site.pub-pkg}}/http
