---
title: Swift Package Manager for app developers
description: How to use Swift Package Manager for native iOS or macOS dependencies
---

:::note
As of the 3.44 release, Flutter uses [Swift Package Manager][]
to manage iOS and macOS native dependencies.
Flutter continues to support CocoaPods in maintenance mode,
however, the CocoaPods registry permanently becomes
[read-only on December 2, 2026][cocoapods].
:::

[cocoapods]: https://blog.cocoapods.org/CocoaPods-Specs-Repo/
[Swift Package Manager]: https://www.swift.org/documentation/package-manager/

## How to turn on Swift Package Manager

As of the 3.44 release, Flutter's Swift Package Manager (SPM)
support is on by default.
Upgrading Flutter and running your app automatically adds SPM integration.
This makes your project download the Swift packages that
your Flutter plugins depend on.
To use an older Flutter version,
you must [remove Swift Package Manager integration][removeSPM]
from the app.

Note that Flutter falls back to CocoaPods for dependencies that don't
yet support Swift Package Manager.

[Optional] To check if your project is using SPM:

1. In Xcode, run the app.
1. Ensure that  **Run Prepare Flutter Framework Script** runs as a pre-action
   and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.

   <DashImage image="development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png" caption="Ensure **Run Prepare Flutter Framework Script** runs as a pre-action" />

If automatic migration works for you, that's it!
You are done with this page.

## How to turn off Swift Package Manager

In general, don't do this. Remember that
the CocoaPods registry becomes read-only on December 2, 2026.

Disabling Swift Package Manager causes Flutter to use CocoaPods for all
dependencies. However, SPM remains integrated with your project.
To remove Swift Package Manager integration completely from your project,
follow the [How to remove Swift Package Manager integration][removeSPM]
instructions.

### Turn off SPM for a single project

In the project's `pubspec.yaml` file, under the `flutter` section,
set `enable-swift-package-manager` to `false` in the `config` subsection.

```yaml title="pubspec.yaml"
# The following section is specific to Flutter packages.
flutter:
  config:
    enable-swift-package-manager: false
```

This turns off Swift Package Manager for all contributors to this project.

### Turn off SPM globally for all projects

Run the following command:

```sh
flutter config --no-enable-swift-package-manager
```

This turns off Swift Package Manager for the current user.

If a project is incompatible with Swift Package Manager,
all contributors need to run this command.

[removeSPM]: #how-to-remove-swift-package-manager-integration

## How to add Swift Package Manager integration

When you upgrade to Flutter 3.44 or later and run
your app, SPM integration is automatically added. You only need
these instructions if problems occurred and you need to manually
add SPM integration to your project.

Most developers do not need to do this.

If you experienced a problem automatically migrating your
project to SPM, please [file an issue][].
Include the error message and, if possible,
include a copy of the following files in your issue:

* `ios/Runner.xcodeproj/project.pbxproj`
* `ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
   (or the xcsheme for the flavor used)

### Add to a Flutter app

Use the following instructions to manually migrate your app.

### Add to a Flutter app manually

<Tabs key="darwin-platform">
<Tab name="iOS project">

{% render "docs/swift-package-manager/migrate-ios-project-manually.md", site: site %}

</Tab>
<Tab name="macOS project">

{% render "docs/swift-package-manager/migrate-macos-project-manually.md", site: site %}

</Tab>
</Tabs>

### Add to an existing app (add-to-app)

To use SPM, consult one of the following pages, as appropriate:

* [Integrate a Flutter app into your iOS project][ios-add-2-app]
* [Integrate a Flutter app into your macOS project][macos-add-2-app]

[ios-add-2-app]:   /add-to-app/ios/project-setup
[macos-add-2-app]: /add-to-app/macos/project-setup

### Add to a custom Xcode target

Your Flutter Xcode project can have custom [Xcode targets][] to build additional
products, like frameworks or unit tests.
You can add Swift Package Manager integration to these custom Xcode targets.

Follow the steps in
[How to add Swift Package Manager integration][manualIntegration].

In [Step 1][] for list item 6,
use your custom target instead of the `Flutter` target.

In [Step 2][] for list item 6,
use your custom target instead of the `Flutter` target.

[Xcode targets]: {{site.apple-dev}}/documentation/xcode/configuring-a-new-target-in-your-project
[manualIntegration]: #how-to-add-swift-package-manager-integration
[Step1]: #step-1-add-fluttergeneratedpluginswiftpackage-package-dependency
[Step2]: #step-2-add-run-prepare-flutter-framework-script-pre-action

## How to remove Swift Package Manager integration

When your app is modified to support SPM,
the Xcode project is updated to add Flutter plugin dependencies.

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
   the <Icon id="remove" label="remove/minus"></Icon> button.

   <DashImage image="development/packages-and-plugins/swift-package-manager/remove-generated-package.png" caption="The `FlutterGeneratedPluginSwiftPackage` to remove" />

1. Navigate to **Frameworks, Libraries, and Embedded Content** for the `Runner`
   target.

1. Click `FlutterGeneratedPluginSwiftPackage`, then click
   the <Icon id="remove" label="remove/minus"></Icon> button.

   <DashImage image="development/packages-and-plugins/swift-package-manager/remove-generated-framework.png" caption="The `FlutterGeneratedPluginSwiftPackage` to remove" />

1. Go to **Product > Scheme > Edit Scheme**.

1. Expand the **Build** section in the left side bar.

1. Click **Pre-actions**.

1. Expand **Run Prepare Flutter Framework Script**.

1. Click the <Icon id="delete" label="delete/trash"></Icon> button.

   <DashImage image="development/packages-and-plugins/swift-package-manager/remove-flutter-pre-action.png" caption="The build pre-action to remove" />

[Turn off Swift Package Manager]: #how-to-turn-off-swift-package-manager

## How to use a Swift Package Manager Flutter plugin that requires a higher OS version

If a Swift Package Flutter Manager plugin requires a higher OS version than
the project, you might get an error like this:

```plaintext
Target Integrity (Xcode): The package product 'plugin_name_ios' requires minimum platform version 14.0 for the iOS platform, but this target supports 12.0
```

To use the plugin:

1. Open your app (`ios/Runner.xcworkspace` or `macos/Runner.xcworkspace`) in
   Xcode.

1. Increase your app's target **Minimum Deployments**.

   <DashImage image="development/packages-and-plugins/swift-package-manager/minimum-deployments.png" caption="The target's **Minimum Deployments** setting" />

1. If you updated your iOS app's **Minimum Deployments**,
   regenerate the iOS project's configuration files:

   ```sh
   flutter build ios --config-only
   ```

1. If you updated your macOS app's **Minimum Deployments**,
   regenerate the macOS project's configuration files:

   ```sh
   flutter build macos --config-only
   ```
