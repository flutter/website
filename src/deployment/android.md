---
title: Build and release an Android app
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
* [Enabling Material Components](#enabling-material-components)
* [Signing the app](#signing-the-app)
* [Shrinking your code with R8](#shrinking-your-code-with-r8)
* [Enabling multidex support](#enabling-multidex-support)
* [Reviewing the app manifest](#reviewing-the-app-manifest)
* [Reviewing the build configuration](#reviewing-the-build-configuration)
* [Building the app for release](#building-the-app-for-release)
* [Publishing to the Google Play Store](#publishing-to-the-google-play-store)
* [Updating the app's version number](#updating-the-apps-version-number)
* [Android release FAQ](#android-release-faq)

{{site.alert.note}}
   Throughout this page, `[project]` refers to 
   the directory that your application is in. While following
   these instructions, substitute `[project]` with 
   your app's directory.
{{site.alert.end}}

## Adding a launcher icon

When a new Flutter app is created, it has a default launcher icon.
To customize this icon, you might want to check out the
[flutter_launcher_icons][] package.

Alternatively, you can do it manually using the following steps:

1. Review the [Material Design product
   icons][launchericons] guidelines for icon design.

1. In the `[project]/android/app/src/main/res/` directory,
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

## Enabling Material Components

If your app uses [Platform Views][], you may want to enable
Material Components by following the steps described in the
[Getting Started guide for Android][].

For example:

1. Add the dependency on Android's Material in `<my-app>/android/app/build.gradle`:

```groovy
dependencies {
    // ...
    implementation 'com.google.android.material:material:<version>'
    // ...
}
```

To find out the latest version, visit [Google Maven][].

2. Set the light theme in `<my-app>/android/app/src/main/res/values/styles.xml`:

```diff
-<style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
+<style name="NormalTheme" parent="Theme.MaterialComponents.Light.NoActionBar">
```

3. Set the dark theme in `<my-app>/android/app/src/main/res/values-night/styles.xml`

```diff
-<style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">
+<style name="NormalTheme" parent="Theme.MaterialComponents.DayNight.NoActionBar">
```

## Signing the app

To publish on the Play Store, you need to give your app a digital
signature. Use the following instructions to sign your app.

On Android, there are two signing keys: deployment and upload. The end-users 
download the .apk signed with the 'deployment key'. An 'upload key' is used to 
authenticate the .aab / .apk uploaded by developers onto the Play Store and is 
re-signed with the deployment key once in the Play Store.
* It's highly recommended to use the automatic cloud managed signing for
  the deployment key. For more information, see the [official Play Store documentation][].

### Create an upload keystore

If you have an existing keystore, skip to the next step.
If not, create one by either:
* Following the [Android Studio key generation steps]({{site.android-dev}}/studio/publish/app-signing#sign-apk) 
* Running the following at the command line:

    On Mac/Linux, use the following command:

    ```terminal
    keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    ```

    On Windows, use the following command:

    ```terminal
    keytool -genkey -v -keystore c:\Users\USER_NAME\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    ```

    This command stores the `upload-keystore.jks` file in your home
    directory. If you want to store it elsewhere, change
    the argument you pass to the `-keystore` parameter.
    **However, keep the `keystore` file private;
    don't check it into public source control!**
    
    {{site.alert.note}}
    * The `keytool` command might not be in your path&mdash;it's
      part of Java, which is installed as part of
      Android Studio.  For the concrete path,
      run `flutter doctor -v` and locate the path printed after
      'Java binary at:'. Then use that fully qualified path
      replacing `java` (at the end) with `keytool`.
      If your path includes space-separated names,
      such as `Program Files`, use platform-appropriate
      notation for the names. For example, on Mac/Linux
      use `Program\ Files`, and on Windows use
      `"Program Files"`.
    
    * The `-storetype JKS` tag is only required for Java 9
      or newer. As of the Java 9 release,
      the keystore type defaults to PKS12.
    {{site.alert.end}}

### Reference the keystore from the app

Create a file named `[project]/android/key.properties`
that contains a reference to your keystore:

```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
```

{{site.alert.warning}}
  Keep the `key.properties` file private;
  don't check it into public source control.
{{site.alert.end}}

### Configure signing in gradle

Configure gradle to use your upload key when building your app in release mode 
by editing the `[project]/android/app/build.gradle` file.

<ol markdown="1">
<li markdown="1"> Add the keystore information from your properties file before the `android` block:

```
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
         ...
   }
```
   
   Load the `key.properties` file into the `keystoreProperties` object.

</li>

<li markdown="1"> Find the `buildTypes` block:

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

   And replace it with the following signing configuration info:

```
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
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

{{site.alert.note}}
  You may need to run `flutter clean` after changing the gradle file.
  This prevents cached builds from affecting the signing process.
{{site.alert.end}}

For more information on signing your app, see
[Sign your app][] on developer.android.com.

## Shrinking your code with R8

[R8][] is the new code shrinker from Google, and it's enabled by default
when you build a release APK or AAB. To disable R8, pass the `--no-shrink`
flag to `flutter build apk` or `flutter build appbundle`.

{{site.alert.note}}
  Obfuscation and minification can considerably extend compile time
  of the Android application.
{{site.alert.end}}

## Enabling multidex support

When writing large apps or making use of large plugins, you may encounter
Android's dex limit of 64k methods when targeting a minimum API of 20 or
below. This may also be encountered when running debug versions of your app
via `flutter run` that does not have shrinking enabled.

Flutter tool supports easily enabling multidex. The simplest way is to
opt into multidex support when prompted. The tool detects multidex build errors
and will ask before making changes to your Android project. Opting in allows
Flutter to automatically depend on `androidx.multidex:multidex` and use a
generated `FlutterMultiDexApplication` as the project's application.

{{site.alert.note}}
  Multidex support is natively included when targeting min sdk 21+.
{{site.alert.end}}

You might also choose to manually support multidex by following Android's guides
and modifying your project's Android directory configuration. A
[multidex keep file][multidex-keep] must be specified to include:

```
io/flutter/embedding/engine/loader/FlutterLoader.class
io/flutter/util/PathUtils.class
```
Also, include any other classes used in app startup.
See the official [Android documentation][multidex-docs] for more detailed
guidance on adding multidex support manually.

## Reviewing the app manifest

Review the default [App Manifest][manifest] file,
`AndroidManifest.xml`,
located in `[project]/android/app/src/main` and verify that the values
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

## Reviewing the Gradle build configuration

Review the default [Gradle build file][gradlebuild] (`build.gradle`) located in 
`[project]/android/app` to verify the values are correct, especially the following
values in the `defaultConfig` block:

#### Under defaultConfig

`applicationId`
: Specify the final, unique (Application Id)[appid]
  
`minSdkVersion`
: Specify the minimum API level on which the app is designed to run.
  Defaults to `flutter.minSdkVersion`.

`targetSdkVersion`
: Specify the target API level on which the app is designed to run.
  Defaults to `flutter.targetSdkVersion`.
  
`versionCode`
: A positive integer used as an internal version number. This number
  is used only to determine whether one version is more recent than
  another, with higher numbers indicating more recent versions.
  This version isn't shown to users.

`versionName`
: A string used as the version number shown to users. This setting
  can be specified as a raw string or as a reference to a string resource.

`buildToolsVersion`
: If you're using Android plugin for Gradle 3.0.0 or higher, your project
  automatically uses the default version of the build tools that the
  plugin specifies. Alternatively, you can specify a version of the build tools.

#### Under android
  
`compileSdkVersion`
: Specify the API level Gradle should use to compile your app.
  Defaults to `flutter.compileSdkVersion`.

For more information, see the module-level build section in the [Gradle build file][gradlebuild].
  
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

{{site.alert.warning}}
  Recently, the Flutter team has received [several reports][crash-issue]
  from developers indicating they are experiencing app
  crashes on certain devices on Android 6.0. If you are targeting
  Android 6.0, use the following steps:

  * If you build an App Bundle
    Edit `android/gradle.properties` and add the flag:
    `android.bundle.enableUncompressedNativeLibs=false`.

  * If you build an APK
    Make sure `android/app/src/AndroidManifest.xml`
    doesn't set `android:extractNativeLibs=false`
    in the `<application>` tag.

  For more information, see the [public issue][crash-issue].
{{site.alert.end}}

### Build an app bundle

This section describes how to build a release app bundle.
If you completed the signing steps,
the app bundle will be signed.
At this point, you might consider [obfuscating your Dart code][]
to make it more difficult to reverse engineer. Obfuscating
your code involves adding a couple flags to your build command,
and maintaining additional files to de-obfuscate stack traces.

From the command line:

1. Enter `cd [project]`<br>
1. Run `flutter build appbundle`<br>
   (Running `flutter build` defaults to a release build.)

The release bundle for your app is created at
`[project]/build/app/outputs/bundle/release/app.aab`.

By default, the app bundle contains your Dart code and the Flutter
runtime compiled for [armeabi-v7a][] (ARM 32-bit), [arm64-v8a][]
(ARM 64-bit), and [x86-64][] (x86 64-bit).

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
At this point, you might consider [obfuscating your Dart code][]
to make it more difficult to reverse engineer. Obfuscating
your code involves adding a couple flags to your build command.

From the command line:

1. Enter `cd [project]`<br>
1. Run `flutter build apk --split-per-abi`<br>
   (The `flutter build` command defaults to `--release`.)

This command results in three APK files:

* `[project]/build/app/outputs/apk/release/app-armeabi-v7a-release.apk`
* `[project]/build/app/outputs/apk/release/app-arm64-v8a-release.apk`
* `[project]/build/app/outputs/apk/release/app-x86_64-release.apk`

Removing the `--split-per-abi` flag results in a fat APK that contains
your code compiled for _all_ the target ABIs. Such APKs are larger in
size than their split counterparts, causing the user to download
native binaries that are not applicable to their device's architecture.

### Install an APK on a device

Follow these steps to install the APK on a connected Android device.

From the command line:

1. Connect your Android device to your computer with a USB cable.
1. Enter `cd [project]`.
1. Run `flutter install`.

## Publishing to the Google Play Store

For detailed instructions on publishing your app to the Google Play Store,
see the [Google Play launch][play] documentation.

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

After updating the version number in the pubspec file,
run `flutter pub get` from the top of the project, or
use the **Pub get** button in your IDE. This updates
the `versionName` and `versionCode` in the `local.properties` file,
which are later updated in the `build.gradle` file when you
rebuild the Flutter app.

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
Flutter apps can be compiled for [armeabi-v7a][] (ARM 32-bit),
[arm64-v8a][] (ARM 64-bit), and [x86-64][] (x86 64-bit).
Flutter does not currently support building for x86 Android
(See [Issue 9253][]).

### How do I sign the app bundle created by `flutter build appbundle`?

See [Signing the app](#signing-the-app).

### How do I build a release from within Android Studio?

In Android Studio, open the existing `android/`
folder under your app’s folder. Then,
select **build.gradle (Module: app)** in the project panel:

<img src='/assets/images/docs/deployment/android/gradle-script-menu.png' width="100%" alt='screenshot of gradle build script menu'>

Next, select the build variant. Click **Build > Select Build Variant**
in the main menu. Select any of the variants in the **Build Variants**
panel (debug is the default):

<img src='/assets/images/docs/deployment/android/build-variant-menu.png' width="100%" alt='screenshot of build variant menu'>

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
[crash-issue]: https://issuetracker.google.com/issues/147096055
[fat APK]: https://en.wikipedia.org/wiki/Fat_binary
[Flutter wiki]: {{site.repo.flutter}}/wiki
[flutter_launcher_icons]: {{site.pub}}/packages/flutter_launcher_icons
[Getting Started guide for Android]: {{site.material}}/develop/android/docs/getting-started
[GitHub repository]: {{site.github}}/google/bundletool/releases/latest
[Google Maven]: https://maven.google.com/web/index.html#com.google.android.material:material
[gradlebuild]: {{site.android-dev}}/studio/build/#module-level
[Issue 9253]: {{site.github}}/flutter/flutter/issues/9253
[Issue 18494]: {{site.github}}/flutter/flutter/issues/18494
[launchericons]: {{site.material}}/design/iconography/
[manifest]: {{site.android-dev}}/guide/topics/manifest/manifest-intro
[manifesttag]: {{site.android-dev}}/guide/topics/manifest/manifest-element
[multidex-docs]: {{site.android-dev}}/studio/build/multidex
[multidex-keep]: {{site.android-dev}}/studio/build/multidex#multidexkeepfile-property
[obfuscating your Dart code]: {{site.url}}/deployment/obfuscate
[official Play Store documentation]: https://support.google.com/googleplay/android-developer/answer/7384423?hl=en
[permissiontag]: {{site.android-dev}}/guide/topics/manifest/uses-permission-element
[Platform Views]: {{site.url}}/development/platform-integration/platform-views
[play]: {{site.android-dev}}/distribute/googleplay/start
[plugin]: {{site.android-dev}}/studio/releases/gradle-plugin
[R8]: {{site.android-dev}}/studio/build/shrink-code
[Sign your app]: https://developer.android.com/studio/publish/app-signing.html#generate-key
[upload-bundle]: {{site.android-dev}}/studio/publish/upload-bundle
[Version your app]: {{site.android-dev}}/studio/publish/versioning
[versions]: {{site.android-dev}}/studio/publish/versioning
[versions-minsdk]: {{site.android-dev}}/studio/publish/versioning#minsdkversion
[x86-64]: {{site.android-dev}}/ndk/guides/abis#86-64
