---
title: "What’s new in Flutter 3.27"
description: "Elevating App Development with Impeller, Cupertino Updates, and More"
publishDate: 2024-12-11
author: itsjustkevin
image: images/1auh3JCfdFKzK_licnLrEKQ.webp
category: releases
layout: blog
---

<DashImage figure src="images/1auh3JCfdFKzK_licnLrEKQ.webp" />


## What’s new in Flutter 3.27

### Elevating App Development with Impeller, Cupertino Updates, and More

## Introduction

Let’s dive into Flutter 3.27! This release is brimming with enhancements and features focused on refining your development experience and boosting your app’s performance.

We’ve got updates across the framework, engine, and ecosystem, including progress with Impeller and improvements to Cupertino widgets. Plus, we’re introducing exciting new features in DevTools, making it easier than ever to manage your Flutter projects. With over 1,400 commits from 187 contributors (including **49 first time contributors**!), Flutter 3.27 is a testament to the incredible energy and collaboration of the Flutter community. Let’s explore what’s new!

## Framework

### Cupertino updates

This release includes high fidelity updates to `CupertinoCheckbox` and `CupertinoRadio`, featuring updates to sizes, colors, stroke widths, and behaviors when pressed. There have also been large customizability updates to `CupertinoRadio`, `CupertinoCheckbox`, and `CupertinoSwitch`, adding properties like mouse cursors, semantic labels, thumb images, and fill colors. Some properties, like the inactive color of `CupertinoCheckbox`, were deprecated, while others, like the track color of `CupertinoSwitch`, were renamed. These changes bring these widgets up to feature parity with their Material counterparts.

`CupertinoSlidingSegmentedControl` sees some fidelity updates to its thumb radius, separator height, padding, shadows, and thumb scale alignment. It also now supports disabling individual segments, and proportional layout based on segment content.

<DashImage figure src="images/0Nr0WuNhNxjlI1Pqg.webp" />


