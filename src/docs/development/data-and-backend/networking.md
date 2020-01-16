---
title: Networking
description: Internet network calls in Flutter.
---

## Cross-platform http networking

The [`http`][] package provides the simplest way to issue http requests. This
package is supported on Android, iOS, and the web.

## Platform notes

### Android

Android apps must [declare their use of the internet][declare] in the Android
manifest (`AndroidManifest.xml `):

```
<manifest xlmns:android...>
 ...
 <uses-permission android:name="android.permission.INTERNET" />
 <application ...
</manifest>
```

## Samples

For a practical samples of various networking tasks (incl. fetching data,
WebSockets, and parsing data in the background) see the 
[networking cookbook(https://flutter.dev/docs/cookbook#networking).

[`http`]: {{site.pub-pkg}}/http
[declare]: https://developer.android.com/training/basics/network-ops/connecting
