---
title: "Saying goodbye to CocoaPods: Swift Package Manager is soon the default in Flutter!"
description: "Starting with the next stable Flutter release, 3.44, Swift Package Manager (SwiftPM) replaces CocoaPods as the default dependency manager…"
publishDate: 2026-04-30
author: magder
image: images/12A_CUygcOEFYUv5ms5KAJw.webp
category: announcement
layout: blog
---

<DashImage figure src="images/12A_CUygcOEFYUv5ms5KAJw.webp" alt="Dash migration!" caption="Dash migration!" />


## Saying goodbye to CocoaPods: Swift Package Manager is soon the default in Flutter!

Starting with the next stable Flutter release, 3.44, Swift Package Manager (SwiftPM) replaces CocoaPods as the default dependency manager for iOS and macOS apps. *This means no more messing around with Ruby or CocoaPods installations just to get your app running!*

CocoaPods is officially in maintenance mode, and its registry will permanently [become read-only on December 2, 2026](https://blog.cocoapods.org/CocoaPods-Specs-Repo/). While existing builds will still work, no new versions or pods will be added to the trunk after this date. To ensure that your apps continue receiving dependency updates and to provide access to the Swift package ecosystem, Flutter is transitioning to Apple’s supported dependency management solution: Swift Package Manager.

**If you’ve already migrated your plugin(s) to use SwiftPM, read the “Plugin developers” section below for new migration requirements.**

Here is how to manage the transition.

## App developers

For app developers, the Flutter CLI handles the migration. When you run or build your iOS or macOS app, the CLI automatically updates your Xcode project to use Swift Package Manager. Check out the [Flutter migration docs for app developers](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers) for more details.

If your app relies on plugins that haven’t adopted Swift Package Manager yet, Flutter will print a warning listing exactly which of your dependencies are unsupported. Flutter will temporarily fall back to CocoaPods for plugins that have not adopted Swift packages yet. Because CocoaPods support will eventually be removed entirely, if a plugin hasn’t updated and breaks your build, file an issue with the dependency’s maintainer to request Swift package support or find an alternative package.

We know that migrations can sometimes hit a snag. If SwiftPM causes a breaking issue, you can temporarily disable it for your project. Open your `pubspec.yaml` file, navigate to the `flutter` section, and set `enable-swift-package-manager` to false under the config block:

```yaml
flutter:
  config:
    enable-swift-package-manager: false
```


If you opt out, please file a bug report using the [Flutter GitHub issue template](https://github.com/flutter/flutter/issues/new/choose) and let us know! Include the error details, a list of your plugins and versions, and copies of your Xcode project files to help us resolve the issue before CocoaPods is completely removed.

## Plugin developers

For plugin authors who maintain an iOS or macOS plugin, *you must add Swift Package Manager support if you haven’t already*. So far, 61% of the top 100 iOS plugins have migrated. We need the remaining plugins on board so app developers aren’t stuck relying on a deprecated tool. To encourage adoption, packages without Swift Package Manager support now receive lower pub.dev scores until they migrate.

To add this support, add a `Package.swift` file and move your source files to match the standard Swift package structure. If you already migrated your plugin during the 2025 pilot, you need to complete one new step: you must add FlutterFramework as a dependency in your `Package.swift` file. Read the [Flutter migration docs for plugin authors](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-plugin-authors) for full instructions.

Thank you for helping with this migration to Swift Package Manager. We hope this simplifies and improves your development experience on iOS and macOS!