Thanks to an amazing contribution from community member [@veloce](https://github.com/veloce), both `CupertinoNavigationBar`’s and `CupertinoSliverNavigationBar`’s backgrounds are now transparent until content is scrolled under them.

<DashImage figure src="images/0dngArPlUvp4pVA-R.webp" />


This allows the sliver navigation bar to have the same color as its background in its expanded state, but a different customizable color in its collapsed state (and the ability to lerp between both colors on scroll).

Thanks to an amazing contribution from community member [@kerberjg](http://github.com/kerberjg), you can now apply the iOS 15+ button styles using the new `CupertinoButtonSize` enum with the new `sizeStyle` property in `CupertinoButton`. Use the new `CupertinoButton.tinted` constructor to make buttons with a translucent background.

<DashImage figure src="images/0vdSn5c7uavWstNO5.webp" />


<DashImage figure src="images/0ZPrThBB6ZN8DEtUq.webp" />


`CupertinoButton` also has a new `onLongPress` handler, and allows performing actions through keyboard shortcuts.

`CupertinoPicker` and `CupertinoDatePicker` will now scroll to tapped items.

<DashImage figure src="images/0XUtBHK9h0zbWrKUF.webp" />


`CupertinoAlertDialog` now supports the tap-slide gesture.

<DashImage figure src="images/0JYBUuzXHcYTCD4i5.webp" />


`CupertinoActionSheet` sees some high fidelity updates, including adjusting padding and font sizes across all system text size settings and supporting haptic feedback when sliding over buttons.

Other changes include `CupertinoContextMenu` now supporting scrolling if its actions overflow the screen, `CupertinoDatePicker` no longer clipping long contents in its columns, and `CupertinoMagnifier` supporting zoom effects by providing a magnification scale.

### Normalizing Material theming

In this release, `CardTheme`, `DialogTheme` and `TabBarTheme` have been refactored to make them conform to Flutter’s conventions for component themes. `CardThemeData`, `DialogThemeData` and `TabBarThemeData` were added to define overrides for the defaults of the component visual properties. Future releases will continue to normalize component themes like these for a more consistent theming experience in the material library.

### More Features for CarouselView

This release introduces `CarouselView.weighted`, enabling more dynamic layouts within carousels. By adjusting the `flexWeights` parameter in the constructor, you can achieve a variety of item layouts. For instance, [3, 2, 1] creates a [multi-browse](https://m3.material.io/components/carousel/specs#3c9dc903-2f88-4b27-84e3-213c50674632) layout, [7, 1] produces a [hero](https://m3.material.io/components/carousel/specs#66eb8746-70f0-4bad-b940-8e1028268d65) layout, and [1, 7, 1] yields a [centered-hero](https://m3.material.io/components/carousel/specs#92c779ce-de8b-4dee-8201-95d3e429204f) layout. These values represent the relative weight each item occupies within the carousel view and can be customized to suit users’ specific needs.

<DashImage figure src="images/0EUjz8K6BQZX2uumi.webp" />


### More in Material

This release includes a number of small feature enhancements and bug fixes. Some enhancement examples:

* `SegmentedButton` now has a `direction` property, so items can be aligned vertically.

<DashImage figure src="images/0ECVkEydB6YuBSGs_.webp" />


* more icon-related properties are added to the styleFrom method for `ButtonStyleButton` classes (`ElevatedButton`, `FilledButton`, `OutlinedButton`, `TextButton`, `MenuItemButton`, and `SubmenuButton`) to allow more customization.

Some bug fixes examples:

* The Icon size and color defaults for `ButtonStyleButton` classes are aligned with Material 3 specifications.

* The AppBar’s scroll-under behavior now correctly persists when the navigation drawer opens, matching the native Android experience.

* `MenuAnchor` is further improved with focus fixes and several `DropdownMenu` issues, including the scrolling issue within nested scrollables and filter mechanism behavior, have been resolved.

### Mixing Route Transitions

[ModalRoutes](https://api.flutter.dev/flutter/widgets/ModalRoute-class.html) are now more flexible when the previous and new routes have different page transitions. When a new route enters the screen, sometimes they need the previous existing route to play a certain transition to sync up with the entrance transition of the new route. Now `ModalRoutes` can provide exit transition builders to each other so the enter and exit transitions always sync up. This allows pages to have multiple route transition options on one page using Flutter’s Navigator and Router.

<DashImage figure src="images/0vyFYrAWVig8f8WGl.webp" />


### Text Selection Improvements

Flutter’s `SelectionArea` now supports Shift + Click gesture to move the extent of the selection to the clicked position on Linux, macOS, and Windows.

<DashImage figure src="images/0QwWCiz-DAHklZZAi.gif" />


You can also now clear the selection under a SelectionArea and `SelectableRegion` through the method [`clearSelection`](https://main-api.flutter.dev/flutter/widgets/SelectableRegionState/clearSelection.html) on [`SelectableRegionState`](https://api.flutter.dev/flutter/widgets/SelectableRegionState-class.html). [`SelectableRegionState`](https://api.flutter.dev/flutter/widgets/SelectableRegionState-class.html) is also now accessible through `SelectionArea` by providing it a `GlobalKey` and accessing its [`SelectionAreaState.selectableRegion`](https://main-api.flutter.dev/flutter/material/SelectionAreaState/selectableRegion.html).

We also resolved some issues with RenderParagraph, so selecting text under a `SelectionArea` or `SelectableRegion` still works as expected after resizing the [window](https://github.com/flutter/flutter/pull/155719), and when clicking or [tapping outside](https://github.com/flutter/flutter/pull/155892) of the actual text.

### Row and Column spacing

This release also features a new convenience to using Rows and Columns, spacing! This double parameter will apply a fixed amount of pixels to offset children of Rows and Columns from each other, reducing the previous amount of code required to do so.

<DashImage figure src="images/185CZePbMbJ99B5-hPvwpKQ.webp" />


## Engine

### Impeller on Android

We are pleased to share that Impeller is now the default rendering engine on modern Android devices. While Impeller on these devices has been in preview since Flutter’s 3.16 stable release in November 2023, since then we have made large improvements to both performance and fidelity based on user feedback.

On older Android devices and devices without Vulkan support, the Skia rendering engine will still be used as before. While we believe that Impeller’s performance and fidelity are both high quality, users are able to opt-out and return to the legacy Skia renderer by passing`--no-enable-impeller` to the `flutter` command line tool, or by placing the following in your `AndroidManifest.xml` file(s):

`&lt;meta-data
 android:name=”io.flutter.embedding.android.EnableImpeller”
 android:value=”false” /&gt;`

Going forward we will continue to make improvements to Impeller’s performance and fidelity on Android. Additionally, we intend to make Impeller’s OpenGL backend production ready to remove the Skia fallback.

As during the preview period, we request that Flutter developers upgrade to the latest stable version, and file issues about any shortcomings noticed when Impeller is enabled. Feedback continues to be invaluable to ensuring that Impeller is successful on Android. The Android hardware ecosystem is much more diverse than the iOS ecosystem. For that reason, the most helpful feedback about Impeller should include detailed information about the specific device and Android version where issues occurred.

## Improvements on iOS devices

In previous versions of Flutter, users may have experienced [an issue](https://github.com/flutter/flutter/issues/134959) in which applications on iOS devices waited several milliseconds per frame on compositor backpressure. This backpressure would be observed as delays in the beginning of the raster workload. In many circumstances, this delay caused missed frames and jank. This effect was especially noticeable on high frame-rate devices with a smaller frame time budget.

In this release, open source contributor [@knopp](https://github.com/knopp) added [a new implementation](https://github.com/flutter/engine/pull/48226) of a Metal rendering surface that allows raster workloads to begin more consistently after the UI workload completes. This means that users will observe that overall frame times are more stable as there is less waiting on the iOS system compositor. In particular, Flutter will now much more consistently hit 120Hz on high frame-rate devices. In our benchmarks we have observed this improvement in a large reduction in average frame rasterization time across many scenarios.

<DashImage figure src="images/0wsAPbKV2yW8tLXNb.webp" alt="*This chart shows an across-the-board decrease in average frame rasterization time in milliseconds on a large number of different benchmarks running on iPhone 11 devices.*" caption="*This chart shows an across-the-board decrease in average frame rasterization time in milliseconds on a large number of different benchmarks running on iPhone 11 devices.*" />


### Framework Wide Gamut Colors

Flutter now supports defining UI’s with colors in the DisplayP3 color space to take full advantage of displays on iOS devices. It also has wider bit depth to support more colors in sRGB and DisplayP3 color spaces. This change has led to the deprecation of some `Color` methods; more information can be found in the [breaking change notice](https://docs.flutter.dev/release/breaking-changes/wide-gamut-framework).

## Web

### Web Improvements

This release brings a variety of improvements to Flutter web, focusing on performance, efficiency, and accessibility:

* Image decoding in Safari and Firefox is now done using an `<img>` element instead of WebAssembly codecs for all static images. This removes jank related to image decoding and reduces WASM memory usage.

* Platform views were optimized to reduce the number of canvas overlays, improving rendering efficiency.

* All plugins and packages developed by the Flutter team are now compatible with WebAssembly.

* Multiple accessibility fixes were implemented for headings, dialogs, passwords, iOS keyboard, links, and scrollables.

* A number of rendering bugs were fixed in the CanvasKit and Skwasm renderers, including image filters, clipping, and memory usage of `Paint` objects.

* Improved drag scrolling in multi-view mode.

## iOS

### Swift Package Manager

Flutter is migrating to Swift Package Manager. This brings several benefits:

1. **Access to the Swift package ecosystem**. Flutter plugins will be able to leverage the growing ecosystem of [Swift packages](https://swiftpackageindex.com/)!
2. **Simpler Flutter installation**. Swift Package Manager is bundled with Xcode. In the future, you won’t need to install Ruby and CocoaPods to use Flutter for Apple’s platforms.

Previously, Swift Package Manager support was only available on Flutter’s “main” channel. We’re pleased to announce that the Swift Package Manager feature is now available on the “beta” and “stable” channels too! For now, the Swift Package Manager feature is off by default while we iron out the kinks.

Plugin authors are encouraged to add support for [Swift Package Manager to your plugins](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-plugin-authors#how-to-add-swift-package-manager-support-to-an-existing-flutter-plugin). Many popular plugins — including [Firebase](https://github.com/firebase/flutterfire/issues/13205), [plus plugins](https://github.com/fluttercommunity/plus_plugins/issues/3152), and [more](https://pub.dev/packages?q=is%3Aswiftpm-plugin) — have already migrated to Swift Package Manager!

Pub.dev now checks plugins for Swift Package Manager compatibility. In the future, packages that are incompatible will not receive full package scores.

If you have feedback on Flutter’s support for Swift Package Manager, please [file an issue](https://github.com/flutter/flutter/issues/new/choose).

## Android

### Edge to Edge

By default on devices running Android 15+, your app will use edge-to-edge mode and run in full screen! For details on the change and how you can opt out of this behavior, see [the guide](https://docs.flutter.dev/release/breaking-changes/default-systemuimode-edge-to-edge).

<DashImage figure src="images/0CNcQF3yqFwc0IGNc.gif" />


### Support for Freeform

[Android Freeform](https://android-developers.googleblog.com/2024/09/developer-preview-desktop-windowing-on-android-tablets.html) allows users to resize app windows and has been available as a developer option. Flutter’s `SafeArea` and `MediaQuery` have been updated to handle hardware cutouts when a freeform window moves into a hardware cutout.

### Kotlin build script support and declarative plugin migration

Developers can now use `build.gradle.kts` files. 
Flutter tooling now supports Kotlin build files. If you encounter a place where we don’t support Kotlin, [please file a bug](https://github.com/flutter/flutter/issues/new/choose). Groovy remains a supported Gradle language.

Flutter 3.27 is the last release that will support [Gradle’s legacy apply script method](https://docs.gradle.org/8.5/userguide/plugins.html#sec:script_plugins). See [migration docs](https://docs.flutter.dev/release/breaking-changes/flutter-gradle-plugin-apply).

**Note: Most apps will need to manually migrate. Newly created apps will [use kotlin build files](https://github.com/flutter/flutter/pull/157195).**

Moving to declarative inclusion of the Flutter Gradle Plugin helps Flutter migrate to Kotlin builds files with better type safety and easier to maintain unit tests for build code. It is also a part of a broader effort to bring more stability across Android tooling versions.

## Ecosystem

### Flutter and Dart Package Ecosystem Summit USA 2024

As part of Fluttercon USA 2024 in September, we held a Flutter and Dart Package Ecosystem Summit. This was our second in-person summit, that followed on from the summit at Fluttercon Europe in July 2024, and the first virtual summit we held in August 2023. See a summary of takeaways from the discussion sessions [here](https://docs.google.com/document/d/e/2PACX-1vRjPlBNo13I9P5UXpehKagVq8e8n7ppNz169HbKSgK4iTmCrbk5rzh-RN6ULpVJ3AkPnnCSI_VCMdYW/pub).

The summit brought together package authors and maintainers for unconference-style sessions on the following topics:

* Session 1 — Adding support for Swift Package Manager

* Session 2 — Past, Present and Future of Native Interop

* Session 3 — Sustainable package maintenance models

We’re looking forward to holding more of these summits going forward, in partnership with the community.

### Package download counts on pub.dev

We launched download count metrics on pub.dev!

Providing more precise popularity metrics on [pub.dev](https://pub.dev) has been [the most requested](https://github.com/dart-lang/pub-dev/issues/2714) feature in the site’s issue tracker for a long time.

Now, when you view a package page you will see a 30-day download count replacing the former “popularity score”.

Additionally, we added an interactive sparkline chart showing weekly download activity over time. This chart helps developers and package authors uncover trends in package usage. For example, it could be an indicator that a new release has caused a spike in usage, or that a package is gaining or losing popularity.

A download is registered each time the package is downloaded from pub.dev. For example, when you run `flutter pub get`, and the package isn’t already in your pub cache.

The download count numbers presented are raw download counts, and reflect usage from CI systems, package analysis, human pub client users, and more.

<DashImage figure src="images/0tIfxBdBCHFzYhStI.webp" />


### Pub workspaces

We are launching [Pub Workspaces](https://dart.dev/go/pub-workspaces) with Dart 3.6, to support the development of multiple related packages in one monorepo

By defining a root pubspec that references the other packages in the repository, running pub get anywhere in the repository will result in a shared resolution for all the packages. This ensures that all packages are developed with a consistent set of dependencies.

The shared resolution is also picked up by the analyzer, which now only has to keep track of a single analysis context for the entire workspace, potentially resulting in a significant reduction in memory use when opening the whole repository in your IDE.

### Automated publishing of Flutter packages from GitHub

We have extended the setup-dart [publish](https://github.com/dart-lang/setup-dart/blob/main/.github/workflows/publish.yml) Github Actions workflow to also allow [automated publishing](https://dart.dev/tools/pub/automated-publishing#configuring-automated-publishing-from-github-actions-on-pub-dev) of Flutter packages to pub.dev, making it easier to contribute to the Pub ecosystem in a verifiable manner.

### Launch of Interactive Media Ads plugin

We launched an [Interactive Media Ads (IMA) Flutter plugin](https://pub.dev/packages/interactive_media_ads) that makes it easy to integrate multimedia ads into iOS and Android apps built with Flutter. The IMA plugin can request ads from any VAST-compliant ad server and manage ad playback in your apps. Ads play in a separate video player positioned on top of the app’s content video player. The current supported features are:

* Client-side APIs for linear instream video ad requests

* VAST & VMAP

* Single & Podded Requests

* Skippable Ads

### In-App Purchase iOS and macOS plugin updates

We’ve added [StoreKit 2](https://developer.apple.com/storekit/) support to the `in_app_purchase_storekit` package to migrate off StoreKit 1 APIs, which were deprecated in iOS 18. This allows us to add new StoreKit 2 features like better subscription management in the future. Stay tuned for an upcoming migration guide to help you transition to the newer StoreKit 2 functionality. This is a non-breaking change, so you can migrate whenever you wish.

## DevTools and IDEs

### Flutter DevTools updates

This release includes new features, overall improvements to robustness and polish, as well as some exciting new experimental features that you can enable from DevTools. See the [Previews and Experimental features](https://docs.google.com/document/d/1dNTgjAR5CAmjK_aYgNPCBOnBatg164fws6qHkLGvBTA/edit?pli=1&tab=t.0#bookmark=id.5x1g42w1xm31) section below for more information on these.

Firstly, we added support for validating iOS deep link settings in the Flutter Deep Links tool. You can now validate deep links for Android and iOS.

<DashImage figure src="images/0WO_tOgbNKHtMAJ4h.webp" alt="*iOS deep link validation in the DevTools Deep Links tool.*" caption="*iOS deep link validation in the DevTools Deep Links tool.*" />


Next, we’ve made some improvements to the workflow of working with “offline” data. Sometimes it is necessary to export the data you are viewing in DevTools for future use or for loading into another tool. This release adds support for exporting Network data as a `.har` file, and for loading memory snapshots into DevTools for viewing when DevTools is not connected to a running app.

Additionally, if you’ve ever been in the middle of debugging a memory issue with DevTools and lost your memory tool data because your app crashed (perhaps due to the very OOM issue you are trying to debug), we feel your frustration! We have fixed this UX pain point by allowing you to continue viewing the most recent memory tool data in DevTools, even after an app disconnects.

These are just a few highlights from this release. To learn more about all the updates included in Flutter 3.27, check out the release notes for DevTools [2.38.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.38.0), [2.39.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.39.0), and [2.40.1](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.40.1).

## Previews and experimental features to try

### Flutter DevTools — New Flutter Inspector

The Flutter Inspector has undergone some major changes to improve usability and enhance your UI debugging journey. Enable the new Inspector by toggling the “New Inspector” setting.

<DashImage figure src="images/0DdHEiQ7FUmFVIMGz.webp" alt="*New Flutter Inspector in DevTools.*" caption="*New Flutter Inspector in DevTools.*" />


A few of the changes include:

* A condensed Widget tree that makes it easier to view deeply nested Flutter widget trees. This is especially helpful when using the Flutter Inspector from inside your IDE, where horizontal screen space is limited.

* An option to toggle whether implementation widgets should be included in the widget tree. Implementation widgets are widgets that you didn’t include in your app code, but rather that were added to the widget tree by the Flutter framework or other packages.

* A details view for the selected widget that shows an inline layout viewer, widget and render object properties, and a flex layout explorer for Flex widgets and their children.

More improvements are coming soon for the new Inspector, but these changes are ready for you to try out! Please file any [issues](https://github.com/flutter/devtools/issues) you encounter so that we can fix them before enabling the new Inspector by default.

### Flutter DevTools — Try with WebAssembly

Enable the WebAssembly feature in DevTools settings to load the WASM-compiled DevTools web app.

This should yield better performance than the default JS-compiled version of DevTools. This feature is experimental, so please file any [issues](https://github.com/flutter/devtools/issues) you encounter with the WASM build.

<DashImage figure src="images/0J2ur0Z_wJsdbAUt8.webp" alt="*DevTools setting to use the WebAssembly build instead of the Javascript build.*" caption="*DevTools setting to use the WebAssembly build instead of the Javascript build.*" />


## Breaking Changes and Deprecations

### Material Design 3 tokens

The latest Material Design 3 tokens(v6.1) have been applied to the Flutter Material library. The Material Design tokens updated the mapping of 4 color roles in Light mode only to be more visually appealing while retaining accessible contrast. We did not identify any breakages in our testing of this change, which applied to these color properties:

* On-primary-container (Primary10 to Primary30)

* On-secondary-container (Secondary10 to Secondary30)

* On-tertiary-container (Tertiary10 to Tertiary30)

* On-error-container (Error10 to Error30)

<DashImage figure src="images/0_uQf9sIr4M1EC34y.webp" />


This affects widgets that use these roles as their default value.

The border color of `Chip`s (`Chip`, `ActionChip`, `ChoiceChip`, `FilterChip`, and `InputChip`) was updated from `ColorScheme.outline` to `ColorScheme.outlineVariant`. This improves the visual hierarchy between chips and buttons.

### Objective-C iOS projects

Since Flutter 1.9.1 released in 2019, new iOS projects use Swift by default. Creating a [new Objective-C iOS project is now deprecated](https://github.com/flutter/flutter/issues/148586), and the `flutter create --ios-language objc` flag will be removed in a future version of Flutter. You will still be able to open your Xcode project and add Objective-C files, including for plugins. Java continues to be supported for Android apps with the `flutter create --android-language java` flag.

### Deep link default flag

The default value for Flutter’s deep linking flag has changed from **false** to **true**, meaning deep linking is now opt-in by default. If you’re using Flutter’s default deep linking setup, there’s no need to manually set the flag to **true** anymore.

However, if you’re using third-party plugins for deep links, such as:

* [firebase dynamic links](https://firebase.google.com/docs/dynamic-links)

* [uni_link](https://pub.dev/packages/uni_links)

* [app_links](https://pub.dev/packages/app_links)

This update will introduce a breaking change. In this case, you’ll need to manually reset the Flutter deep linking flag to **false**.

For more details, refer to the design document: [flutter.dev/go/deep-link-flag-migration](http://flutter.dev/go/deep-link-flag-migration).

### Deprecating support for older SDKs in IDE

To ensure we can continue to deliver a high-quality developer experience, we’re making a change to our IDE plugin support. As the Dart and Flutter plugins for VS Code and IntelliJ have evolved, supporting older Dart SDK versions has become increasingly challenging.

Starting with the release of Dart 3.6, we will deprecate support for Dart SDK versions older than 3.0 (released in May 2023). This means that while the tools may still function with older SDKs, we will no longer provide official support or fixes for issues specific to these versions.

With the release of Dart 3.7 (estimated in Q1 2025), we will remove support for these older SDK versions entirely. Future releases of the plugins may not be compatible with these versions.

**What does this mean for you?**

* If you’re using an older Dart SDK, we encourage you to upgrade to version 3.0 or later to continue receiving support and updates.

* This change affects less than 1% of our users, and it will allow us to focus on delivering the best possible experience for the vast majority of developers.

### Closing

For all breaking changes in this release, see the full list of migration guidance on the [breaking changes page](https://docs.flutter.dev/release/breaking-changes).

As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md) — these help us identify breaking changes. To learn more, check out [Flutter’s breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

## Conclusion

A huge thank you to the entire Flutter community for making this release possible! Your contributions, feedback, and enthusiasm are what drive Flutter forward. We’re incredibly excited about the future of Flutter and can’t wait to see the amazing apps you build with Flutter 3.27.

For a complete rundown of all the changes, check out the detailed [release notes and changelog](https://docs.flutter.dev/release/release-notes). Ready to experience the latest and greatest? Simply run `flutter upgrade` and start building!
