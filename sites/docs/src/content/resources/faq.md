---
title: FAQ
description: Frequently asked questions and answers about Flutter.
showBreadcrumbs: false
---

## Introduction

This page collects common questions about Flutter.
You can also check out the following specialized FAQs:

* [Web FAQ][]
* [Performance FAQ][]

[Performance FAQ]: /perf/faq
[Web FAQ]: /platform-integration/web/faq

### What is Flutter?

Flutter is Google's open source framework
for crafting beautiful, natively compiled applications
for mobile (iOS, Android), web, desktop (macOS, Windows, Linux),
and embedded devices from a single codebase.
Flutter works with existing code,
is used by developers and organizations worldwide,
and is free and open source.

### Who is Flutter for?

For developers, Flutter accelerates app development
and reduces the cost and complexity of building across platforms.

For designers, Flutter provides a flexible canvas
for high-end user experiences.
It turns concepts into production code
without the compromises imposed by traditional cross-platform frameworks.

For engineering managers and businesses,
Flutter enables the unification of app developers into a single team,
building branded apps for multiple platforms from a single codebase.
Flutter speeds feature development and synchronizes release schedules
across your customer base.

### How much development experience do I need to use Flutter?

Flutter is approachable to programmers familiar with object-oriented
and imperative or declarative programming concepts.
Experience with languages such as Java, Kotlin, Swift, TypeScript,
or C# helps you learn Dart and Flutter quickly.

### What kinds of apps can I build with Flutter?

Flutter supports building mobile apps on Android and iOS,
web applications, desktop apps on macOS, Windows, and Linux,
and embedded device interfaces.

Apps that require custom, branded designs are well suited for Flutter.
You can also create pixel-perfect experiences that match
Android's Material Design and iOS's Cupertino design languages.

Flutter's [package ecosystem][] on pub.dev supports a wide variety of hardware
(such as camera, GPS, Bluetooth, network, and local storage)
and cloud services (such as authentication, notifications, payments, and storage).

[package ecosystem]: {{site.pub}}/flutter

### Who makes Flutter?

Flutter is an open source project managed by Google,
with contributions from a global community of developers,
companies, and individuals.

### Who uses Flutter?

Developers and organizations worldwide use Flutter to build
natively compiled applications.
To explore apps built with Flutter, visit the [showcase][].

[showcase]: {{site.main-url}}/showcase

### What makes Flutter unique?

Flutter differs from most cross-platform alternatives
because it does not rely on web browser views
or system-provided platform widgets.
Instead, Flutter renders its UI using its own high-performance
rendering engine ([Impeller][]).

In addition, Flutter implements most of its framework
(including compositing, gestures, animation, and widgets) in [Dart][].
This architecture gives you deep control over the UI,
high predictability, and the ability to inspect or modify
the framework at any level.

[Dart]: {{site.dart-site}}/
[Impeller]: /perf/impeller

### Should I build my next production app with Flutter?

Yes. Thousands of organizations, from early-stage startups
to large enterprises, deploy production Flutter apps
to hundreds of millions of users.
Explore real-world examples in the [showcase][].

Flutter releases updates on a regular cadence,
bringing performance improvements, new features,
and platform updates to the stable channel.

## What does Flutter provide?

### What is inside the Flutter SDK?

The Flutter SDK includes:

* High-performance 2D rendering engine ([Impeller][])
* Modern, reactive framework written in Dart
* Rich set of widgets implementing Material Design 3 and Cupertino (iOS-style)
* APIs for unit, widget, and integration tests
* Interop and plugin APIs to connect to system features and native SDKs
* Headless test runner for running tests on Windows, Linux, and macOS
* [Flutter DevTools][] for profiling, debugging, and inspecting your app
* Command-line tools for creating, building, testing, and compiling apps

[Flutter DevTools]: /tools/devtools

### Does Flutter work with any editors or IDEs?

