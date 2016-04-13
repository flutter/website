---
layout: page
title: Building an APK for Android
permalink: /building-apk/
---

The `flutter run` tool builds an APK and installs it on your
device. However, that tool is only meant for development, and
successive runs of that tool do not update the APK
with the latest code for your app. To build a deployment-ready copy
of your app for Android, use `flutter build apk`.

Note: A default [Android App Manifest file][manifest]
is created for your app by the flutter tool, and can be found at
`MY_FLUTTER_APP/apk/AndroidManifest.xml`.

Follow these steps to build a deployment-ready APK:

1. cd into your application's directory
2. Run `flutter build apk`

The APK can be found in `MY_FLUTTER_APP/build/app.apk`.

# Installing an APK onto a device

Follow these steps to install your APK onto a connected Android device:

1. Connect your Android device to your workstation/laptop
2. cd into your application's directory
3. Run `flutter install`

[manifest]: http://developer.android.com/guide/topics/manifest/manifest-intro.html