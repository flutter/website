---
title: "What’s new in Flutter 3.35"
description: "Hot Reload, Widget Previews, and More"
publishDate: 2025-08-14
author: itsjustkevin
image: images/1KLn6ye1qAU9vAI3zgIhLCg.png
category: releases
layout: blog
---

<DashImage figure src="images/1KLn6ye1qAU9vAI3zgIhLCg.png" />


## What’s new in Flutter 3.35

### Hot Reload, Widget Previews, and More

## Introduction

Welcome to the quarterly release of Flutter 3.35! This update is all about boosting your productivity, and brings the stable release of stateful hot reload on the web and the experimental launch of Widget Previews! Through the efforts of our community, Flutter 3.35 includes 1108 commits from 168 unique contributors, with 39 of them joining us for the first time. Let’s explore what’s new!

## Web

### Stateful hot reload on the web is now enabled by default

We’re thrilled to announce this milestone for Flutter on the web and welcome everyone to add hot reload into their web development workflow.

The positive feedback and issue reports we received during the experimental phase helped a lot. The Dart and Flutter web teams have been hard at work to improve the performance of hot-reloaded code while ensuring that more code changes can be successfully hot reloaded.

Our goal is to provide a seamless and consistent hot reload experience across all platforms. While you can still disable this feature using a flag, we plan to remove that ability in a future release.

### Wasm dry runs

In anticipation of enabling WebAssembly (Wasm) as the default web build target, every JS build now performs a “dry run” compilation to Wasm. A series of checks determines the Wasm-readiness of your application, and any findings are emitted to the console as warnings. This feature can be toggled with the `--(no-)wasm-dry-run` flag.

### What’s new?

Previously, you had to explicitly enable stateful hot reload on the web using an experimental flag. Now, when you run your Flutter web application, stateful hot reload is available out of the box! Whether you run your Flutter web application from the command line or launch it from your IDE or coding agent, just run it in development mode and hot reload freely.

The `--web-experimental-hot-reload` flag is no longer necessary to enable hot reload and you can remove it from your workflow or any IDE launch configurations you may have configured.

### **Feedback**