Flutter provides plugins and extensions for [VS Code][],
[Antigravity][] (an AI-assisted IDE), [Android Studio][],
and [IntelliJ IDEA][].
See [editor configuration][] for setup details,
and [VS Code][] and [Android Studio/IntelliJ][] for usage guidance.

You can also run the `flutter` command from a terminal
along with any editor that supports [editing Dart][].

[Android Studio]: {{site.android-dev}}/studio
[Android Studio/IntelliJ]: /tools/android-studio
[Antigravity]: /ai/antigravity
[editing Dart]: {{site.dart-site}}/tools
[editor configuration]: /tools/editors
[IntelliJ IDEA]: https://www.jetbrains.com/idea/
[VS Code]: https://code.visualstudio.com/

### Does Flutter come with a framework?

Yes. Flutter includes a modern, reactive framework.
The framework is layered and customizable,
allowing you to use high-level widgets or interact directly
with lower layers of the rendering pipeline.

### Does Flutter come with widgets?

Yes. Flutter ships with a collection of high-quality
[Material Design and Cupertino (iOS-style) widgets][widgets],
layouts, and themes.
You can use these widgets as provided,
customize them, or create custom widgets.

[widgets]: /ui/widgets

### Does Flutter support Material Design?

Yes. Flutter provides full support for [Material Design 3][widget catalog],
Google's design system.

[widget catalog]: /ui/widgets/material

### Does Flutter come with a testing framework?

Yes. Flutter provides built-in support for unit, widget,
and integration testing.
To learn more, see [Testing overview][].

[Testing overview]: /testing/overview

### Does Flutter come with debugging tools?

Yes. Flutter includes [Flutter DevTools][].
For more information, see [Debugging Flutter apps][]
and the [Flutter DevTools][] documentation.

[Debugging Flutter apps]: /testing/debugging

### Does Flutter come with a dependency injection framework?

Flutter does not require an opinionated dependency injection framework.
The Flutter ecosystem offers several packages for dependency injection
and service location, such as [Riverpod][], [get_it][],
[Provider][], and [injectable][].

[get_it]: {{site.pub}}/packages/get_it
[injectable]: {{site.pub}}/packages/injectable
[Provider]: {{site.pub}}/packages/provider
[Riverpod]: {{site.pub}}/packages/riverpod

## Technology

### What technology is Flutter built with?

Flutter is built with C, C++, and Dart.
It uses [Impeller][] as its default rendering engine,
taking advantage of modern graphics APIs such as Metal on iOS and macOS,
and Vulkan on Android.
For a detailed description of Flutter's layered architecture,
read the [architectural overview][].

[architectural overview]: /resources/architectural-overview

### How does Flutter run my code on Android? {:#run-android}

The engine's C and C++ code is compiled using Android's NDK.
The Dart code (both the framework and your application code)
is ahead-of-time (AOT) compiled into native ARM and x86-64 machine code.
These libraries are packaged into a runner Android project
and built into an APK or Android App Bundle (AAB).
When launched, the app loads the Flutter engine,
which executes the compiled code and renders the UI.

During debug mode, Flutter runs inside the Dart VM
to enable stateful [hot reload][],
allowing you to make changes to your running code without recompiling.
A "debug" banner in the top right corner indicates
that the app is running in debug mode.

### How does Flutter run my code on iOS? {:#run-ios}

The engine's C and C++ code is compiled with LLVM.
The Dart code (both the framework and your application code)
is ahead-of-time (AOT) compiled into native ARM machine code.
The compiled code is packaged into a runner iOS project
and built into an `.ipa` bundle.
When launched, the app loads the Flutter engine,
which executes the compiled code and renders the UI using Impeller.

During debug mode, Flutter runs inside the Dart VM
to enable stateful [hot reload][].
A "debug" banner in the top right corner indicates
that the app is running in debug mode.

### Does Flutter use my operating system's built-in platform widgets?

