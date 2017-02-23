---
layout: page
title: Preparing an Android app for Release
sidebar: home_sidebar
permalink: /android-release/
---

When running an app during development with `flutter run` from the command line,
or with the Run and Debug actions in IntelliJ, Flutter builds a *Debug* version
of your app. To prepare a *Release* version of the app for Android, for example
in preparation for [publishing on Google Play][play], take these steps.

* TOC Placeholder
{:toc}

## Update the App Manifest

When you create a new app, a default [App Manifest][manifest] file is created
for your app. It and can be found at `<app
dir>/android/src/main/AndroidManifest.xml`. Prior to releasing, make sure the
values are correct. Pay special attention to the following values:

* `application`: Edit the [`application`][applicationtag] tag to contain the final name of the app.

* `manifest`: Specify the [version][versions] code and name in the [`manifest`][manifesttag] tag.

* `uses-sdk`: Specify the [API versions][apiversionstag] the app is compatible with.

*  `uses-permission`: The standard template contains an
  `android.permission.INTERNET` [permission][permissiontag], as this is required
  to enable the Flutter tools to communicate with the running app. For your
  release app, remove this permission if your application code does not need
  Internet access.

## Adding a Launcher icon

When a new Flutter app is created, a default Launcher icon is added. To
customize this icon:

1. Review the [Android Launcher Icons][launchericons] guidance on good icon
design for the Launcher.

1. Inside the `<app dir>/android/src/main/res/` directory, place your icon files
in folders named using [Configuration Qualifiers][configurationqualifiers].].
The default `mipmap-` folders demonstrate this.

1. In `AndroidManifest.xml`, update the [`application`][applicationtag] tag's
`android:icon` attribute to reference icons from the previous step (e.g.
`<application android:icon="@mipmap/ic_launcher" ...`).

1. To test, `flutter run` the app and inspect the app icon in the Launcher.

## Sign the app

### Create a Key Store
If you have an existing "Key Store" skip to the next step. If not, create one
by running the following command in a terminal:
`keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key`

*Note*: Keep this file private; do not check it into public source control.

### Reference the Key Store from the app

Create a file named `<app dir>/android/key.properties`. It should
contain a reference to your Key Store:

```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=key
storeFile=<location of the key store file, e.g. '/Users/<user name>/key.jks'>
```

*Note*: Keep this file private; do not check it into public source control.

### Configure signing in gradle

Configure signing in the `<app dir>/android/app/build.gradle` file:

Replace:
```
android {
```
with:
```
// Load keystore information from a properties file.
def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

android {
```

Next, replace:
```
buildTypes {
    release {
        // TODO: Add your own signing config for the release build.
        // Signing with the debug keys for now, so `flutter run --release` works.
        signingConfig signingConfigs.debug
    }
}
```
with:
```
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

Your app will now automatically be signed when doing release builds.

## Build a release APK

Follow these steps to build a release APK. If you completed the signing steps in
the previous section, the release APK will be signed.

Using the command line:

1. `cd <app dir>` (replace `<app dir>` with your application's directory).
1. Run `flutter build apk`.

The APK is placed in `<app dir>/android/app/build/outputs/app.apk`.

## Installing a release APK onto a device

Follow these steps to install the APK built in the previous step onto a
connected Android device.

Using the command line:

1. Connect your Android device to your PC with a USB cable
1. `cd <app dir>` (replace `<app dir>` with your application's directory)
1. Run `flutter install`

## Publish APK to Google Play

Please see the [Google Play Publishing documentation][play].

[manifest]: http://developer.android.com/guide/topics/manifest/manifest-intro.html
[manifesttag]: https://developer.android.com/guide/topics/manifest/manifest-element.html
[permissiontag]: https://developer.android.com/guide/topics/manifest/uses-permission-element.html
[apiversionstag]: https://developer.android.com/guide/topics/manifest/uses-sdk-element.html
[applicationtag]: https://developer.android.com/guide/topics/manifest/application-element.html
[versions]: https://developer.android.com/studio/publish/versioning.html
[launchericons]: https://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher.html
[configurationqualifiers]: https://developer.android.com/guide/practices/screens_support.html#qualifiers
[play]: https://developer.android.com/distribute/googleplay/start.html
