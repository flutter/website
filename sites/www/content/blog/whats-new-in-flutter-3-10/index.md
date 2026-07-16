---
title: "What’s new in Flutter 3.10"
description: "Seamless web and mobile integration, breakthrough graphics performance via Impeller in stable, and more"
publishDate: 2023-05-10
author: itsjustkevin
image: images/1CPv57Dp1cYXPz-YtZ2jMcA.webp
category: release
layout: blog
---

Welcome to Flutter 3.10! We can’t wait to show off the huge efforts of our amazing Flutter community. This Flutter release runs the incredible [Dart 3](https://medium.com/dartlang/announcing-dart-3-53f065a10635) also available *today*!

Flutter 3.10 includes many improvements to web, mobile, graphics, security and so much more. Let’s get down to business!

## Framework

### Material 3

The Material library now matches the latest [Material Design spec](https://m3.material.io/components). Changes include new components and component themes, updated component visuals and more. Developers must “opt in” to these changes using the `useMaterial3` theme flag. *In the next stable release, `useMaterial3` defaults to `true`.*

To opt in to the M3 version of the Material library, set `useMaterial3 : true` in your `MaterialApp` theme. The `flutter create` command adds this to your theme when creating a new app.

To preview these changes, check out the [demo app](https://flutter.github.io/samples/material_3.html). The demo lets you toggle `useMaterial3` on and off.

### ColorScheme.fromImageProvider()

All M3 components configure the default colors of the theme’s `ColorScheme`. The default color scheme uses shades of purple. You can create a custom color scheme either from a single “seed” color or from an image. Try both variations with the demo. Color schemes generated should look good and be accessible.

<DashImage figure src="images/1CPv57Dp1cYXPz-YtZ2jMcA.webp" />


### NavigationBar

This provides an M3 version of `BottomNavigationBar` widget. While [M3](https://m3.material.io/components/navigation-bar/overview) uses different colors, highlighting, and elevation, it works as it did before. To override the default appearance of the `NavigationBars` widget, use the `NavigationBarTheme` widget. Though you don’t need to migrate existing apps to this component, you should use it for new apps.

<DashImage figure src="images/1sApyn1E7o2DqWJx4fG6T8w.webp" />


### NavigationDrawer

This provides an [M3](https://m3.material.io/components/navigation-drawer/overview) destination selection widget based on the Drawer widget. `NavigationDrawer` shows a single-selection list of `NavigationDestinations` widgets. You can include other widgets in this list as well. The `NavigationDrawer` can scroll when needed. To override the default appearance of the `NavigationDrawers` widget, use the `NavigationDrawerTheme` widget.

<DashImage figure src="images/1tSZSZ2DVOT3CzX2OjxTg2Q.webp" />


### SearchBar and SearchAnchor

These components provide predictive text for search queries. When the user enters a search query, the app computes a list of matching responses in a “search view”. The user either selects one or adjusts the query. To override the [M3](https://m3.material.io/components/search/overview) design of these components, use the `SearchBarTheme` and `SearchAnchorTheme` widgets.

<DashImage figure src="images/1SzGgItEwmTCzwMRTgnTy5A.webp" />


<DashImage figure src="images/167iesripk2_62VSr5US-Iw.webp" />


### Secondary Tab Bar

M3 allows you to create a second tier of tabbed content. To distinguish this second `TabBar`, use [`TabBar.secondary`](https://m3.material.io/components/tabs/overview#34192702-8a18-4da7-b2cf-d1579632cb96).

<DashImage figure src="images/1Fzkz6aIl-ZIry-vGojaM9w.webp" />


### DatePicker updated for [M3](https://m3.material.io/components/date-pickers/overview)

The M3 `DatePicker` updates the colors, layout, and shape for both the calendar and textfield versions of the widget. This doesn’t change the API, but adds a new `DatePickerTheme`.

<DashImage figure src="images/16cpF7kqYEBCHqv-YswfLhg.gif" />


### TimePicker updated for [M3](https://m3.material.io/components/time-pickers/overview)

The M3 `TimePicker`, like the `DatePicker`, updates the colors, layout, and shapes for both the regular and compact versions of the widget.

<DashImage figure src="images/1jYLsooI9kMMCqibaOgwwFA.gif" />


### BottomSheet updated for [M3](https://m3.material.io/components/bottom-sheets/overview)

Beyond M3 color and shape updates, the bottom sheet now adds an optional drag handle that’s included when you set `showDragHandle` to `true`.

<DashImage figure src="images/1x52LrlHvIpARkrF1RevMeA.webp" />


### ListTile updated for [M3](https://m3.material.io/components/lists/overview)

The M3 `ListTile` updates positioning and spacing of this widget. This includes content padding, leading and trailing widget alignment, minimum leading width, and vertical spacing. The API remains unchanged.

<DashImage figure src="images/154RCRghfN9g3tTXzl0U9ew.gif" />


### Drawer updated for M3

The M3 `Drawer` updates the colors and elevation while making some small layout changes.

## TextField Updates

M3 updates all `TextField` widgets to support native gestures. Double clicking or triple clicking with a mouse work the same as double tapping or triple tapping on a touch device. By default, the `TextField` and `CupertinoTextField` widgets use these features.

### `TextField` double click/tap gestures

* **Double click + drag:** Extends the selection in word blocks.

* **Double tap + drag:** Extends the selection in word blocks.

<DashImage figure src="images/1QFzoK7Gj3Q6uFopP7dOJhw.gif" />


### `TextField` triple click/tap gestures

### Triple click

* Selects a paragraph block at the clicked position when inside of a multi-line `TextField` (Android/Fuchsia/iOS/macOS/Windows).

* Selects a line block at the clicked position when inside of a multi-line `TextField` (Linux).

* Selects all text in a single-line `TextField`.

### Triple tap

* Selects a paragraph block at the clicked position when inside of a multi-line `TextField`.

* Selects all text in a single-line `TextField`.

### Triple click + drag

* Extends the selection in paragraph blocks (Android/Fuchsia/iOS/macOS/Windows).

* Extends the selection in line blocks (Linux).

<DashImage figure src="images/1sqmvK_z8gkQw-eFNur6PIQ.gif" />


## Flutter supports SLSA level 1

Flutter Framework now compiles with Supply Chain Levels for Software Artifacts ([SLSA](https://slsa.dev/)) Level 1. This acknowledges the implementation of many security features including:

* **Scripted build process**. The build scripts for Flutter now allow automated builds on trusted build platforms. Building on protected architecture helps prevent artifact tampering which improves supply chain security.

* **Multi-party approval with audit logging**. Flutter release workflows execute only after multiple engineers approve. All executions create auditable log records. These changes ensure that no one can introduce changes between source code and artifact generation.

* **Provenance**. Beta and stable releases now build with [provenance](https://slsa.dev/provenance/v0.1). This means trusted sources with expected contents built the framework release artifacts. Each release publishes links to view and verify provenance on the [SDK archive](https://docs.flutter.dev/release/archive).

<DashImage figure src="images/1n2OloNCiXMyvmFrLOk_WBw.webp" />


This work also allows the team to advance toward SLSA L2 and L3 compliance. These two levels focus on protecting artifacts during and after the build process.

## Web

### Flutter web apps improved load times

This release reduces the file size of icon fonts. It pruned unused glyphs from both Material and Cupertino.

### CanvasKit reduced size for all browsers

Chromium-based browsers can use an even smaller custom CanvasKit “flavor”. The hosted CanvasKit serves from Google’s industry-leading CDN. This should improve performance further.

### Element embedding

You can now [serve Flutter web apps from a specific element in a page](https://docs.flutter.dev/deployment/web#embedding-a-flutter-app-into-an-html-page). Before this release, your apps could either fill the entire page body or display within an `iframe` tag. [Sample code](https://github.com/flutter/samples/tree/main/web_embedding) can be found in GitHub.

### Shader support

Web apps can use Flutter’s [fragment shader support](https://docs.flutter.dev/development/ui/advanced/shaders).

## Engine

### Impeller

In the 3.7 stable release, we previewed [Impeller](https://docs.flutter.dev/perf/impeller) on iOS. Since then, we received and addressed a lot of great feedback from users. With over 250 commits to Impeller in this release, we set Impeller as our default renderer on iOS. By default, all apps built for iOS with Flutter 3.10 use Impeller. These iOS apps will have less jank and better consistent performance.

Since the 3.7 release, Impeller on iOS has improved its memory footprint. Impeller uses fewer render passes and intermediate render targets. On newer iPhones, enabling lossy texture compression reduced memory footprint without affecting fidelity. These advances also made a marked improvement in performance on iPads.

<DashImage figure src="images/1m8HdyPAVFESHa3dpiEU41g.webp" />


Consider a complex screen like the “pull quote” screen in the [Wonderous](https://flutter.gskinner.com/wonderous/) app. Together, these improvements cut the memory footprint of those screens almost in half. The reduction in memory usage also gives a modest drop in GPU and CPU load. The Wondrous app may not register that drop in load. Its frames had rendered under budget before, but this change should extend battery life.

Impeller also unlocks the team’s ability to deliver popular feature requests faster. One example results in support for the wider P3 color gamut on iOS. Look elsewhere in this post for a description of that feature.

Community contributions accelerated our progress, in particular GitHub users [ColdPaleLight](https://github.com/ColdPaleLight) and [luckysmg](https://github.com/luckysmg). They authored several Impeller-related patches that improved fidelity and performance.

While Impeller meets the rendering needs of most Flutter apps, you can opt-out of Impeller. If you choose to opt-out, consider [filing an issue on GitHub](https://github.com/flutter/flutter/issues/new/choose) to tell us why. App users may notice that Skia and Impeller render with minor differences. These differences could be bugs, so don’t hesitate to file issues. In a future release, we will remove the legacy Skia renderer for iOS to reduce Flutter’s size.

Progress continues on a Vulkan backend for Impeller. Impeller on Android remains under active development but not ready for preview. We plan to share more about it in the near future.

To follow along with our progress, check out [our GitHub project board](https://github.com/orgs/flutter/projects/21).

## Performance

This release covers more performance improvements and fixes aside from Impeller.

### Eliminating Jank

We want to thank open-source contributor [luckysmg](https://github.com/luckysmg). They discovered they could slash the time to get the next drawable layer from the Metal driver. To get that bonus, you need to set the `FlutterViews` background color to a non-nil value. This change eliminates low frame rates on recent iOS 120Hz displays. In some cases, it *triples* the frame rate. This helped us close over half a dozen GitHub issues. This change held such significance that we backported a hotfix into the 3.7 release.

In the 3.7 stable release, we shifted loading of local images from the platform thread to the Dart thread to avoid delaying vsync events from the platform thread. However, [users](https://github.com/flutter/flutter/issues/121525) [noticed](https://github.com/flutter/flutter/issues/121351) that this additional work on the Dart thread also caused some jank. In this release, we moved the opening and decoding of local images from the Dart thread to a [background thread](https://github.com/flutter/engine/pull/39918). This change eliminates potential long pauses on screens with a lot of local images, while avoiding delaying vsync events. In our local testing and automated benchmarks, this change cut the load time for several simultaneous images in half.

<DashImage figure src="images/1LyQyiGe8oQrQkQByS1PK5Q.webp" />


We continue to build optimizations on top of Flutter’s new internal DisplayList structure. In this release, we added an [R-Tree based culling](https://github.com/flutter/engine/pull/38429) mechanism. This mechanism removes the processing of drawing operations much earlier in our renderer. This optimization accelerates, [for example](https://github.com/flutter/flutter/issues/92366), a custom painter whose output fails offscreen. Our [microbenchmarks](https://flutter-engine-perf.skia.org/e/?begin=1671661938&end=1671754421&keys=X789f7ff76f30f8ccc672464f335fe09b&num_commits=50&request_type=1&xbaroffset=31974) showed a decreased DisplayList processing time of up to 50%. Apps with clipped custom paints could see differing improvements. The degree of improvement depends on the complexity and number of hidden draw operations.

### Reducing iOS startup latency

An [inefficient strategy](https://github.com/flutter/flutter/issues/37826) for identifier lookups in app bundles increased app startup latency. This startup latency grows in proportion to the app’s size. In this release, [we fixed the bundle identifier lookup](https://github.com/flutter/engine/pull/39975). This reduced startup latency by 100ms or about 30–50% in a large production application.

### Reducing Size

Flutter uses `SkParagraph` as the default library for text shaping, layout, and rendering. We included a flag to fall back on the legacy `libtxt` and `minikin` libraries. As we have full confidence in `SkParagraph`, [we removed](https://github.com/flutter/engine/pull/39499) `libtxt` and `minikin` and their flag in this release. This reduces Flutter’s compressed size by 30KB.

### Stability

In the 3.0 release, we enabled an Android feature late in our rendering pipeline. This Android feature used advanced GPU driver features. These driver features repaint less of the screen when only one “dirty” region changes. We added this to earlier optimizations to our graphics pipeline with similar effects. Though our benchmarks results encouraged us, two issues surfaced. First, the most improved benchmark might not represent practical use cases. Second, the set of devices and Android versions that supported this GPU driver feature proved [hard to find](https://github.com/flutter/engine/pull/37493). Given the limited advances and support, we [disabled](https://github.com/flutter/engine/pull/40898) the partial repaint feature on Android.

The feature remains enabled on iOS when using the Skia backend. We expect to [enable it with Impeller](https://github.com/flutter/flutter/issues/124526) in a future release.

## API Improvements

### APNG Decoder

Flutter 3.10 addresses one of our most [promoted issues](https://github.com/flutter/flutter/issues/37247). It [adds the ability](https://github.com/flutter/engine/pull/31098) to decode `APNG` images. You can load `APNG` images with Flutter’s existing image loading APIs.

### Image loading API improvements

Flutter’s esteemed Director of Engineering [tvolkert](https://github.com/tvolkert) has landed improvements to `dart:ui`’s image loading APIs. We have added a [new method](https://master-api.flutter.dev/flutter/dart-ui/instantiateImageCodecWithSize.html) `instantiateImageCodecWithSize`. This supports the [use case](https://github.com/flutter/flutter/issues/118543) of loading an image that meets these three conditions:

* an aspect ratio unknown at load time

* a bounding box constraint

* an original aspect ratio constraint

An example would be when an app tries to display one image from a pool of possibilities loaded from the network.

## Mobile

## iOS

### Wireless debugging

You can now run and hot reload your Flutter iOS apps without a cable! After a successful wireless pairing of your iOS device in Xcode, you can deploy your app to that device using flutter run. If you encounter issues, verify the network icon appears next to your device under **Window &gt; Devices** and **Simulators &gt; Devices**. To learn more, check out our [documentation](https://docs.flutter.dev/get-started/install/macos#ios-setup).

### Wide gamut image support

Flutter apps on iOS can now support accurate rendering for wide gamut images. To use wide gamut support, the app must use Impeller and add the [`FLTEnableWideGamut`](https://github.com/flutter/flutter/blob/a463bb82c413af319c8b715deedd7f2c345becd6/dev/integration_tests/wide_gamut_test/ios/Runner/Info.plist#L52) flag in the `Info.plist` file.

### Spellcheck support

The `SpellCheckConfiguration()` widget now defaults to supporting [Apple’s spell check service](https://developer.apple.com/documentation/uikit/uitextchecker) on iOS. To use this widget, set it using the `spellCheckConfiguration` parameter in `CupertinoTextField`.

<DashImage figure src="images/14ibBYWIZH1FhDIpaw0BDFg.webp" />


### Adaptive checkbox and radio

This release adds the `CupertinoCheckBox` and `CupertinoRadio` widgets to the `Cupertino` library. They create checkbox and radio button components that match Apple’s styling.

The Material checkbox and radio widgets added the `.adaptive` constructors. On iOS and macOS, these constructors use the corresponding Cupertino widgets. On other platforms, they use Material widgets.

### Refining Cupertino animations, transitions and colors

Flutter 3.10 improved some animations, transitions, and colors to match SwiftUI. These improvements include:

* [Updating](https://github.com/flutter/flutter/pull/122275) the `CupertinoPageRoute` transition

* [Adding](https://github.com/flutter/flutter/pull/110127) a title magnification animation to `CupertinoSliverNavigationBar`

* Adding several [new iOS system colors](https://github.com/flutter/flutter/pull/118971) to `CupertinoColors`

<DashImage figure src="images/180sFA4-LrCTojCDvUJ9j2w.webp" />


### PlatformView performance

When `PlatformViews` appear on screen, Flutter [throttles the refresh rate](https://github.com/flutter/engine/pull/39172) on iOS to reduce jank. App users will notice this when the app displays animated or scrollable `PlatformViews`.

### macOS and iOS can use shared code in plugins

Flutter now supports the [`sharedDarwinSource`](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#shared-ios-and-macos-implementations) key in the `pubspec.yaml` file for plugins. This key indicates that Flutter should share iOS and macOS code.

```yaml
ios:
  pluginClass: PathProviderPlugin
  dartPluginClass: PathProviderFoundation
  sharedDarwinSource: true
macos:
  pluginClass: PathProviderPlugin
  dartPluginClass: PathProviderFoundation
  sharedDarwinSource: true
```


### New resources for app extensions

We added [documentation](https://docs.flutter.dev/development/platform-integration/ios/app-extensions) for Flutter developers to use iOS app extensions. These extensions include live activities, home screen widgets, and share extensions.

To simplify creating home screen widgets and sharing data, we added new methods to the [`path_provider`](https://github.com/flutter/packages/pull/3450) and `homescreen_widget` plugins.

### New resources for cross-platform design

The documentation now includes cross platform design considerations for specific [UI components](https://docs.flutter.dev/resources/platform-adaptations#ui-components). To learn more about each of these UI components, check out the [discussions in the Flutter UX GitHub repository](https://github.com/flutter/uxr/discussions). We appreciate any input or feedback!

## Android

### Android CameraX support

[Camera X](https://developer.android.com/training/camerax), a Jetpack library, simplifies adding rich camera functionality to your Android app. This functionality applies across a wide selection of Android Camera hardware. With this release, we add preliminary support for CameraX to the Flutter Camera plugin. This support covers the following use cases:

* Image Capture

* Video Recording

* Display live camera preview

To give it a try, opt in to using the CameraX implementation. To opt in, add the following line to your `pubspec.yaml` file.

```yaml
dependencies:
  camera: ^0.10.4 # Latest camera version
  camera_android_camerax: ^0.5.0
```


We would love your feedback as we continue to add more CameraX features then make CameraX the default implementation.

## DevTools

We continue to improve DevTools, the suite of performance and debugging tools for Dart and Flutter. Some highlights include:

* The DevTools UI uses Material 3. This both modernizes the look and enhances accessibility.

* The DevTools console supports evaluations for a running app in debug mode. Before this release, you could only do this when you paused an app.

* An embedded [Perfetto trace viewer](https://perfetto.dev/) replaces the previous timeline trace viewer. Perfetto handles larger datasets and performs better than the legacy trace viewer. Perfetto includes more features, such as:
- Allowing you to pin threads of interest.
- Clicking and dragging to select multiple timeline events from multiple frames.
- Using SQL queries to pull specific data from the timeline events.

<DashImage figure src="images/1fOYGagsonbND_VnkasWmzw.webp" />


To learn more, check out the release notes for [DevTools 2.23.1](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.23.1), [DevTools 2.22.2](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.22.2), and [DevTools 2.21.1](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.21.1).

## Deprecations & Breaking Changes

### Deprecated APIs

Breaking changes in this release include deprecated APIs that expired after the release of v3.7. To see all affected APIs, along with additional context and migration guidance, check out [the deprecation guide for this release](https://docs.flutter.dev/release/breaking-changes/3-7-deprecations). [Dart Fix](https://docs.flutter.dev/development/tools/flutter-fix) can remedy many of these issues, including quick fixes in the IDE and bulk apply with the `dart fix` command.

### Android Studio Flamingo upgrade

After you upgrade Android Studio to Flamingo, you might see an error when you try to flutter run or flutter build your Flutter Android apps. This error occurs because Android Studio Flamingo updates its bundled Java SDK from 11 to 17. Gradle versions [earlier than 7.3](https://docs.gradle.org/current/userguide/compatibility.html#java) can’t run when using Java 17. We [updated](https://github.com/flutter/flutter/pull/123916) `flutter analyze --suggestions` to validate if this error occurs due to incompatibility between your Java SDK and your Gradle version.

To learn different ways to fix this error, check out [our migration guide](https://docs.flutter.dev/go/android-java-gradle-error).

### Window singleton deprecation

This release deprecates the window singleton. Apps and libraries relying on it should [migrate](https://docs.flutter.dev/release/breaking-changes/window-singleton) away from it. This prepares your app for multi-window support when it launches in a future version of Flutter.

## Thanks to the community

As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md), they help us identify these breaking changes. To learn more, check out [our breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

## Wrapping it up

As we wrap up this release, the Flutter team at Google wants to thank all the contributors who have made this release possible. Your dedication and hard work have helped to make Flutter a game-changer in the industry and continue to revolutionize application development. We encourage you to start exploring this latest stable version of Flutter to take advantage of all the amazing features it has to offer. To do so, just `flutter upgrade`! Stay tuned for more exciting updates from Flutter in the future.
