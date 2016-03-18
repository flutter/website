---
layout: page
title: Building an APK for Android
permalink: /building-apk/
---

_Note: An `apk/AndroidManifest.xml` file was already created for
your app by `flutter create`. You can check it out if you like,
but you don't need to modify it when getting started._

First, ensure you installed the Android SDK tools
(see "Setting up your Android device" from [Getting started](/getting-started)).

Run `android update sdk` from the command line,
and install SDK version 22 and build tools version 22.0.1.
For now, Flutter currently expects only _these_ versions.

Then, inside your Flutter app, run `flutter build apk`.

The APK can be found in `$MY_FLUTTER_APP/build/app.apk`.
