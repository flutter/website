---
title: Preparing an Android app for release
description: How to prepare for and release an Android app to the Play store.
short-title: Android
---

During a typical development cycle,
you test an app using `flutter run` at the command line,
or by using the **Run** and **Debug**
options in your IDE. By default,
Flutter builds a _debug_ version of your app.

When you're ready to prepare a _release_ version of your app,
for example to [publish to the Google Play Store][play],
this page can help. Before publishing,
you might want to put some finishing touches on your app.
This page covers the following topics:

* [Adding a launcher icon](#adding-a-launcher-icon)
* [Signing the app](#signing-the-app)
* [Enabling Proguard](#enabling-proguard)
* [Reviewing the app manifest](#reviewing-the-app-manifest)
* [Reviewing the build configuration](#reviewing-the-build-configuration)
* [Building the app for release](#building-the-app-for-release)
* [Publishing to the Google Play Store](#publishing-to-the-google-play-store)
* [Updating the app's version number](#updating-the-apps-version-number)
* [Android release FAQ](#android-release-faq)

## Adding a launcher icon

When a new Flutter app is created, it has a default launcher icon.
To customize this icon, you might want to check out the
[flutter_launcher_icons][] package.

Alternatively, you can do it manually using the following steps:

1. Review the [Material Design product
   icons][launchericons] guidelines for icon design.

1. In the `<app dir>/android/app/src/main/res/` directory,
   place your icon files in folders named using
   [configuration qualifiers][].
   The default `mipmap-` folders demonstrate the correct
   naming convention.

1. In `AndroidManifest.xml`, update the
   [`application`][applicationtag] tag's `android:icon`
   attribute to reference icons from the previous
   step (for example,
   `<application android:icon="@mipmap/ic_launcher" ...`).

1. To verify that the icon has been replaced,
   run your app and inspect the app icon in the Launcher.

## Signing the app

To publish on the Play Store, you need to give your app a digital
signature. Use the following instructions to sign your app.

### Create a keystore

If you have an existing keystore, skip to the next step.
If not, create one by running the following at the command line:

On Mac/Linux, use the following command:

```terminal
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

On Windows, use the following command:

```terminal
keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

{{site.alert.warning}}
  Keep the `keystore` file private;
  do not check it into public source control.
{{site.alert.end}}

{{site.alert.note}}
* The `keytool` command might not be in your path&mdash;it's
  part of Java, which is installed as part of
  Android Studio.  For the concrete path,
  run `flutter doctor -v` and locate the path printed after
  'Java binary at:'. Then use that fully qualified path
  replacing `java` (at the end) with `keytool`.
  If your path includes space-separated names,
  such as `Program Files`, place quotes around the
  space-separated names. For example: `/"Program Files"/`

* The `-storetype JKS` tag is only required for Java 9
  or newer. As of the Java 9 release,
  the keystore type defaults to PKS12.
{{site.alert.end}}

### Reference the keystore from the app

Create a file named `<app dir>/android/key.properties`
that contains a reference to your keystore:

```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=key
storeFile=<location of the key store file, such as /Users/<user name>/key.jks>
```

{{site.alert.warning}}
  Keep the `key.properties` file private;
  do not check it into public source control.
{{site.alert.end}}

### Configure signing in gradle

Configure signing for your app by editing the
`<app dir>/android/app/build.gradle` file.

<ol markdown="1">
<li markdown="1">Replace the following:

```
   android {
```

   With the keystore information from your properties file:

```
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
```
</li>

<li markdown="1"> Replace the following:

```
   buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now,
           // so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```

   With the signing configuration info:

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
</li>
</ol>

Release builds of your app will now be signed automatically.

## Enabling Proguard

By default, Flutter does not obfuscate or minify the Android host.
If you intend to use third-party Java, Kotlin, or Android libraries,
you might want to reduce the size of the APK or protect that code from
reverse engineering.

For information on obfuscating Dart code, see
[Obfuscating Dart Code][] in the [Flutter wiki][].

### Step 1 - Configure Proguard

Create a `/android/app/proguard-rules.pro` file and
add the rules listed below.

```
## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
```

This configuration only protects Flutter engine libraries.
Any additional libraries (for example, Firebase) require adding
their own rules.

### Step 2 - Enable obfuscation and/or minification

Open the `/android/app/build.gradle` file and locate the `buildTypes`
definition. Inside the `release` configuration section,
set the `minifiyEnabled` and `useProguard` flags to true.
You must also point Proguard to the file you created in step 1:

```
android {

    ...

    buildTypes {

        release {

            signingConfig signingConfigs.release

            minifyEnabled true
            useProguard true

            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'

        }
    }
}
```

{{site.alert.note}}
  Obfuscation and minification can considerably extend compile time
  of the Android application.
{{site.alert.end}}

## Reviewing the app manifest

Review the default [App Manifest][manifest] file,
`AndroidManifest.xml`,
located in `<app dir>/android/app/src/main` and verify that the values
are correct, especially the following:

`application`
: Edit the `android:label` in the
  [`application`][applicationtag] tag to reflect
  the final name of the app.

`uses-permission`
: Add the `android.permission.INTERNET`
  [permission][permissiontag] if your application code needs Internet
  access. The standard template does not include this tag but allows
  Internet access during development to enable communication between
  Flutter tools and a running app.

## Reviewing the build configuration

Review the default [Gradle build file][gradlebuild] file,
`build.gradle`, located in `<app dir>/android/app` and
verify the values are correct, especially the following
values in the `defaultConfig` block:

`applicationId`
: Specify the final, unique (Application Id)[appid]

`versionCode` & `versionName`
: Specify the internal app version number,
  and the version number display string. You can do this by setting
  the `version` property in the pubspec.yaml file. Consult the version
  information guidance in the [versions documentation][versions].

`minSdkVersion` & `targetSdkVersion`
: Specify the minimum API level,
  and the API level on which the app is designed to run.
  Consult the API level section in the [versions documentation][versions]
  for details.

## Building the app for release

You have two possible release formats when publishing to
the Play Store.

* App bundle (preferred)
* APK

{{site.alert.note}}
  The Google Play Store prefers the app bundle format.
  For more information, see [Android App Bundle][bundle] and
  [About Android App Bundles][bundle2].
{{site.alert.end}}

### Build an app bundle

This section describes how to build a release app bundle.
If you completed the signing steps,
the app bundle will be signed.

{{site.alert.warning}}
  Recently, the Flutter team has received several reports
  from developers indicating they are experiencing app
  crashes on certain devices on Android 6.0 when building
  an app bundle.
  While the Android team is working to identify a feasible
  solution, you might try splitting the APK as a temporary
  workaround. For more information, see [Issue 36822][].
{{site.alert.end}}

From the command line:

1. Enter `cd <app dir>`<br>
   (Replace `<app dir>` with your application's directory.)
1. Run `flutter build appbundle`<br>
   (Running `flutter build` defaults to a release build.)

The release bundle for your app is created at
`<app dir>/build/app/outputs/bundle/release/app.aab`.

By default, the app bundle contains your Dart code and the Flutter
runtime compiled for [armeabi-v7a][] (32-bit) and [arm64-v8a][] (64-bit).

### Test the app bundle

An app bundle can be tested in multiple ways&mdash;this section
describes two.

#### Offline using the bundle tool

1. If you haven't done so already, download `bundletool` from the
   [GitHub repository][].
1. [Generate a set of APKs][apk-set] from your app bundle.
1. [Deploy the APKs][apk-deploy] to connected devices.

#### Online using Google Play

1. Upload your bundle to Google Play to test it.
   You can use the internal test track,
   or the alpha or beta channels to test the bundle before
   releasing it in production.
2. Follow [these steps to upload your bundle][upload-bundle]
   to the Play Store.

### Build an APK

Although app bundles are preferred over APKs, there are stores
that don't yet support app bundles. In this case, build a release
APK for each target ABI (Application Binary Interface).

If you completed the signing steps,
the APK will be signed.

From the command line:

1. Enter `cd <app dir>`<br>
   (Replace `<app dir>` with your application's directory.)
1. Run `flutter build apk --split-per-abi`<br>
   (The `flutter build` command defaults to `--release`.)

This command results in two APK files:

* `<app dir>/build/app/outputs/apk/release/app-armeabi-v7a-release.apk`
* `<app dir>/build/app/outputs/apk/release/app-arm64-v8a-release.apk`

Removing the `--split-per-abi` flag results in a fat APK that contains
your code compiled for _all_ the target ABIs. Such APKs are larger in
size than their split counterparts, causing the user to download
native binaries that are not applicable to their device's architecture.

### Install an APK on a device

Follow these steps to install the APK on a connected Android device.

From the command line:

1. Connect your Android device to your computer with a USB cable.
1. Enter `cd <app dir>` where `<app dir>` is your application directory.
1. Run `flutter install`.

## Publishing to the Google Play Store

For detailed instructions on publishing your app to the Google Play Store,
see the [Google Play launch][play] documentation.

Now that you’ve created your app, attract more users with Google Ads.
App campaigns use machine learning to drive more installs and
make the most of your budget.

Get your campaign running in a few steps:

1. Create your ad&mdash;we’ll help create your ad from your app
   information
1. Choose your budget&mdash;set your target cost-per-install (tCPI)
   and daily budget cap
1. Select your location&mdash;let us know where you’d like your ads to run
1. Decide what action you want users to take&mdash;choose installs,
   in-app actions, or target return on ad spend (ROAS)

[Get $75 app advertising credit when you spend $25.][]

## Updating the app's version number

The default version number of the app is `1.0.0`.
To update it, navigate to the `pubspec.yaml` file
and update the following line:

`version: 1.0.0+1`

The version number is three numbers separated by dots,
such as `1.0.0` in the example above, followed by an optional
build number such as `1` in the example above, separated by a `+`.

Both the version and the build number may be overridden in Flutter's
build by specifying `--build-name` and `--build-number`, respectively.

In Android, `build-name` is used as `versionName` while
`build-number` used as `versionCode`. For more information,
see [Version your app][] in the Android documentation.

## Android release FAQ

Here are some commonly asked questions about deployment for
Android apps.

### When should I build app bundles versus APKs?

The Google Play Store recommends that you deploy app bundles
over APKs because they allow a more efficient delivery of the
application to your users. However, if you’re distributing
your application by means other than the Play Store,
an APK may be your only option.

### What is a fat APK?

A [fat APK][] is a single APK that contains binaries for multiple
ABIs embedded within it. This has the benefit that the single APK
runs on multiple architectures and thus has wider compatibility,
but it has the drawback that its file size is much larger,
causing users to download and store more bytes when installing
your application. When building APKs instead of app bundles,
it is strongly recommended to build split APKs,
as described in [build an APK](#build-an-apk) using the
`--split-per-abi` flag.

### What are the supported target architectures?

When building your application in release mode,
Flutter apps can be compiled for [armeabi-v7a][] (32-bit)
and [arm64-v8a][] (64-bit). Flutter does not currently support
building for x86 Android (See [Issue 9253][]).

### How do I sign the app bundle created by `flutter build appbundle`?

See [Signing the app](#signing-the-app).

### How do I build a release from within Android Studio?

In Android Studio, open the existing `android/`
folder under your app’s folder. Then,
select **build.gradle (Module: app)** in the project panel:

{% asset 'deployment/android/gradle-script-menu.png' alt='screenshot of gradle build script menu' %}

Next, select the build variant. Click **Build > Select Build Variant**
in the main menu. Select any of the variants in the **Build Variants**
panel (debug is the default):

{% asset 'deployment/android/build-variant-menu.png' alt='screenshot of build variant menu' %}

The resulting app bundle or APK files are located in
`build/app/outputs` within your app's folder.

{% comment %}
### Are there any special considerations with add-to-app?
{% endcomment %}

[apk-deploy]: {{site.android-dev}}/studio/command-line/bundletool#deploy_with_bundletool
[apk-set]: {{site.android-dev}}/studio/command-line/bundletool#generate_apks
[appid]: {{site.android-dev}}/studio/build/application-id
[applicationtag]: {{site.android-dev}}/guide/topics/manifest/application-element
[arm64-v8a]: {{site.android-dev}}/ndk/guides/abis#arm64-v8a
[armeabi-v7a]: {{site.android-dev}}/ndk/guides/abis#v7a
[bundle]: {{site.android-dev}}/platform/technology/app-bundle
[bundle2]: {{site.android-dev}}/guide/app-bundle
[configuration qualifiers]: {{site.android-dev}}/guide/topics/resources/providing-resources#AlternativeResources
[fat APK]: https://en.wikipedia.org/wiki/Fat_binary
[Flutter wiki]: {{site.github}}/flutter/flutter/wiki
[flutter_launcher_icons]: {{site.pub}}/packages/flutter_launcher_icons
[Get $75 app advertising credit when you spend $25.]: https://ads.google.com/lp/appcampaigns/?modal_active=none&subid=ww-ww-et-aw-a-flutter1!o1#?modal_active=none
[GitHub repository]: {{site.github}}/google/bundletool/releases/latest
[gradlebuild]: {{site.android-dev}}/studio/build/#module-level
[Issue 9253]: {{site.github}}/flutter/flutter/issues/9253
[Issue 18494]: {{site.github}}/flutter/flutter/issues/18494
[Issue 36822]: {{site.github}}/flutter/flutter/issues/36822
[launchericons]: {{site.material}}/design/iconography/
[manifest]: {{site.android-dev}}/guide/topics/manifest/manifest-intro
[manifesttag]: {{site.android-dev}}/guide/topics/manifest/manifest-element
[Obfuscating Dart Code]: {{site.github}}/flutter/flutter/wiki/Obfuscating-Dart-Code
[permissiontag]: {{site.android-dev}}/guide/topics/manifest/uses-permission-element
[play]: {{site.android-dev}}/distribute/googleplay/start
[upload-bundle]: {{site.android-dev}}/studio/publish/upload-bundle
[Version your app]: {{site.android-dev}}/studio/publish/versioning
[versions]: {{site.android-dev}}/studio/publish/versioning
