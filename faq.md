---
layout: page
title: FAQ
sidebar: home_sidebar
permalink: /faq/
---

* Placeholder for TOC
{:toc}

## Introduction

### What is Flutter?

Flutter is a mobile app SDK, complete with
framework, widgets, and tools, that gives developers an
easy and productive way to build and deploy
beautiful mobile apps on both Android and iOS.

### What does Flutter do?

For users, Flutter makes beautiful app UIs
come to life.

For developers, Flutter lowers the bar to entry
for building mobile apps. It speeds up development of
mobile apps and reduces the cost and complexity
of app production across iOS and Android.

For designers, Flutter helps deliver the original
design vision,
without loss of fidelity or compromises. It also
acts as a productive prototyping tool.

### Who is Flutter for?

Flutter is for mobile app developers wanting a faster
or easier way to build
beautiful mobile apps.

Flutter is also for designers looking for a high-fidelity,
fast prototyping tool. Prototypes built with Flutter can be
handed to developers and shipped to users as real apps.

Fundamentally, Flutter is for users that want beautiful apps,
with delightful motion and animation, and UIs with character
and an identity all their own.

### What kinds of apps can I build with Flutter?

Flutter is optimized for 2D mobile apps that want to run on
both Android and iOS.

Apps that need to deliver brand-first designs are particularly
well suited for Flutter. However, apps that need to look like
stock platform apps can also be built with Flutter.

You can build full-featured apps with Flutter, including
camera, geolocation, network, storage, 3rd-party SDKs, and more.

### Who uses Flutter?

Google uses Flutter to build business-critical apps for iOS and Android.
For example, Google's mobile sales tool app is built with Flutter, along
with a Store Manager app for Google Shopping Express. Other Flutter
apps are in the works, or "inside the firewall".

