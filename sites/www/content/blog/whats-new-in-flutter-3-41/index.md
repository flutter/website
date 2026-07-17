---
title: "What’s new in Flutter 3.41"
description: >-
  Empowering the community
publishDate: 2026-02-11
author: itsjustkevin
image: images/1jmKuW7ItWRJAHNABfTEhHA.gif
category: release
layout: blog
---

<DashImage figure src="images/1XxO20lj9p2xlQfuIiwa8mg.webp" />

## What’s new in Flutter 3.41

### Empowering the community

Today, we’re excited to announce the release of Flutter 3.41, marking a transformative milestone in our journey together! What an exciting time to be a developer; this release represents our commitment to empowering our community in shaping the direction of Flutter. With 868 commits from 145 unique contributors, Flutter 3.41 provides additional transparency and modularity to further improve the experience of contributing to Flutter.

We are introducing public release windows to make it easier for you to know when changes you contribute would land in a stable release. We are also continuing to decouple our design libraries, which in the long term will help us evolve design systems faster, while also giving you control over which design changes you adopt in your apps. Whether you are pushing the limits of the GPU with new fragment shader improvements or embedding Flutter seamlessly into existing native apps with content-sized views, this release ensures you have the tools to build with confidence and speed.

There is so much to explore, so let’s dig right in…

<DashImage figure src="images/1jmKuW7ItWRJAHNABfTEhHA.gif" />

## Structural transparency and modularity

### Public Release Windows

Predictability is key to landing complex features safely. We are introducing public release windows to provide the entire community with the visibility needed to plan ahead. By explicitly calling out branch cutoff dates and release targets publicly, we enable the entire community to have clarity on when their changes would land in future stable releases.

So what is a branch cutoff date? This date is the deadline for pull requests to land in the default branches (`main` for Dart and `master` for Flutter) to guarantee inclusion in the next stable release. If your PR merges before the cutoff, it will ship in the next stable version. If it merges after, it waits for the following cycle.

For 2026, we plan to release four stable releases (including this one), the dates are as follows:

* Flutter 3.41 — Feb | Branched on 06 January

* Flutter 3.44 — May | Branches on 07 April

* Flutter 3.47 — August | Branches on 07 July

* Flutter 3.50 — November | Branches on 06 October

### Decoupling for a leaner core

We’re continuing our project to migrate the Material and Cupertino libraries to separate packages. This modular approach has several benefits:

* **Faster release cycles:** We no longer need to wait for a quarterly SDK release to ship design updates. We can release new Material or Cupertino features and bug fixes the moment they are ready.

* **Independent upgrades:** If you’re using an older SDK version due to a project constraint, you can still upgrade your design packages to get the latest look and feel.

* **Adaptive design:** Versioned packages allow us to react much faster when iOS or Android introduce drastic design shifts like “Liquid Glass” or “Material 3 Expressive”, ensuring your app never looks out of date.

