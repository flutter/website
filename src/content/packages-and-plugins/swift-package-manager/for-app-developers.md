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

{% include docs/swift-package-manager/how-to-enable-disable.md %}

## How to add Swift Package Manager integration to a project manually

{% tabs %}
{% tab "iOS project" %}

{% include docs/swift-package-manager/migrate-ios-project-manually.md %}

{% endtab %}
{% tab "macOS project" %}

{% include docs/swift-package-manager/migrate-macos-project-manually.md %}

{% endtab %}
{% endtabs %}

## How to use a Swift Package Manager Flutter plugin that requires a higher OS version

If a Swift Package Flutter Manager plugin requires a higher OS version than
the project, you may get an error like this:

```txt
Target Integrity (Xcode): The package product 'plugin_name_ios' requires minimum platform version 14.0 for the iOS platform, but this target supports 12.0
```

To use the plugin, you'll need to increase the Minimum Deployment of your
app's target.

:::warning
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
2. Open your app (`ios/Runner.xcworkspace` or `ios/Runner.xcworkspace`) in Xcode
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
