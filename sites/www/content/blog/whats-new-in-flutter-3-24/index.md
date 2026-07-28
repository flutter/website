---
title: "What’s new in Flutter 3.24"
description: >-
  Unleashing Flutter GPU, Multi-View Embedding, and More
publishDate: 2024-08-06
author: itsjustkevin
image: images/0bdcb6KGonosfPZ6m.webp
category: release
layout: blog
---

<DashImage figure src="images/1EA-cAY6uwkYqYb725vnCIw.webp" alt="Flutter 3.24 on a blue background" caption="Flutter 3.24 on a blue background" />

Welcome to the latest Flutter update! Flutter 3.24 is packed with exciting new features and enhancements to elevate your app development experience. This release highlights the preview of Flutter GPU, which enables advanced graphics and 3D scenes directly in Flutter. Web apps can now embed multiple Flutter views, enhancing your app’s versatility. And finally, we’ve added video ad monetization support to help you maximize revenue.

In the past few months, the Flutter community has been incredibly active, with 852 framework commits and 615 engine commits. We’re excited to welcome 49 new contributors who have helped make this release possible. Your dedication and passion are what drive Flutter forward.

So, dive in and discover all the new features and enhancements that the Flutter community has brought to this latest release!

## Flutter Framework

### New Slivers

This release adds new slivers that can be composed together for dynamic app bar behaviors:

