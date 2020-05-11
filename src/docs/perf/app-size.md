---
title: Measuring your app's size
description: How to measure app size for iOS and Android.
---

Many developers are concerned with the size of their
compiled app. As the APK, app bundle, or IPA version
of a Flutter app is self contained, and holds all the
code and assets needed to run the app, its size
can be a concern. The larger an app, the more space
it requires on a device, the longer it takes to download,
and it may break the limit of useful features
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

You can run the following to get 2 APKs,
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
  (and later), because it generates a fat APK
  containing both 32-bit and 64-bit binaries.
{{site.alert.end}}

## iOS

Create an [Xcode App Size Report][]
by configurting the app version and build
as described in the [iOS create build archive instructions][].

Then:

1. Select **Product > Archive** to produce a build archive.
1. In the sidebar of the Xcode Organizer window, select your iOS app,
   then select the build archive you just produced.
1. Click **Distribute App**.

`Method of distribution`
: Ad Hoc, Development, or Enterprise

`App Thinning`
: All compatible device variants

`Rebuild from Bitcode`
: Selected (available if bitcode is enabled on your project)

`Strip Swift symbols`
: Selected

Sign and export the IPA. The exported directory contains
`App Thinning Size Report.txt` with details about your projected
application size on different devices and versions of iOS.

The App Size Report for the default demo app
(as of this writing) shows:
```
Variant: Runner-7433FC8E-1DF4-4299-A7E8-E00768671BEB.ipa
Supported variant descriptors: [device: iPhone12,1, os-version: 13.0] and [device: iPhone11,8, os-version: 13.0]
App + On Demand Resources size: 5.3 MB compressed, 12.9 MB uncompressed
App size: 5.3 MB compressed, 12.9 MB uncompressed
On Demand Resources size: Zero KB compressed, Zero KB uncompressed
```

In this example, the app has an approximate
download size of 5.3 MB and an approximate
install size of 12.9 MB on an iPhone12,1 ([Model ID / Hardware
number][] for iPhone 11)
and iPhone11,8 (iPhone XR) running iOS 13.0.

To measure an iOS app exactly,
you have to upload a release IPA to Apple’s
App Store Connect ([instructions][])
and obtain the size report from there.
IPAs are commonly larger than APKs as explained
in [How big is the Flutter engine?][], a
section in the Flutter [FAQ][].

## Reducing app size

When building a release version of your app,
consider using the `--split-debug-info` tag.
This tag can dramatically reduce code size.
For an example of using this tag, see
[Obfuscating Dart code][].

Some of the other things you can do to make your app smaller
are:

* Remove unused resources
* Minimize resource imported from libraries
* Support a limited number of screen densities
* Compress PNG and JPEG files


[FAQ]: /docs/resources/faq
[How big is the Flutter engine?]: /docs/resources/faq#how-big-is-the-flutter-engine
[instructions]: /docs/deployment/ios
[Xcode App Size Report]: https://developer.apple.com/documentation/xcode/reducing_your_app_s_size#3458589
[iOS create build archive instructions]: /docs/deployment/ios#create-a-build-archive
[Model ID / Hardware number]: https://en.wikipedia.org/wiki/List_of_iOS_devices#Models
[Obfuscating Dart code]: /docs/deployment/obfuscate
[Test drive]: /docs/get-started/test-drive
[Write your first Flutter app]: /docs/get-started/codelab
