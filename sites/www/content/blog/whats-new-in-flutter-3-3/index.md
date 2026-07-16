---
title: "What’s new in Flutter 3.3"
description: "Exciting updates for text handling, performance improvements, and more!"
publishDate: 2022-08-30
author: itsjustkevin
image: images/04Mac8uQL3ynXVIuD.webp
category: release
layout: blog
---

Welcome to **Flutter 3.3**! Only three months ago we announced Flutter 3, a massive milestone that included stable support for all platforms! The good news is that the momentum since this major release has not slowed down. Since the release of Flutter 3, Flutter has merged 5,687 pull requests.

This release brings updates to Flutter web, desktop, text handling improvements in performance — and much more!

We are also introducing exciting updates to the `go_router` package, DevTools, and VS Code extensions. Keep reading to learn more.

## Framework

### Global Selection

Until now, Flutter web apps didn’t match the expected behavior when attempting to select text. Like Flutter apps, native web applications are composed of a tree of elements. In a traditional web app, you can select multiple web elements with a single sweeping gesture, something that couldn’t be easily done on a Flutter web app.

Today that all changes! With the introduction of the `SelectableArea` widget, any child of the `SelectableArea` widget has selection enabled for free!

<DashImage figure src="images/04Mac8uQL3ynXVIuD.webp" />

To take advantage of this powerful new feature, simply wrap your route body (such as the `Scaffold`) with the `SelectionArea` widget and let Flutter do the rest.