* [PinnedHeaderSliver](https://api.flutter.dev/flutter/widgets/PinnedHeaderSliver-class.html)

* [SliverResizingHeader](https://api.flutter.dev/flutter/widgets/SliverResizingHeader-class.html)

You can use these new slivers to make headers that float, stay pinned, or resize as the user scrolls. These new slivers are similar to the existing [`SliverPersistentHeader`](https://api.flutter.dev/flutter/widgets/SliverPersistentHeader-class.html) and [`SliverAppBar`](https://api.flutter.dev/flutter/material/SliverAppBar-class.html) slivers, but have simpler APIs that can be combined for greater effect.

These new slivers come with new sample code. For example, `PinnedHeaderSliver`’s API documentation has an example that recreates effects like the iOS Settings app’s app bar:

<DashImage figure src="images/0bdcb6KGonosfPZ6m.webp" />

### Updates in the Cupertino library

In this release, we’ve improved the fidelity of [`CupertinoActionSheet`](https://api.flutter.dev/flutter/cupertino/CupertinoActionSheet-class.html). Sliding your finger across the action sheet’s buttons now provides haptic feedback. The buttons’ font size and weight now match their native counterparts.

<DashImage figure src="images/0_o_9V0RlITOZdU4v.webp" />

We’ve also added new focus properties to [`CupertinoButton`](https://api.flutter.dev/flutter/cupertino/CupertinoButton-class.html), and you can now customize the color of a disabled [`CupertinoTextField`](https://api.flutter.dev/flutter/cupertino/CupertinoTextField-class.html).

A refresh of the Cupertino library is underway, expect more updates in future releases!

### TreeView

The [`two_dimensional_scrollables`](https://pub.dev/packages/two_dimensional_scrollables) package released the [`TreeView`](https://pub.dev/documentation/two_dimensional_scrollables/latest/two_dimensional_scrollables/TreeView-class.html) widget, alongside several companion classes for building performant scrolling trees that can scroll in all directions as the tree grows. The sample app included in the package was also updated with several new examples of using the [`TableView`](https://pub.dev/documentation/two_dimensional_scrollables/latest/two_dimensional_scrollables/TableView-class.html) and [`TreeView`](https://pub.dev/documentation/two_dimensional_scrollables/latest/two_dimensional_scrollables/TreeView-class.html) widgets.

<DashImage figure src="images/0wcmJCv-6owwsolRl.webp" />

[`TreeSliver`](https://api.flutter.dev/flutter/widgets/TreeSliver-class.html) was also added to the framework for building trees in one dimensional scrolling. The `TreeView` and `TreeSliver` APIs match, making it easy to switch between the one that is right for your use case.

### CarouselView

This release included the [Material Design carousel](https://m3.material.io/components/carousel/overview) widget: `CarouselView`. The `CarouselView` presents the “[Uncontained](https://m3.material.io/components/carousel/specs#477de3a1-c9df-4742-baf3-bcd5eeb3764c)” layout: a scrollable list of items that scroll to the edge of the container, and the leading and the trailing items can dynamically change size when they are scrolling out of the view and scrolling in the view.

<DashImage figure src="images/16ytqSvtR2TJzAE6LntHTGw.webp" />

### More functionality available from widgets

This release contains some of the work to relocate core widget logic, that isn’t design specific, out of the Material library and into the Widgets library for more general use. This includes:

* The [`Feedback`](https://github.com/flutter/flutter/pull/148523) widget, which provides easy access to haptic and audio feedback from the device in response to gestures like tap, long press, and more.

* [`ToggleableStateMixin` and `ToggleablePainter`](https://github.com/flutter/flutter/pull/148272), base classes for building toggle widgets like checkboxes, switches, and radio buttons.

### Enhanced enum features for AnimationStatus

In a fantastic [contribution](https://github.com/flutter/flutter/pull/147801) from community member [@nate-thegrate](https://github.com/nate-thegrate), enhanced enum features were added to [AnimationStatus](https://api.flutter.dev/flutter/animation/AnimationStatus.html), including getters:

* isDismissed

* isCompleted

* isRunning

* isForwardOrCompleted

Some of these getters already existed in [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html) subclasses, like [`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html) and [`CurvedAnimation`](https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html). Now all of these status getters are available in Animation subclasses in addition to AnimationStatus. Lastly, a [`toggle`](https://api.flutter.dev/flutter/animation/AnimationController/toggle.html) method was added to AnimationController to switch the direction of the animation.

### Updates in SelectionArea

Flutter’s [`SelectionArea`](https://api.flutter.dev/flutter/material/SelectionArea-class.html) now supports more native gestures associated with a triple click using a mouse, and double tapping on a touch device. By default, the [`SelectionArea`](https://api.flutter.dev/flutter/material/SelectionArea-class.html) and [`SelectableRegion`](https://api.flutter.dev/flutter/widgets/SelectableRegion-class.html) widgets use these new gestures.

Triple click

* Triple click + drag: Extends the selection in paragraph blocks.

* Triple click: Selects the paragraph block at the clicked position.

<DashImage figure src="images/0_GmbsIKfnwEAW6G8.gif" />

Double tap

* Double tap + drag: extends the selection in word blocks (supported on native Android/Fuchsia/iOS, and iOS web).

* Double tap: selects the word at the tapped position (supported on native Android/Fuchsia/iOS, and Android/Fuchsia web).

<DashImage figure src="images/0DwZgIybQr3FDFxXd.gif" />

## Engine

### Impeller

**Improving Performance and Fidelity**

In anticipation of removing the Impeller opt-out on iOS in a stable release coming soon, the team has been hard at work on improvements to Impeller’s performance and fidelity. As one example, a long series of improvements to text rendering [greatly increased the performance of emoji scrolling](https://github.com/flutter/flutter/issues/138798), eliminating jank when scrolling a large collection of emojis, which was a fantastic stress test of Impeller’s text rendering capabilities.

Additionally, by [solving a number of issues](https://github.com/flutter/engine/pull/53042) we have also greatly improved the fidelity of Impeller’s text rendering in this release. In particular, text weight, spacing, and kerning now all match the fidelity of text with the legacy renderer.

<DashImage figure src="images/0gIu2Wm9mpuMGb1JY.webp" alt="Before (Note gaps instead of proper kerning, and lighter than intended font weight.)" caption="Before (Note gaps instead of proper kerning, and lighter than intended font weight.)" />

<DashImage figure src="images/0tt9hlqhTbrmj4ZCt.webp" alt="After" caption="After" />

<DashImage figure src="images/0eMboSxWLEJBS_EyL.webp" alt="Before (Note incorrect spacing, for example in “vergelijken”)" caption="Before (Note incorrect spacing, for example in “vergelijken”)" />

<DashImage figure src="images/0uxeGJuIKWu0dPW1d.webp" alt="After" caption="After" />

**Android Preview**

In this release, we are continuing to preview Impeller on Android. We have extended the preview period due to difficulties stemming from [a bug in Android 14](https://github.com/flutter/flutter/issues/146499#issuecomment-2082873125) that affects APIs that Impeller uses for Platform Views. The bug has since been patched by the Android team, however many deployed devices will be running the unpatched Android version for the foreseeable future. Working around these issues implies an additional API migration and therefore an additional stable release cycle. Out of an abundance of caution and to ensure that Flutter apps work on the widest possible range of devices, we are holding off on making Impeller the default renderer until a stable release later this year.

As the Impeller preview on Android continues through the 3.24 stable cycle, we request that Flutter developers upgrade to the latest stable version, and file issues about any shortcomings noticed when Impeller is enabled. Feedback at this stage is invaluable to ensuring that Impeller is successful on Android and that we will be able to confidently make it the default renderer in a release later this year. The Android hardware ecosystem is much more diverse than the iOS ecosystem. For that reason, the most helpful feedback about Impeller should include detailed information about the specific device and Android version where issues occurred.

### Improved defaults for downscaled images

In this release, the default `FilterQuality` for images has been changed from `FilterQuality.low` to `FilterQuality.medium`. When a large image is substantially larger than its destination rectangle, which is a common scenario, `FilterQuality.low` causes an image to look more ‘pixelated’ and be slower to render than `FilterQuality.medium`. Going forward the team is also exploring more suitable names for the various `FilterQuality` levels.

### Flutter GPU preview

Flutter has introduced a major update for rendering capabilities with the Flutter GPU, available on the main channel. This low-level graphics API allows developers to create custom renderers using Dart code and GLSL shaders without needing any native platform code.

Flutter GPU expands what you can render directly in Flutter, enabling advanced graphics and 3D scenes. It requires the Impeller rendering backend, currently supported on iOS, macOS, and Android. Although in early preview, Flutter GPU aims to eventually support all Flutter platforms.

The API allows for full control over render pass attachments, the vertex stage, and data upload to the GPU. This flexibility is essential for creating sophisticated rendering solutions, from 2D character animations to complex 3D scenes.

Developers can start using Flutter GPU by switching to the main channel and adding the flutter_gpu package to their projects. The upcoming months will see more functionality and stability improvements, with higher-level rendering libraries like flutter_scene simplifying the use of these advanced features.

For a deeper dive into Flutter GPU and to see how you can leverage it in your projects, check out the detailed [Flutter GPU blog post](https://medium.com/flutter/getting-started-with-flutter-gpu-f33d497b7c11). Whether you’re creating games or complex graphics, Flutter’s new GPU capabilities make it a robust choice for your product.

## Web

### Multi-view embedding

Flutter web applications can now leverage multi-view embedding, allowing developers to render content into multiple HTML elements simultaneously. This feature, known as “embedded mode” or “multi-view,” offers flexibility for integrating Flutter views into existing web applications.

In multi-view mode, a Flutter web application doesn’t render immediately upon launch. Instead, it waits until the host application adds the first “view” using the addView method. The host application can dynamically add or remove these views, and Flutter adjusts its widgets accordingly.

To enable multi-view mode, set `multiViewEnabled: true` in the `initializeEngine` method within the `flutter_bootstrap.js` file. Views can then be managed from JavaScript, adding them to specified HTML elements and removing them as needed. Each view addition and removal triggers updates within Flutter, allowing for dynamic content rendering.

This feature is particularly useful for integrating Flutter into complex web applications where multiple, independent Flutter views are required. It also supports custom initialization data for each view, enabling personalized configurations and interactive experiences.

For a deeper dive into implementing multi-view embedding in your Flutter web applications, check out the [detailed documentation](https://docs.flutter.dev/platform-integration/web/embedding-flutter-web).

## Monetization

### Video ad monetization support

We have launched a new [Interactive Media Ads (IMA) plugin](https://pub.dev/packages/interactive_media_ads) to support instream video ad monetization on Flutter mobile apps. The new IMA plugin provides new ad monetization opportunities for Flutter apps on top of the existing [Google Mobile Ads (GMA) plugin](https://pub.dev/packages/google_mobile_ads) which primarily supports display ad formats.

Instream video ads are typically shown to a user in the video player before (preroll), during (midroll), or after (postroll) video content playback. Some instream video ads can be skippable as well.

<DashImage figure src="images/0_c0s8KMdLNyfxOMQ.webp" />

**Flutter IMA benefits**:

* Seamlessly monetize video player content on Flutter apps. For example, when an app user clicks **play** on video content, you can now implement the Flutter IMA plugin to first show the user a 15 second ad before starting the video content.

* Tap into the same benefits of native IMA SDK including access to premium Google ad demand and industry standard compliance (such as [IAB VAST](https://iabtechlab.com/standards/vast/)).

The initial launch version currently supports pre-roll video ads on Android and iOS platform. Support for midroll ads will be available soon. We encourage you to start exploring the new IMA plugin on your Flutter app video content. Please let us know if have any issues or concerns on [GitHub](https://github.com/flutter/flutter/issues?q=is%3Aissue+is%3Aopen+label%3A%22p%3A+interactive_media_ads%22).

Resources: [Plugin guide](https://pub.dev/packages/interactive_media_ads), [Sample App](https://pub.dev/packages/interactive_media_ads/example), [Git Repository](https://github.com/flutter/packages/tree/main/packages/interactive_media_ads)

## iOS

### Swift Package Manager initial support

Today, Flutter uses CocoaPods to manage native iOS or macOS dependencies.

Flutter 3.24 adds early support for Swift Package Manager. This brings several benefits, including:

1. **Access to the Swift package ecosystem**. Flutter plugins will be able to leverage the growing ecosystem of [Swift packages](https://swiftpackageindex.com/)!
2. **Simplifies Flutter installation**. Swift Package Manager is bundled with Xcode. In the future, you won’t need to install Ruby and CocoaPods to use Flutter for Apple’s platforms.

We encourage plugin authors to [try adding support for Swift Package Manager to your plugins](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-plugin-authors#how-to-add-swift-package-manager-support-to-an-existing-flutter-plugin), and provide feedback on your experience.

If you have feedback on Flutter’s support for Swift Package Manager, please [file an issue](https://github.com/flutter/flutter/issues/new/choose).

## Ecosystem

### Shared Preferences plugin updates

We’ve added two new APIs to the [shared_preferences](https://pub.dev/packages/shared_preferences) plugin, SharedPreferencesAsync and SharedPreferencesWithCache. The most significant change is that the Android implementation uses Preferences DataStore instead of Shared Preferences.

SharedPreferencesAsync allows users to call directly to the platform to get the most up to date preferences saved on the device, at the cost of being async and a little slower than using the cached version. This is useful for preferences that can be updated by other systems or isolates, which would make a cache stale.

SharedPreferencesWithCache is built on top of SharedPreferencesAsync and allows users to access a locally cached copy of the preferences synchronously. This is similar to the old API, but can now be instantiated multiple times with different parameters.

These new APIs are intended to replace the current SharedPreferences API in the future. However, this is one of the most used plugins in the ecosystem, and we know it will take time for the ecosystem to switch to the new APIs.

### Flutter and Dart Package Ecosystem Summit Europe 2024

<DashImage figure src="images/0fWo9ieYzQcJjwQBi.webp" />

As part of Fluttercon Europe 2024, we held the first in-person Flutter and Dart Package Ecosystem Summit. This followed on from the first virtual summit we held in August 2023. See a summary of takeaways from the discussion sessions [here](https://docs.google.com/document/d/e/2PACX-1vRFLdpIJYO5YPARcyUT1FYPzwkFb1hxh_agqnCXxsyirXocLZS5jobs3xFV5ZGpSQHLHZiBzqbJlXNV/pub).

We’re excited to announce that the next summit will be at [Fluttercon USA](https://flutterconusa.dev/) in New York City on 20th September 2024! If you’re a package author or contributor, and are attending Fluttercon USA 2024, [register](https://rsvp.withgoogle.com/events/flutter-package-ecosystem-summit-usa-2024) to save your spot in the summit.

The summit brought together package authors and maintainers for unconference-style sessions on the following topics:

* Session 1 — Past, Present and Future of Native Interop

* Session 2 — Sustainable package maintenance models

* Session 3 — Addressing package ecosystem fragmentation

We believe the summit, especially when part of more general Flutter and Dart events, is a valuable platform for open discussion among the community, to surface critical challenges and brainstorming solutions. We’re looking forward to holding more of these summits going forward, in partnership with the community.

## DevTools and IDEs

This release includes some exciting improvements to the Flutter DevTools tooling suite.

If you have ever wondered whether your Flutter app is building more Widgets than expected, a new feature in the **DevTools Performance** tool that can help with that. Using the new **Rebuild Stats** feature, you can capture information about how many times a widget was built in your app or even in a specific Flutter frame.

<DashImage figure src="images/07LXjXlFR9w-VR6xk.webp" />

*A screenshot of the DevTools Performance tool tracking rebuild stats.*

We’ve added polish and critical bug fixes to tools like the **Network profiler** and the **Flutter Deep Links tool**, and have made some general improvements to provide you with a better experience when you are using DevTools from within your IDE. Speaking of IDEs, did you know that you can use every DevTools tool directly inside your IDE?

<DashImage figure src="images/0tdpToIuTd-mBq-_R.webp" />

*DevTools screens open inside a VS Code window.*

<DashImage figure src="images/0QvoXCNqqfsrMn1oC.webp" />

*DevTools screens open inside Android Studio tool windows.*

This release includes improvements to the Flutter Sidebar in VS Code to give you easier access to the tools you are looking for. Upgrade to the latest versions of VS Code and the Flutter and Dart extensions to access the improved sidebar.

<DashImage figure src="images/0BzEybhMlV-SnSZZl.webp" />

*The Flutter Sidebar is adaptive and scales to fit your workspace*

This release also includes some major improvements to the [DevTools Extensions](https://docs.flutter.dev/tools/devtools/extensions) framework. You can now use DevTools extensions (tools provided by one of your package dependencies) when you are debugging a Dart or Flutter test, or even when you aren’t debugging anything, but are just writing code in your IDE. So, if you’ve wanted to use a tool (or build one!) for one of these user journeys, it is now possible.

To learn more about all the updates included in Flutter 3.24 check out the release notes for DevTools [2.35.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.35.0), [2.36.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.36.0), and [2.37.2](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.37.2).

## Breaking changes and deprecations

Breaking changes in this release include changes to [Navigator’s pages API](https://docs.flutter.dev/release/breaking-changes/navigator-and-page-api), [generic types in PopScope](https://docs.flutter.dev/release/breaking-changes/popscope-with-result), [Flutter web’s default renderer](https://docs.flutter.dev/platform-integration/web/renderers) and the introduction of some new deprecations. See the full list of migration guidance on the [breaking changes page](https://docs.flutter.dev/release/breaking-changes).

As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md) — these help us identify these breaking changes. To learn more, check out [Flutter’s breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

## Conclusion

At the heart of Flutter’s success is you — our amazing community. This release wouldn’t be possible without your countless contributions and unwavering passion. From the bottom of our hearts, thank you.

To dive into the specifics of what has been achieved with this release, we invite you to view the [release notes](https://docs.flutter.dev/release/release-notes/release-notes-3.24.0) and [change log](https://github.com/flutter/flutter/blob/main/CHANGELOG.md) for a comprehensive list of additions in Flutter 3.24.

Flutter 3.24, alongside Dart 3.5, is now available on the stable channel. Embarking on this latest journey with Flutter is as straightforward as running flutter upgrade. We can’t wait to see what you build!
