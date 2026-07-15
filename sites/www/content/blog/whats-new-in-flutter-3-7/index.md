---
title: "What’s new in Flutter 3.7"
description: "Material 3 updates, iOS improvements, and much more!"
publishDate: 2023-01-24
author: itsjustkevin
image: images/1AsyYVtFMXY0iS6gLz_O4BA.png
category: releases
layout: blog
---

We are excited to start 2023 with the release of Flutter 3.7! In Flutter 3.7, we as a community, continue to improve the framework with the addition of some great new features such as: the ability to create custom menu bars, cascading menus, tools to better support internationalization, new debugging tools, and much more.

We also continue to refine features such as global selection, faster rendering with Impeller, DevTools, and as always, performance!

Let’s go on a quick journey together to explore the new features in Flutter 3.7!

## Enhanced Material 3 support

Material 3 support has been greatly enhanced in 3.7 with the migration of the following widgets:

* [`Badge`](https://api.flutter.dev/flutter/material/Badge-class.html)

* [`BottomAppBar`](https://api.flutter.dev/flutter/material/BottomAppBar-class.html)

* [`Filled`](https://api.flutter.dev/flutter/material/FilledButton-class.html) and [`Filled Tonal`](https://api.flutter.dev/flutter/material/FilledButton/FilledButton.tonal.html) buttons

* [`SegmentedButton`](https://api.flutter.dev/flutter/material/SegmentedButton-class.html)

* [`Checkbox`](https://api.flutter.dev/flutter/material/Checkbox-class.html)

* [`Divider`](https://api.flutter.dev/flutter/material/Divider-class.html)

* [`Menus`](https://api.flutter.dev/flutter/material/MenuBar-class.html)

* [`DropdownMenu`](https://api.flutter.dev/flutter/material/DropdownMenu-class.html)

* [`Drawer`](https://api.flutter.dev/flutter/material/Drawer-class.html) and [`NavigationDrawer`](https://api.flutter.dev/flutter/material/NavigationDrawer-class.html)

* [`ProgressIndicator`](https://api.flutter.dev/flutter/material/ProgressIndicator-class.html)

* [`Radio`](https://api.flutter.dev/flutter/material/Radio-class.html) buttons

* [`Slider`](https://api.flutter.dev/flutter/material/Slider-class.html)

* [`SnackBar`](https://api.flutter.dev/flutter/material/SnackBar-class.html)

* [`TabBar`](https://api.flutter.dev/flutter/material/TabBar-class.html)

* [`TextFields`](https://api.flutter.dev/flutter/material/TextField-class.html) and [`InputDecorator`](https://api.flutter.dev/flutter/material/InputDecorator-class.html)

* [`Banner`](https://api.flutter.dev/flutter/widgets/Banner-class.html)

To use these new features just turn on the [`useMaterial3`](https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html) flag in your application’s `[ThemeData](https://api.flutter.dev/flutter/material/ThemeData-class.html) widget.` To take full advantage of M3 support you will want a complete M3 color scheme. You can provide your own, use the new [theme builder](https://m3.material.io/theme-builder#/custom) tool, or Flutter can generate one for you from a single seed color using the `colorSchemeSeed` parameter of the [`ThemeData`](https://api.flutter.dev/flutter/material/ThemeData-class.html) constructor:

```less
MaterialApp(
  theme: ThemeData(
     useMaterial3: true,
    colorSchemeSeed: Colors.green,
  ),
  // …
);
```


For the latest details of Flutter’s Material 3 support, see the [umbrella issue](https://github.com/flutter/flutter/issues/91605) on GitHub.

To play with these components yourself, check out the [interactive demo](https://flutter.github.io/samples/web/material_3_demo/) showing off all the new M3 features:

<DashImage figure src="images/1AsyYVtFMXY0iS6gLz_O4BA.png" />


## Menu bars and cascading menus

Flutter can now create menu bars and cascading context menus.

For macOS, create a menu bar using the `PlatformMenuBar` widget, which defines platform native menu bars rendered by macOS instead of Flutter.

And, for all platforms, you can define a [Material Design menu](https://m3.material.io/components/menus/overview) that provides cascading menu bars ([`MenuBar`](https://api.flutter.dev/flutter/material/MenuBar-class.html)), or standalone cascading menus triggered by another user interface element ([`MenuAnchor`](https://api.flutter.dev/flutter/material/MenuAnchor-class.html)). These menus are fully customizable, and the menu items can be custom widgets, or you can use the new menu item widgets ([`MenuItemButton`](https://api.flutter.dev/flutter/material/MenuItemButton-class.html), [`SubmenuButton`](https://api.flutter.dev/flutter/material/SubmenuButton-class.html)).

<DashImage figure src="images/08T3nUAK-8AUveoD2.webp" />


## Impeller preview

The team is pleased to announce that the new [Impeller rendering engine](https://github.com/flutter/engine/tree/main/impeller) is [ready for preview](https://github.com/flutter/engine/tree/main/impeller#try-impeller-in-flutter) on iOS on the stable channel. We believe the performance of Impeller will meet or exceed the Skia renderer for most apps, and as for fidelity, Impeller implements all but a small number of rarely used corner cases. We expect to make Impeller the default renderer on iOS in a forthcoming stable release, so please continue to file [Impeller feedback](https://github.com/flutter/flutter/issues) on GitHub.

While we are increasingly confident that Impeller on iOS will meet the rendering needs of nearly all existing Flutter apps, there are still a few gaps in API coverage. The small number of remaining gaps are listed [on the Flutter wiki](https://github.com/flutter/flutter/wiki/Impeller#status). Users might also notice minor visual differences in rendering between Skia and Impeller. These minor differences might be bugs, so please don’t hesitate to [file issues](https://github.com/flutter/flutter/issues).

Our progress on Impeller was greatly accelerated by contributions from the community. In particular, GitHub users [ColdPaleLight](https://github.com/ColdPaleLight), [guoguo338](https://github.com/guoguo338), [JsouLiang](https://github.com/JsouLiang), and [magicianA](https://github.com/magicianA) contributed 37 out of 291 (&gt;12%) Impeller-related patches to this release. Thank you!

We continue to make progress on a Vulkan backend for Impeller (with fallback to OpenGL on older devices), but Impeller on Android isn’t yet ready for preview. Android support is under active development, and we hope to share more about it — with more news about support for desktop and web — in future releases.

Follow along with our progress in the [Impeller project board](https://github.com/orgs/flutter/projects/21) on GitHub.

## iOS release validation

When you release an iOS app, a [checklist of settings to update](https://docs.flutter.dev/deployment/ios#review-xcode-project-settings) ensures that your app is ready for submission to the App Store.

The `flutter build ipa` command now validates some of these settings, and informs you if there are changes that should be made to your app before release.

<DashImage figure src="images/0nMxlWBkYUzlFdnI2.webp" />


## DevTools updates

In this release, there are several new tooling features and overall improvements to try out. The DevTools Memory debugging tool has undergone a complete overhaul. There are three new feature tabs, **Profile**, **Trace**, and **Diff**, that support all the previously supported memory debugging features and added more for your debugging ease. New features include the ability to analyze the current memory allocation for your app by class and memory type, investigate what code paths are allocating memory for a set of classes at runtime, and diff memory snapshots to understand memory management between two points in time.

<DashImage figure src="images/0i5K5F5bxN_5X0EAi.webp" />


All of these new memory features have been documented on [docs.flutter.dev](https://docs.flutter.dev/development/tools/devtools/memory), so check out the documentation for more details.

The Performance page also has a couple notable new features. A new **Frame Analysis** tab at the top of the Performance page provides insights for the selected Flutter frame. Insights might include suggestions on how to trace expensive parts of the Flutter frame in more detail, or warnings about expensive operations detected in the Flutter frame.

<DashImage figure src="images/0op4bHcx7HvorMKSE.webp" />


These are just a couple highlights, but this release contains several bug fixes and improvements beyond the features mentioned here, including some important bug fixes for the Inspector, the Network profiler, and the CPU profiler. For a more in-depth list of updates, check out the release notes for the DevTools changes that made it into Flutter 3.7.

* [Flutter DevTools 2.17.0 release notes](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.17.0)

* [Flutter DevTools 2.18.0 release notes](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.18.0)

* [Flutter DevTools 2.19.0 release notes](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.19.0)

* [Flutter DevTools 2.20.0 release notes](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.20.0)

## Custom context menus

You can now create custom context menus anywhere in a Flutter app. You can also use them to customize built-in context menus.

For example, you could add a “Send email” button to the default text selection toolbar that shows up when the user has selected an email address ([code](https://github.com/flutter/samples/blob/main/experimental/context_menus/lib/email_button_page.dart)). See the [`contextMenuBuilder`](https://api.flutter.dev/flutter/cupertino/CupertinoTextField/contextMenuBuilder.html) parameter, which has been added to existing widgets that show a context menu by default, like `TextField`. You can return any widget you want from `contextMenuBuilder`, including modifying the default platform-adaptive context menu.

<DashImage figure src="images/0dYBqWaVEAscMJ2Yz.webp" />


This new feature works outside of text selection, too. You could, for example, create an `Image` widget that shows a **Save** button when right clicked or long pressed ([code](https://github.com/flutter/samples/blob/main/experimental/context_menus/lib/image_page.dart)). Use [`ContextMenuController`](https://api.flutter.dev/flutter/widgets/ContextMenuController-class.html) to display the current platform’s default context menu, or a custom one, anywhere in your app.

<DashImage figure src="images/0uq8A_Zq5BM2DGDRT.webp" />


See a full suite of examples in [Flutter’s samples repository](https://github.com/flutter/samples/tree/main/experimental/context_menus).

## CupertinoListSection and CupertinoListTile widgets

Thanks to the efforts of the Github user [Campovski](https://github.com/campovski), Cupertino has two new widgets, [`CupertinoListSection` and `CupertinoListTile`](https://github.com/flutter/flutter/pull/78732), for showing a scrollable list of widgets in the iOS style. They are the Cupertino versions of `ListView` and `ListTile` in Material.

<DashImage figure src="images/07rMA1GAEoQxfkwYC.webp" />


<DashImage figure src="images/0oLSR3-_9jQzCozYV.webp" />


## Scrolling improvements

Several [scrolling updates](https://github.com/flutter/flutter/issues?page=1&q=is%3Aissue+is%3Aclosed+closed%3A2022-07-11..2022-11-30+label%3A%22f%3A+scrolling%22+reason%3Acompleted) have arrived with this release: polish and refinement for trackpad interactions, new widgets like `Scrollbars` and `DraggableScrollableSheet`, and improved handling for text selection within scrolling contexts.

Notably, MacOS apps will now experience higher fidelity with the addition of [new scrolling physics](https://github.com/flutter/flutter/pull/108298) to match the desktop platform.

New [`AnimatedGrid`](https://github.com/flutter/flutter/pull/112982) and `SliverAnimatedGrid` widgets animate items added to (or removed from) a list.

<DashImage figure src="images/0SY_JFBrqhg_Gs64Z.gif" />


Lastly, we [fixed a regression](https://github.com/flutter/flutter/pull/108706) in the builder constructor of several scrolling widgets, like `ListView`. During the NNBD migration of the Flutter framework, the `itemBuilder`, which allows users to provide widgets on demand, was migrated to an `IndexedWidgetBuilder`. This meant that the `itemBuilder` could no longer return `null`, which (in the past) could be used to indicate that the end of the list had been reached. This functionality was restored with `NullableIndexedWidgetBuilder`. Thanks to @rrousselGit for noticing this — years after the migration — and sending a fix!

## Internationalization tools and docs

Internationalization support has been completely revamped! We’ve completely rewritten the `gen-l10n` tool to support:

* Descriptive syntax errors.

* Complex messages involving nested/multiple plurals, selects, and placeholders.

<DashImage figure src="images/0VSZRJbLyqlfekARB.webp" />


For more information, see the updated [Internationalizing Flutter apps](https://docs.flutter.dev/development/accessibility-and-localization/internationalization) page.

## Global selection improvements

`SelectionArea` now supports keyboard selections. You can extend an existing selection with keyboard shortcuts such as `shift+right`.

<iframe src="https://vimeo.com/792060738" width="796" height="616" frameborder="0" allowfullscreen></iframe>


## Background isolates

Now [Platform Channels](https://docs.flutter.dev/development/platform-integration/platform-channels) can be invoked from any [`Isolate`](https://docs.flutter.dev/development/packages-and-plugins/background-processes). Previously, users were only able to invoke Platform Channels from Flutter’s supplied main isolate. This makes working with isolates and host platform code in [Plugins](https://docs.flutter.dev/development/packages-and-plugins/developing-packages) or [Add-to-app](https://docs.flutter.dev/development/add-to-app) better. For more information, check out [Writing custom platform-specific code](https://docs.flutter.dev/development/platform-integration/platform-channels) on flutter.dev, and the in-depth article, [Introducing background isolate channels](https://medium.com/flutter/introducing-background-isolate-channels-7a299609cad8), a free article on Medium.

## Text magnifier

The magnifying glass that appears during text selection on Android and iOS now works in Flutter. This is enabled out of the box for all apps with text selection, but if you want to disable or customize it, see the [magnifierConfiguration](https://master-api.flutter.dev/flutter/material/TextField/magnifierConfiguration.html) property.

<DashImage figure src="images/0vuIpoOEp5lqEZYeW.webp" />


<DashImage figure src="images/0FIlFtTa6DAlXUwqE.webp" />


## Swift migration for plugins

With Apple focusing on Swift for their own APIs, we wanted to develop references to help Flutter plugin developers migrate or create new plugins with Swift. The [quick_actions](https://pub.dev/packages/quick_actions) plugin has been migrated from Objective-C to Swift, and can be used as a demonstration of best practices. If you are interested in helping us migrate 1P plugins, see [the Swift migration section](https://github.com/flutter/flutter/wiki/Contributing-to-Plugins-and-Packages#swift-migration-for-1p-plugins) of the wiki.

**Resources for iOS developers**

We have published several new resources for iOS developers, including:

* [Flutter for SwiftUI developers](https://docs.flutter.dev/get-started/flutter-for/ios-devs?tab=swiftui)

* [Dart for Swift developers](https://dart.dev/guides/language/coming-from/swift-to-dart)

* [Flutter concurrency for Swift Developers](https://docs.flutter.dev/resources/dart-swift-concurrency)

* [Adding Flutter to an existing SwiftUI app](https://docs.flutter.dev/development/add-to-app/ios/add-flutter-screen)

* [Creating flavors with Flutter](https://docs.flutter.dev/deployment/flavors) (for both Android and iOS)

## Bitcode deprecation

[Starting with Xcode 14, bitcode is no longer required for watchOS and tvOS applications, and the App Store no longer accepts bitcode submissions from Xcode 14.](https://developer.apple.com/documentation/xcode-release-notes/xcode-14-release-notes) As such, bitcode support has been removed from Flutter.

By default, Flutter apps don’t have bitcode enabled, and we don’t expect this to impact many developers. However, if you have enabled bitcode manually in your Xcode project, disable it as soon as you upgrade to Xcode 14. You can do so by opening `ios/Runner.xcworkspace` and set **Enable Bitcode** to **No**. Add-to-app developers should disable it in the host Xcode project.

<DashImage figure src="images/0OQtroLJAJcetxyeV.webp" />


To learn more about bitcode distribution, Check out [Apple’s documentation](https://help.apple.com/xcode/mac/11.0/index.html?localePath=en.lproj#/devde46df08a).

## iOS PlatformView BackdropFilter

We’ve added the ability for native iOS views to be blurred when rendered underneath a blurred Flutter widget, and `UiKitView` widgets can now be wrapped inside a `BackdropFilter`.

<DashImage figure src="images/0kdYw1nYkT8aKHjZP.webp" />


For more information, see the [iOS PlatformView BackdropFilter](https://flutter.dev/go/ios-platformview-backdrop-filter-blur) design doc.

## Memory management

This release introduces a few improvements to memory management that have the collective effect of reducing jank caused by garbage collection pauses, reducing CPU utilization due to allocation velocity and background GC threads, and reducing the memory footprint.

As one example, we have expanded the existing practice of manually deallocating native resources that back certain `dart:ui` Dart objects. Previously, the native resources would be held by the Flutter engine until the Dart VM garbage collected the Dart objects. Through the analysis of user applications and our own benchmarks, we determined that this strategy in general doesn’t do enough to avoid ill-timed GCs and overuses memory. Therefore, in this release, the Flutter engine adds API for explicitly deallocating the native resources held by `Vertices`, `Paragraph`, and `ImageShader` objects.

<DashImage figure src="images/0LmVDzMTW34id5CNV.webp" />


In our benchmarks of the Flutter framework migrated to this API, these improvements reduced 90%-ile frame build times up to more than 30%, which end-users will experience as smoother animations with less jank.

Additionally, the Flutter engine [no longer registers](https://github.com/flutter/engine/pull/35473) the size of GPU images with the Dart VM. As above, these images were already manually deallocated by the framework when no longer needed, so informing Dart’s GC policies of the size of the GPU memory backing the Dart heap objects needlessly increased Dart heap memory pressure, triggering ill-timed GCs that could not have collected any additional memory. Along similar lines, it’s now the policy of the Flutter engine to report to the Dart VM [only the shallow size](https://github.com/flutter/engine/pull/35813) of the native objects that back `dart:ui` Dart objects.

<DashImage figure src="images/0P_s-0gE5JGUerDkA.webp" />


In our benchmarks, this change eliminates synchronous GC work while building frames when a widget creates GPU resident images.

In this release, the Flutter Engine also does a better job of dynamically updating the Dart VM with information about Flutter application state. In particular, Flutter now uses the Dart VM’s [RAIL](https://web.dev/rail/) style [API](https://github.com/dart-lang/sdk/commit/c6a1eb1b61844b2d733f9e2f4c7754f1920325d7) to enter a [low-latency mode during route transition animations](https://github.com/flutter/flutter/pull/110600). During this low-latency mode, the Dart VM’s memory allocator prefers heap growth over garbage collection to avoid interrupting transition animations with GC pauses. While this change didn’t entail any dramatic performance improvement, we plan to expand usage of this model in future releases to further eliminate ill-timed GC pauses. Additionally, we have [fixed errors](https://github.com/flutter/engine/pull/37737) in the logic that decides when to notify the Dart VM that the Flutter engine is idle. Fixing these errors also prevents GC-related jank. Finally, for add-to-app Flutter applications, the Flutter engine now [informs the Dart VM](https://github.com/flutter/engine/pull/37539) when the Flutter view is no longer displayed. This now causes the Dart VM to trigger a final major GC for the `Isolate` associated with the view. This change reduces Flutter’s memory footprint when no Flutter views are visible.

## Sunsetting macOS 10.11 through 10.13

As [previously announced](https://medium.com/flutter/whats-new-in-flutter-3-3-893c7b9af1ff#19cd), Flutter no longer supports macOS versions 10.11 and 10.12. Since that announcement, [further analysis](https://github.com/flutter/flutter/issues/114445) revealed that removing support for 10.13 as well would have limited additional impact, and would help the team to greatly simplify the codebase. This means that apps built against stable Flutter SDKs with this release and onward will no longer work on these versions, and the minimum macOS version supported by Flutter increases to 10.14 Mojave.

As a consequence, since all versions of iOS and macOS supported by Flutter include Metal support, the OpenGL backend has been removed from both the iOS and macOS embedders. Removing these backends reduced the compressed size of the Flutter engine by about 100KB.

## toImageSync

This release [adds the methods](https://github.com/flutter/engine/pull/33736) `Picture.toImageSync` and `Scene.toImageSync` to `dart:ui`, analogous to the asynchronous methods `Picture.toImage`, and `Scene.toImage.Picture.toImageSync` synchronously returns a handle to an `Image` from a `Picture`, with the rasterization for the `Image` taking place asynchronously in the background. The image is then kept as GPU resident when a GPU context is available, meaning that it is faster to draw compared to images produced by `toImage`. (Images produced by `toImage` could also be kept GPU resident, but this optimization has not yet been implemented in that scenario.)

The new `toImageSync` APIs support use-cases, such as:

* Quickly snapping off an expensive-to-rasterize picture for reuse across multiple frames.

* Applying multi-pass filters to a picture.

* Applying custom shaders.

As one example, the Flutter framework [now uses this API](https://github.com/flutter/flutter/pull/106621) to improve the performance of page transitions on Android, which nearly halves frame rasterization times, reduces jank, and allows the animation to hit 90/120fps on devices that support those refresh rates.

## Custom shader support improvements

This release includes numerous improvements to Flutter’s support for custom fragment shaders. The Flutter SDK now includes a shader compiler that compiles GLSL shaders listed in the `pubspec.yaml` file to the correct backend-specific format for the target platform. Additionally, custom shaders can now be hot reloaded for a convenient development cycle. Custom shaders are also now supported by both the Skia and Impeller backends on iOS.

We are very impressed by the demos that the community has already shared, and are excited to see further innovative use of custom shaders in Flutter:

[https://twitter.com/reNotANumber/status/1599717360096620544](https://twitter.com/reNotANumber/status/1599717360096620544)

[https://twitter.com/reNotANumber/status/1599810391625719810](https://twitter.com/reNotANumber/status/1599810391625719810)

[https://twitter.com/wolfenrain/status/1600242975937687553](https://twitter.com/wolfenrain/status/1600242975937687553)

[https://twitter.com/iamjideguru/status/1598308434608283650](https://twitter.com/iamjideguru/status/1598308434608283650)

[https://twitter.com/rxlabz/status/1609975128758026247](https://twitter.com/rxlabz/status/1609975128758026247)

[https://twitter.com/RealDevOwl/status/1528357506795421698](https://twitter.com/RealDevOwl/status/1528357506795421698)

[https://twitter.com/TakRutvik/status/1601380047599808513](https://twitter.com/TakRutvik/status/1601380047599808513)

[https://twitter.com/wolfenrain/status/1600601043477401606](https://twitter.com/wolfenrain/status/1600601043477401606)

See detailed documentation for [writing and using custom fragment shaders](https://docs.flutter.dev/development/ui/advanced/shaders) on docs.flutter.dev, and a helpful package of utilities, [`flutter_shaders`](https://pub.dev/packages/flutter_shaders) on pub.dev.

## Font asset hot reload

Previously, adding new fonts to the `pubspec.yaml` file required rebuilding the application to see them, unlike other asset types that could be hot reloaded. Now changes to the font manifest, including additions of new fonts, can be hot reloaded into an application.

## Reduce animation jank on iOS devices

Thanks to open source contributions from [luckysmg](https://github.com/luckysmg), two improvements have reduced animation jank on iOS. In particular, [the addition](https://github.com/flutter/engine/pull/35592) of a dummy `CADisplayLink` on the main thread during gestures now forces refreshes at the max refresh rate. Also, keyboard animations [now set](https://github.com/flutter/engine/pull/34871) the refresh rate of the `CADisplayLink` to the same refresh rate used by Flutter engine’s animator. Thanks to these changes, users should notice more consistently smooth animations on 120Hz iOS devices.

## Summary

It is an understatement to say that Flutter would not be the amazing experience that it is today without its community of talented and passionate contributors. As we continue this journey together, the Flutter team at Google wants you all to know that we could not do this without you. Thank you!

The momentum isn’t slowing down, stay tuned for future updates!