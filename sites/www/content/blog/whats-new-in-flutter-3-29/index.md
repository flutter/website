---
title: "What’s new in Flutter 3.29"
description: "Enhancing Performance and Fidelity Across Platforms"
publishDate: 2025-02-12
author: itsjustkevin
image: images/1-XHpdhmBoEU-K3pSPWTX3g.webp
category: releases
layout: blog
---

<DashImage figure src="images/1-XHpdhmBoEU-K3pSPWTX3g.webp" />


## What’s new in Flutter 3.29

### Enhancing Performance and Fidelity Across Platforms

## Introduction

Dive into Flutter 3.29! This release refines development and boosts performance, with updates to Impeller, Cupertino, DevTools and more. With 104 unique authors contributing this release cycle, Flutter 3.29 showcases the community’s dedication. Let’s explore what’s new!

## Framework

### Cupertino updates

`CupertinoNavigationBar` and `CupertinoSliverNavigationBar` now accept a [bottom widget](https://main-api.flutter.dev/flutter/cupertino/CupertinoNavigationBar/bottom.html), typically a search field or segmented control.

In a `CupertinoSliverNavigationBar`, this bottom widget can be configured using the [bottomMode](https://main-api.flutter.dev/flutter/cupertino/CupertinoSliverNavigationBar/bottomMode.html) property to either automatically resize until hidden or to always be shown when the navigation bar is scrolled.

Other changes to the navigation bars include:

* When partially scrolled, [`CupertinoSliverNavigationBar`](https://main-api.flutter.dev/flutter/cupertino/CupertinoNavigationBar-class.html) snaps between its expanded and collapsed state.

* A new [`CupertinoNavigationBar.large`](https://main-api.flutter.dev/flutter/cupertino/CupertinoNavigationBar/CupertinoNavigationBar.large.html) constructor allows the static navigation bar to display a large title.

* Thanks to community contributor [davidhicks980](http://github.com/davidhicks980), Cupertino popups now have [more vibrant background blurs](https://github.com/flutter/flutter/pull/159272), which improves native fidelity.

<DashImage figure src="images/09o5hT9CkjtAs9PsH.webp" />


* The new [`CupertinoSheetRoute`](https://main-api.flutter.dev/flutter/cupertino/CupertinoSheetRoute-class.html) shows an iOS-styled modal sheet view that can be removed using the drag-to-dismiss gesture.

* The new [`showCupertinoSheet`](https://main-api.flutter.dev/flutter/cupertino/showCupertinoSheet.html) function displays the sheet with a common setup for nested navigation baked in.

<DashImage figure src="images/0wkUFtSuMJHMV7VBJ.webp" />


* Community member [thejitenpatel](http://github.com/thejitenpatel) improved [`CupertinoAlertDialog`](https://api.flutter.dev/flutter/cupertino/CupertinoAlertDialog-class.html)’s native fidelity in dark mode, as shown in the following screenshots:

<DashImage figure src="images/1R83UkKDD_CWQyHJCbiEUoQ.webp" alt="Before improvement — Left is a native view, right is a Flutter view" caption="Before improvement — Left is a native view, right is a Flutter view" />


<DashImage figure src="images/1RfA62aWh5rI6v1S7zGzerw.webp" alt="After improvement — Left is a native view, right is a Flutter view" caption="After improvement — Left is a native view, right is a Flutter view" />


* When inverted, Flutter’s text selection handles swap their order on iOS, and the border color of the text selection magnifier now matches the current theme.

<DashImage figure src="images/0Zz4XclkgqvYfadFw.webp" />


### Material

* The [`FadeForwardsPageTransitionsBuilder`](https://main-api.flutter.dev/flutter/material/FadeForwardsPageTransitionsBuilder-class.html) is the new Material 3 (M3) page transition builder, designed to match the Android’s latest page transition behavior. During the transition, the incoming page slides in from right to left while simultaneously fading in, and the outgoing page slides out from right to left, fading out concurrently. This new transition also addresses the performance issues previously caused by the `ZoomPageTransitionsBuilder`.

<DashImage figure src="images/04UHEVkh3Lnmhzzfa.webp" />


* This release updates the `CircularProgressIndicator` and `LinearProgressIndicator` to align with the latest Material Design 3 specifications. To use the updated styling, either set the `year2023` property to `false`, or set [`ProgressIndicatorThemeData.year2023`](https://main-api.flutter.dev/flutter/material/ProgressIndicatorThemeData/year2023.html) to `false`.

<DashImage figure src="images/0HAZCXocwTzLyq3iO.webp" />


<DashImage figure src="images/0IhJCAxTPoV0EOc9I.webp" />


* This release also introduces the latest Material 3 `Slider` design, featuring updated track and handle shapes. The `Slider` defaults to the previous Material 3 style. To enable the latest design, either set `year2023` to `false`, or set [`SliderThemeData.year2023`](https://main-api.flutter.dev/flutter/material/SliderThemeData/year2023.html) to `false`.

<DashImage figure src="images/0RP8usLpbhUNSCOhS.webp" />


This release includes several bug fixes and feature enhancements for the Material library. Notable fixes include:

* Keyboard navigation now correctly triggers the [`DropdownMenu.onSelected`](https://main-api.flutter.dev/flutter/material/DropdownMenu/onSelected.html) callback.

* Improved `TabBar` elastic tab animation.

* Improved `RangeSlider` thumb alignment with divisions, thumb padding, and rounded corners.

In addition to bug fixes, this release enhances the customizability of several Material components. The `mouseCursor` property has been added to `Chip`, `Tooltip`, and `ReorderableListView`, allowing for custom mouse cursors on hover.

### Text selection

Flutter now gives you more information about the selection under a `SelectionArea` or `SelectableRegion` with [`SelectionListener`](https://main-api.flutter.dev/flutter/widgets/SelectionListener-class.html) and `SelectionListenerNotifier`. The [`SelectionDetails`](https://main-api.flutter.dev/flutter/widgets/SelectionDetails-class.html) object, available through `SelectionListenerNotifier`, provides you with the start and end offsets of the selection (relative to the wrapped subtree), and indicates whether a selection exists and if it’s collapsed. For a widget or selectable subtree that you want to listen to, wrap it with the `SelectionListener` widget.

Flutter also gives you information regarding the status of a `SelectionArea` or `SelectableRegion` through the [`SelectableRegionSelectionStatusScope`](https://main-api.flutter.dev/flutter/widgets/SelectableRegionSelectionStatusScope-class.html) inherited widget. You can check whether a parent `SelectionArea` or `SelectableRegion` is actively changing or has finalized its selection by using [`SelectableRegionSelectionStatusScope.maybeOf(context)`](https://main-api.flutter.dev/flutter/widgets/SelectableRegionSelectionStatusScope/maybeOf.html) and checking the [`SelectableRegionSelectionStatus`](https://main-api.flutter.dev/flutter/widgets/SelectableRegionSelectionStatus.html).

<DashImage figure src="images/06P3X5mGDk25AoIW6.webp" />


### Accessibility

This release improves the accessibility of several Material widgets:

* When a screen reader is enabled, the Form widget only announces the first error that it encounters.

* A screen reader now announces the correct label for dropdown menus.

## Web

When initially released in May 2024, Flutter’s WebAssembly (wasm) support on the web required you to host your Flutter applications with special HTTP response headers. This requirement has now been relaxed. While updating the headers allows Flutter web apps built with wasm to run with multiple threads, using default headers now allows the application to run with wasm, but limited to a single thread.

We have fixed several issues around images on the WebGL backends but the most important are:

* [Decoding the images asynchronously off the UI thread to avoid jank](https://github.com/flutter/engine/pull/53201)

* [Making Image.network work with CORS images out of the box](https://github.com/flutter/flutter/pull/157755)

## Engine

### Impeller Vulkan stability

Thanks to the feedback and bug reports on the 3.27 beta and stable releases, a number of correctness and performance improvements were made to the Vulkan backend, including:

* Fixed a reproducible flickering and visual jitter that many users reported on older Vulkan-capable devices.

* Disabled Android Hardware Buffer swapchains. This feature has been placed behind a feature flag until it’s determined that it works correctly across Android devices.

* A large number of black screen and crash reports were the result of using Vulkan on MediaTek/PowerVR soc’s and have been disabled. These devices now only use Impeller OpenGLES (see below).

* Android emulators have been updated to use the Impeller GLES backend.

### Impeller OpenGLES

In 3.29, Android devices that don’t have a functional Vulkan driver will fall back to Impeller running on OpenGLES instead of using Skia. This behavior is enabled by default and doesn’t need to be configured. This brings Impeller support on Android to 100% of Flutter’s supported Android devices.

### Impeller on iOS

Skia support has been removed from the iOS backend and the `FLTEnableImpeller` opt-out flag no longer works. Further binary size reductions are expected in future releases as we begin to remove Skia components from iOS builds.

### New features

This release contains a number of new features that take advantage of the Impeller backend.

### Backdrop filter optimizations

Applications that display multiple backdrop filters can now use the new widget `BackdropGroup` and a new `BackdropFilter.grouped` constructor. These can improve performance of multiple blurs above and beyond what was possible on the Skia backend. For an example, visit the [basic.dart](https://github.com/flutter/flutter/blob/flutter-3.29-candidate.0/packages/flutter/lib/src/widgets/basic.dart#L502) source code.

### ImageFilter.shader

A new `ImageFilter` constructor allows applying a custom shader to any child widgets. This provides similar functionality to the `AnimatedSampler` widget from `package:flutter_shaders`, except that it also works with backdrop filters. For an example, visit the [painting.dart](https://github.com/flutter/flutter/blob/flutter-3.29-candidate.0/engine/src/flutter/lib/ui/painting.dart#L4239) source code.

### Dart threading changes on Android/iOS

Previously, Flutter executed Dart code on a different thread (UI thread) than the platform’s main thread. This allowed higher theoretical throughput if both platform and UI threads were occupied, but came at the cost of making most platform interop require serialized and asynchronous message passing. This architecture also had knock-on effects on text input, accessibility, plugins, and so on.

Starting in 3.29, Flutter on Android and iOS execute Dart code on the application’s main thread, and there is no longer a separate UI thread. This is the first part in a series of changes to improve platform interop on mobile platforms, as it allows making synchronous calls to and from the platform without the overhead of serialization and message passing.

## DevTools and IDEs

### **New DevTools inspector**

The new DevTools inspector is enabled by default for all users. The new inspector has a condensed widget tree, a new widget properties view, and an option to automatically update in response to hot-reload and navigation events. For more details, visit the [new inspector page](https://docs.flutter.dev/tools/devtools/inspector#new) on docs.flutter.dev.

<DashImage figure src="images/0u75a-VoDr43H_xxK.webp" />


### **Changes to on-device widget selection**

After enabling widget selection mode from the DevTools inspector, any selections on the device are considered widget selections until you exit widget selection mode. Previously, after the initial widget selection you needed to click the on-device **Select widget** button to then select another widget. Instead, there is now an on-device button that can be used to quickly exit widget selection mode.

<DashImage figure src="images/0BcgxalxFMTEB_RFP.gif" />


### **Logging tool improvements**

The Logging tool in DevTools has been improved in the following ways:

* Logs include and display more metadata such as log severity, category, zone, and isolate.

* Added support for filtering by log severity level.

* Significant improvement in performance and initial load time.

<DashImage figure src="images/0mIvmDgvoydaAWE05.webp" />


These are just a few highlights from this release. To learn more about all the updates included in Flutter 3.29, check out the release notes for DevTools [2.41.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.41.0) and [2.42.2](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.42.2).

## Breaking changes and deprecations

### Discountinuing package support

We plan to discontinue support for the following packages on April 30th, 2025:

* ios_platform_images; see [ios_platform_images planned to be discontinued #162961](https://github.com/flutter/flutter/issues/162961)

* css_colors; see [css_colors planned to be discontinued #162962](https://github.com/flutter/flutter/issues/162962)

* palette_generator; see [palette_generator planned to be discontinued #162963](https://github.com/flutter/flutter/issues/162963)

* flutter_image; see [flutter_image discontinued #162964](https://github.com/flutter/flutter/issues/162964)

* flutter_adaptive_scaffold; see [flutter_adaptive_scaffold planned to be discontinued #162965](https://github.com/flutter/flutter/issues/162965)

* flutter_markdown; see [flutter_markdown planned to be discontinued #162966](https://github.com/flutter/flutter/issues/162966)

We encourage any interested members of the community to coordinate on establishing and maintaining forks. Links to the issues are provided above for discussion and coordination.

### Removal of script-based application of the Flutter Gradle plugin

Removal of script-based application of the Flutter Gradle plugin, which has been deprecated since 3.19. This supports converting the Flutter Gradle plugin from Groovy to Kotlin, and towards migrating it to use AGPs public API. This work is expected to decrease the frequency of breakages when a new AGP version is published and reduce build-based regressions.

Projects created before 3.16 that have not yet migrated will likely be impacted. If the flutter tool logs the warning: “You are applying Flutter’s main Gradle plugin imperatively” when building your project, you are impacted and need to migrate according to [Deprecated imperative apply of Flutter’s Gradle plugins](https://docs.flutter.dev/release/breaking-changes/flutter-gradle-plugin-apply) on docs.flutter.dev.

### Removal of the web HTML renderer

This is the first release where the HTML renderer has been removed from Flutter web. For more information, visit [The intent to deprecate and remove the HTML renderer in Flutter web](https://docs.google.com/document/d/1DGamHsa2lz_Qtgfrfa3j3fRaEopJXc7tCFVM1TQlck8/edit?resourcekey=0-IjkqrCoo_EcRRS2bPYKI8w&tab=t.0) and[ Issue 145584: Intent to deprecate and remove the HTML renderer in Flutter web](https://github.com/flutter/flutter/issues/145954).

### Web image handling

This release also gives you [more control over how images are displayed on the web](https://github.com/flutter/flutter/pull/159917). In the previous beta release (3.28), Image widgets would automatically use `&lt;img&gt;` elements to display images from URLs when CORS errors occurred. This could lead to inconsistent behavior. Now, the `webHtmlElementStrategy` flag lets you choose when `&lt;img&gt;` elements are used. While this fallback is disabled by default, you can still enable the fallback or even prioritize `&lt;img&gt;` elements if needed for your application.

### Material normalization

As part of our ongoing theme normalization project in Material, this release deprecates `ThemeData.dialogBackgroundColor` in favor of `DialogThemeData.backgroundColor`. You can use the `dart fix` command to migrate affected code.

Also in Material, the `ButtonStyleButton` `iconAlignment` property was deprecated after being added to `ButtonStyle` and associated `styleFrom` methods.

For all [breaking changes](https://docs.flutter.dev/release/breaking-changes) in this release, see the full list of migration guidance on the breaking changes page of the website.

As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md) — these help us identify breaking changes. To learn more, check out [Flutter’s breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

## **Conclusion**

<DashImage figure src="images/1Mk6_aE2XEiK3Iq_H-q1L5Q.jpeg" />


Thanks to the Flutter community for making this release possible! We’re excited for the future and can’t wait to see your apps. Check the [release notes and changelog](https://docs.flutter.dev/release/release-notes/release-notes-3.29.0), then run `flutter upgrade` and start building!