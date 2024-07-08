---
title: Build and release an Android app
description: How to prepare for and release an Android app to the Play store.
short-title: Android
---

To test an app, you can use `flutter run` at the command line,
or the **Run** and **Debug** options in your IDE.

When you're ready to prepare a _release_ version of your app,
for example to [publish to the Google Play Store][play],
this page can help. Before publishing,
you might want to put some finishing touches on your app.
This guide explains how to perform the following tasks:

* [Add a launcher icon](#add-a-launcher-icon)
* [Enable Material Components](#enable-material-components)
* [Signing the app](#signing-the-app)
* [Shrink your code with R8](#shrink-your-code-with-r8)
* [Enable multidex support](#enable-multidex-support)
* [Review the app manifest](#review-the-app-manifest)
* [Review the build configuration](#review-the-gradle-build-configuration)
* [Build the app for release](#build-the-app-for-release)
* [Publish to the Google Play Store](#publish-to-the-google-play-store)
* [Update the app's version number](#update-the-apps-version-number)
* [Android release FAQ](#android-release-faq)

:::note
Throughout this page, `[project]` refers to 
the directory that your application is in. While following
these instructions, substitute `[project]` with 
your app's directory.
:::

## Add a launcher icon

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

## Enable Material Components

If your app uses [Platform Views][], you might want to enable
Material Components by following the steps described in the
[Getting Started guide for Android][].

For example:

1. Add the dependency on Android's Material in `<my-app>/android/app/build.gradle`:

```groovy
dependencies {
    // ...
    implementation("com.google.android.material:material:<version>")
    // ...
}
```

To find out the latest version, visit [Google Maven][].

1. Set the light theme in `<my-app>/android/app/src/main/res/values/styles.xml`:

```diff
-<style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
+<style name="NormalTheme" parent="Theme.MaterialComponents.Light.NoActionBar">
```

1. Set the dark theme in `<my-app>/android/app/src/main/res/values-night/styles.xml`

```diff
-<style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">
+<style name="NormalTheme" parent="Theme.MaterialComponents.DayNight.NoActionBar">
```

<a id="signing-the-app"></a>
## Sign the app

To publish on the Play Store, you need to
sign your app with a digital certificate.

Android uses two signing keys: _upload_ and _app signing_.

* Developers upload an `.aab` or `.apk` file signed with
  an _upload key_ to the Play Store.
* The end-users download the `.apk` file signed with an _app signing key_.

To create your app signing key, use Play App Signing
as described in the [official Play Store documentation][].

To sign your app, use the following instructions.

### Create an upload keystore

If you have an existing keystore, skip to the next step.
If not, create one using one of the following methods:

1. Follow the [Android Studio key generation steps]({{site.android-dev}}/studio/publish/app-signing#generate-key)
1. Run the following command at the command line:

   On macOS or Linux, use the following command:

   ```console
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
           -keysize 2048 -validity 10000 -alias upload
   ```

   On Windows, use the following command in PowerShell:

   ```powershell
   keytool -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks `
           -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
           -alias upload
   ```

   This command stores the `upload-keystore.jks` file in your home
   directory. If you want to store it elsewhere, change
   the argument you pass to the `-keystore` parameter.
   **However, keep the `keystore` file private;
   don't check it into public source control!**

   :::note
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
   :::

### Reference the keystore from the app

Create a file named `[project]/android/key.properties`
that contains a reference to your keystore.
Don't include the angle brackets (`< >`).
They indicate that the text serves as a placeholder for your values.

```properties
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```

The `storeFile` might be located at
`/Users/<user name>/upload-keystore.jks` on macOS
or `C:\\Users\\<user name>\\upload-keystore.jks` on Windows.

:::warning
Keep the `key.properties` file private;
don't check it into public source control.
:::

### Configure signing in gradle

When building your app in release mode, configure gradle to use your upload key.
To configure gradle, edit the `<project>/android/app/build.gradle` file.

1. Define and load the keystore properties file before the `android`
   property block.

1. Set the `keystoreProperties` object to load the `key.properties` file.

   ```diff title="[project]/android/app/build.gradle"
   +   def keystoreProperties = new Properties()
   +   def keystorePropertiesFile = rootProject.file('key.properties')
   +   if (keystorePropertiesFile.exists()) {
   +       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   +   }
   +
      android {
         ...
      }
   ```

1. Add the signing configuration before the `buildTypes` property block
   inside the `android` property block.

   ```diff title="[project]/android/app/build.gradle"
       android {
           ...

   +       signingConfigs {
   +           release {
   +               keyAlias keystoreProperties['keyAlias']
   +               keyPassword keystoreProperties['keyPassword']
   +               storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
   +               storePassword keystoreProperties['storePassword']
   +           }
   +       }
           buildTypes {
              release {
                 // TODO: Add your own signing config for the release build.
                 // Signing with the debug keys for now,
                 // so `flutter run --release` works.
   -                signingConfig signingConfigs.debug
   +                signingConfig signingConfigs.release
              }
           }
       ...
       }
   ```

Flutter now signs all release builds.

:::note
You might need to run `flutter clean` after changing the gradle file.
This prevents cached builds from affecting the signing process.
:::

To learn more about signing your app, check out
[Sign your app][] on developer.android.com.

## Shrink your code with R8

[R8][] is the new code shrinker from Google.
It's enabled by default when you build a release APK or AAB.
To disable R8, pass the `--no-shrink` flag to
`flutter build apk` or `flutter build appbundle`.

:::note
Obfuscation and minification can considerably extend compile time
of the Android application.
:::

## Enable multidex support

When writing large apps or making use of large plugins,
you might encounter Android's dex limit of 64k methods
when targeting a minimum API of 20 or below.
This might also be encountered when running debug versions of your app
using `flutter run` that does not have shrinking enabled.

Flutter tool supports easily enabling multidex. The simplest way is to
opt into multidex support when prompted. The tool detects multidex build errors
and asks before making changes to your Android project.
Opting in allows Flutter to automatically depend on
`androidx.multidex:multidex` and use a generated
`FlutterMultiDexApplication` as the project's application.

When you try to build and run your app with the **Run** and **Debug**
options in your IDE, your build might fail with the following message:

<img src='/assets/images/docs/deployment/android/ide-build-failure-multidex.png' width="100%" alt='Build failure because Multidex support is required'>

To enable multidex from the command line,
run `flutter run --debug` and select an Android device:

<img src='/assets/images/docs/deployment/android/cli-select-device.png' width="100%" alt='Selecting an Android device with the flutter CLI.'>

When prompted, enter `y`.
The Flutter tool enables multidex support and retries the build:

<img src='/assets/images/docs/deployment/android/cli-multidex-added-build.png' width="100%" alt='The output of a successful build after adding multidex.'>

:::note
Multidex support is natively included when targeting
Android SDK 21 or later. However, we don't recommend
targeting API 21+ purely to resolve the multidex issue
as this might inadvertently exclude users running older devices.
:::

You might also choose to manually support multidex by following Android's guides
and modifying your project's Android directory configuration.
A [multidex keep file][multidex-keep] must be specified to include:

```plaintext
io/flutter/embedding/engine/loader/FlutterLoader.class
io/flutter/util/PathUtils.class
```

Also, include any other classes used in app startup.
For more detailed guidance on adding multidex support manually,
check out the official [Android documentation][multidex-docs].

## Review the app manifest

Review the default [App Manifest][manifest] file.

```xml title="[project]/android/app/src/main/AndroidManifest.xml"
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        [!android:label="[project]"!]
        ...
    </application>
    ...
    [!<uses-permission android:name="android.permission.INTERNET"/>!]
</manifest>
```

Verify the following values:

| Tag                                | Attribute | Value                                                                                                   |
|------------------------------------|-----------|-----------------------------------------------------------------------------------------------------------|
| [`application`][applicationtag]    | Edit the `android:label` in the [`application`][applicationtag] tag to reflect the final name of the app. |
| [`uses-permission`][permissiontag] | Add the `android.permission.INTERNET` [permission][permissiontag] value to the `android:name` attribute if your app needs Internet access. The standard template doesn't include this tag but allows Internet access during development to enable communication between Flutter tools and a running app. |

{:.table .table-striped}

## Review or change the Gradle build configuration {:#review-the-gradle-build-configuration}

To verify the Android build configuration,
review the `android` block in the default
[Gradle build script][gradlebuild].
The default Gradle build script is found at `[project]/android/app/build.gradle`.
You can change the values of any of these properties.

```groovy title="[project]/android/app/build.gradle"
android {
    namespace = "com.example.[project]"
    // Any value starting with "flutter." gets its value from
    // the Flutter Gradle plugin.
    // To change from these defaults, make your changes in this file.
    [!compileSdk = flutter.compileSdkVersion!]
    ndkVersion = flutter.ndkVersion

    ...

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        [!applicationId = "com.example.[project]"!]
        // You can update the following values to match your application needs.
        [!minSdk = flutter.minSdkVersion!]
        [!targetSdk = flutter.targetSdkVersion!]
        // These two properties use values defined elsewhere in this file.
        // You can set these values in the property declaration
        // or use a variable.
        [!versionCode = flutterVersionCode.toInteger()!]
        [!versionName = flutterVersionName!]
    }

    buildTypes {
        ...
    }
}
```

### Properties to adjust in build.gradle

| Property             | Purpose                                                                                                                                                                                                                                                     | Default Value              |
|----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| `compileSdk`         | The Android API level against which your app is compiled. This should be the highest version available. If you set this property to `31`, you run your app on a device running API `30` or earlier as long as your app makes uses no APIs specific to `31`. | |
| `defaultConfig`      |  |  |
| `.applicationId`     | The final, unique [application ID][] that identifies your app.                                                                                                                                                                                              |                            |
| `.minSdk`            | The [minimum Android API level][] for which you designed your app to run.                                                                                                                                                                                   | `flutter.minSdkVersion`    |
| `.targetSdk`         | The Android API level against which you tested your app to run. Your app should run on all Android API levels up to this one.                                                                                                                               | `flutter.targetSdkVersion` |
| `.versionCode`       | A positive integer that sets an [internal version number][]. This number only determines which version is more recent than another. Greater numbers indicate more recent versions. App users never see this value.                                          |                            |
| `.versionName`       | A string that your app displays as its version number. Set this property as a raw string or as a reference to a string resource.                                                                                                                            |                            |
| `.buildToolsVersion` | The Gradle plugin specifies the default version of the Android build tools that your project uses. To specify a different version of the build tools, change this value.                                                                                    |                            |

{:.table .table-striped}

To learn more about Gradle, check out the module-level build
section in the [Gradle build file][gradlebuild].

:::note
If you use a recent version of the Android SDK, you might get deprecation warnings about `compileSdkVersion`, `minSdkVersion` or `targetSdkVersion`.
You can rename these properties to `compileSdk`, `minSdk` and `targetSdk` respectively.
:::
  
## Build the app for release

You have two possible release formats when publishing to
the Play Store.

* App bundle (preferred)
* APK

:::note
The Google Play Store prefers the app bundle format.
To learn more, check out [About Android App Bundles][bundle].
:::

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

An app bundle can be tested in multiple ways.
This section describes two.

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

If you completed the signing steps, the APK will be signed.
At this point, you might consider [obfuscating your Dart code][]
to make it more difficult to reverse engineer. Obfuscating
your code involves adding a couple flags to your build command.

From the command line:

1. Enter `cd [project]`.

1. Run `flutter build apk --split-per-abi`.
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

## Publish to the Google Play Store

For detailed instructions on publishing your app to the Google Play Store,
check out the [Google Play launch][play] documentation.

## Update the app's version number

The default version number of the app is `1.0.0`.
To update it, navigate to the `pubspec.yaml` file
and update the following line:

`version: 1.0.0+1`

The version number is three numbers separated by dots,
such as `1.0.0` in the example above, followed by an optional
build number such as `1` in the example above, separated by a `+`.

Both the version and the build number can be overridden in Flutter's
build by specifying `--build-name` and `--build-number`, respectively.

In Android, `build-name` is used as `versionName` while
`build-number` used as `versionCode`. For more information,
check out [Version your app][] in the Android documentation.

When you rebuild the app for Android, any updates in the version number
from the pubspec file will update the `versionName` and `versionCode` 
in the `local.properties` file.

## Android release FAQ

Here are some commonly asked questions about deployment for
Android apps.

### When should I build app bundles versus APKs?

The Google Play Store recommends that you deploy app bundles
over APKs because they allow a more efficient delivery of the
application to your users. However, if you're distributing
your application by means other than the Play Store,
an APK might be your only option.

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

### How do I sign the app bundle created by `flutter build appbundle`?

See [Signing the app](#signing-the-app).

### How do I build a release from within Android Studio?

In Android Studio, open the existing `android/`
folder under your app's folder. Then,
select **build.gradle (Module: app)** in the project panel:

<img src='/assets/images/docs/deployment/android/gradle-script-menu.png' width="100%" alt='The Gradle build script menu in Android Studio.'>

Next, select the build variant. Click **Build > Select Build Variant**
in the main menu. Select any of the variants in the **Build Variants**
panel (debug is the default):

<img src='/assets/images/docs/deployment/android/build-variant-menu.png' width="100%" alt='The build variant menu in Android Studio with Release selected.'>

The resulting app bundle or APK files are located in
`build/app/outputs` within your app's folder.

{% comment %}
### Are there any special considerations with add-to-app?
{% endcomment %}

[apk-deploy]: {{site.android-dev}}/studio/command-line/bundletool#deploy_with_bundletool
[apk-set]: {{site.android-dev}}/studio/command-line/bundletool#generate_apks
[application ID]: {{site.android-dev}}/studio/build/application-id
[applicationtag]: {{site.android-dev}}/guide/topics/manifest/application-element
[arm64-v8a]: {{site.android-dev}}/ndk/guides/abis#arm64-v8a
[armeabi-v7a]: {{site.android-dev}}/ndk/guides/abis#v7a
[bundle]: {{site.android-dev}}/guide/app-bundle
[configuration qualifiers]: {{site.android-dev}}/guide/topics/resources/providing-resources#AlternativeResources
[fat APK]: https://en.wikipedia.org/wiki/Fat_binary
[flutter_launcher_icons]: {{site.pub}}/packages/flutter_launcher_icons
[Getting Started guide for Android]: {{site.material}}/develop/android/mdc-android
[GitHub repository]: {{site.github}}/google/bundletool/releases/latest
[Google Maven]: https://maven.google.com/web/index.html#com.google.android.material:material
[gradlebuild]: {{site.android-dev}}/studio/build/#module-level
[internal version number]: {{site.android-dev}}/studio/publish/versioning
[launchericons]: {{site.material}}/styles/icons
[manifest]: {{site.android-dev}}/guide/topics/manifest/manifest-intro
[minimum Android API level]: {{site.android-dev}}/studio/publish/versioning#minsdk
[multidex-docs]: {{site.android-dev}}/studio/build/multidex
[multidex-keep]: {{site.android-dev}}/studio/build/multidex#keep
[obfuscating your Dart code]: /deployment/obfuscate
[official Play Store documentation]: https://support.google.com/googleplay/android-developer/answer/7384423?hl=en
[permissiontag]: {{site.android-dev}}/guide/topics/manifest/uses-permission-element
[Platform Views]: /platform-integration/android/platform-views
[play]: {{site.android-dev}}/distribute
[R8]: {{site.android-dev}}/studio/build/shrink-code
[Sign your app]: {{site.android-dev}}/studio/publish/app-signing.html#generate-key
[upload-bundle]: {{site.android-dev}}/studio/publish/upload-bundle
[Version your app]: {{site.android-dev}}/studio/publish/versioning
[x86-64]: {{site.android-dev}}/ndk/guides/abis#86-64
