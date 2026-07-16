---
title: "What’s new in Flutter 3"
description: "Deep dive into our latest release, including macOS and Linux stable, performance improvements, and more!"
publishDate: 2022-05-11
author: itsjustkevin
image: images/1K1Ru7PVkH74N56hgjBTjjQ.webp
category: release
layout: blog
---

It’s time again for a Flutter stable release — and we are incredibly proud to announce **Flutter 3**! Only three months ago, we announced Flutter support for Windows. Today, we are excited to announce that Flutter is now stable for macOS and Linux, in addition to Windows!

<DashImage figure src="images/1K1Ru7PVkH74N56hgjBTjjQ.webp" />


Thanks to the hard work of our Flutter contributors, we’ve merged 5248 pull requests!

We have several exciting things to announce as part of this release, including the update on Flutter’s support for macOS and Linux, significant performance improvements, mobile and web updates — and much more! In addition, we have news about reduction in support for older versions of Windows, and a short list of breaking changes. So, let’s get down to business!

## Ready for production on all desktop platforms

Linux and macOS have reached stable and include the following features:

### Cascading menus and support for the macOS system menu bar

You can now create platform-rendered menu bars on macOS using the `PlatformMenuBar` widget, which supports insertion of platform-only menus, and control over what appears in the macOS application menus.

<DashImage figure src="images/1kS32jfapJAvSyspT3aOH5A.webp" alt="Cascading menus demo" caption="Cascading menus demo" />


### Full support for international text input on all desktop platforms