For a more comprehensive deep dive into this awesome new feature, please visit the [`SelectableArea` API](https://api.flutter.dev/flutter/material/SelectionArea-class.html) page.

### Trackpad input

Flutter 3.3 provides improved support for trackpad input. This not only provides richer and smoother control, but also reduces misinterpretation in certain cases. For an example of this misinterpretation, check out the [Drag a UI element](https://docs.flutter.dev/cookbook/effects/drag-a-widget) page in the [Flutter cookbook](https://docs.flutter.dev/cookbook). Scroll to the bottom of the page to get to the DartPad instance, and perform the following steps:

1. Size the window smaller so that the upper part presents a scrollbar

1. Hover over the upper part

1. Use a trackpad to scroll

1. Prior to installing Flutter 3.3, scrolling on a trackpad drags the item because Flutter was dispatching emulated general events

1. After installing Flutter 3.3, scrolling on a trackpad correctly scrolls the list because Flutter is delivering the “scrolling” gesture, which isn’t recognized by the cards, but *is* recognized by the scroll view

For more information, see the [Flutter Trackpad Gesture](https://docs.google.com/document/d/1oRvebwjpsC3KlxN1gOYnEdxtNpQDYpPtUFAkmTUe-K8/edit?resourcekey=0-pt4_T7uggSTrsq2gWeGsYQ) design doc, and the following PRs on GitHub:

* PR 89944: [Support trackpad gestures in framework](https://github.com/flutter/flutter/pull/89944)

* PR 31591: [iPad trackpad gestures](https://github.com/flutter/engine/pull/31591)

* PR 34060: [Re-land “ChromeOS/Android trackpad gestures”](https://github.com/flutter/engine/pull/34060)

* PR 31594: [Win32 trackpad gestures](https://github.com/flutter/engine/pull/31594)

* PR 31592: [Linux trackpad gestures](https://github.com/flutter/engine/pull/31592)

* PR 31593: [Mac trackpad gesturesmacOS](https://github.com/flutter/engine/pull/31593)

### Scribble

Thanks to the amazing contributions of community member [fbcouch](https://github.com/fbcouch), Flutter now supports [Scribble](https://support.apple.com/guide/ipad/enter-text-with-scribble-ipad355ab2a7/ipados) handwriting input using the Apple Pencil on iPadOS. This feature is enabled by default on `CupertinoTextField`, `TextField`, and `EditableText`. To enable this feature for your end users, simply upgrade to Flutter 3.3.

<DashImage figure src="images/0SlsnQUfdOTijdsyF.webp" />

### Text input

To improve support for rich text editing, this release introduces the ability to receive granular text updates from the platform’s `TextInputPlugin`. Previously, the `TextInputClient` only delivered the new editing state with no delta between the old and new, `TextEditingDeltas` and the `DeltaTextInputClient` fill this information gap. Having access to these deltas allows you to build an input field with styled ranges that expand and contract as you type. To learn more, check out the [Rich Text Editor demo](https://flutter.github.io/samples/rich_text_editor.html).

## Material Design 3

The Flutter team continues to migrate more Material Design 3 components to Flutter. This release includes updates to [`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html), [`Chips`](https://api.flutter.dev/flutter/material/Chip-class.html), and large and medium variants for [`AppBar`](https://api.flutter.dev/flutter/material/AppBar-class.html).

To monitor the progress on the Material Design 3 migration, check out [Bring Material 3 to Flutter](https://github.com/flutter/flutter/issues/91605) on GitHub.

### IconButton

<DashImage figure src="images/0AxLlKvPfaiODtzch.webp" />

### Chip

<DashImage figure src="images/05fCsX84PRpjMtzx5.webp" />

### Medium and large AppBar

<DashImage figure src="images/0jVFZWFsCOuzeqzTb.webp" />

<DashImage figure src="images/0c4wovLXB8TpulHVU.webp" />

## Desktop

### Windows

Previously, the Windows desktop application’s version was set by a file specific to the Windows application. This behavior was inconsistent with the way other platforms set their versions.

Windows desktop application versions can now be set from your projects `pubspec.yaml` file and build arguments. This makes it easier to enable auto updates for your end customers to get the latest and greatest when an application update is pushed.

For more information on setting your applications version, follow the documentation on [docs.flutter.dev](https://docs.flutter.dev/deployment/windows#updating-the-apps-version-number) and the [migration guide](https://docs.flutter.dev/development/platform-integration/windows/version-migration). Projects created before Flutter 3.3 need to be updated to get this feature.

## Packages

### go_router

When designing apps with complex navigation needs, things can get pretty hard to wrap your head around. To extend Flutter’s native navigation API, the team has published a new version of the `go_router` package, making it simpler to design routing logic that works across mobile, desktop, and the web.

The [`go router`](https://pub.dev/packages/go_router) package, maintained by the Flutter team, simplifies routing by providing a declarative, url-based API, making it easier to navigate and handle deep-links. The latest version (4.3) enables apps to redirect using asynchronous code, and includes other breaking changes described in the [migration guide](https://docs.google.com/document/d/10l22o4ml4Ss83UyzqUC8_xYOv_QjZEi80lJDNE4q7wM/edit?usp=sharing&resourcekey=0-U-BXBQzNfkk4v241Ow-vZg).

For more information, check out the [Navigation and routing](https://docs.flutter.dev/development/ui/navigation) page on docs.flutter.dev.

## VS Code extension enhancements

The Visual Studio Code extension for Flutter has several updates including improvements for adding dependencies. You can now add multiple, comma-separated dependencies in one step using **Dart: Add Dependency**.

<DashImage figure src="images/0vFIZ4WL4UWSTrC27.webp" />

You can read about the Visual Studio Code extension enhancements made since the last Flutter stable release at:

* [VS Code extensions v3.46](https://groups.google.com/g/flutter-announce/c/u1iSDMtKMVg)

* [VS Code extensions v3.44](https://groups.google.com/g/flutter-announce/c/x4m9o93-Dng)

* [VS Code extensions v3.42](https://groups.google.com/g/flutter-announce/c/45Wsk5pISx4)

## Flutter DevTools updates

DevTools comes with a number of updates since the last stable Flutter release, including UX and performance improvements to data display tables for faster, less jittery scrolling of large lists of events ([#4175](https://github.com/flutter/devtools/pull/4175)).

For the complete list of updates since Flutter 3.0, check out the individual announcements here:

* [Flutter DevTools 2.16.0 release notes](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.16.0)

* [Flutter DevTools 2.15.0 release notes](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.15.0)

* [Flutter DevTools 2.14.0 release notes](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.14.0)

## Performance

### Raster cache improvements

This release increases the performance of loading images from assets by eliminating copies and reducing Dart garbage collection (GC) pressure. Previously, when loading asset images, the `ImageProvider` API required the compressed data to be copied multiple times. First, it was copied into the native heap when opening the asset and exposing it to Dart as a typed data array. Then, it was copied a second time when that typed data array was copied to the internal storage of a `ui.ImmutableBuffer`.

With [the addition](https://github.com/flutter/engine/pull/32999) of `ui.ImmutableBuffer.fromAsset`, compressed image bytes can be loaded directly into the structure used for decoding. This approach [requires changes](https://github.com/flutter/flutter/pull/103496) to the byte loading pipeline of `ImageProviders`. This process is also faster, because it bypasses some additional scheduling overhead required bythe previous method channel-based loader. In particular, image loading time improved by nearly 2x in our microbenchmarks.

<DashImage figure src="images/0dZTaQMQri0EI7HCw.webp" />

For more information and a migration guide, see [Adding ImageProvider.loadBuffer](https://docs.flutter.dev/release/breaking-changes/image-provider-load-buffer) on docs.flutter.dev.

## Stability

### iOS pointer compression disabled

In the 2.10 stable release, we enabled Dart’s [pointer compression optimization](https://medium.com/dartlang/dart-2-15-7e7a598e508a#0c15) on iOS. However, [Yeatse](https://github.com/Yeatse), on GitHub, [alerted us](https://github.com/flutter/flutter/issues/105183) to an unintended consequence of the optimization. Dart’s pointer compression works by reserving a large virtual memory region for Dart’s heap. Since the total virtual memory allocation allowed on iOS is less than on other platforms, this large reservation reduces the amount of memory available for use by other components that reserve their own memory, for example, Flutter plugins.

While disabling pointer compression increases the memory consumed by Dart objects, it also increases the memory *available* for non-Dart parts of a Flutter application, which is more desirable overall.

Apple provides an entitlement that can increase the maximum allowed virtual memory allocation for an application, however this entitlement is only supported on newer iOS versions, and wouldn’t work on devices running versions of iOS that Flutter still supports. When we are able to use this entitlement everywhere, we intend to revisit this optimization.

## API improvements

### PlatformDispatcher.onError

In previous releases, you had to manually configure a custom `Zone` in order to catch all of an application’s exceptions and errors. However, custom `Zone`s were detrimental to a number of optimizations in Dart’s core libraries, which slowed down application start-up time. **In this release, instead of using a custom `Zone`, you should catch all errors and exceptions by setting the `PlatformDispatcher.onError` callback.** For more information, check out the updated [Handling errors in Flutter](https://docs.flutter.dev/testing/errors) page on docs.flutter.dev.

### FragmentProgram changes

Fragment shaders written in GLSL and listed under a `shaders:` section in the Flutter manifest of an application’s `pubspec.yaml` file will now be automatically compiled to the correct format understood by the Engine and bundled with the application as an asset. Thanks to this change, you will no longer have to manually compile shaders using third-party tools. Going forward, you should regard the Engine’s `FragmentProgram` API as accepting only the output of Flutter’s build tooling. This isn’t yet the case, but this change is planned for a future release, as described in the [FragmentProgram API Support improvements](https://flutter.dev/go/fragment-program-support) design doc.

For an example of this change, see this [Flutter shader example](https://github.com/zanderso/fragment_shader_example).

### Fractional translation

Previously, the Flutter Engine would always align composited layers to exact pixel boundaries because it improved rendering performance on older (32-bit) model iPhones. Since adding desktop support, we’ve noticed that this led to observable snapping behavior, since screen device pixel ratios are commonly much lower. For example, on low DPR screens, tooltips could be seen visibly snapping when fading in. After determining that this pixel snapping was no longer necessary for performance on newer iPhone models, [we’ve removed this pixel snapping](https://github.com/flutter/flutter/issues/103909) from the Flutter Engine to improve desktop fidelity. Additionally, we also found that removing this pixel snapping stabilized a number of our golden image tests, which would frequently change with small hairline rendering differences.

## Changes to supported platforms

### 32-bit iOS deprecation

As we announced earlier with the 3.0 stable release, due to decreased usage, that release was the [last one to support 32-bit iOS devices and iOS versions 9 and 10](https://flutter.dev/go/rfc-32-bit-ios-unsupported). This change affects the iPhone 4S, iPhone 5, iPhone 5C, and the 2nd, 3d, and 4th generation iPad devices. The 3.3 stable version of Flutter and all following stable releases no longer support 32-bit iOS devices and iOS versions 9 and 10. This means that apps built against Flutter 3.3 and later won’t run on those devices.

### Sunsetting macOS 10.11 and 10.12

In the Q4 2022 stable release, we expect to drop support for macOS versions 10.11 and 10.12. This means that apps built against stable Flutter SDKs after that point will no longer work on these versions, and the minimum macOS version supported by Flutter will increase to 10.13 High Sierra.

### Bitcode deprecation

Bitcode [will no longer be accepted for iOS app submission in the upcoming Xcode 14 release](https://developer.apple.com/documentation/xcode-release-notes/xcode-14-release-notes), and projects with bitcode enabled will emit a build warning in this version of Xcode. In light of this, Flutter will drop support for bitcode in a future stable release.

By default, Flutter apps don’t have bitcode enabled, and we don’t expect this to impact many developers. However, if you have enabled bitcode manually in your Xcode project, disable it as soon as you upgrade to Xcode 14. You can do so by opening `ios/Runner.xcworkspace` and setting the build setting **Enable Bitcode** to **No**. Add-to-app developers should disable it in the host Xcode project.

<DashImage figure src="images/04EQPd4ednGIAhMwl.webp" />

See [Apple’s documentation](https://help.apple.com/xcode/mac/11.0/index.html?localePath=en.lproj#/devde46df08a) to learn more about bitcode distribution.

## Summary

As we always say, the Flutter team at Google is extremely grateful for the incredible work the community puts in to make Flutter the wonderful experience that it is! We look forward to continuing to iterate on the work that has been done, focusing on what matters most — all of you!
