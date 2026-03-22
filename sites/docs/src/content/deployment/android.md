---
title: Build and release an Android app
description: How to prepare for and release an Android app to the Play store.
shortTitle: Android
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
* [Sign the app](#sign-the-app)
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

[play]: {{site.android-dev}}/distribute

## Add a launcher icon

When a new Flutter app is created, it has a default launcher icon.
To customize this icon, you might want to check out the
[flutter_launcher_icons][] package.

Alternatively, you can do it manually using the following steps:

1. Review the
   [Material Design product icons][launchericons] guidelines for icon design.

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

[flutter_launcher_icons]: {{site.pub}}/packages/flutter_launcher_icons
[launchericons]: {{site.material}}/styles/icons
[configuration qualifiers]: {{site.android-dev}}/guide/topics/resources/providing-resources#AlternativeResources
[applicationtag]: {{site.android-dev}}/guide/topics/manifest/application-element

## Enable Material Components

If your app uses [platform views][], you might want to enable
Material Components by following the steps described in the
[Getting Started guide for Android][].

For example:

1. Add the dependency on Android's Material in `<my-app>/android/app/build.gradle.kts`:

<Tabs key="android-material-dependency">
<Tab name="Kotlin">

```kotlin
dependencies {
    // ...
    implementation("com.google.android.material:material:<version>")
    // ...
}
```

</Tab>
<Tab name="Groovy">

```groovy
dependencies {
    // ...
    implementation 'com.google.android.material:material:<version>'
    // ...
}
```

</Tab>
</Tabs>

   To find out the latest version, visit [Google Maven][maven-material].

1. Set the light theme in `<my-app>/android/app/src/main/res/values/styles.xml`:

   ```xml diff
   - <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
   + <style name="NormalTheme" parent="Theme.MaterialComponents.Light.NoActionBar">
   ```

1. Set the dark theme in `<my-app>/android/app/src/main/res/values-night/styles.xml`:

   ```xml diff
   - <style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">
   + <style name="NormalTheme" parent="Theme.MaterialComponents.DayNight.NoActionBar">
   ```

[platform views]: /platform-integration/android/platform-views
[Getting Started guide for Android]: {{site.material}}/develop/android/mdc-android
[maven-material]: https://maven.google.com/web/index.html#com.google.android.material:material

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

[official Play Store documentation]: https://support.google.com/googleplay/android-developer/answer/7384423?hl=en

### Create an upload keystore

If you have an existing keystore, skip to the next step.
If not, create one using one of the following methods:

1. Follow the [Android Studio key generation steps][].
1. Run the following command at the command line:

   On macOS or Linux, use the following command:

   ```console
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
           -keysize 2048 -validity 10000 -alias upload
   ```

   On Windows, use the following command in PowerShell:

   ```ps
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
     part of Java, which is installed as part of Android Studio.
     For the concrete path, run `flutter doctor -v` and
     locate the path printed after 'Java binary at:'.
     Then use that fully qualified path
     replacing `java` (at the end) with `keytool`.
     If your path includes space-separated names, such as `Program Files`,
     use platform-appropriate notation for the names.
     For example, on macOS and Linux use `Program\ Files`, and
     on Windows use `"Program Files"`.

   * The `-storetype JKS` tag is only required for Java 9
     or newer. As of the Java 9 release,
     the keystore type defaults to PKS12.
   :::

[Android Studio key generation steps]: {{site.android-dev}}/studio/publish/app-signing#generate-key

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

:::note
The Windows path to `keystore.jks` must be specified with double backslashes: `\\`.
:::

:::warning
Keep the `key.properties` file private;
don't check it into public source control.
:::

### Configure signing in Gradle

When building your app in release mode, configure Gradle to use your upload key.
To configure Gradle, edit the `<project>/android/app/build.gradle.kts` file.

1. Define and load the keystore properties file before the `android`
   property block.

1. Set the `keystoreProperties` object to load the `key.properties` file.

<Tabs key="android-keystore-properties">
<Tab name="Kotlin">

```kotlin diff title="[project]/android/app/build.gradle.kts"
+ import java.util.Properties
+ import java.io.FileInputStream
+
  plugins {
     ...
  }
+
+ val keystoreProperties = Properties()
+ val keystorePropertiesFile = rootProject.file("key.properties")
+ if (keystorePropertiesFile.exists()) {
+     keystoreProperties.load(FileInputStream(keystorePropertiesFile))
+ }
+
  android {
     ...
  }
```

</Tab>
<Tab name="Groovy">

```groovy diff title="[project]/android/app/build.gradle"
+ import java.util.Properties
+ import java.io.FileInputStream
+
  plugins {
     ...
  }
+
+ def keystoreProperties = new Properties()
+ def keystorePropertiesFile = rootProject.file('key.properties')
+ if (keystorePropertiesFile.exists()) {
+     keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
+ }
+
  android {
     ...
  }
```

</Tab>
</Tabs>

1. Add the signing configuration before the `buildTypes` property block
   inside the `android` property block.

<Tabs key="android-signing-config">
<Tab name="Kotlin">

```kotlin diff title="[project]/android/app/build.gradle.kts"
  android {
      // ...

+     signingConfigs {
+         create("release") {
+             keyAlias = keystoreProperties["keyAlias"] as String
+             keyPassword = keystoreProperties["keyPassword"] as String
+             storeFile = keystoreProperties["storeFile"]?.let { file(it) }
+             storePassword = keystoreProperties["storePassword"] as String
+         }
+     }
      buildTypes {
          release {
              // TODO: Add your own signing config for the release build.
              // Signing with the debug keys for now,
              // so `flutter run --release` works.
-             signingConfig = signingConfigs.getByName("debug")
+             signingConfig = signingConfigs.getByName("release")
          }
      }
  ...
  }
```

</Tab>
<Tab name="Groovy">

```groovy diff title="[project]/android/app/build.gradle"
  android {
      // ...

+     signingConfigs {
+         release {
+             keyAlias = keystoreProperties['keyAlias']
+             keyPassword = keystoreProperties['keyPassword']
+             storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
+             storePassword = keystoreProperties['storePassword']
+         }
+     }
      buildTypes {
          release {
              // TODO: Add your own signing config for the release build.
              // Signing with the debug keys for now,
              // so `flutter run --release` works.
-             signingConfig = signingConfigs.debug
+             signingConfig = signingConfigs.release
          }
      }
  ...
  }
```

</Tab>
</Tabs>

Flutter now signs all release builds.

:::note
You might need to run `flutter clean` after changing the Gradle file.
This prevents cached builds from affecting the signing process.
:::

To learn more about signing your app, check out
[Sign your app][] on the Android developer docs.

[Sign your app]: {{site.android-dev}}/studio/publish/app-signing.html#generate-key

## Shrink your code with R8

[R8][] is the new code shrinker from Google.
It's enabled by default when you build a release APK or AAB.
To disable R8, pass the `--no-shrink` flag to
`flutter build apk` or `flutter build appbundle`.

:::note
Obfuscation and minification can considerably extend
the compile time of an Android application.

The `--[no-]shrink` flag has no effect.
Code shrinking is always enabled in release builds.
To learn more, check out [Shrink, obfuscate, and optimize your app][].
:::

[R8]: {{site.android-dev}}/studio/build/shrink-code
[Shrink, obfuscate, and optimize your app]: {{site.android-dev}}/studio/build/shrink-code

## Enable multidex support

When writing large apps or making use of large plugins,
you might encounter Android's dex limit of 64k methods
when targeting a minimum API of 20 or below.
This might also be encountered when running debug versions of your app
using `flutter run` that doesn't have shrinking enabled.

Flutter tool supports easily enabling multidex.
The simplest way is to opt into multidex support when prompted.
The tool detects multidex build errors and
asks before making changes to your Android project.
Opting in allows Flutter to automatically depend on
`androidx.multidex:multidex` and use a generated
`FlutterMultiDexApplication` as the project's application.

When you try to build and run your app with the **Run** and **Debug**
options in your IDE, your build might fail with the following message:

<img src='/assets/images/docs/deployment/android/ide-build-failure-multidex.png' width="100%" alt='Build failure because Multidex support is required'>

To enable multidex from the command line,
run `flutter run --debug` and select an Android-powered device:

<img src='/assets/images/docs/deployment/android/cli-select-device.png' width="100%" alt='Selecting an Android device with the flutter CLI.'>

When prompted, enter `y`.
The Flutter tool enables multidex support and retries the build:

<img src='/assets/images/docs/deployment/android/cli-multidex-added-build.png' width="100%" alt='The output of a successful build after adding multidex.'>

:::note
Multidex support is natively included when targeting
Android SDK 21 or later.
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

[multidex-keep]: {{site.android-dev}}/studio/build/multidex#keep
[multidex-docs]: {{site.android-dev}}/studio/build/multidex

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

[manifest]: {{site.android-dev}}/guide/topics/manifest/manifest-intro
[applicationtag]: {{site.android-dev}}/guide/topics/manifest/application-element
[permissiontag]: {{site.android-dev}}/guide/topics/manifest/uses-permission-element

## Review the Gradle build configuration {:#review-the-gradle-build-configuration}

To verify the Android build configuration,
review the `android` block in the default
[Gradle build script][gradlebuild].
The default Gradle build script is found at `[project]/android/app/build.gradle.kts`.

```kotlin title="[project]/android/app/build.gradle.kts"
android {
    namespace = "com.example.[project]"
    // Any value starting with "flutter." gets its value from
    // the Flutter Gradle plugin.
    // To change from these defaults, make your changes in this file.
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    ...

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.[project]"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }

    buildTypes {
        ...
    }
}
```

[gradlebuild]: {{site.android-dev}}/studio/build/#module-level

### Application ID

The `applicationId` is the unique identifier for your app on the Google Play Store
and on developers' devices.

:::important
Review the `applicationId` in `defaultConfig` and ensure it is unique.
Typically, this is a reverse domain name, such as `com.example.myapp`.
Once you upload your app to the Play Store, you cannot change the Application ID.
:::

[application-id]: {{site.android-dev}}/studio/build/application-id

### Android SDK versions

The Flutter tooling sets default values for the Android SDK versions:

*   **`compileSdk`**: The version of the Android SDK used to compile the app.
*   **`minSdk`**: The minimum Android version that the app supports.
*   **`targetSdk`**: The Android version the app is designed and tested to run on.

These default values (`flutter.compileSdkVersion`, etc.) are managed by Flutter
to ensure compatibility with the framework and plugins.
You typically **do not** need to change these unless:

1.  **You need a newer API**: If you are using a plugin or feature that requires a higher
    `minSdk` than Flutter's default, you can manually set it to a higher version number
    (for example, `minSdk = 24`).
2.  **You need to lock versions**: If you want to prevent automatic updates to these versions
    when upgrading Flutter, you can replace the default variables with specific integer values.

### Version code and name

The `versionCode` and `versionName` are automatically set from your `pubspec.yaml` file
(using the `version: 1.0.0+1` field). You generally don't need to modify these in the Gradle file.

[Version your app]: {{site.android-dev}}/studio/publish/versioning

## Build the app for release

You have two possible release formats when
publishing to the Play Store.

* App bundle (preferred)
* APK

:::note
The Google Play Store prefers the app bundle format.
To learn more, check out [About Android App Bundles][bundle].
:::

[bundle]: {{site.android-dev}}/guide/app-bundle

### Build an app bundle

This section describes how to build a release app bundle.
If you completed the signing steps,
the app bundle will be signed.
At this point, you might consider [obfuscating your Dart code][]
to make it more difficult to reverse engineer.
Obfuscating your code involves adding flags to your build command and
maintaining additional files to de-obfuscate stack traces.

From the command line:

1. Enter `cd [project]`<br>
1. Run `flutter build appbundle`<br>
   (Running `flutter build` defaults to a release build.)

The release bundle for your app is created at
`[project]/build/app/outputs/bundle/release/app.aab`.

By default, the app bundle contains your Dart code and the Flutter
runtime compiled for [armeabi-v7a][] (ARM 32-bit), [arm64-v8a][]
(ARM 64-bit), and [x86-64][] (x86 64-bit).

[obfuscating your Dart code]: /deployment/obfuscate
[arm64-v8a]: {{site.android-dev}}/ndk/guides/abis#arm64-v8a
[armeabi-v7a]: {{site.android-dev}}/ndk/guides/abis#v7a
[x86-64]: {{site.android-dev}}/ndk/guides/abis#86-64

### Test the app bundle

An app bundle can be tested in multiple ways.
This section describes two.

#### Offline using the bundle tool

1. If you haven't done so already, download `bundletool` from
   its [GitHub repository][bundletool-github].
1. [Generate a set of APKs][apk-set] from your app bundle.
1. [Deploy the APKs][apk-deploy] to connected devices.

[bundletool-github]: {{site.github}}/google/bundletool/releases/latest
[apk-set]: {{site.android-dev}}/studio/command-line/bundletool#generate_apks
[apk-deploy]: {{site.android-dev}}/studio/command-line/bundletool#deploy_with_bundletool

#### Online using Google Play

1. Upload your bundle to Google Play to test it.
   You can use the internal test track,
   or the alpha or beta channels to test the bundle before
   releasing it in production.
2. Follow the steps to [upload your bundle][upload-bundle]
   to the Play Store.

[upload-bundle]: {{site.android-dev}}/studio/publish/upload-bundle

### Build an APK

Although app bundles are preferred over APKs,
there are stores that don't yet support app bundles.
In this case, build a release APK for
each target ABI (Application Binary Interface).

If you completed the signing steps, the APK will be signed.
At this point, you might consider [obfuscating your Dart code][]
to make it more difficult to reverse engineer.
Obfuscating your code involves adding flags to your build command.

From the command line:

1. Enter `cd [project]`.

1. Run `flutter build apk --split-per-abi`.
   (The `flutter build` command defaults to `--release`.)

This command results in three APK files:

* `[project]/build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk`
* `[project]/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`
* `[project]/build/app/outputs/flutter-apk/app-x86_64-release.apk`

Removing the `--split-per-abi` flag results in a fat APK that contains
your code compiled for _all_ the target ABIs.
Such APKs are larger in size than their split counterparts,
causing the user to download native binaries that
aren't applicable to their device's architecture.

[obfuscating your Dart code]: /deployment/obfuscate

### Install an APK on a device

Follow these steps to install the APK on a connected Android-powered device.

From the command line:

1. Connect your Android-powered device to your computer with a USB cable.
1. Enter `cd [project]`.
1. Run `flutter install`.

## Publish to the Google Play Store

For detailed instructions on publishing your app to the Google Play Store,
check out the [Google Play launch][play] documentation.

## Update the app's version number

The default version number of the app is `1.0.0`.
To update it, navigate to the `pubspec.yaml` file
and update the following line:

```yaml
version: 1.0.0+1
```

The version number is three numbers separated by dots,
such as `1.0.0` in the preceding example,
followed by an optional build number,
such as `1` in the preceding example, separated by a `+`.

Both the version and the build number can be overridden in
Flutter's build by specifying `--build-name` and `--build-number`, respectively.

In Android, `build-name` is used as `versionName` while
`build-number` used as `versionCode`. For more information,
check out [Version your app][] in the Android documentation.

When you rebuild the app for Android, any updates in
the version number from the pubspec file will
update the `versionName` and `versionCode`in the `local.properties` file.

[Version your app]: {{site.android-dev}}/studio/publish/versioning

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

[fat APK]: https://en.wikipedia.org/wiki/Fat_binary

### What are the supported target architectures?

When building your application in release mode,
Flutter apps can be compiled for [armeabi-v7a][] (ARM 32-bit),
[arm64-v8a][] (ARM 64-bit), and [x86-64][] (x86 64-bit).

### How do I sign the app bundle created by `flutter build appbundle`?

Check out [Sign the app](#sign-the-app).

### How do I build a release from within Android Studio?

In Android Studio, open the existing `android/`
folder under your app's folder. Then,
select **build.gradle (Module: app)** in the project panel:

<img src='/assets/images/docs/deployment/android/gradle-script-menu.png' alt='The Gradle build script menu in Android Studio.' style="max-height: 20rem">

Next, select the build variant. Click **Build > Select Build Variant**
in the main menu. Select any of the variants in the **Build Variants**
panel (debug is the default):

<img src='/assets/images/docs/deployment/android/build-variant-menu.png' alt='The build variant menu in Android Studio with Release selected.' style="max-height: 20rem">

The resulting app bundle or APK files are located in
`build/app/outputs` within your app's folder.

### How to tell if an apk uses Flutter?

Recommended: Using APK files
[apkanalyzer](https://developer.android.com/tools/apkanalyzer) files list --files-only <SOME-APK>
Then looking for a file in `/lib/<ARCH>/libflutter.so`

Example:
`apkanalyzer files list some-flutter-app.apk | grep flutter.so | wc -l`
returns any number greater than 0.

**Why this works**
Flutter depends on C++ code used by the Flutter engine. In Android,
this code is bundled with the Flutter framework and the developer's
Dart code as a native library called `libflutter.so`.
The Java/Android tooling renames the `flutter` library with the `lib` prefix
and handles library location across architectures.
This is how some reverse engineer an APK to identify it as a Flutter app.

#### Secondary Evaluation:
Run `apkanalyzer manifest print <SOME-APK>` and look for a `<meta-data>` tag with `android:name="flutterEmbedding"`.
The value can be `1` or `2`.

Example:
`apkanalyzer manifest print some-flutter-app.apk | grep flutterEmbedding -C 2`
returns the following style string.
```
<meta-data
   android:name="flutterEmbedding"
   android:value="2" />
```


**Why this works**
Flutter has had two different embedders, and this flag was read to determine which embedder was used.
Flutter 3.22 removed the ability of v1 embedder apps to build.
https://blog.flutter.dev/whats-new-in-flutter-3-22-fbde6c164fe3
This mechanism is not recommended because it is unclear how long the `flutterEmbedding` value will
continue to be included in all Flutter apps. Additionally, this will not work for all libraries written
in Flutter that are imported into Android apps as AAR dependencies.

#### Non-technical evaluation
*   Download [Flutter Shark](https://play.google.com/store/apps/details?id=com.fluttershark.fluttersharkapp&pli=1) on a device and let it scan local apps.
*   Visit the [Flutter Hunt](https://flutterhunt.com/) website.

{% comment %}
### Are there any special considerations with add-to-app?
{% endcomment %}
