---
title: Request local network permissions on Android
shortTitle: Local network permission
description: >-
  Learn how to declare and request Android local area network permissions
  before opening Dart sockets in Flutter.
---

Starting in Android 17 (API level 37), Android blocks local network access
by default. Apps targeting Android 17 or higher that discover, scan,
or connect to devices on the local area network must declare and request
the `ACCESS_LOCAL_NETWORK` runtime permission.

:::note
Although enforced for apps targeting Android 17 (API level 37) and higher,
you can opt in to test this behavior on Android 16 (API level 36).
:::

## Understand the impact on Dart sockets

The standard `dart:io` library provides low-level socket networking,
including [`Socket`][socket-class], [`RawSocket`][raw-socket-class],
and [`ServerSocket`][server-socket-class].
These socket classes operate at the system level
and do not interact with Android's application framework UI.

Because Dart sockets cannot display an Android permission prompt,
any attempt to connect to a local IP address without the required permission
fails and throws a `SocketException`.
To prevent connection failures,
request the runtime permission in Flutter
before you initialize or connect your Dart socket.

## Declare the permission in Android

Before you can request the permission at runtime,
declare it in your Android manifest.

1. Open `android/app/src/main/AndroidManifest.xml`.
1. Add the `ACCESS_LOCAL_NETWORK` permission inside the `<manifest>` tag:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.ACCESS_LOCAL_NETWORK" />
    <application
        ...
    </application>
</manifest>
```

## Add the permission_handler package

To request Android runtime permissions from Dart,
use the [`permission_handler`][] plugin from [pub.dev][].

Add `permission_handler` to your Flutter project dependencies:

```bash
flutter pub add permission_handler
```

## Request permission before connecting a socket

Call `Permission.accessLocalNetwork.request()`
before opening a Dart socket connection.

The following example demonstrates how to check the platform,
request local network permission,
and open a socket connection:

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> connectToLocalDevice({
  required String host,
  required int port,
}) async {
  // Check and request runtime permission on Android.
  if (Platform.isAndroid) {
    final status = await Permission.accessLocalNetwork.request();

    if (status.isPermanentlyDenied) {
      // The user opted not to grant permission and checked "Don't ask again".
      // In a real app, show an explanation dialog before calling openAppSettings().
      debugPrint('Permission permanently denied. Please enable it in settings.');
      return;
    }

    if (!status.isGranted) {
      // Handle the case where the user denied permission.
      debugPrint('Local network permission was denied.');
      return;
    }
  }

  // Connect the Dart socket after the permission is granted.
  try {
    final socket = await Socket.connect(
      host,
      port,
      timeout: const Duration(seconds: 5),
    );

    debugPrint(
      'Connected to ${socket.remoteAddress.address}:${socket.remotePort}',
    );

    // Use the socket...

    await socket.close();
  } on SocketException catch (e) {
    debugPrint('Failed to connect: $e');
  }
}
```

## Handle permission status

The `Permission.accessLocalNetwork.request()` method
returns a `PermissionStatus` enum that indicates the outcome:

* `PermissionStatus.granted`: The user granted local network access.
  You can proceed to connect your Dart sockets.
* `PermissionStatus.denied`: The user denied permission for this request.
  Prompt the user with an explanation before requesting permission again.
* `PermissionStatus.permanentlyDenied`: The user denied permission permanently.
  Call `openAppSettings()` to help the user enable permission
  in the system settings.

:::tip
You only need to obtain permission once during an app session,
but checking the status before establishing a socket connection
ensures reliable network calls.
:::

## More information

To learn more about local network permissions and socket programming,
consult the following resources:

* Android developer guide on [Local network permission][android-local-network]
* [`permission_handler`][] package on pub.dev
* Dart [`Socket` class documentation][socket-class]
* [Issue #184859 on GitHub][flutter-issue-184859]

[android-local-network]: https://developer.android.com/privacy-and-security/local-network-permission#android-17-enforcement
[`permission_handler`]: {{site.pub-pkg}}/permission_handler
[pub.dev]: {{site.pub}}
[socket-class]: {{site.dart.api}}/dart-io/Socket-class.html
[raw-socket-class]: {{site.dart.api}}/dart-io/RawSocket-class.html
[server-socket-class]: {{site.dart.api}}/dart-io/ServerSocket-class.html
[flutter-issue-184859]: {{site.repo.flutter}}/issues/184859
