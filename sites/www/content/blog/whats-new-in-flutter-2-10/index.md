---
title: "What’s New in Flutter 2.10"
description: "Windows stable, performance improvements, Material 3 updates and more!"
publishDate: 2022-02-03
author: csells
image: images/0278rYAB5Pac8_7SD.webp
category: releases
layout: blog
---

I can’t believe it’s time again for a Flutter stable release! Hello and welcome to Flutter 2.10. It has been less than two months since our last release, but even in that short time we’ve had 1,843 issues closed and 1,525 PRs merged from 155 contributors worldwide. Thanks everyone for the great work, especially during the 2021 holiday season.

We have several exciting things to announce as part of this release, including a big update on Flutter’s support for Windows, several significant performance improvements, new support for icons and colors in the framework, and some tooling improvements. In addition, we’ve got some updates on the removal of the dev channel, reduction in support for older versions of iOS, and a short list of breaking changes. Let’s get to it!

## Ready for production apps on Windows

First and foremost, the Flutter 2.10 release brings with it the stable release of Windows support. You no longer need to flip a flag to get the functionality that produces Windows apps on the stable channel of Flutter — now it’s available by default!

<DashImage figure src="images/0278rYAB5Pac8_7SD.webp" />


Of course, we did a lot more than just flip a flag. This release includes extensive improvements for text handling, keyboard handling, and keyboard shortcuts, as well as new integrations directly into Windows, with support for command-line arguments, globalized text entry, and accessibility.