We know everyone can have a slightly different development environment, so if yours is broken by this change, you can disable hot reload with the flag `--no-web-experimental-hot-reload` for now. If you discover any issues, please file a bug using Dart’s [web hot reload issue template](https://github.com/dart-lang/sdk/issues/new?template=5_web_hot_reload.yml). For more information, see the [hot reload on the web documentation](https://docs.flutter.dev/platform-integration/web/building#hot-reload-web).

### **What’s next?**

Current active work will bring hot reload to more development environments, including `-d web-server`. We expect this will unlock more of your productivity while developing on the web, so keep an eye out for future releases!

## Framework

### A more inclusive and accessible experience

Making applications accessible to all users is a cornerstone of the Flutter framework. This release continues our commitment with a host of improvements that give developers more control and refine the out-of-the-box experience for users of assistive technologies.

**Richer semantics on the web**

We’ve made significant strides in how Flutter web apps communicate with screen readers and other tools. For international users, we’ve added support for semantics locales ([#171196](https://github.com/flutter/flutter/pull/171196)), ensuring that accessibility features are presented in the user’s preferred language.

**New tools for building accessible widgets**

Developers now have more powerful tools to create sophisticated accessible experiences. The new `SemanticsLabelBuilder` widget ([#171683](https://github.com/flutter/flutter/pull/171683)) simplifies the process of combining multiple data points into a single, coherent announcement without messy string concatenation.

For complex scrollable views, the new `SliverEnsureSemantics` widget ([#166889](https://github.com/flutter/flutter/pull/166889)) can be used to wrap slivers, ensuring they are always represented in the semantics tree, even when scrolled out of view.

**Core widget and platform polish**

This release is packed with fixes that polish the accessibility of core widgets.

* On iOS, the `CupertinoSliverNavigationBar` now correctly respects accessible text scaling ([#168866](https://github.com/flutter/flutter/pull/168866)), and VoiceOver tab activation behavior now works correctly ([#170076](https://github.com/flutter/flutter/pull/170076)).

* For Android, Talkback issues now work when using platform views ([#168939](https://github.com/flutter/flutter/pull/168939)), a critical fix for apps that embed native components.

* Semantics properties for `CustomPainter` ([#168113](https://github.com/flutter/flutter/pull/168113)) are now backfilled, empowering you to make your custom-drawn UI fully accessible.

* The text selection toolbar is now correctly aligned for right-to-left (RTL) languages, improving the experience for a global audience ([#169854](https://github.com/flutter/flutter/pull/169854)).

### Material and Cupertino: More power and polish

The Material and Cupertino libraries continue to evolve, giving you more control over your app’s look and feel.

**New and enhanced components**

We’ve added brand new, highly requested components and shipped significant enhancements to existing ones.

* **Introducing DropdownMenuFormField ([#163721](https://github.com/flutter/flutter/pull/163721)):** You can now easily integrate the M3 `DropdownMenu` directly into your forms.

* **Scrollable NavigationRail ([#169421](https://github.com/flutter/flutter/pull/169421)):** The `NavigationRail` can now be configured to scroll for cases where you have more destinations than can fit on the screen.

* **NavigationDrawer header and footer ([#168005](https://github.com/flutter/flutter/pull/168005)):** You can now add a header and footer to the `NavigationDrawer`, providing more layout flexibility.

* **Introducing CupertinoExpansionTile ([#165606](https://github.com/flutter/flutter/pull/165606)):** Create expandable and collapsible list items with the new `CupertinoExpansionTile` widget.

<DashImage figure src="images/1Npm3gOKVmU1hMq4ujCPxCg.gif" />


**Higher fidelity and interactivity**

A key theme for this release was polishing our widgets to be as pixel-perfect as we can make them and behaviorally cohesive as their native counterparts.

* Many Cupertino widgets have been updated to use the `RSuperellipse` shape ([#167784](https://github.com/flutter/flutter/pull/167784)), giving them the signature continuous-corner look that iOS users expect.

* To make apps feel more alive and native, we’ve added haptic feedback to key interactive components like the `CupertinoPicker` ([#170641](https://github.com/flutter/flutter/pull/170641)) and `CupertinoSlider` ([#167362](https://github.com/flutter/flutter/pull/167362)).

* The `Slider`’s value indicator can now be configured to be always visible ([#162223](https://github.com/flutter/flutter/pull/162223)).

### More from the framework

This release includes a number of powerful new features and refinements for some of the framework’s most essential parts, giving you more granular control over complex UI.

**More powerful slivers**

For developers building sophisticated scrolling experiences, you can now explicitly control the **paint order (or z-order) of slivers** ([#164818](https://github.com/flutter/flutter/pull/164818)), making it possible to correctly implement advanced effects like “sticky” headers that overlap other slivers without visual glitches.

**Finer-grained control over navigation and forms**

We’ve added several new features to give you more control over your app’s navigation and routing.

* **Fullscreen dialogs ([#167794](https://github.com/flutter/flutter/pull/167794)):** The property `fullscreenDialog` was added to ModalRoute (plus all its descendants) and to `showDialog`. This enables customizing navigation behavior to and from dialog routes.

* **Form Improvements ([#167060](https://github.com/flutter/flutter/pull/167060)):** `FormField` now includes an onReset callback, making it easier to handle form clearing logic.

**Multi-window support (engine)**

Our friends at Canonical continue to make excellent progress on adding support for multi-window applications! In this release, they landed the foundational logic to create and update windows in Windows and macOS ([#168728](https://github.com/flutter/flutter/pull/168728)). Subsequent releases will update Linux and introduce experimental APIs to expose multi-window functionality. Stay tuned!

**Text input and selection refinements**

Text input is a fundamental part of the user experience, and this release brings several refinements to make it more powerful and predictable.

* **A more unified gesture system:** The introduction of the `PositionedGestureDetails` interface ([#160714](https://github.com/flutter/flutter/pull/160714)) unifies the details for all pointer-based gestures and allows you to write more generic gesture-handling code.

* **iOS single-line scrolling ([#162841](https://github.com/flutter/flutter/pull/162841)):** To better align with native iOS behavior, single-line text fields are no longer scrollable by the user.

**Android home/end key support ([#168184](https://github.com/flutter/flutter/pull/168184)):** We’ve added support for the `Home` and `End` keyboard shortcuts on Android.

### Looking forward: Decoupling Flutter’s design libraries

As the Flutter ecosystem continues to grow and mature, so too must the core framework. A key part of this maturation is ensuring that all parts of Flutter can evolve at the pace that best serves the community.

To that end, we are beginning the process of moving the Material and Cupertino libraries out of the core Flutter framework and into their own standalone packages. We are just getting started on this work and, as always, are doing so openly and in collaboration with our contributor community.

**Why is this changing?**

This evolution will allow the Material and Cupertino libraries to innovate and release updates more frequently, independent of the quarterly Flutter release cycle. It also empowers the community to contribute more directly to the UI libraries they use every day. For the core framework, this change will lead to a more focused and stable foundation.

**What does this mean for you?**

There are no immediate changes to your workflow. This is the start of a long-term project, and we are committed to making the eventual transition as smooth as possible. We invite you to follow our progress, learn more about the plan, and share your feedback.

* To read the detailed vision and rationale, see: **[Decoupling Design in Flutter](https://docs.google.com/document/d/189AbzVGpxhQczTcdfJd13o_EL36t-M5jOEt1hgBIh7w/edit?usp=sharing).**

* To provide feedback and help coordinate the work, please [join the discussion on GitHub](https://github.com/flutter/flutter/issues/101479).

This is a natural evolution for a mature and thriving ecosystem. We believe this change will lead to stronger and more agile Material and Cupertino libraries, with an even greater opportunity for community collaboration.

## iOS

### iOS 26 and Xcode 26 beta compatibility

We are actively working on Flutter’s compatibility with the [iOS 26 betas](https://www.apple.com/os/ios/). Please help us by testing your apps and plugins on the latest beta releases and [filing any new issues](https://github.com/flutter/flutter/issues/new/choose) you discover. You can track our progress and see a list of known issues in this [GitHub project](https://github.com/orgs/flutter/projects/212).

## Android

### Sensitive content protection

On Android, you can now protect sensitive user content during media projection by using the `SensitiveContent` widget in your Flutter app. With API 35 and later, you can use this widget to obscure the entire screen during a screen share and help prevent data theft. For more details on this feature and how to use it, check out [Protect sensitive content](https://docs.flutter.dev/platform-integration/android/sensitive-content).

## Engine

### General engine updates

3.35 continues to focus on improving Impeller performance and compatibility. Investments have also been made to adopt `UISceneDelegate` for iOS and to introduce additional tooling improvements. Some notable additions are below.

**Engine**

* Optimization: App startup time has been reduced by performing initialization on a new thread.

**Impeller**

* Optimization: Removed MSAA from intermediate targets.

* Fidelity: Removed lossy texture compression default.

* Fix: Fixed stuck `MaskFilter` in subsequent draws.

* Optimization: Path rendering.

* New: Added Vivante GPU support.

* Optimization: `DrawImageNine` now use fast Porter Duff blends.

* Fix: Fixed memory leak in VideoPlayer

* Fidelity: Increased blur radius calculation for cleaner blurs with large sigmas.

**iOS**

* Fix: Resolved crash in `WebView` wrapped with `ClipRSuperellipse`.

* Fix: Image decoding now works when launching apps in the background from a remote notification.

* Revival: Brought back Live Text (OCR) option to text fields.

**Android**

* Migration: template project migrated to Android 24.

* Fix: Fixed crash on Android &lt;= 14 from background image readers.

* Fix: Fixed uniform arrays in fragment shaders for OpenGLES Impeller.

* Fix: Fixed upside down fragment shader passes in OpenGLES Impeller.

* Fix: Fixed crash in `FlutterEngineGroup`.

**macOS**

* Fix: Fixed Display P3 colors.

## DevTools and IDEs

### The Dart and Flutter MCP Server is now in the stable channel

The experimental [Dart and Flutter MCP Server](https://dart.dev/tools/mcp-server) is now available on the stable channel of the Dart SDK. This marks a major step forward in our vision for a highly productive, AI-assisted development experience for every Dart and Flutter developer.

**Enhanced Dart and Flutter context for AI coding assistants**

The Dart and Flutter MCP Server acts as a bridge, giving AI coding assistants access to even more of your project’s context via the Dart and Flutter toolchain. Instead of just suggesting code, your AI assistant can now understand your project deeply and take action on your behalf. This allows you to stay focused on your goals while the AI handles the mechanics.

With the Dart and Flutter MCP Server, you can ask your AI assistant to:

* **Fix runtime errors**: Inspect the live widget tree, identify a Flutter RenderFlex overflow, and apply the correct fix automatically.

* **Manage dependencies**: Find the best package on pub.dev for a specific task, add it to your `pubspec.yaml`, and run `pub get`.

* **Write and correct code**: Generate the boilerplate for a new feature, and then self-correct any analysis errors it introduces along the way.

* And more….

**Connect to your favorite AI tools**

By connecting your favorite AI tools like Gemini Code Assist, Firebase Studio, Gemini CLI, GitHub Copilot, and Cursor to the Dart and Flutter MCP Server, you can unlock a new level of productivity.

For a comprehensive guide on what the Dart and Flutter MCP Server can do and how to configure it in your editor of choice, check out our detailed blog post [Supercharge Your Dart & Flutter Development Experience with the Dart and Flutter MCP Server](https://medium.com/flutter/supercharge-your-dart-flutter-development-experience-with-the-dart-mcp-server-2edcc8107b49), and [the documentation](https://dart.dev/tools/mcp-server).

<DashImage figure src="images/13K1rgoDtIBWbIFZPp1VCEQ.gif" alt="*Fixing a layout issue, enabled by the Dart and Flutter MCP Server (Note: For brevity, parts of this recording have been sped up.)*" caption="*Fixing a layout issue, enabled by the Dart and Flutter MCP Server (Note: For brevity, parts of this recording have been sped up.)*" />


### DevTools updates

We’ve continued to make general, UX, and performance updates to DevTools. To learn more about all the updates included in Flutter 3.35, check out the release notes for DevTools [2.46.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.46.0), [2.47.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.47.0) and [2.48.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.48.0).

### Experimental Widget Previews are here!

A highly-requested feature from the community is the ability to preview widgets in isolation, similar to tools available in other modern UI toolkits. We’ve heard you, and today, we’re thrilled to take the first step in addressing this with an early experimental version of **Flutter Widget Previews**, now available in the stable channel!

Flutter’s stateful hot reload is already best-in-class for iterating quickly on a running application. Widget previews complements this by allowing you to visualize and test your widgets in a sandboxed environment, completely separate from a full app. This is invaluable when building out a design system or testing a component across a matrix of different configurations, such as various screen sizes, themes, and text scales, all at once and side-by-side.

<DashImage figure src="images/1lbPiKmVYKfvwC8v20DuGWA.gif" alt="*Experimenting with theming in Widget Previews*" caption="*Experimenting with theming in Widget Previews*" />


This is an early, experimental release, and your feedback is critical in shaping its future. The APIs and user experience are not yet stable and will change as we learn from you. Based on early feedback, we are already planning future enhancements, including:

1. **Tighter IDE integration**: We plan to move beyond the current separate browser window to offer an optional, embedded preview pane directly within VS Code, Android Studio and IntelliJ IDEA.

1. **Generic theming support**: As we move forward with our plan mentioned earlier in this blogpost to decouple the Material and Cupertino design libraries from the core framework, Widget Previews will evolve to support custom and generic design systems more effectively.

We are incredibly excited to get this into your hands. To get started, check out the documentation and let us know what you think!

* **Read the docs**: **[**Getting Started with Flutter Widget Previewer (Experimental)](https://docs.flutter.dev/development/tools/widget-previewer)

* **Give feedback**: File issues and feature requests in the[ Flutter GitHub repository](https://github.com/flutter/flutter/issues/new/choose).

* **Learn more**: For a technical deep-dive, see the[ Flutter Widget Previews Architecture document](https://flutter.dev/go/widget-previews-architecture).

### Analysis Server speed improvements

The [dart command-line tool](https://dart.dev/tools/dart-tool) commands that use the analysis server now run the AOT-compiled analysis server snapshot. These include `dart analyze`, `dart fix`, and `dart language-server`.

There is no functional difference when using the AOT-compiled analysis server snapshot, but various tests indicate that there is a significant speedup in the time to analyze a project. Check out the change in stats when we ran some common commands on a sample package after this update:

<DashImage figure src="images/1HQ1LCGF02lv7OmBz_lJ4-Q.png" />


Results vary depending on the source code, but in general, some short commands like formatting now complete in a fraction of the time and longer running ones like analysis got nearly 50% faster. This should make your everyday use of the tool feel much more responsive, and could make a big difference in common test workflows running in CI systems.

### Android Studio and Jetbrains IDE plugin updates

With the release of the [Flutter IntelliJ Plugin](https://plugins.jetbrains.com/plugin/9212-flutter) version M87, there is now support for Android Studio [Meerkat](https://developer.android.com/studio/archive) and [Narwhal](https://developer.android.com/studio/preview). With this version, the Flutter plugin can now additionally be installed on CLion, GoLand, PyCharm, and several other JetBrains IDEs! For the full list, see the supported products [here](https://plugins.jetbrains.com/plugin/9212-flutter/versions/stable/818757). Thank you to Alex Li ([Flutter and Dart GDE](https://developers.google.com/profile/u/AlexV525)) whose [PR #7949](https://github.com/flutter/flutter-intellij/pull/7949) and diligent collaboration with our team was a driving force to expand the number of Jetbrains IDEs supported by the plugin.

For a list of all the updates and fixes, see our [changelog](https://github.com/flutter/flutter-intellij/blob/master/CHANGELOG.md) and file issues [here](https://github.com/flutter/flutter-intellij/issues). To get the latest update: **Settings &gt; Plugins &gt; Flutter &gt; Update**.

Consider subscribing to the dev channel to test the latest updates as they are released weekly. Find instructions are [here](https://github.com/flutter/flutter-intellij/blob/master/docs/Dev-Channel.md).

<DashImage figure src="images/1v2ml1DWIPJRRnz8zEo8QaQ.png" alt="*The full set of IDEs supported by the Flutter IntelliJ Plugin version M87.*" caption="*The full set of IDEs supported by the Flutter IntelliJ Plugin version M87.*" />


## Breaking changes and deprecations

This release includes several important deprecations and breaking changes that are part of our ongoing effort to modernize and improve the Flutter framework.

* **Component theme normalization:** This release marks the completion of a significant, long-term project to normalize component themes. To make theming more consistent and align with Material 3, component themes like `AppBarTheme`, `BottomAppBarTheme`, and `InputDecorationTheme` have been refactored to be based on new, data-oriented `…ThemeData` classes.

* **Radio widget redesign:** The `Radio`, `CupertinoRadio`, and `RadioListTile` widgets have been redesigned to improve accessibility. The `groupValue` and `onChanged` properties have been deprecated in favor of a new `RadioGroup` widget that manages the state for a set of radio buttons.

* **Form widget and slivers:** The `Form` widget can no longer be used directly as a sliver. To include a `Form` in a `CustomScrollView`, it should be wrapped in a `SliverToBoxAdapter`.

* **Semantics elevation and thickness removal:** The `elevation` and `thickness` properties on `SemanticsConfiguration` and `SemanticsNode` have been removed. These properties were unimplemented and their removal simplifies the API.

* **DropdownButtonFormField value deprecation:** The `value` parameter on `DropdownButtonFormField` has been deprecated and renamed to `initialValue` to more accurately reflect its behavior.

For more details and migration guidance, see our [breaking changes page](https://docs.flutter.dev/release/breaking-changes).

**Deprecated 32-bit x86 architecture on Android**

Flutter has deprecated the 32-bit x86 architecture on Android. For most developers this will have no impact, as it mainly affects older x86-based Android emulators and a small number of physical devices. 32-bit ARM and 64-bit x86_64 emulators and devices are still supported. The full technical breakdown is available on the [Dart GitHub deprecation issue](https://github.com/dart-lang/sdk/issues/49969).

**Deprecated IDE support for older Flutter SDKs**

With this release, we are deprecating IDE support for Flutter SDKs before 3.13.

In our next stable release, Flutter SDKs before 3.16 will be deprecated.

To learn more about Flutter’s deprecation policy, visit the [Flutter compatibility](https://docs.flutter.dev/release/compatibility-policy#deprecation-policy) page. To learn more about the deprecation policy regarding IDEs, visit [SDK support for Flutter developer tools](https://docs.flutter.dev/tools/sdk#sdk-support-for-flutter-developer-tools).

If you are a user of an older Dart or Flutter SDK that is no longer supported, please be sure to [download a compatible version](https://docs.flutter.dev/install/upgrade).

**Minimum Android SDK has changed**

The minimum Android SDK supported by Flutter, provided by `flutter.minSdkVersion`, is now API 24 (Android 7). If you have modified this value to something other than `flutter.minSdkVersion` you need to bump it to at least 24.

Also, Flutter’s minimum required values for some Android specific dependencies has increased. The Flutter tool will inform you if you need to increase any of these values, as well as provide guidance on how to upgrade (if the tool doesn’t print any warnings, no action is required).

You must now at least have:

* Gradle version: 8.7.0

* Android Gradle Plugin (AGP): 8.6.0

* Java: 17

To address AGP and Gradle issues, either [run the AGP Upgrade Assistant in Android Studio](https://developer.android.com/build/agp-upgrade-assistant) or [run it from the command line](https://docs.flutter.dev/release/breaking-changes/android-java-gradle-migration-guide#solution-2-command-line).

**Deprecation of pluginClass: none**

Support for `pluginClass: none` in plugin `pubspec.yaml` files will be removed in future versions of Flutter, and any plugin using this field should remove it to ensure forward compatibility. All recent versions of Flutter support having no `pluginClass:` entry when there is no native code for that platform.

## Conclusion

Flutter 3.35 is the result of a collective effort to build a better developer experience for everyone. We’re grateful for the contributions and feedback from our community including teams such as Canonical, that helped make features like web hot reload and Widget Previews a reality. Your passion is what drives Flutter forward, and we’re excited to see the amazing things you’ll create with these new tools.

For a complete list of all the changes, be sure to check out the detailed release notes and changelog. To get started, with everything in Flutter 3.35, run `flutter upgrade.` We can’t wait to see what you build!