No. Instead, Flutter renders widgets directly using its own engine,
providing implementations of Material Design and Cupertino (iOS-style) widgets.
You can explore the available widgets in the [widget catalog][catalog of Flutter's widgets].

By rendering pixels directly, Flutter avoids the performance constraints
and behavioral differences of platform widget abstractions.
This approach delivers consistent performance and appearance across platforms.

For cases where you need a platform-native component
(such as Google Maps or a web view),
Flutter supports embedding [platform views][] directly into the widget tree.

[catalog of Flutter's widgets]: /ui/widgets
[platform views]: /platform-integration/platform-views

### What happens when my mobile OS updates and introduces new widgets?

The Flutter team and community track new design guidelines
and platform widgets from Apple and Google,
updating Flutter's widget libraries accordingly.
Because Flutter widgets are written in Dart,
you can also build or adapt widgets immediately
without waiting for an OS or SDK update.

### What happens when my mobile OS updates and introduces new platform capabilities?

Flutter's plugin architecture, [platform channels][],
and native interop tools (such as Dart FFI, `ffigen`, and `jnigen`)
allow you to access new OS APIs immediately.
You do not need to wait for a Flutter SDK release to integrate new platform capabilities.

[platform channels]: /platform-integration/platform-channels

### Does Flutter support code push?

Flutter does not provide built-in code push functionality.
Third-party solutions, such as [Shorebird][],
provide code push support for Flutter applications.

[Shorebird]: https://shorebird.dev/

### What operating systems can I use to build a Flutter app?

Flutter supports development on macOS, Windows, Linux, and ChromeOS.
For details on system requirements, see the [install guide][install].

[install]: /install

### What language is Flutter written in?

The Flutter framework is written in [Dart][].
The underlying engine and graphics pipeline are implemented in C and C++.

### Why did Flutter choose to use Dart?

During initial development, the Flutter team evaluated multiple languages
and runtimes before selecting Dart for the framework and widgets.
Dart scored highest across several key evaluation criteria:

_Developer productivity_
: Dart supports both JIT (Just-in-Time) compilation for fast development
  with stateful hot reload, and AOT (Ahead-of-Time) compilation
  for efficient native machine code in production.
  Because the framework is written in Dart,
  developers can inspect, debug, and modify the entire stack.

_Object orientation and UI composition_
: Dart's object-oriented structure matches the requirements
  of building composable user interfaces without requiring a separate markup language.

_Predictable, high performance_
: Dart compiles directly to native machine code without an interpreter or bridge,
  delivering consistent frame rates without unpredictable runtime pauses.

_Fast memory allocation_
: Flutter's reactive framework creates many short-lived objects.
  Dart's generational garbage collector is optimized
  for fast allocation and cleanup of ephemeral objects.

### Can Flutter run any Dart code?

Flutter can run any Dart code that does not depend on libraries
unavailable on the target platform.
For example, mobile and desktop apps cannot import web-specific libraries,
and web apps cannot use `dart:io`.

### How does Flutter compile for the web?

Flutter compiles Dart for the web to both JavaScript and WebAssembly (Wasm).
WebAssembly compilation (WasmGC) delivers high-performance rendering
comparable to native desktop and mobile apps.
For details, see the [Flutter web documentation][web].

[web]: /platform-integration/web

### How big is the Flutter engine? {:#how-big-is-the-flutter-engine}

A minimal release Flutter application includes the Flutter engine,
the framework, and your application code.
The engine adds a small baseline footprint (a few megabytes compressed),
which varies by target platform and architecture.

App size is largely determined by bundled assets, fonts,
and third-party packages.
To analyze and minimize the size of your application,
see [Measuring your app's size][].

[Measuring your app's size]: /perf/app-size

### How does Flutter define a pixel?

Flutter uses logical pixels,
which correspond roughly to physical pixels on a standard-density display.
Flutter automatically maps logical pixels to physical device pixels
based on the view's [`devicePixelRatio`][].

[`devicePixelRatio`]: {{site.api}}/flutter/dart-ui/FlutterView/devicePixelRatio.html

## Capabilities

### What kind of app performance can I expect?

Flutter is designed to deliver smooth 60fps and 120fps animations.
Flutter apps compile directly to native machine code or WebAssembly,
eliminating interpreter overhead.
To learn more about performance optimization, see the [Performance FAQ][].

### What kind of developer cycles can I expect? How long between edit and refresh? {:#hot-reload}

Flutter implements a stateful _hot reload_ developer cycle.
You can expect sub-second reload times on physical devices,
emulators, and simulators.

Hot reload preserves your application state,
allowing you to iterate rapidly without navigating back
to the current screen after every code change.

### How is hot reload different from hot restart?

Hot reload injects updated source code files into the running Dart VM
without clearing the application state.
Hot restart resets the application state and re-executes `main()`,
which takes slightly longer than hot reload but remains faster
than a full recompile.

For more information, see [Hot reload][].

[Hot reload]: /tools/hot-reload

### Where can I deploy my Flutter app?

You can compile and deploy Flutter apps to iOS, Android,
[web][], [desktop][] (macOS, Windows, Linux), and embedded devices.

[desktop]: /platform-integration/desktop

### What devices and OS versions does Flutter run on? {:#what-devices-and-os-versions-does-flutter-run-on}

Flutter supports a broad range of operating systems and hardware platforms:

* Mobile: Android (ARM32, ARM64, x86_64) and iOS (ARM64).
* Desktop: macOS (x86_64, ARM64), Windows (x86_64, ARM64), and Linux (x86_64, ARM64).
* Web: Modern browsers supporting WebAssembly or JavaScript.

For the complete list of supported OS versions,
see [Supported platforms][].

[Supported platforms]: /reference/supported-platforms

### Does Flutter run on the web?

Yes. Flutter web support is available on the stable channel
and supports compilation to both WebAssembly (Wasm) and JavaScript.
For more details, see [Web support for Flutter][web].

### Can I use Flutter to build desktop apps?

Yes. Desktop support is available on the stable channel
for macOS, Windows, and Linux.
For details, see [Desktop support for Flutter][desktop].

### Can I use Flutter inside of my existing native app?

Yes. You can integrate Flutter into existing Android and iOS applications
using [Add-to-App][add-to-app].

[add-to-app]: /add-to-app

### Can I access platform services and APIs like sensors and local storage?

Yes. Flutter provides access to platform-specific APIs and hardware
through plugins available on [pub.dev][ready-made packages].
You can also create custom integrations using [platform channels][]
or native interop (Dart FFI).

[ready-made packages]: {{site.pub}}/flutter/

### Can I extend and customize the bundled widgets?

Yes. Flutter's widget system is built around composition.
Instead of subclassing complex widgets,
you compose smaller, single-purpose widgets to create custom designs.
This architecture provides control over layout, painting,
and gesture handling.

### Why would I want to share layout code across iOS and Android?

Sharing layout and UI code reduces engineering effort,
keeps feature releases synchronized,
and ensures a consistent brand experience across platforms.
When you want platform-specific behavior or styling,
you can adapt the UI using platform checks or responsive layouts.

### Can I interop with my mobile platform's default programming language?

Yes. Flutter supports calling native code on all supported platforms:

* On Android: Kotlin and Java via [platform channels][] and [JNI interop][] (`jnigen`).
* On iOS and macOS: Swift and Objective-C via [platform channels][] and [Objective-C/Swift interop][] (`ffigen`).
* On desktop and mobile: C and C++ via Dart FFI ([`dart:ffi`][]).

[JNI interop]: {{site.dart-site}}/interop/java-interop
[Objective-C/Swift interop]: {{site.dart-site}}/interop/objective-c-interop
[`dart:ffi`]: {{site.dart-site}}/interop/c-interop

### Does Flutter come with a reflection / mirrors system?

No. Dart disables `dart:mirrors` in Flutter to enable aggressive
ahead-of-time (AOT) compilation and dead-code elimination (tree shaking).
This keeps binary sizes small and startup times fast.
For metadata inspection and serialization,
Flutter applications use compile-time code generation.

### Are internationalization and localization supported?

Yes. Flutter provides built-in internationalization (i18n)
and localization (l10n) support,
including pluralization, bidirectional text, and date formatting.
To learn more, see [Internationalizing Flutter apps][internationalization documentation].

[internationalization documentation]: /ui/internationalization

### What accessibility is supported?

Flutter supports standard accessibility features (a11y),
including screen readers (TalkBack, VoiceOver), large text scaling,
high-contrast themes, and hardware switch access.
For details, see [Accessibility][accessibility documentation].

[accessibility documentation]: /ui/accessibility

### How do I write parallel and/or concurrent apps for Flutter?

Dart uses an event loop for asynchronous operations (`Future` and `Stream`).
For CPU-intensive tasks, Flutter supports isolates—isolated execution
threads with independent memory heaps that communicate through message passing.
You can use [`Isolate.run()`][] or the [`compute()`][] function
to run heavy computations in the background.

[`Isolate.run()`]: {{site.api}}/flutter/dart-isolate/Isolate/run.html
[`compute()`]: {{site.api}}/flutter/foundation/compute-constant.html

### Can I run Dart code in the background of a Flutter app?

Yes. You can execute Dart code in background processes on Android and iOS
using background execution packages and platform service integrations.

### Can I use JSON, XML, or Protocol Buffers with Flutter?

Yes. The Dart ecosystem provides packages on [pub.dev][]
for JSON serialization, XML parsing, Protocol Buffers,
and other data formats.
For details on working with JSON, see [JSON and serialization][JSON tutorial].

[JSON tutorial]: /data-and-backend/serialization/json
[pub.dev]: {{site.pub}}

### Can I build 3D apps with Flutter?

Yes. Flutter supports 3D graphics through Flutter GPU
and packages such as `flutter_scene`,
which use the Impeller rendering backend to draw 3D scenes.
You can also embed third-party 3D views (such as Unity or native 3D engines)
using platform views.

### Why is my APK or IPA so big?

App bundle size includes the Flutter engine, framework code,
application logic, and bundled assets (such as images, fonts, and audio).
Always create a release build (`flutter build apk` or `flutter build appbundle`
for Android, and `flutter build ipa` for iOS),
which removes debug symbols and enables compiler optimizations.
To analyze and reduce app size, see [Measuring your app's size][].

### Is Flutter ABI compatible?

Flutter and Dart do not provide application binary interface (ABI)
compatibility across different compiler releases.
Always compile your application using matching SDK versions.

### How does Flutter handle scrolling?

Flutter provides platform-specific scroll physics
that match the native scrolling behavior of each platform
(such as momentum scrolling on iOS and overscroll stretch on Android).
For more details, see the [scrolling][] documentation.

[scrolling]: /ui/layout/scrolling

## Framework

### Why is the build() method on State, rather than StatefulWidget?

Placing the `Widget build(BuildContext context)` method on `State`
rather than `StatefulWidget` provides greater flexibility
when subclassing `StatefulWidget` and managing lifecycle state.
For a detailed explanation, see the [API documentation for `State.build`][].

[API documentation for `State.build`]: {{site.api}}/flutter/widgets/State/build.html

### Where is Flutter's markup language? Why doesn't Flutter have a markup syntax?

Flutter UIs are defined in Dart code rather than a declarative markup language.
Defining UI in code enables:

* Fast development with stateful hot reload.
* Full access to programming language features (loops, conditionals, functions).
* Strong type safety and compiler checks.
* Easy refactoring and code reuse across widgets.

Because build methods are standard code,
you can also create widgets dynamically from data or external configurations.

### My app has a Debug banner in the upper right. Why am I seeing that?

By default, `flutter run` launches the app in debug mode.
The debug build configuration runs code inside the Dart VM
to enable stateful [hot reload][],
and enables runtime assertions to catch errors early.
The "Debug" banner indicates that these checks are active.

To run without assertions and with optimized performance,
run the app in release mode using `flutter run --release`
or build a release binary.

### What programming paradigm does Flutter's framework use? {:#what-programming-paradigm-does-flutters-framework-use}

Flutter uses a combination of programming paradigms,
applying each where it is most effective:

**Composition**
: The primary paradigm in Flutter is composing small,
  single-purpose widgets into complex user interfaces.
  For example, the Material [`TextButton`][] widget is composed of
  an [`IconTheme`][], an [`InkWell`][], a [`Padding`][],
  a [`Center`][], a [`Material`][],
  an [`AnimatedDefaultTextStyle`][], and a [`ConstrainedBox`][].

**Functional programming**
: Applications can define UI using [`StatelessWidget`][] instances,
  which act as functions mapping configuration inputs to child widgets.
  Flutter uses immutable data structures across its widget hierarchy,
  including [`Widget`][], [`TextStyle`][], and [`Rect`][].

**Event-driven programming**
: User interactions are represented by event objects
  dispatched to callbacks registered on widgets.
  Classes like [`Listenable`][] formalize event subscription models.

**Class-based object-oriented programming**
: The framework APIs use inheritance to specialize behavior.
  For example, [`RenderBox`][] extends [`RenderObject`][]
  to establish a Cartesian coordinate system for 2D layout.

**Prototype-based object-oriented programming**
: The [`ScrollPhysics`][] class chains instances to compose
  scrolling physics dynamically at runtime.

**Imperative programming**
: Imperative code manages encapsulated state and test execution,
  where step-by-step logic is clearest.

**Reactive programming**
: Constructor parameters propagate changes down the widget tree,
  and user interactions trigger updates back up the tree through callbacks.
  State changes schedule rebuilds of affected subtrees.

**Declarative programming**
: Widget `build` methods describe the desired UI state declaratively,
  leaving layout and rendering updates to the framework.

**Generic programming**
: Generic types enforce type safety across the framework,
  such as parameterizing [`State`][]`<T>` with its widget type
  and [`GlobalKey`][]`<T>` with its state type.

**Concurrent programming**
: Flutter uses [`Future`][] and [`Stream`][] for asynchronous operations,
  and isolates for parallel background computation.

**Constraint programming**
: The layout system uses box constraints (minimum and maximum width and height)
  passed down from parent to child to compute geometry in a single pass.

[`AnimatedDefaultTextStyle`]: {{site.api}}/flutter/widgets/AnimatedDefaultTextStyle-class.html
[`Center`]: {{site.api}}/flutter/widgets/Center-class.html
[`ConstrainedBox`]: {{site.api}}/flutter/widgets/ConstrainedBox-class.html
[`Future`]: {{site.api}}/flutter/dart-async/Future-class.html
[`GlobalKey`]: {{site.api}}/flutter/widgets/GlobalKey-class.html
[`IconTheme`]: {{site.api}}/flutter/widgets/IconTheme-class.html
[`InkWell`]: {{site.api}}/flutter/material/InkWell-class.html
[`Listenable`]: {{site.api}}/flutter/foundation/Listenable-class.html
[`Material`]: {{site.api}}/flutter/material/Material-class.html
[`Padding`]: {{site.api}}/flutter/widgets/Padding-class.html
[`Rect`]: {{site.api}}/flutter/dart-ui/Rect-class.html
[`RenderBox`]: {{site.api}}/flutter/rendering/RenderBox-class.html
[`RenderObject`]: {{site.api}}/flutter/rendering/RenderObject-class.html
[`ScrollPhysics`]: {{site.api}}/flutter/widgets/ScrollPhysics-class.html
[`State`]: {{site.api}}/flutter/widgets/State-class.html
[`StatelessWidget`]: {{site.api}}/flutter/widgets/StatelessWidget-class.html
[`Stream`]: {{site.api}}/flutter/dart-async/Stream-class.html
[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html
[`TextStyle`]: {{site.api}}/flutter/painting/TextStyle-class.html
[`Widget`]: {{site.api}}/flutter/widgets/Widget-class.html

## Project

### Where can I get support?

To report bugs or request features, file an issue in the
[Flutter issue tracker][issue tracker].

For community discussion, troubleshooting, and advice:

* Join the [Flutter Discord][Discord].
* Ask questions on [Stack Overflow][] using the `flutter` tag.
* Participate in discussions on [Reddit r/FlutterDev][Reddit].
* Visit the [Community][] page for additional resources.

[Community]: {{site.main-url}}/community
[Discord]: https://discord.com/invite/rflutterdev
[issue tracker]: {{site.repo.flutter}}/issues
[Reddit]: https://www.reddit.com/r/FlutterDev/
[Stack Overflow]: {{site.so}}/tags/flutter

### How do I get involved?

Flutter is open source, and contributions are welcome.
You can help by:

* Reporting bugs and feature requests on the [issue tracker][].
* Contributing code and documentation by following the [Contributing guide][].
* Triaging issues or helping other developers on [Discord][] and [Stack Overflow][].

[Contributing guide]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md

### Is Flutter open source?

Yes. Flutter is open source and available under the
BSD 3-Clause License on [GitHub][].

[GitHub]: {{site.repo.flutter}}

### Which software license(s) apply to Flutter and its dependencies?

Flutter includes two main components:
the engine (compiled binary with dependencies)
and the framework (Dart source code).

* The framework is licensed under the [BSD 3-Clause License][only one license].
* The engine uses open source dependencies listed in its [license file][].
* Dart packages on pub.dev specify their own individual licenses.

[license file]: {{site.repo.flutter}}/blob/main/engine/src/flutter/sky/packages/sky_engine/LICENSE
[only one license]: {{site.repo.flutter}}/blob/main/LICENSE

### How can I determine the licenses my Flutter application needs to show?

Flutter provides built-in APIs to display open source licenses:

* If your application uses a `Drawer`, add an [`AboutListTile`][].
* If your application uses Material Design, call [`showAboutDialog`][]
  or [`showLicensePage`][].
* For custom presentations, access the raw licenses from the [`LicenseRegistry`][].

[`AboutListTile`]: {{site.api}}/flutter/material/AboutListTile-class.html
[`LicenseRegistry`]: {{site.api}}/flutter/foundation/LicenseRegistry-class.html
[`showAboutDialog`]: {{site.api}}/flutter/material/showAboutDialog.html
[`showLicensePage`]: {{site.api}}/flutter/material/showLicensePage.html

### Who works on Flutter?

Flutter is developed by engineers at Google along with
hundreds of open source contributors worldwide.
To join the community, see [contribute to Flutter][].

[contribute to Flutter]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md

### What are Flutter's guiding principles?

Flutter is built around three core principles:

_Control_
: Developers have full access to and control over every layer of the system.

_Performance_
: Applications deliver smooth, responsive, jank-free experiences.

_Fidelity_
: Applications achieve pixel-perfect, beautiful user experiences on every platform.

### Will Apple or Google reject my Flutter app?

No. Thousands of Flutter apps are published, approved, and featured
in the Apple App Store and Google Play Store.
As with any application, ensure your app complies with
Apple's [App Store Review Guidelines][guidelines]
and Google Play's Developer Program Policies.

[guidelines]: {{site.apple-dev}}/app-store/review/guidelines/
