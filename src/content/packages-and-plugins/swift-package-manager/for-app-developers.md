---
title: Swift Package Manager for app developers
description: How to use Swift Package Manager for native iOS or macOS dependencies
---

Flutter is migrating to Swift Package Manager to manage iOS and macOS native dependencies.
This is an experimental feature that may change in the future.
It is currently only available on the [`master` channel](https://docs.flutter.dev/release/upgrade#switching-flutter-channels).
Flutter will continue to support CocoaPods until further notice.

:::tip
If you find a bug in Flutter's Swift Package Manager feature,
please [open an issue](https://github.com/flutter/flutter/issues/new?template=2_bug.yml).
:::

Issue tracking Flutter's Swift Package Manager migration: https://github.com/flutter/flutter/issues/126005.

{% include docs/swift-package-manager/how-to-enable-disable.md %}

## How to add Swift Package Manager integration to an iOS project manually

Once you enable the Swift Package Manager feature, the Flutter CLI will try
to migrate your project to add Swift Package Manager integration. This makes
your project download the Swift packages that your Flutter plugins depend on.

However, the Flutter CLI may be unable to migrate your project if you've
modified it significantly since it was created.

Please [file a bug](https://github.com/flutter/flutter/issues/new?template=1_activation.yml) before migrating manually to help the Flutter team improve the automatic migration.
Please include the error message you received and consider including a copy of
the of the following files in your bug report:

* `ios/Runner.xcodeproj/project.pbxproj`
* `ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` (or the xcsheme for the flavor used)

### Step 1: Add FlutterGeneratedPluginSwiftPackage Package Dependency

1. Open your app (`ios/Runner.xcworkspace`) in Xcode
2. Navigate to Package Dependencies for the project

![Screenshot 2024-04-05 at 10 13 56 AM](https://github.com/flutter/flutter/assets/15619084/0d862f5f-8bff-41df-9cf4-3f56b1957230)

3. Click the `+` button
4. Click the `Add Local...` button on the bottom of the dialog that opens
5. Navigate to `ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage` and click the `Add Package` button
6. Ensure it is added to the `Runner` target and click the `Add Package` button

![Screenshot 2024-04-05 at 10 17 21 AM](https://github.com/flutter/flutter/assets/15619084/b5bf410d-c0d4-47b0-b84c-2738002e97d4)

7. Ensure `FlutterGeneratedPluginSwiftPackage` was added to Frameworks, Libraries, and Embedded Content

![Screenshot 2024-04-05 at 10 20 12 AM](https://github.com/flutter/flutter/assets/15619084/7511e021-337c-4d14-bf14-e5804130cb0a)

### Step 2: Add Run Prepare Flutter Framework Script Pre-Action

**The following must be completed for each flavor.**

1. Next, select Product > Scheme > Edit Scheme
2. Click the `>` next to "Build" in the left side bar
3. Select Pre-actions
4. Click the `+` button and select `New Run Script Action` from the menu
5. Click the "Run Script" title and change to `Run Prepare Flutter Framework Script`.
6. Change the "Provide build settings from" to the app.
7. Input the following in the text box:
```sh
/bin/sh "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" prepare
```

![Screenshot 2024-04-05 at 10 24 44 AM](https://github.com/flutter/flutter/assets/15619084/f363db20-634d-46c1-9dd3-9f4a3ec9b992)

### Step 3: Run app

1. Run the app in Xcode and ensure `FlutterGeneratedPluginSwiftPackage` is a target dependency and `Run Prepare Flutter Framework Script` is being run as a pre-action.

![Screenshot 2024-04-05 at 12 31 43 PM](https://github.com/flutter/flutter/assets/15619084/ff5070c9-b42f-4930-8b15-70e8024fd3c1)

2. Also, ensure the app runs on the command line with `flutter run`.

## How to add Swift Package Manager integration to a macOS project manually

Once you enable the Swift Package Manager feature, the Flutter CLI will try
to migrate your project to add Swift Package Manager integration. This makes
your project download the Swift packages that your Flutter plugins depend on.

However, the Flutter CLI may be unable to migrate your project if you've
modified it significantly since it was created.

Please [file a bug](https://github.com/flutter/flutter/issues/new?template=1_activation.yml) before migrating manually to help the Flutter team improve the automatic migration.
Please include the error message you received and consider including a copy of
the of the following files in your bug report:

* `macos/Runner.xcodeproj/project.pbxproj`
* `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` (or the xcscheme for the flavor used)

### Step 1: Add FlutterGeneratedPluginSwiftPackage Package Dependency

1. Open your app (`/macos/Runner.xcworkspace`) in Xcode
2. Navigate to Package Dependencies for the project

![Screenshot 2024-04-05 at 10 13 56 AM](https://github.com/flutter/flutter/assets/15619084/0d862f5f-8bff-41df-9cf4-3f56b1957230)

3. Click the `+` button
4. Click the `Add Local...` button on the bottom of the dialog that opens
5. Navigate to `/macos/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage` and click the `Add Package` button
6. Ensure it is added to the Runner Target and click the `Add Package` button

![Screenshot 2024-04-05 at 10 17 21 AM](https://github.com/flutter/flutter/assets/15619084/b5bf410d-c0d4-47b0-b84c-2738002e97d4)

7. Ensure `FlutterGeneratedPluginSwiftPackage` was added to Frameworks, Libraries, and Embedded Content

![Screenshot 2024-04-05 at 10 20 12 AM](https://github.com/flutter/flutter/assets/15619084/7511e021-337c-4d14-bf14-e5804130cb0a)

### Step 2: Add Run Prepare Flutter Framework Script Pre-Action

**The following must be completed for each flavor.**

1. Next, select Product > Scheme > Edit Scheme
2. Click the `>` next to "Build" in the left side bar
3. Select Pre-actions
4. Click the `+` button and select `New Run Script Action` from the menu
5. Click the "Run Script" title and change to `Run Prepare Flutter Framework Script`.
6. Change the "Provide build settings from" to the Runner target.
7. Input the following in the text box:

   ```sh
   "$FLUTTER_ROOT"/packages/flutter_tools/bin/macos_assemble.sh prepare
   ```

![Screenshot 2024-04-05 at 2 22 56 PM](https://github.com/flutter/flutter/assets/15619084/c9c2e159-12ff-4230-829a-c5c72a7e31dc)

### Step 3: Run app

1. Run the app in Xcode and ensure `FlutterGeneratedPluginSwiftPackage` is a target dependency and `Run Prepare Flutter Framework Script` is being run as a pre-action.

![Screenshot 2024-04-05 at 12 31 43 PM](https://github.com/flutter/flutter/assets/15619084/ff5070c9-b42f-4930-8b15-70e8024fd3c1)

2. Also, ensure the app runs on the command line with `flutter run`.

## How to use a Swift Package Manager Flutter plugin that requires a higher OS version

If a Swift Package Flutter Manager plugin requires a higher OS version than
the project, you may get an error like this:

```txt
Target Integrity (Xcode): The package product 'plugin_name_ios' requires minimum platform version 14.0 for the iOS platform, but this target supports 12.0
```

To use the plugin, you'll need to increase the Minimum Deployment of your
app's target.

:::note
This raises your app's minimum OS version requirement.
:::

![Screenshot 2024-04-05 at 3 04 09 PM](https://github.com/flutter/flutter/assets/15619084/c7cfe40c-8d90-4be5-9bee-b92af090f663)

## How to add Swift Package Manager integration to a custom target

Follow the steps in `How to add Swift Package Manager integration to an iOS/macOS project manually`.

In Step 1, list item 6 use your custom target instead of the Flutter target.

In Step 2, list item 6 use your custom target instead of the Flutter target.

## How to remove Swift Package Manager integration

The Flutter CLI migrates your project to add Swift Package Manager integration.
This makes your project download the Swift packages that your Flutter plugins
depend on.

To undo this migration:

1. Disable Swift Package Manager (see "Disable Swift Package Manager" instructions above).
2. Open your app (`/ios/Runner.xcworkspace`) in Xcode
3. Navigate to Package Dependencies for the project
4. Click on the `FlutterGeneratedPluginSwiftPackage` package and then click the `-` button

![Screenshot 2024-04-05 at 2 24 48 PM](https://github.com/flutter/flutter/assets/15619084/2ad421e3-473e-4db4-92a1-175b5984c822)

4. Navigate to Frameworks, Libraries, and Embedded Content for the Runner target
5. Click on `FlutterGeneratedPluginSwiftPackage` and then click the `-` button

![Screenshot 2024-04-05 at 2 25 25 PM](https://github.com/flutter/flutter/assets/15619084/caa5194a-80c2-4243-b251-13bd8fd3bfee)

6. Next, select Product > Scheme > Edit Scheme
7. Click the `>` next to "Build" in the left side bar
8. Select Pre-actions
9. Select the `Run Prepare Flutter Framework Script`
10. Click the 🗑️ button

![Screenshot](https://github.com/flutter/flutter/assets/737941/0f760191-bfb5-400b-a120-7c99f4751b0f)

## Add Flutter to an existing app (add-to-app)

Flutter's Swift Package Manager feature does not support add-to-app scenarios yet.

See: https://github.com/flutter/flutter/issues/146957