Keep an eye on the [GitHub issue](https://github.com/flutter/flutter/issues/101479) to follow the progress.

## Embracing ecosystem standards

Part of empowering the community is ensuring Flutter plays nicely with the tools we already rely on.

### Swift Package Manager and UIScene

The transition from CocoaPods to Swift Package Manager continues. We strongly encourage [Plugin authors](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-plugin-authors) to adopt Swift Package Manager, as it is now the standard for the Apple ecosystem. Additionally, to ensure compatibility with future iOS releases, Flutter now fully supports the [UIScene lifecycle by default](https://github.com/flutter/flutter/pull/178328) . This update is critical in meeting Apple’s requirements for upcoming iOS versions. To streamline migration from the deprecated AppDelegate lifecycle logic, check out our [migration guide](https://docs.flutter.dev/release/breaking-changes/uiscenedelegate).

### Android Grade Plugin (AGP) 9 and Kotlin DSL

We continue to align with modern Android standards. With the release of Android Gradle Plugin (AGP) 9, we are working on supporting new strictness requirements and providing guidance on how to navigate them.

**Warning:** **Do not** update your Flutter app for Android to AGP 9 as **migrating plugins to AGP 9 and Flutter apps on AGP 9 using plugins** is not yet supported ([#181383](https://github.com/flutter/flutter/issues/181383)). This support is paused while the Flutter team audits the migration for backwards compatibility with older versions of AGP. This [migration doc](https://docs.flutter.dev/release/breaking-changes/migrate-to-agp-9) will be updated as guidance changes.

Thanks to contributions from community member [Byoungchan Lee (bc-lee@)](https://github.com/bc-lee), new plugin projects now default to using the Kotlin DSL for Gradle.

## Platform-specific assets

Optimizing is now easier thanks to the work of [Alex Frei (hm21@)](https://github.com/hm21). You can now specify which platforms an asset should be bundled for in your pubspec.yaml. This allows optimizations such as, excluding heavy desktop assets from your mobile builds, significantly reducing app size.

```yaml
flutter:
  assets:
    - path: assets/logo.png
    - path: assets/web_worker.js
      platforms: [web]
    - path: assets/desktop_icon.png
      platforms: [windows, linux, macos]
```

## Listening to the community

The Flutter team at Google continues to prioritize what matters most to you.

### The getting started experience

<DashImage figure src="images/1baxbpT88lI2jDoF7fQmErQ.webp" />

For years, the community has called out that while Flutter is delightful and productive, it can be difficult to know where to begin the learning journey.

We recently launched a completely reimagined [Dart and Flutter Getting Started Experience](https://blog.flutter.dev/announcing-our-new-dart-and-flutter-getting-started-experience-b8c4b2be0984).

It’s a new learning pathway designed to guide you through the fundamentals of building apps with Flutter and Dart. Let’s take a quick look at some of the changes:

* We’ve introduced a new “quick install” guide that leverages hot-reload on the web, enabling learners to experience the full power of Flutter fast, without setting up a platform-specific environment first. A pathway consisting of written tutorials, low-stakes quizzes, and eight new videos featuring some familiar faces from the Flutter team at Google.

* Learners would finish the learning path having built 4 apps completely from scratch.

Give the new Getting Started Experience a try in the newly redesigned [Learn](https://docs.flutter.dev/learn/pathway) section of our website, powered by [Jaspr](https://jaspr.site/).

### Fragment shader improvements

In Q4 2025, we surveyed developers using the `FragmentShader` API and asked simply: *What is impeding your work?* You told us that you needed improved ergonomics when using the API, while also having more flexibility when defining your shaders. In response to that, we made the following changes:

* In 3.41, we added Synchronous Image Decoding. Previously, creating textures for shaders could introduce a frame of lag. With `decodeImageFromPixelsSync`, you can now generate textures and use them as samplers in the same frame.

* We’ve also added support for High Bitrate Textures (up to 128-bit float), unlocking the ability to use high-resolution lookup tables (LUTs) for GPU-accelerated photo filters and SDFs.

```dart
void attachTexture(ui.FragmentShader shader) {
  ui.PictureRecorder recorder = ui.PictureRecorder();
  Canvas canvas = Canvas(recorder);
  canvas.drawCircle(const Offset(64, 64), 64, Paint()..color = Colors.red);
  ui.Picture picture = recorder.endRecording();
  ui.Image image = picture.toImageSync(
    128,
    128,
    targetFormat: ui.TargetPixelFormat.rFloat32,
  );
  shader.setImageSampler(0, image);
}
```

### Widget Previews (Experimental)

Based on your early feedback, we are iterating rapidly on Widget Previews. With this release, Widget Previews have improved as follows:

* **Flutter Inspector support:** The Widget Preview environment now has access to an embedded Flutter Inspector instance, making it easy to inspect layouts and the state of previewed widgets. **Important note:** it might be necessary to configure additional package directories to see widgets from your project by default. To do this, open the Flutter Inspector settings by clicking the gear icon and add a new package directory pointing to your project.

<DashImage figure src="images/1FyWSKI69_GcAv7MoAbPbww.webp" />

* **Support for applications with `dart:ffi` dependencies:** Previously, previews that included widgets with transitive dependencies on libraries importing `dart:ffi` would cause compilation errors and prevent the preview environment from updating. This occurred because `dart:ffi` isn’t supported on web platforms ([flutter/flutter#166431](https://github.com/flutter/flutter/issues/166431)). The widget previewer can now handle previews that have dependencies on platform-specific libraries, including `dart:ffi` and `dart:io`. **Important note**: invoking APIs from these libraries isn’t supported in the widget previewer and will result in an error being displayed for previews calling these platform-specific APIs. See the [Dart documentation on conditional imports](https://dart.dev/tools/pub/create-packages#conditionally-importing-and-exporting-library-files) for examples of how to write code that’s compatible with both native and web platforms.

## Framework fidelity and polish

We continue to refine the present experience with a focus on platform fidelity and developer efficiency.

### iOS polish

In Flutter 3.41 we’ve made visual improvements with the new “bounded blur” style. Previously, translucent widgets using the `BackdropFilter` could suffer from color bleeding at the edges. Thanks to improvements in the Impeller rendering engine, we have eliminated this artifact.

<DashImage figure src="images/1YQySx5fHQJ9zs7_EI_Y4_g.webp" />

<DashImage figure src="images/1tM9ItzXJAm4nN_OcyxzLCw.webp" />

We’ve also added support for native styled drag handling for `CupertinoSheet` through the `showDragHandle` property.

<DashImage figure src="images/1ocj9sgfhhYAYFlVIqPxZmA.webp" />

### Add-to-App

Adding Flutter views to existing Android and iOS apps is now easier! Flutter views embedded in existing native apps can now automatically resize themselves based on their content. Previously, a Flutter view needed a fixed size provided by its native parent. This made some scenarios difficult, like adding Flutter views to a native scrollable view.

To use this, your root widget must support unbounded constraints. Avoid using widgets that require a pre-defined size (like `ListView` or `LayoutBuilder`) at the top of your tree, as they will conflict with the dynamic sizing logic.

To enable this behavior on iOS, [set `FlutterViewController.isAutoResizable` to true](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#content-sized-views). For Android, enable content sizing in your Android Manifest and [set the width or height of your FlutterView to content_wrap.](https://docs.flutter.dev/add-to-app/android/add-flutter-view#content-sized-views)

<DashImage figure src="images/1BU1kKyxkWidSLXOA37nPLg.webp" />

<DashImage figure src="images/146fO6mit5AFOq9ZY7YtRmA.webp" />

### Navigation and scrolling

We’ve worked hard to smooth out the rough edges in core interaction models through the following changes:

* We’ve introduced `Navigator.popUntilWithResult`, allowing you to pop multiple screens and pass a value back to the destination route in a single call, drastically simplifying state management in multi-step flows.

* We reimplemented `StretchingOverscrollIndicator` using a simulation-based approach ported from Android 12. This ensures a more natural and fluid overscroll effect that responds correctly to high-velocity flings.

<DashImage figure src="images/1klfeLTPZihrgBRUmUzWaIA.webp" />

* We fixed an issue with pinned headers in `NestedScrollView` and `SliverMainAxisGroup`, ensuring headers correctly overlap subsequent slivers.

## Accessibility

Helping you build accessible experiences that reach users on any screen is at the heart of our mission. In this update, we’ve added the following:

* Native accessibility support for `CircularProgressIndicator` and `LinearProgressIndicator`, allowing assistive technologies to announce progress updates.

* Flutter now respects web users’ text spacing overrides to improve the reading experience.

* We’ve introduced new matchers like `isSemantics` and `accessibilityAnnouncement` in flutter_test to make validating accessibility easier.

## Material and animation

We have introduced new primitives and properties to expand control over animations and layout. Thanks to the work of community member [Bernardo Ferrari (bernaferrari@)](https://github.com/bernaferrari), `RepeatingAnimationBuilder` introduces a declarative way to create continuous animations like a loading indicator, a pulsing button, or a shimmering placeholder effect.

For example, here’s how you can make a square slide back-and-forth:

```dart
RepeatingAnimationBuilder<Offset>(
  animatable: Tween<Offset>(
    begin: const Offset(-1.0, 0.0),
    end: const Offset(1.0, 0.0),
  ),
  duration: const Duration(seconds: 1),
  repeatMode: RepeatMode.reverse,
  curve: Curves.easeInOut,
  builder: (BuildContext context, Offset offset, Widget child) {
    return FractionalTranslation(
      translation: offset,
      child: child,
    );
  },
  child: const ColoredBox(
    color: Colors.green,
    child: SizedBox.square(dimension: 100),
  ),
),
```

We also updated `CarouselView` with a `.builder` constructor, making it easier to create carousels with dynamic content. `DropdownMenuFormField` now supports a custom `errorBuilder`, and `RawAutoComplete` now includes an `OptionsViewOpenDirection.mostSpace` option to intelligently position options based on available screen space.

## Community-led evolution

One of the strongest examples of Flutter open source partnerships is our longstanding relationship with Canonical. Their team continues to drive the Flutter Desktop roadmap forward, delivering critical features that benefit the entire ecosystem.

Thanks to Canonical’s engineering leadership, we are closing the gap on complex desktop UI requirements. This release introduces experimental APIs for creating popup windows and tooltip windows, along with cross-platform support for dialog windows on Linux, macOS, and Windows. Finally, new APIs were added to let you test multi-window apps. If you’d like a sneak peek of these upcoming windowing APIs, check out Flutter’s [multiple_windows example app](https://github.com/flutter/flutter/tree/master/examples/multiple_windows)!

Flutter Linux now also enables merged threads by default, simplifying the threading model and improving performance while also working to improve Windows stability. We intend to remove the merged threads opt-out in a future release. If you have any issues with merged threads, please [let us know](https://github.com/flutter/flutter/issues/150525).

## DevTools

Devtools has seen improvements in performance and stability:

* Flutter’s DevTools are compiled using dart2wasm, resulting in performance improvements. You can still opt out and revert to the dart2js-compiled DevTools by using the settings dialog.

* Dropped connections to the Dart Tooling Daemon (DTD) are now automatically retried to improve the experience when your machine resumes after sleeping.

These are just a couple highlights from this release. To learn about all the updates included in Flutter 3.41, check out the release notes for DevTools [2.52.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.52.0), [2.53.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.53.0), and [2.54.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.54.0).

## Next Stop: `flutter upgrade`

Flutter 3.41 is a step toward improving our open source contributing experience, while also improving Flutter’s foundational feature to enhance your development experience whether you are migrating a plugin to Swift Package Manager, optimizing assets for specific platforms, or pushing pixels with new Shader APIs. We are grateful for the amazing community we’ve built together.

For a comprehensive list of all the changes, be sure to check out the detailed [breaking changes](https://docs.flutter.dev/release/breaking-changes) and [release notes](https://docs.flutter.dev/release/release-notes/release-notes-3.41.0). To try out the new features in Flutter 3.41, all it takes is a `flutter upgrade`!