Teams outside of Google are also using Flutter. For example,
Newsvoice shipped to both
[iOS](https://itunes.apple.com/nz/app/newsvoice/id1208421834?mt=8) and
[Android](https://play.google.com/store/apps/details?id=com.newsvoice.newsvoice).

### What makes Flutter unique?

Flutter is different than most other options for building
mobile apps because Flutter uses neither WebView nor the OEM widgets
that shipped with the device. Instead, Flutter uses its own high-performance
rendering engine to draw widgets.

In addition, Flutter is different because it only has a thin layer of
C/C++ code. Flutter implements most of its system (compositing, gestures,
animation, framework, widgets, etc) in _Dart_ (a modern, terse, object-oriented
language) that developers can
easily approach read, change, replace, or remove.
This gives developers tremendous
control over the system, as well as significantly lowers the bar
to approachability for the majority of the system.

### Should I build my next production app with Flutter?

Flutter is still being developed and is not yet at
1.0.

Our APIs are stabilizing, and we continue to improve
parts of the system based on user feedback.
We email [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)
when we make a change that might impact our users.

Flutter is used inside of Google and apps built with Flutter
are deployed to users.

Some key features, such as accessibility, are not yet ready for
broad deployment.

So really, it is up to you. The features you need may be
available today. Please let us know if you released an app
built with Flutter to users. We'd love to hear what you're building!

## What does Flutter provide?

### What is inside the Flutter SDK?

* Heavily optimized, mobile-first 2D rendering engine with excellent support for text
* Functional-reactive framework
* Rich set of widgets for Android and iOS
* APIs for unit and integration tests
* Interop and plugin APIs to connect to the system and 3rd-party SDKs
* Headless test runner for running tests on Windows, Linux, and Mac
* Command-line tools for creating, building, testing, and compiling your apps

### Does Flutter work with any editors or IDEs?

We are building plugins for [IntelliJ IDEA](https://www.jetbrains.com/idea/),
enabling [fully integrated development experience](/intellij-ide/) for Flutter.
The plugins work in both the Ultimate and the free Community editions.

Alternatively, you can use a combination of the `flutter` command in a terminal
and one of the many editors that support [editing Dart](https://www.dartlang.org/tools).

### Does Flutter come with a framework?

Yes! Flutter ships with a functional-reactive style framework, inspired by
React. Flutter's framework is designed to be layered and customizable
(and optional).
Developers can choose to use only parts of the framework, or a different
framework.

### Does Flutter come with widgets?

Yes! Flutter ships with a set of
[high quality Material and Cupertino (iOS-style) widgets][widgets], layouts,
and themes. Of
course, these widgets are only a starting point.
Flutter is designed to make it easy to
create your own widgets, or customize the existing widgets.

### Does Flutter come with a testing framework?

Yes, Flutter provides APIs for writing unit and integration
tests. Learn more about
[testing with Flutter](/testing/).

We use our own testing capabilities to test our SDK.
We measure our
[test coverage](https://coveralls.io/github/flutter/flutter?branch=master)
on every commit.

### Does Flutter come with a dependency injection framework or solution?

Not at this time. Please share your ideas at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

## Technology

### What technology is Flutter built with?

Flutter is built with C, C++, Dart, and Skia (a 2D rendering engine). See this
[architecture diagram](https://docs.google.com/presentation/d/1cw7A4HbvM_Abv320rVgPVGiUP2msVs7tfGbkgdrTy0I/edit#slide=id.gbb3c3233b_0_162) for a better picture of the main components.

### How does Flutter run my code on Android? {#run-android}

The engine's C/C++ code is compiled with Android's NDK, and the majority of the
framework and application code is running as native code
compiled by the Dart compiler.

### How does Flutter run my code on iOS? {#run-ios}

The engine's C/C++ code is compiled with LLVM, and any Dart code is AOT-compiled
into native code. The app runs using the native instruction set (no interpreter
is involved).

### Does Flutter use my system's OEM widgets?

No. Instead, Flutter provides a set of Material Design and
Cupertino (iOS-styled) widgets, managed and rendered by
Flutter's framework and engine. You can browse a
[catalog of Flutter's widgets](/widgets/).

We are hoping the end-result will be higher quality apps. If we reused
the OEM widgets, the quality and performance of Flutter apps would be
limited by the quality of those widgets.

In Android, for example, there's a hard-coded set of gestures and fixed
rules for disambiguating them. In Flutter, you can write your
own gesture recognizer that is a first-class participant in the
[gesture system](/gestures/). Moreover, two widgets
authored by different people can coordinate to disambiguate gestures.

Modern app design trends point towards designers and users wanting
more motion-rich UIs and brand-first designs.
In order to achieve that level of customized, beautiful design,
Flutter is architectured to drive pixels instead of the OEM widgets.

### What operating systems can I use to build a Flutter app?

Flutter supports development on Linux, Mac, and, Windows.

### What language is Flutter written in?

We looked at a lot of languages and runtimes, and ultimately adopted Dart for
the framework and widgets. The underlying graphics framework and the Dart
virtual machine are implemented in C/C++.

### Why did Flutter choose to use Dart?

The primary criteria we used to pick a programming language were the following:

* _Developer productivity_. One of Flutter's main value propositions is that it
  saves engineering resources by letting developers create apps for both iOS and
  Android with the same codebase. Using a highly productive language
  accelerates developers further and makes Flutter more attractive.

* _Object-orientation_. For Flutter, we want a language that's suited to
  Flutter's problem domain: creating visual user experiences. The industry has
  multiple decades of experience building user interface frameworks in
  object-oriented languages. While we could use a non-object-oriented language,
  this would mean reinventing the wheel to solve several hard problems.

* _Predictable, high performance_. With Flutter, we want to empower developers
  to create fast, fluid user experiences. In order to achieve that, we need to
  be able to run a significant amount of end-developer code during every
  animation frame. That means we need a language that both delivers high
  performance and delivers predictable performance, without periodic
  pauses that would cause dropped frames.

* _Fast allocation_. The Flutter framework uses a functional-reactive style
  programming model, whose performance depends heavily on the underlying memory
  allocator efficiently handling small, short-lived allocations. The
  functional-reactive style was developed in languages with this property and
  does not work efficiently in languages that lack this facility.

Dart scores highly on all four dimensions. In addition, we have the opportunity
to work closely with the Dart community, which is actively investing resources
in improving Dart for use in Flutter. For example, when we
adopted Dart, the language did not have an ahead-of-time toolchain for producing
native binaries, which is instrumental in achieving predictable, high
performance, but now the language does because the Dart team built it for
Flutter. Similarly, the Dart VM has previously been optimized for throughput
but the team is now optimizing the VM for latency, which is more important for
Flutter's workload.

### Can Flutter run any Dart code?

Flutter should be able to run most Dart code that does not import (transitively,
or directly) dart:mirrors or dart:html.

### How big is the Flutter engine?

In November 2015, we measured the size of a minimal Flutter app, bundled as
an APK, to be approximately 8MB. For this simple app that used Material Design
widgets, the core engine is approximately 5MB, the framework + app code is
approximately 400kb, necessary Java code is 330k, and there is approximately
2.5MB of ICU data.

## Capabilities

### What kind of app performance can I expect?

You can expect excellent performance. Flutter is
designed to help developers easily achieve a constant 60fps. Flutter apps run
via natively compiled code – no interpreters are involved.
This means Flutter apps start quickly.

### What kind of developer cycles can I expect? How long between edit and refresh? {#hot-reload}

Flutter implements a _hot reload_ developer cycle. You can expect
sub-second reload times, on a device or an emulator/simulator.

Flutter's hot reload is _stateful_, which means the app state
is retained after a reload. This means you can quickly iterate
on a screen deeply nested in your app, without starting
from the home screen after every reload.

### Where can I deploy my Flutter app?

You can compile and deploy your Flutter app to iOS and Android.

### What devices and OS versions does Flutter run on?

Mobile operating systems: Android Jelly Bean, v16, 4.1.x or newer, and
iOS 8 or newer.

Mobile hardware: 64-bit iOS devices (starting with iPhone 5S and newer
iPhone models), and ARM Android devices.

We support developing Flutter apps with Android and iOS devices, as
well as with Android emulators and the iOS simulator.

We test on a variety of low-end to high-end phones (excluding tablets)
but we don't yet have an official device compatibility guarantee.
We do not offer support for tablets or have tablet-aware layouts.

### Does Flutter run on the web?

No. We are not working to provide a web version of Flutter.

### Can I use Flutter to build desktop apps?

We are focused on mobile-first use cases. However, Flutter is open source and we
encourage the community to use Flutter in a variety of interesting ways.

### Can I use Flutter inside of my existing native app?

Yes, you can embed a Flutter view in your existing Android or iOS app.
You can learn more about this at [[docs coming soon]]. If you want to do this,
we encourage you to email our mailing list:
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

Please follow [this issue](https://github.com/flutter/flutter/issues/8945)
to be notified when docs for this feature are available.

### Can I access platform services and APIs like sensors and local storage?

Yes. Flutter gives developers out-of-the-box access to _some_ platform-specific
services and APIs from the operating system. However, we want to avoid the
"lowest common denominator" problem with most cross-platform APIs, so we do not
intend to build cross-platform APIs for all native services and APIs.

We encourage developers to use Flutter's asynchronous message passing system to
create your own integrations with
[platform and third-party APIs](/platform-plugins/). Developers
can expose as much or as little of the platform APIs as they need, and build
layers of abstractions that are a best fit for their project.

### Can I extend and customize the bundled widgets?

Absolutely. Flutter's widget system was designed to be easily customizable.

Rather than having each widget provide a large number of parameters, Flutter
embraces composition. Widgets are built out of smaller widgets that you can
reuse and combine in novel ways to make custom widgets. For example, rather
than subclassing a generic button widget, RaisedButton combines a Material
widget with a GestureDetector widget. The Material widget provides the visual
design and the GestureDetector widget provides the interaction design.

To create a button with a custom visual design, you can combine widgets that
implement your visual design with a GestureDetector, which provides the
interaction design. For example, CupertinoButton follows this approach and
combines a GestureDetector with several other widgets that implement its
visual design.

Composition gives you maximum control over the visual and interaction design
of your widgets while also allowing a large amount of code reuse. In the
framework, we've decomposed complex widgets to pieces that separately implement
the visual, interaction, and motion design. You can remix these widgets however
you like to make your own custom widgets that have full range of expression.

### Can I interop with my mobile platform's default programming language?

Yes, Flutter supports calling into the platform, including integrating with Java
code on Android, and ObjectiveC or Swift code on iOS. This is enabled via a
flexible message passing style where a Flutter app may send and receive messages
to the mobile platform using a
[`BasicMessageChannel`](https://docs.flutter.io/flutter/services/BasicMessageChannel-class.html).

Learn more about [accessing platform and third-party services in Flutter](/platform-plugins/).

Here is an [example project](https://github.com/flutter/flutter/tree/master/examples/platform_channel)
that shows how to use a platform channel to access battery state information on
iOS and Android.

### Does Flutter come with a reflection/mirrors system?

Not at this time. Because Flutter apps are pre-compiled for iOS, and binary size
is always a concern with mobile apps, we disabled dart:mirrors. We are curious
what you might need reflection/mirrors for – please let us know at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

### How do I do internationalization (i18n), localization (l10n), and accessibility (a11y) in Flutter?

Flutter has basic support for accessibility on iOS and Android, though this
feature is a work in progress.

Flutter developers are encouraged to use the
[intl package](https://pub.dartlang.org/packages/intl) for
internationalization and localization.

We encourage you to email
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)
with your questions regarding these features.

### How do I write parallel and/or concurrent apps for Flutter?

Flutter supports isolates. Isolates are separate heaps in Flutter's VM, and they
are able to run in parallel (usually implemented as separate threads). Isolates
communicate by sending and receiving asynchronous messages. Flutter does not
currently have a shared-memory parallelism solution, although we are evaluating
solutions for this.

Check out an
[example of using isolates with Flutter](https://github.com/flutter/flutter/blob/master/examples/layers/services/isolate.dart).

### Can I use JSON/XML/protobuffers/etc with Flutter?

Absolutely. There are libraries in
[pub.dartlang.org](https://pub.dartlang.org) for JSON, XML,
protobufs, and many other utilities and formats.

### Can I build 3D (OpenGL) apps with Flutter?

Today we don't support for 3D via OpenGL ES or similar. We have long-term plans
to expose an optimized 3D API, but right now we're focused on 2D.

## Framework

### Why is the build() method on State, not StatefulWidget?

Putting a `Widget build(BuildContext context)` method on State
rather putting a `Widget build(BuildContext context, State state)`
method on StatefulWidget gives developers more flexibility when
subclassing StatefulWidget. You can read a more
[detailed discussion on the API docs for State.build](https://docs.flutter.io/flutter/widgets/State/build.html).

### Where is Flutter's markup language? Why doesn't Flutter have a markup syntax?

Flutter UIs are built with an imperative, object-oriented
language (Dart, the same language used to build Flutter's framework). Flutter
does not ship with a declarative markup.

We found that UIs dynamically built with code allow for
more flexibility. For example, we have found it difficult
for a rigid markup system to express and produce
customized widgets with bespoke behaviours.

We have also found that our "code-first" better allows for features like
hot reload and dynamic environment adaptations.

It is possible to create a custom language that is then
converted to widgets on the fly. Since build methods are "just code", they
can do anything, including interpreting markup and turning it into widgets.

### My app has a Slow Mode banner/ribbon in the upper right. Why am I seeing that?

By default `flutter run` command uses the debug build configuration. 

The debug configuration runs your Dart code in a VM (Virtual Machine) enabling a
fast development cycle with [hot reload](#hot-reload) (release builds are
compiled on [Android](#run-android) and [iOS](#run-ios)).

The debug configuration also checks all asserts, which helps you catch errors
early during development but impose a runtime cost. The "slow mode" banner
indicates that these checks are enabled. You can run your app without these
checks by using either the `--profile` or `--release` flag to `flutter run`.

## Project

### Where can I get support?

If you think you've encountered a bug, please file it in our
[issue tracker](https://github.com/flutter/flutter/issues). We
encourage you to use
[Stack Overflow](https://stackoverflow.com/tags/flutter) for "HOWTO"
type questions. For discussions,
please join our mailing list at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

### How do I get involved?

Flutter is open source, and we encourage you to contribute. You can start by
simply filing issues for feature requests and bugs in our
[issue tracker](https://github.com/flutter/flutter/issues).

We recommend that you join our mailing list at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com) and let us
know how you're using Flutter and what you'd like to do with it.

If you're
interested in contributing code, you can start by reading our
[Contributing Guide](https://github.com/flutter/flutter/blob/master/CONTRIBUTING.md)
and check out our list of
[easy starter issues](https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+fix%22).

### Is Flutter open source?

Yes, Flutter is open source technology. You can find the project
on [GitHub](https://github.com/flutter/flutter).

### Which software license(s) apply to Flutter and its dependencies?

Flutter includes two components: an engine that ships as a dynamically linked
binary, and the Dart framework as a separate binary that the engine loads.
The engine uses multiple software components with many dependencies; view the
complete list [here](https://raw.githubusercontent.com/flutter/engine/master/sky/packages/sky_engine/LICENSE).

The framework is entirely self-contained and requires [only one license](https://github.com/flutter/flutter/blob/master/LICENSE).

In addition, any Dart packages you use may have their own license requirements.

### How can I determine the licenses my Flutter application needs to show?

There's an API to find the list of licenses you need to show:

* If your application has a [Drawer](https://docs.flutter.io/flutter/material/Drawer-class.html),
  add an [AboutListTile](https://docs.flutter.io/flutter/material/AboutListTile-class.html).

* If your application doesn't have a Drawer but does use the material
  library, call either [showAboutDialog](https://docs.flutter.io/flutter/material/showAboutDialog.html)
  or [showLicensePage](https://docs.flutter.io/flutter/material/showLicensePage.html).

* For a more custom approach, you can get the raw licenses from the [LicenseRegistry](https://docs.flutter.io/flutter/foundation/LicenseRegistry-class.html).

### Who works on Flutter?

Flutter is an open source project. Currently, the bulk of the development is done
by engineers at Google. If you're excited about Flutter, we encourage you to join
the community and contribute to Flutter!

[widgets]: https://flutter.io/widgets/

### What are Flutter's guiding principles?

We believe that:

* In order to reach every potential user, developers need to target multiple
mobile platforms.
* HTML and WebViews as they exist today make it challenging to
consistently hit high frame rates and deliver high-fidelity experiences, due to
automatic behavior (scrolling, layout) and legacy support.
* Today, it's too
costly to build the same app multiple times: it requires different teams,
different code bases, different workflows, different tools, etc.
* Developers want
an easier, better way to use a single codebase to build mobile apps for multiple
target platforms, and they don't want to sacrifice quality, control, or
performance.

We are focused on three things:

* _Control_ - Developers deserve access to, and control over, all layers of the
system. Which leads to:
* _Performance_ - Users deserve perfectly fluid, responsive,
jank-free apps. Which leads to:
* _Fidelity_ - Everyone deserves precise, beautiful,
delightful mobile app experiences.

### Will Apple reject my Flutter app?

We can't speak for Apple, but Apple's policies have changed over the
years, and they have
allowed apps built with systems like Flutter. We are aware of
apps built with Flutter that have been reviewed and
released via the App Store.

Of course, Apple is ultimately
in charge of their ecosystem, but our goal is to continue to do everything we
can to ensure Flutter apps can be deployed into Apple's App Store.