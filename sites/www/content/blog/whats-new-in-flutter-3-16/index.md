---
title: "What’s new in Flutter 3.16"
description: "Material 3 by default, Impeller preview for Android, DevTools extensions, and much more"
publishDate: 2023-11-15
author: itsjustkevin
image: images/1TDndNB8cS95g5faXBKitHA.webp
category: release
layout: blog
---

<DashImage figure src="images/1TDndNB8cS95g5faXBKitHA.webp" />


## What’s new in Flutter 3.16

### Material 3 by default, Impeller preview for Android, DevTools extensions, and much more

Welcome back to the quarterly Flutter stable release, this time for Flutter 3.16. This release sets Material 3 as the new default theme, brings a preview of Impeller to Android, allows adding extensions for DevTools, and much more! It also coincides with [significant updates to the Flutter Casual Games Toolkit](https://medium.com/flutter/building-your-next-casual-game-with-flutter-716ef457e440)!

In only three months since our last release, we’ve had 928 pull requests merged by 145 community members with 40 community members authoring their first commit to Flutter!

Keep reading to learn about all the new additions and improvements the Flutter community has contributed to this latest release!

## Framework

### Material 3 is the new default

As of the 3.10 release (May 2023) the Material library has been updated to match the latest Material Design spec. Changes include new components and component themes, and updated component visuals. Prior to the 3.16 release, the changes were “opt-in” with the `useMaterial3` theme flag. As of this release, `useMaterial3` is true by default. ([#130764](https://github.com/flutter/flutter/pull/130764))

You can still opt out of the M3 version of the Material library by specifying `useMaterial3: false` in your `MaterialApp` theme, but Material 2 will eventually be deprecated and removed. Also, some of the widgets couldn’t merely be updated, but needed a whole new implementation. For this reason, your UI might look a little strange when you see it running as Material 3. To fix this, manually migrate to the new widgets, such as [NavigationBar](https://api.flutter.dev/flutter/material/NavigationBar-class.html). For more details, check out the [Material 3 umbrella issue](https://github.com/flutter/flutter/issues/91605) on GitHub.

A [demo application](https://flutter.github.io/samples/material_3.html) allows you to try all of the components. The demo supports toggling `useMaterial3` so that you can compare the changes.

The appearance of Material 3 components are primarily determined by the values for [`ThemeData.colorScheme`] and [`ThemeData.textTheme`]. The preferred way to create a Material 3 color scheme is with `ColorScheme.fromSeed()`, which creates dark and light schemes that are both aesthetically pleasing and compliant with the contrast requirements for accessibility. You can also create a color scheme from the dominant colors in an image with `ColorScheme.fromImageProvider`. To further customize the appearance of Material 3 components, add component themes to your `ThemeData`, such as [`ThemeData.segmentedButtonTheme`](https://api.flutter.dev/flutter/material/SegmentedButtonThemeData-class.html) or [`ThemeData.snackBarTheme`](https://api.flutter.dev/flutter/material/SnackBarThemeData-class.html). Non-null component theme properties override the defaults specified in the component’s API documentation.

<DashImage figure src="images/0LMOV8BTSB4tEIisF.webp" />


### Support Material 3 motion

Improvements to Material 3 motion includes the addition of `Easing` and `Durations` classes. Material 2 curves have been renamed to include the word “legacy” and will eventually be deprecated and removed. ([#129942](https://github.com/flutter/flutter/pull/129942))

### Add additional options in edit menu

On native iOS, users can now select text and initiate a share menu that provides several standard services. In this release, we’ve added the look up, search, and share options.

<DashImage figure src="images/0YKZc4cxJjsafHgd4.webp" />


### TextScaler for specifying a global text scale factor

To support Android 14’s [non-linear font scaling feature](https://blog.google/products/android/android-14/#:~:text=Also%2C%20you%20can%20improve%20readability,rate%20than%20smaller%20font%20size.) that helps those who are visually impaired, the new [`TextScaler`](https://api.flutter.dev/flutter/painting/TextScaler-class.html) class replaces the `Text.textScaleFactor` property. ([#128522](https://github.com/flutter/flutter/pull/128522))

### SelectionArea updates

Flutter’s `SelectionArea` is updated to support native gestures associated with a single or double click using a mouse, and long pressing on a touch device. These new gestures are available by default with `SelectionArea` and `SelectableRegion`.

* Single click: Sets the collapsed selection at the clicked position.

* Double click: Select the word at the clicked position.

* Double click + drag: Extends the selection in word blocks.

<DashImage figure src="images/04RDi6tkvHa3R2uqa.gif" />


* Long press + drag: Extends the selection in word blocks.

<DashImage figure src="images/0Xhow360Xn88KLAWF.webp" />


### Menu items that operate on the focused widget

This release features cleanup of focus changes when using menu items: The `FocusManager`’s `applyFocusChangesIfNeeded` function now restores menu focus — when the user clicks a menu item, focus will already have returned to the item that had focus before the menu was opened. ([#130536](https://github.com/flutter/flutter/pull/130536))

### Automatic reordering of menu item shortcuts for iOS, macOS

Flutter apps on Mac platforms now order the shortcut modifiers in menus to follow Apple Human Interface Guidelines. ([#129309](https://github.com/flutter/flutter/pull/129309))

<DashImage figure src="images/0b1mnWiuWv-cxt7g7.webp" alt="Before" caption="Before" />


<DashImage figure src="images/0LbHdBtWltdB4_Kcf.webp" alt="After" caption="After" />


### MatrixTransition animation

A new `MatrixTransition` widget allows transforms when creating animated transitions. Based on the current animation value, you can provide a matrix transformation that is applied to the child widget to create effects like the one in the following GIF. ([Example in DartPad](https://dartpad.dev/?channel=beta&id=c82be58209035722f2cc7d78da855329)) ([#131084](https://github.com/flutter/flutter/pull/131084))

### PaintPattern added to flutter_test

In the `flutter_test` package, the new `PaintPattern` class allows you to validate paint calls made to the canvas by widgets like `CustomPainter`s and `Decoration`s (used in unit tests).

Previously, a golden file was needed to verify that the correct color and rect were painted, but you can now use `PaintPattern`. The following example verifies that `MyWidget` painted a circle on the canvas:

```dart
expect(
  find.byType(MyWidget),
  paints
    ..circle(
      x: 10,
      y: 10,
      radius: 20,
      color: const Color(0xFFF44336),
    ),
);
// Multiple paint calls can even be chained together.
expect(
  find.byType(MyWidget),
  paints
    ..circle(
      x: 10,
      y: 10,
      radius: 20,
      color: const Color(0xFFF44336),
    ),
    ..image(
      image: MyImage,
      x: 20,
      y: 20,
    ),
);
```


This API previously existed deep in the framework test files, and we noticed some developers found it so useful, they had copied it into their own projects. If this applies to you, you can delete the copy from your project after upgrading to Flutter 3.16.

### Scrolling updates

After the initial release of the two dimensional scrolling foundation in Flutter 3.13, this release brings more features and polish. With Flutter 3.16, the 2D foundation now supports `KeepAlive` widgets, as well as default focus traversal and implicit scrolling. 2D scrolling widgets built on top of the foundation will automatically adopt this support. For a comprehensive guide on building on the 2D foundation, see [the latest episode of the Flutter Build Show](https://www.youtube.com/watch?v=ppEdTo-VGcg).

Soon after the 3.13 release, the [two_dimensional_scrollables](https://pub.dev/packages/two_dimensional_scrollables) package was published. This package is maintained by the Flutter team, and contains the first of several 2D scrolling widgets built on the framework’s foundation — `TableView`. Since the initial release, more decoration and styling support has been added with additional bug fixes.

## Engine

### Impeller

### Android

In this release, we are pleased to share that Impeller on Android is ready for preview feedback on the stable channel. Since early this year, the team has been hard at work on a Vulkan backend for Impeller, and this preview includes gathering feedback about Impeller’s characteristics on Vulkan-capable devices.

<DashImage figure src="images/0wyMXhtcLW98BTKl-.webp" alt="*This chart shows improvements over the past year in 99%-ile, 90%-ile, and average frame rasterization times on the Flutter Gallery transition performance benchmark running on Impeller’s Vulkan backend, which users will observe as both less jank and higher steady state framerates. Towards the end of this period, we switched from Samsung S10 devices to Pixel 7 Pro devices, which accounts for a substantial drop in the numbers. Nevertheless, we find the trend and overall results to be very encouraging.*" caption="*This chart shows improvements over the past year in 99%-ile, 90%-ile, and average frame rasterization times on the Flutter Gallery transition performance benchmark running on Impeller’s Vulkan backend, which users will observe as both less jank and higher steady state framerates. Towards the end of this period, we switched from Samsung S10 devices to Pixel 7 Pro devices, which accounts for a substantial drop in the numbers. Nevertheless, we find the trend and overall results to be very encouraging.*" />


Impeller isn’t yet expected to perform well on devices without Vulkan support. As we bring Impeller’s OpenGL backend up to feature completeness in the coming months, we plan to also seek feedback about Impeller’s characteristics on such devices in a future stable release.

Flutter developers can try out Impeller on Vulkan-capable Android devices by passing the `— enable-impeller` flag to `flutter run`, or by adding the following setting to their project’s `AndroidManifest.xml` file under the `<application>` tag:

```xml
<meta-data
  android:name="io.flutter.embedding.android.EnableImpeller"
  android:value="true" />
```


To determine whether a device supports Vulkan, Impeller uses the tests discussed in the [Impeller repo docs](https://github.com/flutter/engine/blob/main/impeller/docs/android.md#rendering-backend-selection). Generally, Impeller uses the Vulkan backend on devices running a 64-bit OS at Android API level 29 or newer. Users can also determine whether their device supports Vulkan by following the advice in [checking for Vulkan support](https://docs.vulkan.org/guide/latest/checking_for_support.html#_android).

While confident in the progress we’ve made on Impeller’s Vulkan backend so far, there are a few known issues going into the preview period:

* Platform views aren’t yet implemented, and frames that would otherwise include a platform view perform somewhat poorly.

* Custom shaders are not yet implemented.

* For the full list of [known bugs](https://github.com/orgs/flutter/projects/21/views/1?filterQuery=-status%3A%22%E2%9C%85+Done%22+status%3A%22%F0%9F%90%9E+Bugs%22) and [missing features](https://github.com/orgs/flutter/projects/21/views/11), the most up-to-date information is on the Impeller [project board](https://github.com/orgs/flutter/projects/21) on GitHub. Many issues already have fixes coming in the 3.17 beta, so please give it a try as well.

We are generally happy with our progress on Impeller’s fidelity and performance on the Vulkan capable Android devices that we’ve tried. However, compared with iOS, the Android hardware ecosystem is much more diverse, and we anticipate a longer preview period for Android than for iOS before making it the default backend on the stable channel. For that reason, the most helpful feedback about Impeller should include detailed information about the specific device and Android version where issues occurred.

Further, Impeller’s Vulkan backend enables additional debugging capabilities in “debug” builds beyond what is used with Skia, and these capabilities have additional runtime overhead. Therefore it’s important that feedback about Impeller’s performance is from a profile or release build, and should include timelines from DevTools and a comparison with the Skia backend on the same device. Finally, as always, we are very grateful for feedback that includes a small reproducible test case that demonstrates the issue.

### Impeller performance, fidelity, and stability

In addition to the focus on the Vulkan backend, since the beginning of the year, the team has also made a number of improvements to text performance in Impeller that benefit both Android and iOS. In particular, we have made improvements to the management of Impeller’s glyph atlas and the way that text workloads are divided across the Engine’s UI and raster threads. As a result, users will notice less jank in text heavy workloads.

<DashImage figure src="images/0RPu62U3N57JJqu0b.webp" alt="*This chart shows a decrease in 99%-ile, 90%-ile, and average frame rasterization times in milliseconds in one of our text-heavy benchmarks on an iPhone 11 using Impeller. In particular, 90%-ile and average frame rasterization times are nearly halved.*" caption="*This chart shows a decrease in 99%-ile, 90%-ile, and average frame rasterization times in milliseconds in one of our text-heavy benchmarks on an iPhone 11 using Impeller. In particular, 90%-ile and average frame rasterization times are nearly halved.*" />


The team has also been hard at work on fidelity and stability improvements for both Android and iOS, especially those reported by users. In particular, in the three months of this stable release cycle, the team has made 209 Impeller related commits to the flutter/engine repo, closing 217 issues, including 42 user reports of fidelity, stability, or performance issues.

### Engine performance

To support better performance on mobile devices with heterogeneous multiprocessing, we [have modified](https://github.com/flutter/engine/pull/45673) the engine so threads that are performance sensitive, such as the UI and raster threads, have affinity for a device’s more powerful cores. We observed that this change had a positive impact across a range of benchmarks and devices. In some cases the improvement was dramatic, halving or better 99%-ile or 90%-ile frame times. We anticipate that users will notice less jank after this change with both the Skia and Impeller backends on Android. The effect is less dramatic on iOS devices, where there is a smaller difference between the more powerful and less powerful cores.

<DashImage figure src="images/0v9hhy6Y9fhfIbejZ.webp" alt="*This chart shows improvements in worst, 99%-ile, 90%-ile, and average frame build and frame rasterization times across nearly all of our Android benchmarks and devices.*" caption="*This chart shows improvements in worst, 99%-ile, 90%-ile, and average frame build and frame rasterization times across nearly all of our Android benchmarks and devices.*" />


### API and fidelity improvements

### Impeller performance overlay

In previous releases, Flutter’s [performance overlay](https://docs.flutter.dev/perf/ui-performance#the-performance-overlay) feature wasn’t displayed with Impeller. This release fixes that issue. The performance overlay [now displays correctly](https://github.com/flutter/engine/pull/45259) with Impeller enabled.

### Dithering is now displayed correctly

In this release, the `Paint.enableDithering` property is set to true, and is deprecated as per [Flutter’s deprecation policy](https://docs.flutter.dev/release/compatibility-policy#deprecation-policy). Dithering is now enabled by default (developer-configurable dithering is no longer supported), and you will no longer see banding issues. For the full explanation of this change and the migration guide, see [the breaking change page](https://docs.flutter.dev/release/breaking-changes/paint-enableDithering) on docs.flutter.dev.

<DashImage figure src="images/0yoTgJmfOTF1NrHyf.webp" alt="Before" caption="Before" />


<DashImage figure src="images/0cnBlQufEWMXx6AJI.webp" alt="After" caption="After" />


## Games

### Flutter Games Toolkit

Over the past few years, we’ve seen a growing community around casual game development. Tens of thousands of games have been published using Flutter, from simple but fun puzzles to more complex arcade games. Some of our favorites include Etermax’s [Trivia Crack](https://triviacrack.com/), Lotum’s [4 Pics 1 Word](https://flutter.dev/showcase/lotum) (word guess game), Dong Digital’s [Brick Mania](https://play.google.com/store/apps/details?id=net.countrymania.brick&hl=en) (arcade game), Onrizon’s [StopotS](https://play.google.com/store/apps/details?id=com.gartic.StopotS&hl=en) (categories game), the [retro pinball game](https://pinball.flutter.dev/) we built in Flutter for I/O, and [PUBG](https://flutter.dev/showcase/pubg-mobile) mobile who uses Flutter in their social and menu screens.

<DashImage figure src="images/1yWHI-1YwQAFUIVFvr5jGHQ.gif" />


To help game developers become more productive, today Flutter is launching a major update to its [Casual Games Toolkit.](https://flutter.dev) It is a collection of new resources to help you move from concept to launch with more genre-specific templates such as a card game, an endless runner game, and service integrations like Play Games Services, in-app purchase, ads, achievements, crashlytics and multiplayer support. To learn more, check out the [games toolkit launch post](https://medium.com/flutter/building-your-next-casual-game-with-flutter-716ef457e440) by [Zoey Fan](https://medium.com/@zoeyfan_43394).

## Web

### Flutter timeline events on Chrome DevTools

Flutter Timeline events are now exposed in the performance panel of Chrome DevTools. ([#130132](https://github.com/flutter/flutter/issues/130132))

To learn more, check out [Debugging performance for web apps](https://docs.flutter.dev/perf/web-performance).

<DashImage figure src="images/0UDd-ZshZBEIfb4OA.webp" />


## Android

### Mouse scroll wheel support

While optimizing [Wonderous to meet Android’s large screen guidelines](https://medium.com/flutter/developing-flutter-apps-for-large-screens-53b7b0e17f10), one issue we discovered was that the mouse scroll wheel didn’t work well on tablets or foldables. It was [well known](https://github.com/flutter/flutter/issues/82973) that the user had to move the scroll wheel a significant amount for the screen to respond.

With this release, scrolling with a mouse on a flutter view matches the scroll speed on Android devices. ([44724](https://github.com/flutter/engine/pull/44724))

<DashImage figure src="images/0wlSYQiElLRGgOTmO.webp" alt="Before" caption="Before" />


<DashImage figure src="images/0KZki5KYsfeMi01Lw.webp" alt="After" caption="After" />


### Predictive back navigation

The Android 14 release included the predictive back gesture feature that allows you to use the back gesture on your device to “peek” at the home screen behind your current screen. This update brings predictive back gestures to Flutter! Check out the [migration guide](https://docs.flutter.dev/release/breaking-changes/android-predictive-back#migration-guide).

<DashImage figure src="images/0KdmeVMUgmKWzw0-P.webp" />


## iOS

### App extensions

Flutter can now be used to target some [iOS app extensions](https://developer.apple.com/app-extensions/). This means that you can draw the UI for certain types of iOS app extensions using Flutter widgets. This doesn’t work for all types of app extensions because there might be limitations to the API (for example, home screen widgets) or memory.

<DashImage figure src="images/0OxjjAlCbFFXWrrR9.webp" />


Learn more and see an example for how to target the Share extension at [Adding iOS app extensions](https://docs.flutter.dev/platform-integration/ios/app-extensions) on docs.flutter.dev.

## Package ecosystem

### New Flutter Favorites

We have rebooted the [Flutter Favorite](https://docs.flutter.dev/packages-and-plugins/favorites) program! For this cycle, the Flutter Ecosystem Committee designated the [flame](https://pub.dev/packages/flame), [flutter_animate](https://pub.dev/packages/flutter_animate), [flutter_rust_bridge](https://pub.dev/packages/flutter_rust_bridge), [riverpod](https://pub.dev/packages/riverpod), [video_player](https://pub.dev/packages/video_player), [macos_ui](https://pub.dev/packages/macos_ui) and [fpdart](https://pub.dev/packages/fpdart) packages as new Flutter Favorites. Congrats to all!

Look out for new Flutter Favorites in the future. To nominate a package or plugin as a potential future Flutter Favorite, or to bring any other issues to the attention of the committee, send the committee an email at [flutter-committee@googlegroups.com](mailto:flutter-committee@googlegroups.com).

<DashImage figure src="images/0RAkkLR53oDQekLmN.webp" />


### First package ecosystem virtual summit

In August, we held a first-time virtual summit for the package ecosystem, attended by more than 50 non-Googler and Googler contributors to [pub.dev](https://pub.dev). The goal was to bring contributors together in unconference-style discussions to plan, educate, learn, and share amongst the community. Satisfaction with the event was 100% in a post-event survey. We plan to partner with the community on similar events for the package ecosystem (in-person and virtually) in the future. Find out more in an upcoming Package ecosystem update blog post.

### Cloud-based Google Maps styling

Google Maps Platform offers the ability to customize the style of your map from the Map Styles page in the Google Cloud Console. This lets you create a customized experience without having to update your app code each time you make a style change.

<DashImage figure src="images/0b3vDhobD-p7YRw6O.webp" />


To use this feature in Flutter, you simply refer to your map using the Map ID set in the console:

```dart
GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: _kMapCenter,
          zoom: 7.0,
        ),
        key: _key,
        cloudMapId: _mapId
);
```


### Camera X improvements

In the 3.10 stable release, we added preliminary support for Camera X to the Flutter camera plugin. [Camera X](https://developer.android.com/training/camerax) is a Jetpack library that simplifies adding rich camera functionality to your Android app.

With this release, we’ve added most of the features needed by any app that uses a camera. CameraX solves many issues that exist with the Camera 2 implementation of the plugin.

We encourage you to use the CameraX plugin. To opt in, add the following line to your pubspec.yaml file.

```yaml
dependencies:
  camera: ^0.10.4 # Or try the latest camera version
  camera_android_camerax: ^0.5.0
```


We would love your feedback as we plan on making CameraX the default implementation in a future release.

### macOS Video Player

We have added macOS support to the [video player plugin](https://pub.dev/packages/video_player), allowing developers to play videos on a widget surface.

To learn more check out the [video player plugin](https://pub.dev/packages/video_player) on [pub.dev](https://pub.dev).

## DevTools

### DevTools extensions

The new [DevTools extensions framework](https://pub.dev/packages/devtools_extensions) enables:

* package authors to build custom tooling for their package that is surfaced directly in DevTools.

* package authors to write powerful tools that leverage existing frameworks and utilities from DevTools.

* Dart and Flutter developers who are debugging an app with DevTools to get access to tools that are specific to their use cases (as determined by their app’s dependencies and which dependencies provide DevTools extensions).

Thanks to the package authors of [Provider](https://pub.dev/packages/provider), [Drift](https://pub.dev/packages/drift), and [Patrol](https://pub.dev/packages/patrol), this ecosystem is already being built out and you can use the DevTools extensions for those packages today!

<DashImage figure src="images/0gprea_z4l0Y_mizE.webp" alt="Provider" caption="Provider" />


<DashImage figure src="images/0uGcjhY3w8eKoKwLH.webp" alt="Patrol" caption="Patrol" />


<DashImage figure src="images/0PlGmgXXrK7LBpiPR.webp" alt="Drift" caption="Drift" />


For a deep dive into DevTools extensions, check out the [Dart and Flutter DevTools Extensions announcement](https://medium.com/flutter/dart-flutter-devtools-extensions-c8bc1aaf8e5f) by [Kenzie Davisson](https://medium.com/@kenzieschmoll).

### DevTools updates

Some highlights for DevTools with this release are:

* Added support for DevTools extensions

* Added a new “Home” screen that shows a summary of your connected app.

<DashImage figure src="images/01nmVYze1uMCxvzoI.webp" />


Other improvements include:

* Overall performance

* Hot restart robustness

* Text selection and copy behavior

* Network profiler response viewer polish

To learn more, check out the release notes for DevTools [2.26.1](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.26.1), [2.27.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.27.0), and [2.28.1](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.28.1).

### VS Code UI discoverability

Thanks to the amazing work by Flutter community member [DanTup](https://github.com/DanTup), the Flutter VS Code extension now has a Flutter Sidebar that gives you easy access to:

* Open Flutter DevTools screens

* View active debug sessions

* View available devices

* Create new projects

* Hot reload and restart

* Run Flutter Doctor -v

* Much more

<DashImage figure src="images/0FXlCMB0adYkH2y4u.jpg" />


## Deprecations and breaking changes

### Deprecations and breaking changes

Breaking changes in this release include deprecated APIs that expired after the release of v3.13. To see all affected APIs, along with additional context and migration guidance, see [the deprecation guide for this release](https://docs.flutter.dev/release/breaking-changes/3-13-deprecations). Many of these are supported by [Flutter fix](https://docs.flutter.dev/development/tools/flutter-fix), including quick fixes in the IDE. Bulk fixes can be evaluated and applied with the `dart fix` command.

As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md) — these help us identify these breaking changes. To learn more, check out [Flutter’s breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

In our next release, we will be planning to extend the deprecation policy to cover the `flutter_driver` package in addition to already supported packages, `flutter` and `flutter_test`.

## Conclusion

We called out the number of contributors at the beginning of this announcement, this is with intention. Flutter would not be the delightful and productive toolkit that it is today without the efforts of you all — our amazing community. Thank you.

For a full list of PRs that were included in this release, check out the [release notes and change log](https://docs.flutter.dev/release/release-notes).

Flutter 3.16 is available on the stable channel today, and includes [Dart 3.2](https://medium.com/dartlang/dart-3-2-c8de8fe1b91f). To get started with these newest updates, all it takes is a [`flutter upgrade`](https://docs.flutter.dev/release/upgrade).

See you all again soon!