For much more on the Windows stable launch, see [the Announcing Flutter for Windows blog post](https://timsneath.medium.com/6979d0d01fed), which describes the architecture of Flutter on Windows that allows for deep integration and gives you a sense of just how many Flutter packages and plugins already support Windows. You can also see some examples of what our tooling and app partners are doing with Flutter on Windows!

## Performance improvements

This release of Flutter includes initial support for **dirty region management** provided by Flutter community member [knopp](https://github.com/knopp). He’s enabled [partial repaints for a single dirty region on iOS/Metal](https://github.com/flutter/engine/pull/28801). This change reduced 90th and 99th percentile rasterization times on a few benchmarks by an order of magnitude, and reduced GPU utilization on these benchmarks from more than 90% to less than 10%.

<DashImage figure src="images/0mWerp_uZBj64dBeC.webp" />


We expect to bring the benefits of partial repaints to [other platforms](https://github.com/flutter/engine/pull/29591) in future releases.

In the Flutter 2.8 release, we [landed our own internal picture recording format](https://github.com/flutter/flutter/issues/53501). Now in Flutter 2.10, we’ve started building optimizations with it. As an example, one common case of **opacity layers is now [implemented much more efficiently](https://github.com/flutter/engine/pull/29775)**. Even in the worst case, frame raster times in our benchmarks fell to under a third of their previous value.

<DashImage figure src="images/0sJIYBXONsWsYa5l4.webp" />


We expect this optimization to expand to cover more cases as we continue developing the picture recording format.

In profile and release modes, Dart code is compiled ahead of time to native machine code. The key to the efficiency and small size of this code is a whole program type flow analysis that unlocks many compiler optimizations and aggressive tree-shaking. However, as the type flow analysis must cover the whole program, it can be somewhat expensive. This release includes [**a faster implementation of type flow analysis**](https://dart.googlesource.com/sdk.git/+/e698500693603374ecc409e158f36c25bff45b12). Overall build time for the Flutter app in our benchmarks fell by ~10%.

<DashImage figure src="images/03bjgNV_6OjBYDj24.webp" />


As always, performance enhancements, reduced memory usage, and reduced latency are a priority for the Flutter team. Look forward to further improvements in future releases.

## iOS updates

In addition to performance improvements, we’ve also added some platform-specific features and enhancements. One new enhancement is [smoother keyboard animations in iOS](https://github.com/flutter/engine/pull/29281) from [luckysmg](https://github.com/luckysmg), which is provided automatically to your app without you having to do a thing.

<DashImage figure src="images/0qMbaTcooLzyIxwgp.webp" />


We’ve also improved the stability of the camera plugin for iOS by fixing a few [edge](https://github.com/flutter/plugins/pull/4608) [case](https://github.com/flutter/plugins/pull/4661) [crashes](https://github.com/flutter/plugins/pull/4619).

Finally, **64-bit iOS architectures get a new feature to reduce memory usage: [compressed](https://github.com/flutter/engine/pull/30077) [pointers](https://github.com/flutter/engine/pull/30333)**.

A 64-bit architecture represents pointers as a 8-byte data structure. When you have a lot of objects, the space taken up by the pointers themselves adds to the overall memory usage of your app, especially if you have larger, more complicated apps that have more GC churn. However, your iOS app is very unlikely to have enough objects to require a significant portion of even the 32-bit address space (2 billion objects), let alone the enormity of the 64-bit address space (9 million billion objects).

Compressed pointers were provided in Dart 2.15 and in this release of Flutter, we use them to reduce the memory usage for 64-bit iOS apps. You can [check out the Dart 2.15 blog post for details](https://medium.com/dartlang/dart-2-15-7e7a598e508a).

And while you’re reading Dart blog posts, don’t forget to [check out the Dart 2.16 announcement](https://medium.com/dartlang/dd87abd6bad1) for updates on supporting Flutter for Windows with package platform tagging and a new search experience on pub.dev.

## Android updates

This release contains a number of improvements for Android as well. By default, when you create a new app, **Flutter defaults to support the latest version of Android**, version 12 (API level 31). Also, in this release, **we’ve enabled [multidex](https://developer.android.com/studio/build/multidex) support automatically**. If your app supports Android SDK versions below 21, and it exceeds the 64K method limit, simply pass the `--multidex` flag to `flutter build appbundle` or `flutter build apk` and your app will support multidex.

And last but not least, we listened to your feedback that Gradle error messages can be intimidating. For this reason, **the Flutter tool now suggests resolution steps to common issues**. For example, if you add a plugin to your app that requires you to increase the minimum supported Android SDK version, you now see a “Flutter Fix” suggestion in the logs.

<DashImage figure src="images/01U5AWT3j69NL5jWn.webp" />


We continue to add more suggestions to common error messages, and would love to get your feedback on other error messages where this treatment would be useful.

## Web updates

This release contains some improvements on the web as well. For example, in previous releases, when scrolling to the edge of a multiline `TextField` on the web, it wouldn’t scroll properly. This release introduces **[edge scrolling for text selection](https://github.com/flutter/flutter/pull/93170):** when the selection moves outside of the text field, the field scrolls to view the scroll extent. This new behavior is available for both web and desktop apps.

<DashImage figure src="images/1VpOHaGxbrVr262jc6bMUmg.gif" />


In addition, this release of Flutter includes another notable improvement in the web. We’re always looking to reduce the overhead of our mapping of Flutter to the web. In previous versions, every time we wanted to bring a native HTML widget into your Flutter app, we needed an overlay as part of our platform view support for the web. Each one of these overlays enables custom painting but represents a certain amount of overhead. If you have a large number of native HTML widgets in your app, such as links, that adds up to a lot of overhead. With this release, **we’ve created a new “non-painting platform view” for the web that essentially removes that overhead**. And we’ve [taken advantage of this optimization](https://github.com/flutter/plugins/pull/4578) in [the `Link` widget](https://pub.dev/documentation/url_launcher/latest/link/Link-class.html), which means if you have many links in your Flutter web app, they no longer represent any significant overhead at all. We’ll be applying this optimization to other widgets over time.

## Material 3

This release is the beginning of the transition to Material 3, which includes the ability to [**generate an entire color scheme from a single seed color**](https://github.com/flutter/flutter/pull/93463).

With any color, you can construct an instance of the new `ColorScheme` type:

```dart
final lightScheme = ColorScheme.fromSeed(seedColor: Colors.green);
final darkScheme = ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark);
```

There’s also a new `colorSchemeSeed` parameter to the `ThemeData` factory constructor that allows you to generate the theme’s color scheme:

```dart
final lightTheme = ThemeData(colorSchemeSeed: Colors.orange, …);
final darkTheme = ThemeData(colorSchemeSeed: Colors.orange, brightness: Brightness.dark, …);
```

In addition, this release includes **the `ThemeData.useMaterial3` flag, which switches components to the new Material 3 look**.

Last but not least, **we’ve added [1,028 new Material icons](https://github.com/flutter/flutter/pull/95007)**.

<DashImage figure src="images/0-XysmyfnVC_Rt_rj.webp" alt="*A tiny sample of the 1,028 new Material icons*" caption="*A tiny sample of the 1,028 new Material icons*" />


Updates can be found in [the issue tracking our Material 3 work](https://github.com/flutter/flutter/issues/91605); feel free to leave your feedback.

## Integration testing improvements

In December of 2020, we announced a new way to [do end-to-end testing using the integration_test package](https://medium.com/flutter/updates-on-flutter-testing-f54aa9f74c7e). This new package replaced the flutter_driver package as the recommended way to do integration testing, providing new features, like Firebase Test Lab support as well as support for web and desktop.

Since that time, we’ve made further improvements in the integration testing story, including **bundling the integration_test package into the Flutter SDK itself**, making it easier to integrate with your app. There’s also **a new [migration guide if you’re moving your existing flutter_driver tests to integration_test](https://docs.flutter.dev/testing/integration-tests/migration)**.

<DashImage figure src="images/004e4XmQgP9CAyJ6x.webp" alt="*An example from the new flutter_driver to integration_test migration guide*" caption="*An example from the new flutter_driver to integration_test migration guide*" />


Several of the [existing](https://docs.flutter.dev/testing/integration-tests) [docs](https://docs.flutter.dev/cookbook/testing/integration/profiling), [samples](https://github.com/flutter/samples/tree/master/testing_app) and [codelabs](https://codelabs.developers.google.com/codelabs/flutter-app-testing) have also been updated for integration_test. To get started, point your browser to the [Testing Flutter apps](https://docs.flutter.dev/testing) page on flutter.dev. If you aren’t already using integration_test on your Flutter apps, now’s the time to start!

## Flutter DevTools

We’ve done some work on Flutter DevTools in this release as well, including one ease-of-use feature if you use DevTools from the command line. Instead of using `pub global activate` to download and execute the latest version, you can now **simply use `dart devtools`** and get the version that is up-to-date with the version of Flutter that you’re using.

We’ve also made a number [of](https://github.com/flutter/devtools/pull/3526) [usability](https://github.com/flutter/devtools/pull/3493) [updates](https://github.com/flutter/devtools/pull/3480), including [**improved support for inspecting large lists and maps in the Debugger variables pane**](https://github.com/flutter/devtools/pull/3497) (thanks to [elliette](https://github.com/elliette)).

<DashImage figure src="images/0Tau4a2z5GHZzuJky.webp" />


And finally, we’re about to release our **annual DevTools survey**! Please provide your feedback and help us improve your development experience.

<DashImage figure src="images/0bc2CaiWCLCpaYWMV.webp" />


This survey prompt will show up directly in DevTools sometime in mid-February. Thanks!

## VSCode improvements

The Visual Studio Code extension for Flutter has also gotten a number of enhancements, including **color previews in more places in your code** and [**a color picker that updates your code for you**](https://github.com/Dart-Code/Dart-Code/issues/3240).

<DashImage figure src="images/0eA2UN8_kzzJreUQf.webp" />


In addition, if you’d like to be a tester on prerelease versions of the Dart and Flutter extensions for VSCode, you can [switch to prerelease versions in your extension settings](https://github.com/Dart-Code/Dart-Code/issues/3729).

<DashImage figure src="images/08k22xPfwMobXvYJB.webp" />


You can read about the details of this update and more in [this post](https://groups.google.com/g/flutter-announce/c/lR-yn1s9HKk) on [the flutter-announce mailing list](https://groups.google.com/g/flutter-announce).

* [VS Code extensions v3.32](https://groups.google.com/g/flutter-announce/c/lR-yn1s9HKk)

* [VS Code extensions v3.34](https://groups.google.com/g/flutter-announce/c/lDSpaiWvUdI)

## Removing the dev channel

In [the Flutter 2.8 release](https://medium.com/flutter/whats-new-in-flutter-2-8-d085b763d181), we announced that we were doing the work to **remove the dev channel**, simplifying your choices, and removing engineering overhead. In this release, [we’ve completed that work](https://github.com/flutter/flutter/issues/94962), including:

* Updated Flutter tool to help migrate developers off the dev channel

* Updated wiki to reflect updated customer promises

* Updated deprecation policy

* Removed dev channel support from DartPad, pre-submit tests, and the website

The dev channel has now been scrubbed away. If we missed a spot, please [let us know](https://github.com/flutter/flutter/issues).

## Sunsetting Support for iOS 9.3.6

Due to decreased usage and increased difficulty in maintaining the target devices in our lab, we are **[moving support](https://flutter.dev/go/rfc-32-bit-ios-support) for iOS 9.3.6 [from the “Supported” tier to the “Best Effort” tier](https://docs.flutter.dev/development/tools/sdk/release-notes/supported-platforms)**. This means that support for iOS 9.3.6 and support for 32-bit iOS devices will be maintained only through coding practices, and ad-hoc and community testing.

In the Q3, 2022 stable release, we expect to drop support for 32-bit iOS devices and iOS versions 9 and 10 from Flutter stable releases. This means that apps built against stable Flutter SDKs after that point will no longer work on 32-bit iOS devices, and the minimum iOS version supported by Flutter will increase to iOS 11.

## Breaking Changes

We also work to have **a small number of breaking changes** in each release and with this release, although we’re not quite at zero yet — but we’ll keep trying!

* [Required Kotlin version](https://docs.flutter.dev/release/breaking-changes/kotlin-version)

* [Deprecated API removed after v2.5](https://docs.flutter.dev/release/breaking-changes/2-5-deprecations)

* [Raw images on Web uses correct origin and colors](https://docs.flutter.dev/release/breaking-changes/raw-images-on-web-uses-correct-origin-and-colors)

* [Scribble Text Input Client](https://docs.flutter.dev/release/breaking-changes/scribble-text-input-client)

If you’re still using these APIs, you can [read the migration guidance on flutter.dev](https://docs.flutter.dev/release/breaking-changes). As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md) that help us identify these breaking changes.

## Summary

From all of us here on the Flutter Team at Google, we want to say — thank you. Thank you for being part of the community that has helped Flutter become the most popular cross-platform UI toolkit, as measured by analysts like Statista and SlashData. Stable support for Windows is just the beginning of a packed year, and we can’t wait for everything we’ll build together!