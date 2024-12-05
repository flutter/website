---
title: Swift Package Manager for app developers
description: How to use Swift Package Manager for native iOS or macOS dependencies
---

:::warning
Flutter is migrating to [Swift Package Manager][] to manage iOS and macOS native
dependencies.
Flutter's support of Swift Package Manager is under development.
The implementation might change in the future.
Swift Package Manager support is only available on the [`main` channel][].
Flutter continues to support CocoaPods.
:::

Flutter's Swift Package Manager integration has several benefits:

1. **Provides access to the Swift package ecosystem**.
   Flutter plugins can use the growing ecosystem of [Swift packages][]. 
1. **Simplifies Flutter installation**.
   Xcode includes Swift Package Manager.
   You don't need to install Ruby and CocoaPods if your project uses
   Swift Package Manager.

If you find a bug in Flutter's Swift Package Manager support,
[open an issue][].

[Swift Package Manager]: https://www.swift.org/documentation/package-manager/
[`main` channel]: /release/upgrade#switching-flutter-channels
[Swift packages]: https://swiftpackageindex.com/
[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml

{% include docs/swift-package-manager/how-to-enable-disable.md %}

## How to add Swift Package Manager integration

### Add to a Flutter app

{% tabs %}
{% tab "iOS project" %}

{% include docs/swift-package-manager/migrate-ios-project.md %}

{% endtab %}
{% tab "macOS project" %}

{% include docs/swift-package-manager/migrate-macos-project.md %}

{% endtab %}
{% endtabs %}

### Add to a Flutter app _manually_

{% tabs %}
{% tab "iOS project" %}

{% include docs/swift-package-manager/migrate-ios-project-manually.md %}

{% endtab %}
{% tab "macOS project" %}

{% include docs/swift-package-manager/migrate-macos-project-manually.md %}

{% endtab %}
{% endtabs %}

### Add to an existing app (add-to-app)

Flutter's Swift Package Manager support doesn't work with add-to-app scenarios.

To keep current on status updates, consult [flutter#146957][].

[flutter#146957]: https://github.com/flutter/flutter/issues/146957

### Add to a custom Xcode target

Your Flutter Xcode project can have custom [Xcode targets][] to build additional
products, like frameworks or unit tests.
You can add Swift Package Manager integration to these custom Xcode targets.

Follow the steps in
[How to add Swift Package Manager integration to a project _manually_][manualIntegration].

In [Step 1][manualIntegrationStep1], list item 6 use your custom target instead
of the `Flutter` target.

In [Step 2][manualIntegrationStep2], list item 6 use your custom target instead
of the `Flutter` target.

[Xcode targets]: https://developer.apple.com/documentation/xcode/configuring-a-new-target-in-your-project
[manualIntegration]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-add-swift-package-manager-integration-to-a-flutter-app-manually
[manualIntegrationStep1]: /packages-and-plugins/swift-package-manager/for-app-developers/#step-1-add-fluttergeneratedpluginswiftpackage-package-dependency
[manualIntegrationStep2]: /packages-and-plugins/swift-package-manager/for-app-developers/#step-2-add-run-prepare-flutter-framework-script-pre-action

## How to remove Swift Package Manager integration

To add Swift Package Manager integration, the Flutter CLI migrates your project.
This migration updates your Xcode project to add Flutter plugin dependencies.

To undo this migration:

1. [Turn off Swift Package Manager][].

1. Clean your project:

   ```sh
   flutter clean
   ```

1. Open your app (`ios/Runner.xcworkspace` or `macos/Runner.xcworkspace`) in
   Xcode.

1. Navigate to **Package Dependencies** for the project.

1. Click the `FlutterGeneratedPluginSwiftPackage` package, then click
   <span class="material-symbols">remove</span>.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/remove-generated-package.png",
   caption:"The `FlutterGeneratedPluginSwiftPackage` to remove" %}

1. Navigate to **Frameworks, Libraries, and Embedded Content** for the `Runner`
   target.

1. Click `FlutterGeneratedPluginSwiftPackage`, then click the
   <span class="material-symbols">remove</span>.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/remove-generated-framework.png",
   caption:"The `FlutterGeneratedPluginSwiftPackage` to remove" %}

1. Go to **Product > Scheme > Edit Scheme**.

1. Expand the **Build** section in the left side bar.

1. Click **Pre-actions**.

1. Expand **Run Prepare Flutter Framework Script**.

1. Click **<span class="material-symbols">delete</span>**.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/remove-flutter-pre-action.png",
   caption:"The build pre-action to remove" %}

[Turn off Swift Package Manager]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-off-swift-package-manager

## How to use a Swift Package Manager Flutter plugin that requires a higher OS version

If a Swift Package Flutter Manager plugin requires a higher OS version than
the project, you might get an error like this:

```plaintext
Target Integrity (Xcode): The package product 'plugin_name_ios' requires minimum platform version 14.0 for the iOS platform, but this target supports 12.0
```

To use the plugin, increase the **Minimum Deployments** of your app's target.

{% render docs/captioned-image.liquid,
image:"development/packages-and-plugins/swift-package-manager/minimum-deployments.png",
caption:"The target's **Minimum Deployments** setting" %}
