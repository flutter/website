---
title: Set up Flutter flavors for Android
short-title: Flavors (Android)
description: >
  How to create build flavors specific to different
  release types or development environments.
---

## Overview

A Flutter flavor is basically a collection of settings that
define how a specific version of your app should be built
and run. For example, a flavor could determine which icon,
app name, API key, feature flag, and logging level is
associated with a specific version of your app.

If you want to create Flutter flavors for an Android app,
you can do this in Flutter. In Android, the concept called
"flavor" is referred to as a build variant.

## Using flavors {: #using-flavors-in-android }

Setting up flavors in Android can be done in your project's
**build.gradle** file.

1. Inside your Flutter project,
   navigate to **android**/**app**/**build.gradle**.

2. Create a [`flavorDimension`][] to group your added product flavors.
   Gradle doesn't combine product flavors that share the same `dimension`.

3. Add a `productFlavors` object with the desired flavors along
   with values for **dimension**, **resValue**,
   and **applicationId** or **applicationIdSuffix**.

   * The name of the application for each build is located in **resValue**.
   * If you specify a **applicationIdSuffix** instead of a **applicationId**,
     it is appended to the "base" application id.

    ```groovy title="android/app/build.gradle"
    android {
        // ...
        flavorDimensions "default"

        productFlavors {
            staging {
                dimension "default"
                resValue "string", "app_name", "Flavor example (staging)"
                applicationIdSuffix ".staging"
            }
        }
    }
    ```

[`flavorDimension`]: {{site.android-dev}}/studio/build/build-variants#flavor-dimensions

## Setting up launch configurations

Next, add a **launch.json** file; this allows you to run the command
`flutter run --flavor <android build variant>`.

In VSCode, set up the launch configurations as follows:

1. In the root directory of your project, add a folder called **.vscode**.
2. Inside the **.vscode** folder, create a file named **launch.json**.
3. In the **launch.json** file, add a configuration object for each flavor.
   Each configuration has a **name**, **request**, **type**, **program**,
   and **args** key.

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_development.dart",
      "args": ["--flavor", "staging", "--target", "lib/main_staging.dart" ]
    }
  ],
  "compounds": []
}
```

You can now run the terminal command
`flutter run --flavor staging` or you can set up a run
configuration in your IDE.

{% comment %}
TODO: When available, add an app sample.
{% endcomment -%}

## Launching your app flavors

1. Once the flavors are set up, modify the Dart code in
**lib** / **main.dart** to consume the flavors.
2. Test the setup using `flutter run --flavor staging`
at the command line, or in your IDE.

For examples of build flavors for [iOS][], [macOS][], and [Android][],
check out the integration test samples in the [Flutter repo][].

## Retrieving your app's flavor at runtime

From your Dart code, you can use the [`appFlavor`][] API to determine what
flavor your app was built with.

## Conditionally bundling assets based on flavor

If you aren't familiar with how to add assets to your app, see
[Adding assets and images][].

If you have assets that are only used in a specific flavor in your app, you can
configure them to only be bundled into your app when building for that flavor.
This prevents your app bundle size from being bloated by unused assets.

Here is an example:

```yaml
flutter:
  assets:
    - assets/common/
    - path: assets/staging/
      flavors:
        - staging
    - path: assets/production/
      flavors:
        - production
```

In this example, files within the `assets/common/` directory will always be bundled
when app is built during `flutter run` or `flutter build`. Files within the
`assets/staging/` directory are bundled _only_ when the `--flavor` option is set
to `staging`. Similarly, files within the `assets/production` directory are
bundled _only_ if `--flavor` is set to `production`.

## More information

For more information on creating and using flavors, check out
the following resources:

* [Build flavors in Flutter (Android and iOS) with different Firebase projects per flavor Flutter Ready to Go][]
* [Flavoring Flutter Applications (Android & iOS)][]
* [How to Setup Flutter & Firebase with Multiple Flavors using the FlutterFire CLI][flutterfireCLI]

### Packages

For packages that support creating flavors, check out the following:

* [`flutter_flavor`][]
* [`flutter_flavorizr`][]

[Launching your app flavors]: /deployment/flavors/#launching-your-app-flavors
[Flutter repo]: {{site.repo.flutter}}/blob/main/dev/integration_tests/flavors/lib/main.dart
[iOS]: {{site.repo.flutter}}/tree/main/dev/integration_tests/flavors/ios
[macOS]: {{site.repo.flutter}}/tree/main/dev/integration_tests/flavors/macos
[iOS (Xcode)]: {{site.repo.flutter}}/tree/main/dev/integration_tests/flavors/ios
[`appFlavor`]: {{site.api}}/flutter/services/appFlavor-constant.html
[Android]: {{site.repo.flutter}}/tree/main/dev/integration_tests/flavors/android
[Adding assets and images]: /ui/assets/assets-and-images
[Build flavors in Flutter (Android and iOS) with different Firebase projects per flavor Flutter Ready to Go]: {{site.medium}}/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b
[Flavoring Flutter Applications (Android & iOS)]: {{site.medium}}/flutter-community/flavoring-flutter-applications-android-ios-ea39d3155346
[flutterfireCLI]: https://codewithandrea.com/articles/flutter-firebase-multiple-flavors-flutterfire-cli/
[`flutter_flavor`]: {{site.pub}}/packages/flutter_flavor
[`flutter_flavorizr`]: {{site.pub}}/packages/flutter_flavorizr
