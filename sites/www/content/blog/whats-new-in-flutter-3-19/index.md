---
title: "What’s new in Flutter 3.19"
description: "Revolutionizing App Development with the Gemini API, Impeller Updates, and Windows Arm64 Support"
publishDate: 2024-02-15
author: itsjustkevin
image: images/0ZX3bHJdGGZwwOQHt.gif
category: release
layout: blog
---

<DashImage figure src="images/0ZX3bHJdGGZwwOQHt.gif" />


## What’s new in Flutter 3.19

### Revolutionizing App Development with the Gemini API, Impeller Updates, and Windows Arm64 Support

Today we present you with a new Flutter release, Flutter 3.19. This release brings a new Dart SDK for Gemini, a widget enabling developers to add fine-grained control to widget animations, a rendering boost with updates to Impeller, tooling to help implement deep links, Windows Arm64 support and so much more!

The Flutter community continues to impress, merging 1429 pull requests by 168 community members, with 43 community members committing their first Flutter pull requests!

Keep reading to learn about all the new additions and improvements the Flutter community has contributed to this latest release!

## AI integration

### Gemini Google AI Dart SDK beta release

The Google AI Dart SDK has been released to beta. This enables you to build generative AI features into your Dart or Flutter app, powered by Gemini, Google’s latest family of AI models. There is now a [`google_generative_ai`](https://pub.dev/packages/google_generative_ai) package on pub.dev. Learn more about how to build with the Google AI Dart SDK in [this blog post](https://medium.com/flutter/harness-gemini-in-your-dart-and-flutter-apps-00573e560381) or jump straight into the [Dart quickstart](https://ai.google.dev/tutorials/dart_quickstart).

<DashImage figure src="images/013y0iIXD9nN5wCcX.webp" />


## Framework

### Scrolling improvements

Flutter used to scroll twice as fast if you dragged two fingers. You can now configure the default `ScrollBehavior` with `MultiTouchDragStrategy.latestPointer` to get number-of-fingers-agnostic scrolling behavior. For more information on this change, see the [migration guide](https://docs.flutter.dev/release/breaking-changes/multi-touch-scrolling).

We also completed bug fixes for [`SingleChildScrollView`](https://github.com/flutter/flutter/pull/136871) and [`ReorderableList`](https://github.com/flutter/flutter/pull/136828), resolving a number of reported crashes and unexpected behavior.

In two dimensional scrolling, we resolved an issue so now, if you drag or tap while a scroll is underway in either direction, the scroll activity stops as expected.

The `TableView` widget in the `two_dimensional_scrollables` package has also been updated since the last release, providing more polish, adding support for merged cells, and adopting more of the new features of the 2D foundation after the last stable release of 3.16.

### AnimationStyle

Thanks to a [contribution](https://github.com/flutter/flutter/pull/138721) by Flutter community member [@TahaTesser](https://github.com/TahaTesser), Flutter has a new `AnimationStyle` widget that allows users to override the default animation behavior in widgets, such as `MaterialApp`, `ExpansionTile`, and `PopupMenuButton`, providing developers with the ability to override animation curves and durations.

### SegmentedButton.styleFrom

Flutter community member [@AcarFurkan](https://github.com/AcarFurkan) added a `styleFrom` static utility method, just like the ones provided by the other button types. This method enables quickly creating a `SegmentedButton`’s `ButtonStyle` that can be shared with other segmented buttons or used to configure the app’s `SegmentedButtonTheme`.

### Adaptive Switch

This adaptive component looks and feels native on macOS and iOS and has the Material Design look and feel elsewhere. It does not depend on the Cupertino library so its API is exactly the same on all platforms.

See the [adaptive switch pull request](https://github.com/flutter/flutter/pull/130425) and the live example on the `Switch.adaptive` constructor [API page](https://api.flutter.dev/flutter/material/Switch/Switch.adaptive.html).

### SemanticsProperties accessibility identifier

A new accessibility identifier in `SemanticsProperties` provides an identifier for the semantic node in the native accessibility hierarchy. On Android, it appears in the accessibility hierarchy as `resource-id`. On iOS, this sets `UIAccessibilityElement.accessibilityIdentifier`. We want to thank community member [@bartekpacia](https://github.com/bartekpacia) for this change, which spanned the [engine](https://github.com/flutter/engine/pull/47961) and [framework](https://github.com/flutter/flutter/pull/138331).

### Increased access to text widget state

We added support for a `MaterialStatesController` in `TextField` and `TextFormField` so that you can listen to `MaterialState` changes.

### UndoHistory stack

We [fixed](https://github.com/flutter/flutter/pull/138674) a [problem](https://github.com/flutter/flutter/issues/130881) where the undo/redo history could disappear on Japanese keyboards. You can now modify an entry before it’s pushed to the `UndoHistory` stack.

## Engine

### Impeller progress

**Android OpenGL preview**

In the 3.16 stable release, we invited users to try out Impeller on Vulkan-enabled Android devices, covering 77% of Android devices in the field. Over the past few months, we have brought Impeller’s OpenGL backend up to feature parity with the Vulkan backend, for example, by adding [support for MSAA](https://github.com/flutter/engine/pull/47030). This means that Flutter apps on nearly all Android devices are expected to render correctly, with the exception of a small number of remaining features that are coming soon, such as custom shaders and full support for external textures.

We request that Flutter developers upgrade to the latest stable version, and file issues about any shortcomings observed when [Impeller is enabled](https://docs.flutter.dev/perf/impeller#android). Feedback at this stage is invaluable to ensuring that Impeller is successful on Android and that we can confidently make it the default renderer in a release later this year. The Android hardware ecosystem is much more diverse than the iOS ecosystem. For that reason, the most helpful feedback about Impeller should include detailed information about the specific device and Android version where issues occurred.

Further, as a reminder, Impeller’s Vulkan backend enables additional debugging capabilities in [debug](https://docs.flutter.dev/testing/build-modes#debug) builds beyond what is used with Skia, and these capabilities have additional runtime overhead. Therefore, it’s important to give feedback about Impeller’s performance from a [profile](https://docs.flutter.dev/testing/build-modes#profile) or [release](https://docs.flutter.dev/testing/build-modes#release) build. The bug report should include timelines from DevTools and a comparison with the Skia backend on the same device. Finally, as always, we are very grateful for feedback that includes a small reproducible test case that demonstrates the issue.

**Roadmap**

After rendering fidelity, our main focus in Impeller’s Android preview period is performance. We continue to make incremental gains, however a couple of larger improvements are also in progress. We expect work to take advantage of [Vulkan subpasses](https://github.com/flutter/flutter/issues/128911) to greatly improve the performance of advanced blend modes. Further, we also expect that a change in rendering strategy away from always tessellating every path on the CPU towards a [Stencil-then-cover](https://github.com/flutter/flutter/issues/137714) approach will greatly reduce Impeller’s CPU utilization on both Android and iOS. Finally, we expect that a new implementation of [Gaussian blurring](https://github.com/flutter/flutter/issues/131580) will match the throughput of the Skia implementation, and improve idiomatic use of blurring on iOS.

### API improvements

**Glyph Information**

This release includes two new methods on `dart:ui`’s `Paragraph` object: `getClosestGlyphInfoForOffset`, and `getGlyphInfoAt`, which each return an object of the new type `GlyphInfo`. Check out the documentation on the new [`GlyphInfo`](https://main-api.flutter.dev/flutter/dart-ui/GlyphInfo-class.html) type.

**GPU tracing**

Under Impeller on Metal (iOS, macOS, Simulator) and on Vulkan-enabled Android devices, the Flutter engine now reports GPU times for each frame in the timeline in debug and profile builds. GPU frame timing can be inspected in DevTools under the “GPUTracer” heading.

<DashImage figure src="images/0m3qW6u7Q4mNfTKxN.webp" />


Please note that since non-Vulkan Android devices might misreport their support for querying GPU timing, Impeller’s GPU tracing can only be enabled with a flag set in the `AndroidManifest.xml` file on these devices.

```dart
<meta-data
  android:name="io.flutter.embedding.android.EnableOpenGLGPUTracing"
  android:value="true" />
```


### Performance optimizations

**Specialization constants**

The team added [support for specialization constants](https://github.com/flutter/flutter/issues/119357) to Impeller. Taking advantage of this feature in Impeller’s shaders reduced uncompressed binary size of the Flutter engine by [nearly 350KB](https://flutter-flutter-perf.skia.org/e/?begin=1698877815&end=1702074996&queries=test%3Dhello_world_ios__compile&requestType=0&selected=commit%3D37892%26name%3D%252Carch%253Darm%252Cbranch%253Dmaster%252Cconfig%253Ddefault%252Cdevice_type%253DiPhone_11%252Cdevice_version%253Dnone%252Chost_type%253Dmac%252Csub_result%253Dflutter_framework_uncompressed_bytes%252Ctest%253Dhello_world_ios__compile%252C).

**Backdrop filter speedups**

There is much more work to do, however this release includes a couple of nice performance improvements for backdrop filters and blurs on Impeller. In particular, open source contributor [@knopp](https://github.com/knopp) [noticed](https://github.com/flutter/flutter/issues/131567#issuecomment-1678210475) that Impeller was mistakenly requesting the capability to read from the onscreen texture. [Removing this capability](https://github.com/flutter/engine/pull/47808) improved scenes that include multiple backdrop filters anywhere from 20–70% in our benchmarks, depending on complexity.

Further, Impeller [no longer unconditionally stores the stencil buffer](https://github.com/flutter/engine/pull/47397) on every backdrop filter. Instead, any clip affecting operations are recorded, and replayed into a new stencil buffer when restoring the save layer for the backdrop filter.

<DashImage figure src="images/06Of__x8KILe6U5Si.webp" />


With this change, our benchmark of animated advanced blend modes on a Pixel 7 Pro running Impeller with the Vulkan backend improved average GPU frame times from 55ms to 16ms, and improved 90%-ile raster thread CPU times from around 110ms down to 22ms.

## Android

### Deeplinking web validator

We have learned from developers that deep linking (taking users from a web URL to a specific page in a mobile app) has always been difficult to implement, and also error prone. So we first created a validation tool to help developers understand what links are incorrectly configured, and provide implementation guidance. We are very happy to share that an early version of the Flutter deeplink validator is now available!

In this early version, the Flutter deep link validator supports web check on Android, which means validating the setup of your `assetlinks.json` file. You can open DevTools, click into the **Deep Links** tab, and import a Flutter project that contains deeplinks. The deeplinking validator tells you if your web file is configured correctly. You can refer to the deep link validation tool [testing instructions](https://docs.google.com/document/d/1fnWe8EpZleMtSmP0rFm2iulqS3-gA86z8u9IsnXjJak/edit?tab=t.0) for more information.

We hope this tool is the first step to simplify your deep linking implementation journey. We will continue to work on providing future support for web check on iOS, and app check on both iOS and Android!

<DashImage figure src="images/01YoGEcLgpaFythel.webp" />


### Support for Share.invoke

The default **Share** button on text fields and views was previously missing from Android, but we’ve added it in this release as part of our ongoing effort to ensure all the default context menu buttons are available on each platform. You can follow that ongoing work in [PR #107578](https://github.com/flutter/flutter/issues/107578).

### Native assets feature

If you’re interested in the interoperability of Flutter with functions from other languages in your Flutter code, you can now perform FFI calls through Native assets on Android as part of our [ongoing work](https://github.com/flutter/flutter/issues/129757) towards supporting Native assets.

### Texture Layer Hybrid Composition (TLHC) mode

Flutter 3.19 includes work that now makes Google Maps and the text input magnifier work in TLHC mode, which means better performance for your apps. If you’re using Google Maps, we encourage you to test out the changes and let us know your feedback!

This work doesn’t include commits under the Framework or Engine, but you can see the work in [PR 5408](https://github.com/flutter/packages/pull/5408), along with the steps to test the THLC.

### Custom system-wide text selection toolbar buttons

Android apps can add custom text selection menu items that appear in all text selection menus (the menu that appears when you long-press on text). Flutter’s `TextField` selection menu now incorporates those items.

## iOS

### Flutter iOS native fonts

Flutter text now looks a little more compact and a little more native on iOS. According to the Apple design guidelines, smaller fonts on iOS should be more spread out in order to be easier to read on mobile, while larger fonts should be more compact to not take up as much space. Before, we were incorrectly using the smaller, more spaced out font in all cases. Now, by default Flutter will use the compact font for larger text.

<DashImage figure src="images/0q9BjqFkxrFRfx9eP.webp" />


## DevTools

### DevTools updates

Some highlights for DevTools with this release are:

* Added a new feature and screen in DevTools to validate deeplinks setup on Android.

* Added an option in the **Enhance Tracing** menu for tracking platform channel activity. This is useful for apps with plugins.

<DashImage figure src="images/0zDY2wXaCTMankTTb.webp" />


* The Performance and CPU profiler screens are now made available when there is no connected app. Performance data or CPU profiles that were previously saved from DevTools can be reloaded for viewing from these screens.

* The Flutter Sidebar in VS Code now has the ability to enable new platforms if not enabled for the current project, and the DevTools menu in the sidebar now has an option to open DevTools in an external browser window.

To learn more, check out the release notes for DevTools, [2.29.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.29.0), [2.30.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.30.0), and [2.31.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.31.0).

## Desktop

### Windows Arm64 support

Flutter on Windows is now embracing initial support for the Arm64 architecture, thanks to the commendable efforts of community member [@pbo-linaro](https://github.com/pbo-linaro). This initial support paves the way for more efficient and performant Flutter applications that run natively on Windows Arm64 devices. Although still in development, with progress trackable on GitHub issue [#62597](https://github.com/flutter/flutter/issues/62597), this move signifies a promising enhancement for Flutter developers aiming to optimize their apps for a broader range of Windows devices.

## Ecosystem

### Required reason privacy manifest

Flutter now includes a privacy manifest on iOS to meet [upcoming Apple requirements](https://developer.apple.com/support/third-party-SDK-requirements/).

### Progress of the Flutter and Dart package ecosystem

In case you missed it, check out the blogpost from January on the [progress of the Flutter and Dart package ecosystem](https://medium.com/flutter/progress-of-the-flutter-package-ecosystem-17cded9a0703).

## Deprecations and breaking changes

### Dropping Windows 7 and 8 support

As Flutter evolves, we’re excited to focus on the latest technologies by ending support for Windows 7 and 8 with Dart 3.3 and Flutter 3.19 releases. This shift, in line with Microsoft’s strategy, allows us to enhance Flutter on modern operating systems. We appreciate the adjustments required from our developers and are committed to assisting you through this transition. This move paves the way for a more secure, efficient, and feature-rich development environment on supported versions of Windows. Thank you for your understanding and adaptability as we continue to innovate together in the Flutter ecosystem.

### Impeller dithering flag

As noted in the release notes for the 3.16 stable release, the global flag `Paint.enableDithering` has been [removed](https://github.com/flutter/engine/pull/46745). See the [breaking change announcement](https://docs.flutter.dev/release/breaking-changes/paint-enableDithering) on the website for full details.

### Deprecate iOS 11

Due to a [runtime crash](https://github.com/flutter/flutter/issues/136060) when certain networking APIs were called, Flutter no longer supports iOS 11. This means that apps built against Flutter 3.16.6 and later won’t run on those devices.

### Deprecate auto render mode

[Breaking changes](https://docs.flutter.dev/release/breaking-changes) in this release include deprecated APIs that expired after the release of v3.16. To see all affected APIs, along with additional context and migration guidance, see the [deprecation guide for this release](https://docs.flutter.dev/release/breaking-changes/3-16-deprecations). Many of these deprecations are supported by [Flutter fix](https://docs.flutter.dev/development/tools/flutter-fix), including quick fixes in the IDE. Bulk fixes can be evaluated and applied with the `dart fix` command line tool.

As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md) — these help us identify these breaking changes. To learn more, check out [Flutter’s breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

This is the first release to adopt the flutter_driver package into the deprecation policy in addition to already supported packages, flutter and flutter_test.

## Conclusion

As we highlighted the remarkable number of contributors at the start of this announcement, we did so with purpose. The evolution of Flutter into the powerful and efficient toolkit it has become is a direct testament to the dedication and hard work of our incredible community. A heartfelt thank you to each and every one of you.

To dive into the specifics of what has been achieved with this release, we invite you to view the [release notes and change log](https://docs.flutter.dev/release/release-notes/release-notes-3.19.0) for a comprehensive list of additions in Flutter 3.19.

Flutter 3.19, alongside [Dart 3.3](https://medium.com/dartlang/new-in-dart-3-3-extension-types-javascript-interop-and-more-325bf2bf6c13), is now available on the stable channel. Embarking on this latest journey with Flutter is as straightforward as running flutter upgrade.