International text input, including for languages that make use of text [input method editors](https://en.wikipedia.org/wiki/Input_method) (IMEs) such as Chinese, Japanese, and Korean is fully-supported on all three desktop platforms, including third-party input methods such as Sogou and Google Japanese Input.

### Accessibility on all desktop platforms

Flutter for Windows, macOS, and Linux support accessibility services such as screen-readers, accessible navigation, and inverted colors.

### Universal binaries by default on macOS

As of Flutter 3, Flutter macOS desktop apps are built as universal binaries, with native support for both existing Intel-based Macs and Apple’s latest Apple Silicon devices.

### Deprecating Windows 7/8 for development

With this release, we’re raising the recommended Windows version for development to Windows 10. While we aren’t blocking development on older versions (Windows 7, Windows 8, Windows 8.1), these versions are [no longer supported by Microsoft](https://docs.microsoft.com/en-us/lifecycle/faq/windows) and we provide limited testing on these releases. While we will continue to offer ‘best effort’ support for older versions, we encourage you to upgrade.
> **Note**: We continue to offer support for Flutter apps *running* on Windows 7 and Windows 8; this change only affects the recommended development environment.

## Mobile updates

Our updates to mobile platforms includes the following:

### Foldable phone support

The Flutter 3 release supports foldable mobile devices. In a collaboration spearheaded by Microsoft, new features and widgets allow you to create dynamic and delightful experiences on foldable devices.

As part of this work, [`MediaQuery`](https://master-api.flutter.dev/flutter/widgets/MediaQuery-class.html) now contains a list of [`DisplayFeatures`](https://master-api.flutter.dev/flutter/dart-ui/DisplayFeature-class.html), describing the bounds and states of device elements like hinges, folds, and cutouts. Additionally, the [`DisplayFeatureSubScreen`](https://master-api.flutter.dev/flutter/widgets/DisplayFeatureSubScreen-class.html) widget now positions its child widget without overlapping the bounds of `DisplayFeatures`, and has already been integrated with the framework’s default dialogs and pop-ups, making Flutter aware and responsive to these elements **out of the box**.

<DashImage figure src="images/0z8pzEtJOPFv-xzw2.webp" />


Many thanks goes to the Microsoft team, and especially to [@andreidiaconu](https://github.com/andreidiaconu), for their contributions!

Try [the Surface Duo emulator samples](https://docs.microsoft.com/en-us/dual-screen/flutter/samples), including one with a special fork of the Flutter Gallery, to see Flutter’s dual displays in action.

### iOS variable refresh rate support

Flutter now supports variable refresh rate on iOS devices with ProMotion displays, including iPhone 13 Pro and iPad Pro. On these devices, Flutter apps can render at refresh rates reaching 120 hz, which were previously limited to 60 hz. This results in a smoother experience during fast animations such as scrolling. See [flutter.dev/go/variable-refresh-rate](https://flutter.dev/go/variable-refresh-rate) for more details.

### Simplified iOS releases

We’ve added [new options to the flutter build ipa command](https://github.com/flutter/flutter/pull/97672) to simplify releasing your iOS app. When you’re ready to distribute to TestFlight or the App Store, run `flutter build ipa` to build an Xcode archive (`.xcarchive` file) and an app bundle (`.ipa` file). You can optionally add `—-export-method ad-hoc`, `—-export-method development`, or `—-export-method enterprise`. Once the app bundle is built, upload it to Apple through the [Apple Transport macOS app](https://apps.apple.com/us/app/transporter/id1450874784) or on the command line using `xcrun altool` (run `man altool` for App Store Connect API key authentication instructions). After uploading, your app is available for release to [TestFlight or the App Store](https://docs.flutter.dev/deployment/ios#release-your-app-to-the-app-store). After setting up your initial [Xcode project settings](https://docs.flutter.dev/deployment/ios#review-xcode-project-settings), such as display name and app icon, you no longer need to open Xcode to release your app.

### Gradle version update

If you create a new project with the Flutter tool, you might notice that the generated files now use the latest versions of the Gradle and Android Gradle plugins. For existing projects, you need to manually bump the versions to 7.4 for Gradle, and 7.1.2 for the Android Gradle plugin.

### Sunsetting 32-bit iOS/iOS 9/iOS 10

As we announced in Feb 2022 with the 2.10 stable release, Flutter’s support for 32-bit iOS devices and iOS versions 9 and 10 is coming to an end. This change affects the iPhone 4S, iPhone 5, iPhone 5C, and the 2nd, 3d, and 4th gen iPad devices. Flutter 3 is the last stable release that supports these iOS versions and devices.

To learn more about this change, take a look at [RFC: End of support for 32-bit iOS devices](https://flutter.dev/go/rfc-32-bit-ios-unsupported).

## Web updates

Our updates for web apps include the following:

### Image decoding

Flutter web now automatically detects and uses the ImageDecoder API in browsers that support it. As of today, most Chromium-based browsers (Chrome, Edge, Opera, Samsung Browser, and more) have added this API.

The new API decodes images asynchronously off the main thread using the browser’s built-in image codecs. This speeds up image decoding by 2x, and it never blocks the main thread, removing all jank that was previously caused by images.

### Web app lifecycles

The new lifecycle API for Flutter web apps gives you the flexibility to control the bootstrap process of your Flutter app from the hosting HTML page, and helps Lighthouse analyze the performance of your app. This applies to many use-cases, including the following frequently requested scenarios:

* A splash screen.

* A loading indicator.

* A plain HTML interactive landing page displayed before the Flutter app.

For more information, check out [Customizing web app initialization](https://docs.flutter.dev/development/platform-integration/web/initialization) on docs.flutter.dev.

## Tooling updates

Our updates to Flutter and Dart tooling include:

### Updated lint package

Version 2.0 of the lint packages have been released:

* Flutter: [https://pub.dev/packages/flutter_lints/versions/2.0.0](https://pub.dev/packages/flutter_lints/versions/2.0.0)

* Dart: [https://pub.dev/packages/lints/versions/2.0.0](https://pub.dev/packages/lints/versions/2.0.0)

Apps generated in Flutter 3 with `flutter create` automatically enable the v2.0 sets of lints. Existing apps, packages, and plugins are encouraged to migrate to v2.0 to follow the latest and greatest best practices in the Flutter world, by running `flutter pub upgrade --major-versions flutter_lints`.

Most of the newly added lint warnings in v2 come with automated fixes. So, after upgrading to the latest package version in your app’s `pubspec.yaml` file, you can run `dart fix —-apply` over your code base to fix most lint warnings automatically (some warnings still require some manual work). Apps, packages, or plugins that aren’t using `package:flutter_lints` yet can migrate by following the [migration guide](https://docs.flutter.dev/release/breaking-changes/flutter-lints-package#migration-guide).

### Performance improvements

Thanks to open source contributor [knopp](https://github.com/knopp), partial repaint has been [enabled on Android](https://github.com/flutter/engine/pull/29591) devices that support it. In our local testing this change cut average, 90th percentile, and 99th percentile frame rasterization times on the `backdrop_filter_perf` benchmark on a Pixel 4 XL device by 5x. Partial repaint when there is a single rectangular dirty region is now enabled on both iOS and newer Android devices.

We have [further improved](https://github.com/flutter/engine/pull/30957) the performance of opacity animations in simple cases. In particular, when an `Opacity` widget contains only a single rendering primitive, the `saveLayer` method that is usually invoked by `Opacity` is omitted. In a benchmark constructed to measure the benefits of this optimization, rasterization time for this case improved by [an order of magnitude](https://flutter-flutter-perf.skia.org/e/?begin=1643063115&end=1644004520&keys=X32827d8819e8271e025f50e77bf2bec0&requestType=0&xbaroffset=27447). In future releases we plan to apply this optimization to even more scenarios.

Thanks to work by open source contributor [JsouLiang](https://github.com/JsouLiang), the Engine’s raster and UI threads now run at higher priority on Android and iOS than other threads; for example, Dart VM background garbage collection threads. In our benchmarks, this resulted in [~20% faster](https://flutter-flutter-perf.skia.org/e/?begin=1644581114&end=1644647407&keys=X3999dc0a0c89054eaa9f66bcff27d882&num_commits=50&request_type=1&xbaroffset=27549) average frame build times.

Prior to the 3 release, the admission policy for the raster cache only looked at the number of draw operations in a picture, assuming that any with more than a few operations would be good candidates for caching. Unfortunately, this resulted in the Engine spending memory to cache pictures that were actually very fast to render. This release [introduces a mechanism](https://github.com/flutter/engine/pull/31417) that estimates the rendering complexity of pictures based on the cost of draw operations that it contains. Using this as the raster cache admissions policy [reduced memory usage](https://flutter-flutter-perf.skia.org/e/?begin=1644790212&end=1646044276&keys=X4c7dd4e4903a38523816c00b31d4d787&requestType=0&xbaroffset=27636) without regressing performance in our benchmarks.

Thanks to open source contributor [ColdPaleLight](https://github.com/ColdPaleLight) who [fixed a bug in frame scheduling](https://github.com/flutter/engine/pull/31513) that caused a small number of animation frames to be dropped on iOS. Thanks to everyone who reported this issue and provided reproductions and videos of the dropped frames.

### Impeller

The team has been hard at work on a solution to address early-onset jank on iOS and other platforms. In the Flutter 3 release, you can preview an experimental rendering backend called [Impeller](https://github.com/flutter/engine/tree/main/impeller) on iOS. Impeller precompiles [a smaller, simpler set of shaders](https://github.com/flutter/flutter/issues/77412) at engine build time so that they won’t compile while an app is running; this has been a major source of jank in Flutter. Impeller is not production ready and is far from finished. Not all Flutter features are implemented yet, but we’re pleased enough with its fidelity and performance in the [flutter/gallery](https://github.com/flutter/gallery) app that we are sharing our progress. In particular, the worst frame in the transition animation of the Gallery app is around [20x faster](https://flutter-flutter-perf.skia.org/e/?begin=1650297849&end=1651261748&queries=sub_result%3Dworst_frame_rasterizer_time_millis%26test%3Dnew_gallery_impeller_ios__transition_perf%26test%3Dnew_gallery_ios__transition_perf&requestType=0).

Impeller is available under a flag on iOS. You can pass `—-enable-impeller` to `flutter run`, or set the `FLTEnableImpeller` flag in your `Info.plist` file to `true`, to give Impeller a try. Development of Impeller continues on Flutter’s master channel, and we hope to provide further updates in future releases.

### Inline ads on android

When you use the `[google_mobile](https://pub.dev/packages/google_mobile_ads)_ads` package, you should see better performance in user critical interactions such as scrolling and transitions between pages. This is particularly noticeable on devices popular in emerging markets. The best part is that no code changes are required!

Under the hood, Flutter now composes Android views, commonly referred to as [platform views](https://docs.flutter.dev/development/platform-integration/platform-views), asynchronously. This means that the Flutter raster thread doesn’t need to wait for the Android view to render. Instead, the Flutter engine places the view on screen using an OpenGL texture that it manages.

## More exciting updates

Other updates to the Flutter ecosystem include the following:

### Material 3

Flutter 3 supports [Material Design 3](https://m3.material.io/), the next generation of Material Design. Flutter 3 provides opt-in support for Material 3; this includes Material You features like dynamic color, an updated color system and typography, updates to many components, and new visual effects introduced in Android 12 like a new touch ripple design and a stretch overscroll effect. Try the Material 3 features in the *new* [Take your Flutter app from Boring to Beautiful](https://codelabs.developers.google.com/codelabs/flutter-boring-to-beautiful) codelab. See the [API docs](https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html) for details on how to opt-in to these new features and what components have support for Material 3. Follow ongoing work with the [Material 3 Umbrella issue](https://github.com/flutter/flutter/issues/91605).

### Theme extensions

Flutter now enables adding *anything* to the material library’s `ThemeData`, with a concept called *Theme extensions*. Rather than extending (in the Dart sense) `ThemeData` and re-implementing its `copyWith`, `lerp`, and other methods, you can specify `ThemeData`.extensions. Also, as a package developer, you can provide `ThemeExtension`. See [flutter.dev/go/theme-extensions](https://flutter.dev/go/custom-colors-m3) for more details and check out [this example on GitHub](https://github.com/guidezpl/flutter/blob/master/examples/api/lib/material/theme/theme_extension.1.dart).

### Ads

We know it is important for publishers to request consent for personalized ads and to handle Apple’s App Tracking Transparency (ATT) requirements.

To support these requirements, Google offers the User Messaging Platform (UMP) SDK, which replaces the previous open source [Consent SDK](https://github.com/googleads/googleads-consent-sdk-ios). In the upcoming release of GMA SDK for Flutter, we are adding support for the UMP SDK to allow publishers to obtain user consent. For more details, check out the [google_mobile_ads](https://pub.dev/packages/google_mobile_ads) page on pub.dev.

## Breaking changes

As we continue to grow and improve Flutter, we aim to keep the number of breaking changes to a minimum. With the release of Flutter 3, we have the following breaking changes:

* [Deprecated API removed after v2.10](https://docs.flutter.dev/release/breaking-changes/2-10-deprecations)

* [Page transitions replaced by ZoomPageTransitionsBuilder](https://docs.flutter.dev/release/breaking-changes/page-transition-replaced-by-ZoomPageTransitionBuilder)

* [Migrate useDeleteButtonTooltip to deleteButtonTooltipMessage of Chips](https://docs.flutter.dev/release/breaking-changes/chip-usedeletebuttontooltip-migration)

If you are using any of these apis please refer to the [migration guide on Flutter.dev](https://docs.flutter.dev/release/breaking-changes).

## Summary

From the Flutter Team at Google, we say thank you for the awesome work the community has done to help Flutter maintain its status as the most popular cross-platform UI toolkit, as measured by analysts like Statista and SlashData. We look forward to working together as a community to continue to provide a community driven tool that helps create a delightful experience for the developers and users alike!