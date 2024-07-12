---
title: Swift Package Manager for app developers
description: How to use Swift Package Manager for native iOS or macOS dependencies
---

:::warning
Flutter is migrating to [Swift Package Manager][] to manage iOS and macOS native
dependencies.
This is an experimental feature that might change in the future.
It is currently only available on the [`main` channel][].
Flutter will continue to support CocoaPods until further notice.
:::

Flutter's Swift Package Manager integration has several benefits:

1. **Access to the Swift package ecosystem**.
   Flutter plugins can use the growing ecosystem of [Swift packages][]! 
2. **Simplifies Flutter installation**.
   Swift Package Manager is bundled with Xcode.
   In the future, you won’t need to install Ruby and CocoaPods to target iOS or
   macOS.

If you find a bug in Flutter's Swift Package Manager support,
please [open an issue][].

[Swift Package Manager]: https://www.swift.org/documentation/package-manager/
[`main` channel]: /release/upgrade#switching-flutter-channels
[Swift packages]: https://swiftpackageindex.com/
[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml

{% include docs/swift-package-manager/how-to-enable-disable.md %}

## How to add Flutter to an existing app (add-to-app)

Flutter's Swift Package Manager support doesn't work with add-to-app scenarios
yet.

For status updates, see [flutter#146957].

[flutter#146957]: https://github.com/flutter/flutter/issues/146957

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
the project, you might get an error like this:

```plaintext
Target Integrity (Xcode): The package product 'plugin_name_ios' requires minimum platform version 14.0 for the iOS platform, but this target supports 12.0
```

To use the plugin, you'll need to increase the **Minimum Deployments** of your
app's target.

:::warning
This raises your app's minimum OS version requirement.
:::

{% render docs/captioned-image.liquid,
image:"development/packages-and-plugins/swift-package-manager/minimum-deployments.png",
caption:"The target's **Minimum Deployments** setting" %}

## How to add Swift Package Manager integration to a custom Xcode target

Your Flutter Xcode project can have custom [Xcode targets][] to build additional
products, like frameworks or unit tests.
You can add Swift Package Manager integration to these custom Xcode targets
as well.

Follow the steps in
[How to add Swift Package Manager integration to a project manually][manualIntegration].

In [Step 1][manualIntegrationStep1], list item 6 use your custom target instead
of the `Flutter` target.

In [Step 2][manualIntegrationStep2], list item 6 use your custom target instead
of the `Flutter` target.

[Xcode targets]: https://developer.apple.com/documentation/xcode/configuring-a-new-target-in-your-project
[manualIntegration]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-add-swift-package-manager-integration-to-a-project-manually
[manualIntegrationStep1]: /packages-and-plugins/swift-package-manager/for-app-developers/#step-1-add-fluttergeneratedpluginswiftpackage-package-dependency
[manualIntegrationStep2]: /packages-and-plugins/swift-package-manager/for-app-developers/#step-2-add-run-prepare-flutter-framework-script-pre-action

## How to remove Swift Package Manager integration

The Flutter CLI migrates your project to add Swift Package Manager integration.
This makes your project download the Swift packages that your Flutter plugins
depend on.

To undo this migration:

1. [Turn off Swift Package Manager][].

2. Open your app (`ios/Runner.xcworkspace` or `ios/Runner.xcworkspace`) in
   Xcode.

3. Navigate to **Package Dependencies** for the project.

4. Click on the `FlutterGeneratedPluginSwiftPackage` package and then click the
   **-** button.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/remove-generated-package.png",
   caption:"The `FlutterGeneratedPluginSwiftPackage` to remove" %}

4. Navigate to **Frameworks, Libraries, and Embedded Content** for the `Runner`
   target.

5. Click on `FlutterGeneratedPluginSwiftPackage` and then click the **-**
   button.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/remove-generated-framework.png",
   caption:"The `FlutterGeneratedPluginSwiftPackage` to remove" %}

6. Select **Product > Scheme > Edit Scheme**.

7. Click the **>** next to **Build** in the left side bar.

8. Select **Pre-actions**.

9. Select the **Run Prepare Flutter Framework Script**.

10. Click the **<span class="material-symbols">delete</span>** button.

    {% render docs/captioned-image.liquid,
    image:"development/packages-and-plugins/swift-package-manager/remove-flutter-pre-action.png",
    caption:"The build pre-action to remove" %}

[Turn off Swift Package Manager]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-off-swift-package-manager
