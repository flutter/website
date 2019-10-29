---
title: Measuring your app's size
description: How to measure app size for iOS and Android.
---

Many developers are concerned with the size of their
compiled apps. As the APK, app bundle, or IPA version
of a Flutter app is self contained, and holds all the
code and assets needed to run the app, its size
can be a concern. The larger an app, the more space
it requires on a device, and the longer it takes to
download, and it may break the limit of useful features
like Android instant apps.

By default, launching your app with `flutter run`,
or by clicking the **Play** button in your IDE
(as used in [Test drive][] and
[Write your first Flutter app][]),
generates a _debug_ build of the Flutter app.
The app size of a debug build is large due to
the debugging overhead that allows for hot reload
and source level debugging.

To get a better sense of what an end-user actually
has to download for a Flutter app, use the
following instructions.

## Android

Run the following from the top of your Flutter project
to get the size of APK for 32-bit Android devices:

```shell
flutter build apk --target-platform=android-arm
```

The output should look something like the following:

```shell
Built build/app/outputs/apk/release/app-release.apk (4.2MB).
```

For 64-bit Android devices, run the following:

```shell
flutter build apk --target-platform=android-arm64
```

Here is an example output:

```shell
Built build/app/outputs/apk/release/app-release.apk (4.6MB).
```

As of Flutter 1.9, you can run the following to get 2 APKs,
one for 32-bit and one for 64-bit:

```shell
flutter build apk --split-per-abi
```

Here's some sample output:

```shell
Built build/app/outputs/apk/release/app-armeabi-v7a-release.apk (4.2MB).
Built build/app/outputs/apk/release/app-arm64-v8a-release.apk (4.6MB).
```

{{site.alert.warning}}
  Do not run `flutter build apk` directly in Flutter 1.9
  (and later), because it generates a fat APK with both
  32-bit and 64-bit binaries.
{{site.alert.end}}

## iOS

To get a rough idea of how large your release IPA is,
run the following:

```shell
flutter build ios && tar -zcf build/app.ipa build/ios/iphoneos/Runner.app && ls -lh build/app.ipa
```

The resulting IPA file for the `example/helloworld` app
(as of this writing) is 8.3 MB.

```shell
-rw-r--r--  1 userName  primarygroup   8.3M Oct 25 13:47 build/app.ipa
```

To measure an iOS app exactly,
you have to upload a release IPA to Apple’s
App Store Connect ([instructions][])
and obtain the size report from there.
IPAs are commonly larger than APKs as explained
in [How big is the Flutter engine?][], a
section in the Flutter [FAQ][].

## Reducing app size

Some of the obvious things you can do to make your app smaller
are:

* Remove unused resources
* Minimize resource imported from libraries
* Support a limited number of screen densities
* Compress PNG, JPEG, and PNG files..


[FAQ]: /docs/resources/faq
[How big is the Flutter engine?]: /docs/resources/faq#how-big-is-the-flutter-engine
[instructions]: /docs/deployment/ios
[Test drive]: /docs/get-started/test-drive
[Write your first Flutter app]: /docs/get-started/codelab

