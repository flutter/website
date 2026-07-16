---
title: "What’s new in Flutter 3.32"
description: "Hot reload on web, native fidelity, and deeper integrations"
publishDate: 2025-05-20
author: itsjustkevin
image: images/1FTpRgnrZGMzzCjEl4sCmiw.webp
category: release
layout: blog
---

<DashImage figure src="images/1FTpRgnrZGMzzCjEl4sCmiw.webp" />

## What’s new in Flutter 3.32

### Hot reload on web, native fidelity, and deeper integrations

## Introduction

Welcome to Flutter 3.32! This release is packed with features designed to accelerate your development and enhance your apps. Get ready for hot reload on the web, stunning Cupertino squircles for native fidelity, and powerful new AI integrations with Firebase. With 1024 commits from 156 unique contributors, including 39 first time contributors, Flutter 3.32 is a testament to our community’s incredible work. Let’s explore what’s new!

## Web

### Hot reload on the web (Experimental)

We’re excited to announce that you can now hot reload on the web! Web support for hot reload is the [#2 most voted issue](https://github.com/flutter/flutter/issues/53041) on the Flutter tracker. We’re excited to give you a chance to try it out on your own projects! We want your help to make sure this exciting new feature has everything developers want from it.

If you discover any issues, file a bug using Dart’s [Web Hot Reload issue template](https://github.com/dart-lang/sdk/issues/new?template=6_web_hot_reload.yml). You can find a list of known issues on the [Web Hot Reload Known Issues](https://github.com/orgs/dart-lang/projects/107/views/1) GitHub project.

### Now the fun part: how to use the feature

We’ve added a simple command line flag `--web-experimental-hot-reload` that you can pass to Flutter anywhere you invoke `flutter run`.

### Running from VS Code

If you use debug configurations in VS Code, you can add this extra configuration to your [launch.json file](https://code.visualstudio.com/docs/editor/debugging-configuration):

```json
"configurations": [
  …
  {
    "name": "Flutter for web (hot reloadable)",
    "type": "dart",
    "request": "launch",
    "program": "lib/main.dart",
    "args": [
      "-d",
      "chrome",
      "--web-experimental-hot-reload",
    ]
  }
]
```

For best results, we recommend enabling the “[Dart: Flutter Hot Reload On Save](https://code.visualstudio.com/docs/editor/settings)” setting in VS Code. A hot reload can also be triggered with the ⚡icon in the Run/Debug panel. Hot restarts can still be triggered by using the ⟳ button.

### Running from the command line

If you use “flutter run” on the command line, you can now run hot reload on the web with the following:

`flutter run -d chrome --web-experimental-hot-reload`

When hot reload is enabled, you can reload your application by pressing “r” in the running terminal, or “R” to hot restart.

### Reloading in DartPad

Hot reload is also now available on [DartPad](https://dartpad.dev/) with a new **Reload** button. The feature is only available if Flutter is detected in the running application. You can try it using a [sample app](https://dartpad.dev/?sample=counter&channel=main) provided by DartPad.

Thanks for taking the time to help us make Hot Reload on the web amazing!

## Framework

We have continued our effort to move logic from the Material library to the widgets library.

This release introduces a new [`Expansible`](https://main-api.flutter.dev/flutter/widgets/Expansible-class.html) widget that makes it easier to create widgets that expand and collapse with different visual themes. This new widget serves as the underlying building block for the Material-styled [`ExpansionTile`](https://main-api.flutter.dev/flutter/material/ExpansionTile-class.html).

Another valuable addition in this release is [`RawMenuAnchor`](https://main-api.flutter.dev/flutter/widgets/RawMenuAnchor-class.html), contributed by community member [@davidhicks980](https://github.com/davidhicks980). This widget now serves as the underlying building block for the Material-styled [`MenuAnchor`](https://main-api.flutter.dev/flutter/material/MenuAnchor-class.html), paving the way for the creation of menus with diverse visual themes. Furthermore, `RawMenuAnchor` can be used independently as an unstyled menu, granting you full control over its appearance.

<DashImage figure src="images/0uHuGHM5dYCTkF_Vz.webp" />

Refactors like these add better support for core widgets to be used in the implementation of design languages like Cupertino and Material (and more!) with more consistent surfaces and code sharing.

### Cupertino

**Squircles**

We’re pleased to introduce a significant new addition to Flutter’s shape capabilities: the rounded superellipse.

<DashImage figure src="images/0NIsvxkNdRcbgtLdk.gif" />

Often referred to as the “Apple squircle”, this shape is a cornerstone of the iOS design language, known for its smoother and more continuous curves compared to traditional rounded rectangles. Support for this shape was a frequent request from the Flutter community. Its inclusion represents another step in our efforts to provide high-fidelity UI with native look and feel on Apple platforms.

Both `CupertinoAlertDialog` and `CupertinoActionSheet` have been updated to use this new shape!

You can add rounded superellipses to your applications using these new APIs:

1. [`RoundedSuperellipseBorder`](https://main-api.flutter.dev/flutter/painting/RoundedSuperellipseBorder-class.html) for painting or as a widget shape

1. [`ClipRSuperellipse`](https://main-api.flutter.dev/flutter/widgets/ClipRSuperellipse-class.html) for clipping.

1. [`Canvas.drawRSuperellipse`](https://main-api.flutter.dev/flutter/dart-ui/Canvas/drawRSuperellipse.html), [`Canvas.clipRSuperellipse`](https://main-api.flutter.dev/flutter/dart-ui/Canvas/clipRSuperellipse.html), and [`Path.addRSuperellipse`](https://main-api.flutter.dev/flutter/dart-ui/Path/addRSuperellipse.html) for lower-level APIs that offer more direct control.

Please note that the rounded superellipse is under active development. Currently, it’s only supported on iOS and Android, otherwise the behavior falls back to a standard rounded rectangle. Performance optimizations are also ongoing. We encourage you to explore this new feature with these considerations in mind, and we look forward to enhancing its capabilities in future updates!

**Sheet**

There were also several issues addressed with the Cupertino sheet, including fixing how the sheet sets the system UI theme when it opens on Android.

The sheet was adjusted to fix the navigation bar’s height and ensure content isn’t cut off at the bottom. The following screenshot demonstrates before and after this change.

<DashImage figure src="images/0JjkFrjtxjh5tQmql.webp" />

<DashImage figure src="images/0YCBMHZS_mi2vJ92S.webp" />

Other fixes in this release include an issue where the sheet transition was incompatible with `PopupMenuButton`, and the rounded corner transition of the sheet was improved to look correct on more devices. Previously, it looked incorrect on some screens with different corner radii.

You can also now use the new [`enableDrag`](https://main-api.flutter.dev/flutter/cupertino/CupertinoSheetRoute/enableDrag.html) argument on [`CupertinoSheetRoute`](https://main-api.flutter.dev/flutter/cupertino/CupertinoSheetRoute-class.html) and [`showCupertinoSheet`](https://main-api.flutter.dev/flutter/cupertino/showCupertinoSheet.html) to disable the Cupertino bottom sheet’s drag-down-to-dismiss behavior. ([#163923](https://github.com/flutter/flutter/pull/163923))

<DashImage figure src="images/1iEWYohD1vd7FMpPWvK2__A.webp" />

**Navigation bars**

[`CupertinoSliverNavigationBar.search`](https://main-api.flutter.dev/flutter/cupertino/CupertinoSliverNavigationBar/CupertinoSliverNavigationBar.search.html) sees fidelity improvements to its animation while opening or closing the search view, as well as correct alignment of the search field’s prefix and suffix icons.

<DashImage figure src="images/0R1tsiciz-w7OdOjr.webp" />

Finally, the transition between routes with `CupertinoNavigationBars` or `CupertinoSliverNavigationBars` has been updated to match the latest iOS transitions ([#164956](https://github.com/flutter/flutter/pull/164956)).

### Material

This release brings a range of feature enhancements and bug fixes to the Material library, improving both functionality and developer experience.

The feature enhancements include:

* The `CarouselController` provides a more convenient [`animateToIndex`](https://github.com/flutter/flutter/pull/162694) method, enabling a smooth, index-based navigation for carousels, whether with fixed- or dynamically-sized items using `flexWeights`.

<DashImage figure src="images/0nT-5bpsRVyZELaTq.webp" />

* TabBar now has [`onHover`](https://main-api.flutter.dev/flutter/material/TabBar/onHover.html) and [`onFocusChange`](https://main-api.flutter.dev/flutter/material/TabBar/onFocusChange.html) callbacks, giving you more control over the widget’s appearance in different states.

<DashImage figure src="images/0nFVGZ5PG6gTqc_F7.webp" />

* `SearchAnchor` and `SearchAnchor.bar` now include [`viewOnOpen` and `onOpen`](https://github.com/flutter/flutter/pull/164541) callbacks respectively, allowing for better observation and handling of open/close events.

<DashImage figure src="images/0H9mW79LCQEJBJ_i2.webp" />

* [`CalendarDatePicker`](https://main-api.flutter.dev/flutter/material/CalendarDatePicker-class.html) now accepts a [`calendarDelegate`](https://main-api.flutter.dev/flutter/material/CalendarDatePicker/calendarDelegate.html) to enable the integration of custom calendar logic beyond the Gregorian Calendar System. The example demonstrates a hypothetical calendar system where even-numbered months have 21 days, odd-numbered months have 28 days, and every month starts on a Monday, showcasing the flexibility this delegate offers.

<DashImage figure src="images/0uqbdwtRR2oryyhJy.webp" />

Other minor enhancements include adding [`animationStyle`](https://github.com/flutter/flutter/pull/164002) to `showDialog`, `showAdaptiveDialog`, and `DialogRoute` to customize the animation when the dialog is opened and closed; `Divider` now accepts a [`borderRadius`](https://main-api.flutter.dev/flutter/material/Divider/radius.html) to allow customizing the border of the divider, especially when the divider is thick.

Beyond the new features, this release also addresses several bugs related to `DropdownMenu` and `Slider`s in the Material library:

* The `DropdownMenu` widget now allows its menu width to be smaller than the text field. The example has been updated to resolve a previous `RenderFlex` overflow error. The default width of `DropdownMenu` now respects the width of the text label in the text field.

* When hovering over a `RangeSlider` thumb, only the overlay of the hovered thumb appears. Previously, both overlays would incorrectly show up. The `Slider` thumb can now reach both ends of the track when the track color is transparent, overcoming a prior limitation where it could not.

### Accessibility

**Optimized [semantics tree compiling](https://github.com/flutter/flutter/pull/161195)**

This feature reduced semantics compilation time by ~80%. In Flutter for web, this translates to 30% reduction in frame time when semantics is enabled.

**Introducing finely-grained semantics roles**

A new [`SemanticsRole`](https://api.flutter.dev/flutter/dart-ui/SemanticsRole.html) API has been integrated into the `Semantics` widget and its associated components, offering developers more precise control over how UI elements are interpreted by assistive technologies. This enhancement allows for the assignment of specific roles to an entire subtree of widgets by simply wrapping it with a `Semantics` widget configured with the desired role.

A list of available roles is detailed in the [official API documentation](https://api.flutter.dev/flutter/dart-ui/SemanticsRole.html). Currently, this advanced semantics role functionality is available for web-based applications, with support for other platforms coming in future releases.

For more information, see [Enhancing accessibility with semantic roles](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#enhancing-accessibility-with-semantic-roles).

**Other accessibility improvements**

* **Improved user experience for widgets and screen readers:** Better accessibility support and user experience across various widgets, including text fields, focus handling, menus, sliders, and dropdowns. Screen readers now provide more descriptive feedback when users interact with these elements.

* **Smoother web-focus navigation with semantics:** Refined web focus behavior when semantics are enabled, significantly reducing abrupt focus jumps between widgets for a more intuitive navigation experience.

* **Improved link recognition for Android TalkBack:** Android TalkBack now correctly identifies and announces links defined using `Semantics.linkUrl` or the `Link` widget from the `url_launcher` package.

* **Windows high-contrast mode support in Flutter for web:** Introduced support for Windows’ “forced colors” mode (often used in high contrast scenarios). Developers can now set the `useSystemColors` boolean in `ThemeData` to automatically apply system colors to Flutter themes, enhancing visibility for users who rely on these settings.

* **Refined iOS Voice Control experience:** Improved the user experience for iOS Voice Control by ensuring that non-actionable widgets no longer display unnecessary labels, leading to a cleaner and more focused interaction for users.

### Text input

Text input had several improvements in this release:

1. The system text selection context menu was launched on iOS, which is referenced in the iOS section below.

1. The layout of the `Autocomplete` widget’s options were ported to `OverlayPortal`, improving performance and fixing layout bugs.

1. It’s now possible to customize `onTapUpOutside` behavior in text fields ([#162575](https://github.com/flutter/flutter/pull/162575)).

1. Developers can now generate any widget they want as an error message for `FormField` instead of just error text ([#162255](https://github.com/flutter/flutter/pull/162255)).

1. Selectable text in Flutter became less buggy ([#162228](https://github.com/flutter/flutter/pull/162228)) and more performant on web ([#161682](https://github.com/flutter/flutter/pull/161682)).

### Progress on multi-window support

Contributors from Canonical have made excellent progress towards allowing desktop applications to have multiple windows!

Canonical fixed several features that were broken when an app has multiple windows:

1. Accessibility: [#164577](https://github.com/flutter/flutter/pull/164577)

1. App lifecycle notifications: [#164872](https://github.com/flutter/flutter/pull/164872)

1. Focus: [#164296](https://github.com/flutter/flutter/pull/164296)

1. Keyboard events: [#162131](https://github.com/flutter/flutter/pull/162131), [#163962](https://github.com/flutter/flutter/pull/163962)

1. Text input: [#163847](https://github.com/flutter/flutter/pull/163847), [#164014](https://github.com/flutter/flutter/pull/164014)

1. Mouse events: [#163855](https://github.com/flutter/flutter/pull/163855)

Canonical also added a feature that lets Dart code FFI communicate directly to the Flutter engine ([#163430](https://github.com/flutter/flutter/issues/163430)). This lays the foundation for Flutter’s future windowing APIs.

Finally, Canonical introduced a raster thread on Linux ([#161879](https://github.com/flutter/flutter/pull/161879)). This improves frame throughput, ensuring Flutter Linux remains buttery smooth even if you have multiple windows.

### Desktop thread merging

Canonical also updated Windows and macOS to allow apps to merge the UI and platform threads ([#162883](https://github.com/flutter/flutter/pull/162883), [#162935](https://github.com/flutter/flutter/pull/162935)).

Merged threads let you use Dart FFI to interoperate with native APIs that must be called on the platform thread. For example, if you enable merged threads on Windows you can use Dart FFI to resize your app’s window using win32 APIs!

On Windows, you can turn on merged threads by adding the following to your `windows/runner/main.cpp` file, inside the `wWinMain` method:

```cpp
project.set_ui_thread_policy(flutter::UIThreadPolicy::RunOnPlatformThread)
```

On macOS, you can turn on merged threads by adding the following to your `macos/Runner/Info.plist` file, inside the `<dict>` element:

```xml
<key>FLTEnableMergedPlatformUIThread</key>
<true />
```

In a future release, we will turn on merged threads by default on Windows and macOS. Please try this out and [create issues](https://github.com/flutter/flutter/issues/new/choose) if you run into any bugs!

## iOS

We’ve enhanced the pasting experience in Flutter apps on iOS! For basic text fields without custom actions, users will no longer see a confirmation dialog when they paste content from other apps. This is now enabled by default on all Flutter iOS apps. Note, if your app uses custom actions (for example, “Send Email” in context menus), this feature is [not yet supported](https://github.com/flutter/flutter/issues/140184).

## Android

### Kotlin language rewrite of Gradle tooling

Flutter’s Gradle plugin has been converted from Groovy to Kotlin. This transition to Kotlin makes the codebase easier to contribute to, and also facilitates the introduction of unit tests for the plugin. The added tests, as well as the conversion from a dynamically typed and executed language to a statically typed one, should result in a more stable and reliable build process for Flutter developers. We don’t expect any behavior changes as a result of the rewrite, so please [file an issue](https://github.com/flutter/flutter/issues/new/choose) if you notice Android builds behaving differently than you expect.

### Scribe / Stylus support

You can now use your stylus to write into text fields on Android, in the same way that Apple Pencil handwriting input already works on Flutter iOS apps. Users can start writing directly on top of any Flutter text input field, and the handwriting will appear as text in the field. Not all gestures are supported yet, but we are [working to close those gaps](https://github.com/flutter/flutter/issues/156018). This feature is supported on Android 14 and above and can be disabled, if needed, with the [`TextField.stylusHandwritingEnabled`](https://api.flutter.dev/flutter/material/TextField/stylusHandwritingEnabled.html) or [`CupertinoTextField.stylusHandwritingEnabled`](https://api.flutter.dev/flutter/cupertino/CupertinoTextField/stylusHandwritingEnabled.html) parameters.

## Engine

### Impeller on Android

Beginning from the 3.29.3 release, on devices running Android API level 28 (Android 9) and older, Flutter apps will use the legacy Skia renderer. This change improves the stability of Flutter on older Android devices. Impeller continues to be the default renderer on devices running API level 29 (Android 10) and newer.

As we get more feedback from users using different devices, we have adjusted which devices use Impeller’s Vulkan versus OpenGLES backend. In particular, in this release the following devices will use OpenGLES instead of Vulkan: [the Android emulator](https://github.com/flutter/flutter/pull/162454), MediaTek devices with API version less than 31, PowerVR devices older than CXT, and older versions of Samsung’s XClipse GPUs that don’t support Vulkan 1.3.

As in prior releases, you can opt-out of Impeller by following [these instructions](https://docs.flutter.dev/perf/impeller#android). Due to our increasing confidence in Impeller’s stability and performance, the ability to opt-out of Impeller on newer Android devices will be removed in an upcoming stable release.

Finally, Flutter 3.27 has a number of rendering bugs and crashes related to Impeller rendering on Vulkan capable devices that are fixed in 3.29 and later versions. We do not plan to hotfix any of these changes into 3.27 and we highly recommend updating to 3.29 or later. If your application is unable to do so, we recommend opting out of Impeller on Android devices.

### Other Impeller updates

This release improves Impeller’s text rendering. Notably, text animations are smoother with less jitter thanks to higher resolution glyphs in Impeller’s glyph atlas, and fixing rounding errors in floating point calculations. More details can be found in [flutter#149652](https://github.com/flutter/flutter/issues/149652).

<DashImage figure src="images/0yGjm9dQU4oCG5XwG.webp" alt="Before" caption="Before" />

<DashImage figure src="images/0s1EWYhGX9j4qOWB1.webp" alt="After" caption="After" />

This release also includes a variety of other fidelity and performance improvements, including:

* Conic curves are no longer approximated but [tessellated directly](https://github.com/flutter/flutter/pull/166165)

* Partial repaint has been [optimized](https://github.com/flutter/flutter/pull/161626) to avoid frequent memory allocation

* Blur speed has been improved by [removing redundant attachments](https://github.com/flutter/flutter/pull/165137)

* [Fixed orientation](https://github.com/flutter/flutter/issues/164958) of text rotated exactly 180 degrees.

## DevTools and IDEs

### [New] Flutter Property Editor

Easily edit widget properties and read documentation from the new Property Editor tool, which is accessible from the Flutter Property Editor sidebar panel ([VS Code](https://docs.flutter.dev/tools/vs-code#property-editor)) or tool window ([Android Studio / IntelliJ](https://docs.flutter.dev/tools/android-studio#property-editor)).

<DashImage figure src="images/0ZbSuN_xSc7pXkUyC.webp" alt="VSCode" caption="VSCode" />

<DashImage figure src="images/0KoBkOexQ6DyQdnQt.webp" alt="Android Studio & IntelliJ" caption="Android Studio & IntelliJ" />

### DevTools improvements

Additional improvements have been made across DevTools, including new offline support for the Network screen, bug fixes for issues related to review history, inspector errors, the Deep Links tool, and data improvements for the CPU Profiler and Memory screens. This release also includes several performance and memory improvements for DevTools, which will result in faster data load times and fewer memory-related crashes.

These are just a few highlights from this release. To learn more about all the updates included in Flutter 3.32, check out the release notes for DevTools [2.44.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.44.0) and [2.45.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.45.0).

### Analyzer improvements

We have continued to make improvements to the Dart Analyzer, and hence the developer experience. This includes adding “doc imports,” a new comment-based syntax that enables external elements to be referenced in documentation comments without actually importing them. Check out the details on [dart.dev](https://dart.dev/tools/doc-comments/references#doc-imports). We’ve also made several quick fix, assist, and renaming improvements.

### Gemini in Android Studio now speaks fluent Flutter and Dart

Gemini in Android Studio now offers first-class support for Dart and Flutter development! This means you can leverage the power of Gemini directly within your favorite IDE to build beautiful, high-performance Flutter apps faster and easier than ever before.

[Read this blog post](https://medium.com/flutter/gemini-in-android-studio-now-speaks-fluent-flutter-915dfec98274) to learn more.

<DashImage figure src="images/151UZbL3Qb7BGDEuujTTg6A.gif" />

### Dart and Flutter support for the Model Context Protocol ([MCP](https://modelcontextprotocol.io/introduction)) is on the way

Support for the Model Context Protocol ([MCP](https://modelcontextprotocol.io/introduction)) and the recently published [Dart MCP SDK](https://pub.dev/packages/dart_mcp), is actively underway. A new [Dart Tooling MCP Server](https://github.com/dart-lang/ai/tree/main/pkgs/dart_tooling_mcp_server), also under development, will expose Dart and Flutter static, runtime, and ecosystem tooling to MCP clients, such as IDEs.

This will drive the following benefits for Dart and Flutter developers:

* More accurate and relevant code generation.

* Complex tasks — like fixing layout issues, managing dependencies, or even resolving runtime errors — becomes feasible as the MCP protocol exposes semantic information from the *actual Dart and Flutter tools*.

Watch this space!

## Build with AI

### Introducing Firebase AI Logic

You might have heard of, or even used Vertex AI in Firebase, our client SDK for directly integrating Gemini API-driven functionality into your Flutter app.

Many of you asked to use the Gemini Developer API, instead of Vertex AI, to take advantage of the generous free tier and to start adding generative AI at no cost. We heard you! From today, we are evolving Vertex AI in Firebase to Firebase AI Logic that provides access to both Gemini API providers with just one Flutter SDK. It enables you to use Gemini and Imagen models directly from your Flutter app rather than needing a server-side SDK.

Check out the [`firebase_ai`](https://pub.dev/packages/firebase_ai) package for the new functionality. If you’re already using the [`firebase_vertexai`](https://pub.dev/packages/firebase_vertexai) package, it will continue to work as-is for now, but we encourage you to migrate to the new package.

<DashImage figure src="images/0HlInLfTOQSZ3n-NG.webp" />

### Gain Actionable Insights with AI Monitoring dashboard

The new AI Monitoring dashboard in the Firebase console provides detailed, actionable insights into your Gemini API usage. This includes comprehensive visibility into consumption patterns, performance metrics, and potential issues. This enables data-driven decisions and ensures that you’re using the Gemini APIs in the most efficient way. AI Monitoring also helps you to debug your Gemini API usage, and identify and address any unexpected behaviors.

<DashImage figure src="images/0d7zwnDUZqn9bgnoS.webp" />

## Breaking changes and deprecations

### Android accessibility announcements

On Android, semantic announcement events are now [deprecated, as of API 36](https://api.flutter.dev/flutter/semantics/AnnounceSemanticsEvent-class.html#android). Instead, use “polite” implicit announcements by configuring a [`SemanticProperties.liveRegion`](https://api.flutter.dev/flutter/semantics/SemanticsProperties/liveRegion.html). Currently, there is a known limitation when announcing text that should not be focusable. See issue [#165857](https://github.com/flutter/flutter/issues/165857#issue-2945314471) for details on this limitation and the plans to resolve this issue. To see alternative solutions, check the [documentation on SemanticService.announce](https://api.flutter.dev/flutter/semantics/SemanticsService/announce.html).

### Discontinued support for 6 packages

As we planned and shared in our [Flutter 3.29 release blog post](https://medium.com/flutter/whats-new-in-flutter-3-29-f90c380c2317) we have discontinued support for the following packages:

* `flutter_markdown`; see [flutter_markdown planned to be discontinued #162966](https://github.com/flutter/flutter/issues/162966)

* `ios_platform_images`; see [ios_platform_images planned to be discontinued #162961](https://github.com/flutter/flutter/issues/162961)

* `css_colors`; see [css_colors planned to be discontinued #162962](https://github.com/flutter/flutter/issues/162962)

* `palette_generator`; see [palette_generator planned to be discontinued #162963](https://github.com/flutter/flutter/issues/162963)

* `flutter_image`; see [flutter_image discontinued #162964](https://github.com/flutter/flutter/issues/162964)

* `flutter_adaptive_scaffold`; see [flutter_adaptive_scaffold planned to be discontinued #162965](https://github.com/flutter/flutter/issues/162965)

We encourage members of the community to refer to the discussion in each of the issues for alternatives.

### iOS and macOS minimum versions

Flutter will deprecate support for iOS 12 and macOS 10.14 (Mojave) in the next stable release, and will target a minimum of iOS 13 and macOS 10.15 (Catalina). This means that apps built against future versions of Flutter won’t run on iOS 12 or macOS 10.14.

### Other breaking changes

Other breaking changes and deprecations in this release include:

* Deprecated the `ExpansionTileController` in Material in favor of the new reusable [`ExpansibleController`](https://main-api.flutter.dev/flutter/widgets/ExpansibleController-class.html) in the Widgets layer.

* Renamed `SelectionChangedCause.scribble` (which is deprecated), to [`SelectionChangedCause.stylusHandwriting`](https://main-api.flutter.dev/flutter/services/SelectionChangedCause.html#stylusHandwriting), as Apple’s Scribble feature is now unified with Android’s Scribe.

* As part of our continuing work to normalize Material theming, `ThemeData.indicatorColor` is deprecated in favor of [`TabBarThemeData.indicatorColor`](https://main-api.flutter.dev/flutter/material/TabBarThemeData/indicatorColor.html), while the component theme types for `cardTheme`, `dialogTheme`, and `tabBarTheme` will need to be migrated to [`CardThemeData`](https://main-api.flutter.dev/flutter/material/CardThemeData-class.html), [`DialogThemeData`](https://main-api.flutter.dev/flutter/material/DialogThemeData-class.html), and [`TabBarThemeData`](https://main-api.flutter.dev/flutter/material/TabBarThemeData-class.html), respectively.

* The formula for `SpringDescription` in some behaviors has been corrected. This change fixes the problem where the behavior for some parameter combinations would not match expected real-world physics and exhibit discontinuity near the critical damping point. This breakage affects underdamped springs (damping ratio less than 1) with mass values other than 1. Such springs created prior to this change might exhibit different bouncing behaviors after upgrading. To restore previous animation behavior, update your spring parameters according to the [Spring Description Underdamped breaking change guide](https://docs.flutter.dev/release/breaking-changes/spring-description-underdamped), where you can also find [a tool](https://jsfiddle.net/DKWings/6jgvbzps/30/) that calculates the parameter adjustments.

To see migration guides for all deprecations or breaking changes in this release, see the [breaking changes](https://docs.flutter.dev/release/breaking-changes) page. Running `dart fix` after updating will automatically migrate some of these changes for you.

## Conclusion

Flutter 3.32 marks another step forward, powered by the incredible dedication of our community. We’re thrilled to bring you features like web hot reload and continued platform improvements. Your contributions are invaluable, and we can’t wait to see what you build. For a comprehensive overview, check out the detailed release notes and changelog. To get started, simply run `flutter upgrade` and dive into the latest version!
