---
layout: page
title: FAQ

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

Flutter is for _developers_ that want a faster
way to build beautiful mobile apps, or
a way to reach more users with a single investment.

Flutter is also for _engineering managers_ that need to lead
mobile development teams. Flutter allows eng managers
to create a single _mobile app dev team_, unifying their
development investments to ship more features faster,
ship the same feature set to iOS and Android at the same
time, and lower maintenance costs.

While not the initial target audience,
Flutter is also for _designers_
that want their original design visions delivered
consistently, with high fidelity, to all users on mobile.

Fundamentally, Flutter is for users that want beautiful apps,
with delightful motion and animation, and UIs with character
and an identity all their own.

### How experienced of a programmer/developer do I have to be to use Flutter?

Flutter is approachable to programmers familiar with object-oriented
concepts (classes, methods, variables, etc) and imperative programming
concepts (loops, conditionals, etc).

No prior mobile experience is required in order to learn and use Flutter.

We have seen people with very little programming experience learn
and use Flutter for prototyping and app development.

### What kinds of apps can I build with Flutter?

Flutter is optimized for 2D mobile apps that want to run on
both Android and iOS.

Apps that need to deliver brand-first designs are particularly
well suited for Flutter. However, apps that need to look like
stock platform apps can also be built with Flutter.

You can build full-featured apps with Flutter, including
camera, geolocation, network, storage, 3rd-party SDKs, and more.

### Who makes Flutter?

Flutter is an open source project, with contributions from Google
and the community.

### Who uses Flutter?

Google uses Flutter to build business-critical apps for iOS and Android.
For example, Google's mobile sales tool app is built with Flutter, along
with a Store Manager app for Google Shopping Express. Other Flutter
apps are in the works, or "inside the firewall".

Teams outside of Google are also using Flutter.
For example, the official app for the musical Hamilton
([Android](https://play.google.com/store/apps/details?id=com.hamilton.app),
[iOS](https://itunes.apple.com/us/app/hamilton-the-official-app/id1255231054?mt=8))
is built with Flutter.

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

* Heavily optimized, mobile-first 2D rendering engine with excellent support for
  text
* Modern react-style framework
* Rich set of widgets for Android and iOS
* APIs for unit and integration tests
* Interop and plugin APIs to connect to the system and 3rd-party SDKs
* Headless test runner for running tests on Windows, Linux, and Mac
* Command-line tools for creating, building, testing, and compiling your apps

### Does Flutter work with any editors or IDEs?

We are building plugins for [Android Studio](https://developer.android.com/studio/),
[IntelliJ IDEA](https://www.jetbrains.com/idea/), and [VS Code](https://code.visualstudio.com/).

See [editor configuration](/get-started/editor/) for setup details, and
['Developing Flutter apps in an IDE'](/using-ide/) for tips on how to use the plugins.

Alternatively, you can use a combination of the `flutter` command in a terminal
and one of the many editors that support [editing Dart](https://www.dartlang.org/tools).

### Does Flutter come with a framework?

Yes! Flutter ships with a modern framework, inspired by React.
Flutter's framework is designed to be layered and customizable (and optional).
Developers can choose to use only parts of the framework, or a different
framework.

### Does Flutter come with widgets?

Yes! Flutter ships with a set of
[high quality Material Design and Cupertino (iOS-style) widgets][widgets], layouts,
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

The engine's C/C++ code is compiled with Android's NDK, and any Dart code is AOT-compiled
into native code. The app runs using the native instruction set (no interpreter
is involved).

### How does Flutter run my code on iOS? {#run-ios}

The engine's C/C++ code is compiled with LLVM, and any Dart code is AOT-compiled
into native code. The app runs using the native instruction set (no interpreter
is involved).

### Does Flutter use my system's OEM widgets?

No. Instead, Flutter provides a set of widgets
(including Material Design and Cupertino (iOS-styled) widgets),
managed and rendered by Flutter's framework and engine.
You can browse a
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

By using the same renderer, framework, and set of widgets, we make it
easier to publish for both iOS and Android concurrently, without having to do
careful and costly planning to align two separate codebases and feature sets.

By using a single language, a single framework,
and a single set of libraries for all of your UI
(regardless if your UI is different for each mobile platform
or largely consistent), we also aim to
help lower app development and maintenance costs.

### What happens when my mobile OS updates and introduces new widgets?

The Flutter team watches the adoption and demand for new mobile
widgets from iOS and Android, and aims to work with the community
to build support for new widgets. This work may come in the form
of lower-level framework features, new composable widgets, or new
widget implementations.

Flutter's layered architecture is designed to support numerous
widget libraries, and we encourage and support the community in
building and maintaining widget libraries.

### What happens when my mobile OS updates and introduces new platform capabilities?

Flutter's interop and plugin system is designed to allow
developers to access new mobile OS features and capabilities
immediately. Developers don't have to wait for the Flutter team
to expose the new mobile OS capability.

### What operating systems can I use to build a Flutter app?

Flutter supports development on Linux, Mac, and, Windows.

### What language is Flutter written in?

We looked at a lot of languages and runtimes, and ultimately adopted Dart for
the framework and widgets. The underlying graphics framework and the Dart
virtual machine are implemented in C/C++.

### Why did Flutter choose to use Dart?

Flutter used four primary dimensions for evaluation, and considered the needs
of framework authors, developers, and end users. We found some languages met
some requirements, but Dart scored highly on all of our evaluation dimensions
and met all our requirements and criteria.

Dart runtimes and compilers support the combination of two critical features for
Flutter: a JIT-based fast development cycle that allows for shape changing and
stateful hot reloads in a language with types, plus an Ahead-of-Time compiler
that emits efficient ARM code for fast startup and predictable performance of
production deployments.

In addition, we have the opportunity to work closely with the Dart community,
which is actively investing resources in improving Dart for use in Flutter. For
example, when we adopted Dart, the language did not have an ahead-of-time
toolchain for producing native binaries, which is instrumental in achieving
predictable, high performance, but now the language does because the Dart team
built it for Flutter. Similarly, the Dart VM has previously been optimized for
throughput but the team is now optimizing the VM for latency, which is more
important for Flutter’s workload.

Dart scores highly for us on the following primary criteria:

* _Developer productivity_. One of Flutter's main value propositions is that it
  saves engineering resources by letting developers create apps for both iOS and
  Android with the same codebase. Using a highly productive language
  accelerates developers further and makes Flutter more attractive.
  This was very important to both our framework team as well as our developers.
  The majority of Flutter is built in the same language we give to our users, so
  we need to stay productive at 100k's lines of code, without sacrificing
  approachability or readability of the framework and widgets for our developers.

* _Object-orientation_. For Flutter, we want a language that's suited to
  Flutter's problem domain: creating visual user experiences. The industry has
  multiple decades of experience building user interface frameworks in
  object-oriented languages. While we could use a non-object-oriented language,
  this would mean reinventing the wheel to solve several hard problems.
  Plus, the vast majority of developers have experience with object-oriented
  development, making it easier to learn how to develop with Flutter.

* _Predictable, high performance_. With Flutter, we want to empower developers
  to create fast, fluid user experiences. In order to achieve that, we need to
  be able to run a significant amount of end-developer code during every
  animation frame. That means we need a language that both delivers high
  performance and delivers predictable performance, without periodic
  pauses that would cause dropped frames.

* _Fast allocation_. The Flutter framework uses a functional-style flow
  that depends heavily on the underlying memory
  allocator efficiently handling small, short-lived allocations.
  This style was developed in languages with this property and does
  not work efficiently in languages that lack this facility.

### Can Flutter run any Dart code?

Flutter should be able to run most Dart code that does not import (transitively,
or directly) dart:mirrors or dart:html.

### How big is the Flutter engine?

In June 2017, we measured the size of a minimal Flutter app
(no Material Components, just a single `Center` widget, built with
`flutter build apk`), bundled and
compressed as a release APK, to be approximately 6.7MB.

For this simple app,
the core engine is approximately 3.3MB (compressed),
the framework + app code is approximately 1.25MB (compressed),
the LICENSE file (contained in app.flx) is 55k (compressed),
necessary Java code (classes.dex) is 40k (compressed),
and there is approximately 2.1MB of (compressed) ICU data.

Of course, YMMV, and we recommend that you measure your own app,
by running `flutter build apk` and looking at `app/outputs/apk/app-release.apk`.

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

### How is 'hot reload' different from 'full restart'?

Hot Reload works by injecting updated source code files into the running Dart VM
(Virtual Machine). This includes not only adding new classes, but also adding
methods and fields to existing classes, and changing existing functions. A few
types of code changes cannot be hot reloaded though:

* Global variable initializers.
* Static field initializers.
* The `main()` method of the app.

See [Using Hot Reload](/hot-reload/) for additional details.

### Where can I deploy my Flutter app?

You can compile and deploy your Flutter app to iOS and Android.

### What devices and OS versions does Flutter run on?

Mobile operating systems: Android Jelly Bean, v16, 4.1.x or newer, and
iOS 8 or newer.

Mobile hardware: 64-bit iOS devices (starting with iPhone 5S and newer
iPhone models), and ARM Android devices.

Note that we currently do not support:
  * ARM32 iOS devices (iPhone 4, iPhone 5; issue [#2089](https://github.com/flutter/flutter/issues/2089))
  * x86 Android devices (issue [#9253](https://github.com/flutter/flutter/issues/9253))

We support developing Flutter apps with Android and iOS devices, as
well as with Android emulators and the iOS simulator.

We test on a variety of low-end to high-end phones
but we don't yet have an official device compatibility guarantee.

We do not test on tablets, so there may be issues with some
widgets on tablets. We have not implemented tablet-specific
adaptations in our widgets.

### Does Flutter run on the web?

No. We are not working to provide a web version of Flutter.

### Can I use Flutter to build desktop apps?

We are focused on mobile-first use cases. However, Flutter is open source and we
encourage the community to use Flutter in a variety of interesting ways.

### Can I use Flutter inside of my existing native app?

Yes, you can embed a Flutter view in your existing Android or iOS app, however
our tooling is currently not fully optimized for this use case (see
[this issue](https://github.com/flutter/flutter/issues/14821) for details).

Two current demonstrations of this are the [platform_view](https://github.com/flutter/flutter/tree/master/examples/platform_view)
and [flutter_view](https://github.com/flutter/flutter/tree/master/examples/flutter_view)
examples. Some initial documentation is available in the wiki page
[Add Flutter to existing apps](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps).

### Can I access platform services and APIs like sensors and local storage?

Yes. Flutter gives developers out-of-the-box access to _some_ platform-specific
services and APIs from the operating system. However, we want to avoid the
"lowest common denominator" problem with most cross-platform APIs, so we do not
intend to build cross-platform APIs for all native services and APIs.

A number of platform services and APIs have [ready-made
packages](https://pub.dartlang.org/flutter/) available in the Pub
repository. Using an existing package [is easy](/using-packages/).

Finally, we encourage developers to use Flutter's asynchronous message passing
system to create your own integrations with [platform and third-party
APIs](/platform-channels/). Developers can expose as much or as little of the
platform APIs as they need, and build layers of abstractions that are a best fit
for their project.

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

### Why would I want to share layout code across iOS and Android?

You can choose to implement different app layouts for iOS and Android.
Developers are free to check the mobile OS at runtime
and render different layouts, though we find this practice to be rare.

More and more, we see mobile app layouts and designs evolving
to be more brand-driven and unified across platforms. This implies
a strong motivation to share layout and UI code across iOS and
Android.

The brand identity and customization of the app's aesthetic design is now
becoming more important than strictly adhering to traditional platform
aesthetics. For example, app designs often require custom fonts, colors,
shapes, motion, and more in order to clearly convey their brand identity.

We also see common layout patterns deployed across iOS and Android.
For example, the "bottom nav bar" pattern can now be naturally found
across iOS and Android. There seems to be a convergence of design ideas
across mobile platforms.

### Can I interop with my mobile platform's default programming language?

Yes, Flutter supports calling into the platform, including integrating with Java or Kotlin
code on Android, and ObjectiveC or Swift code on iOS. This is enabled via a
flexible message passing style where a Flutter app may send and receive messages
to the mobile platform using a
[`BasicMessageChannel`](https://docs.flutter.io/flutter/services/BasicMessageChannel-class.html).

Learn more about accessing platform and third-party services in Flutter with
[platform channels](/platform-channels/).

Here is an [example project](https://github.com/flutter/flutter/tree/master/examples/platform_channel)
that shows how to use a platform channel to access battery state information on
iOS and Android.

### Does Flutter come with a reflection/mirrors system?

Not at this time. Because Flutter apps are pre-compiled for iOS, and binary size
is always a concern with mobile apps, we disabled dart:mirrors. We are curious
what you might need reflection/mirrors for – please let us know at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

### How do I do internationalization (i18n), localization (l10n), and accessibility (a11y) in Flutter?

Learn more about i18n and l10n in the
[Flutter Internationalization Tutorial](/tutorials/internationalization/).

Flutter has built-in support for basic accessibility features including
screen readers on Android and iOS. Check the
[Semantics](https://docs.flutter.io/flutter/widgets/Semantics-class.html)
widget for ways to customize the accessibility experience of
your Flutter app.

We encourage you to email
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com) with your
questions regarding these features.

### How do I write parallel and/or concurrent apps for Flutter?

Flutter supports isolates. Isolates are separate heaps in Flutter's VM, and they
are able to run in parallel (usually implemented as separate threads). Isolates
communicate by sending and receiving asynchronous messages. Flutter does not
currently have a shared-memory parallelism solution, although we are evaluating
solutions for this.

Check out an
[example of using isolates with Flutter](https://github.com/flutter/flutter/blob/master/examples/layers/services/isolate.dart).

### Can I run Dart code in the background of an Flutter app?

Running code in the background has platform-specific APIs due to fundamental
differences in the support for background execution on each of the for Android
and iOS platforms.

On Android, the [`android_alarm_manager`](https://pub.dartlang.org/packages/android_alarm_manager)
plugin enables you to run Dart code in the background, even when your Flutter
app is not in the foreground.

On iOS we currently do not support this capability. Please keep an eye on [bug
6192](https://github.com/flutter/flutter/issues/6192) for updates.

### Can I use JSON/XML/protobuffers/etc with Flutter?

Absolutely. There are libraries in
[pub.dartlang.org](https://pub.dartlang.org) for JSON, XML,
protobufs, and many other utilities and formats.

For a detailed writeup on using JSON with Flutter, check out [the JSON
tutorial](/json/).

### Can I build 3D (OpenGL) apps with Flutter?

Today we don't support for 3D via OpenGL ES or similar. We have long-term plans
to expose an optimized 3D API, but right now we're focused on 2D.

### Why is my APK or IPA so big?

Usually, assets including images, sound files, fonts, etc, are the bulk
of an APK or IPA.
Various tools in the Android and iOS ecosystems can help you understand
what's inside of your APK or IPA.

Also, be sure to create a
_release build_
of your APK or IPA with the Flutter tools.
A release build is usually _much_ smaller
than a _debug build_.

Learn more about creating a
[release build of your Android app](https://flutter.io/android-release/),
and creating a [release build of your iOS app](https://flutter.io/ios-release/).

### Do Flutter apps run on Chromebooks?

We have seen Flutter apps run on some Chromebooks.
We are tracking
[issues related to running Flutter on Chromebooks](https://github.com/flutter/flutter/labels/platform-arc).

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
converted to widgets on the fly. Because build methods are "just code", they
can do anything, including interpreting markup and turning it into widgets.

### My app has a Slow Mode banner/ribbon in the upper right. Why am I seeing that?

By default `flutter run` command uses the debug build configuration.

The debug configuration runs your Dart code in a VM (Virtual Machine) enabling a
fast development cycle with [hot reload](#hot-reload) (release builds are
compiled using the standard [Android](#run-android) and [iOS](#run-ios)
toolchains).

The debug configuration also checks all asserts, which helps you catch errors
early during development, but imposes a runtime cost. The "slow mode" banner
indicates that these checks are enabled. You can run your app without these
checks by using either the `--profile` or `--release` flag to `flutter run`.

If you are using the Flutter plugin for IntelliJ, you can launch the app in
profile or release mode using the menu entries **Run > Flutter Run in Profile Mode**
or **Release Mode**.

### What programming paradigm does Flutter's framework use?

Flutter is a multi-paradigm programming environment. Many programming techniques
developed over the past few decades are used in Flutter. We use each one where
we believe the strengths of the technique make it particularly well-suited. In
no particular order:

* Composition: The primary paradigm used by Flutter is that of using
small objects with narrow scopes of behavior, composed together to
obtain more complicated effects. Most widgets in the Flutter widget
library are built in this way. For example, the Material
[FlatButton](https://docs.flutter.io/flutter/material/FlatButton-class.html)
class is built using a
[MaterialButton](https://docs.flutter.io/flutter/material/MaterialButton-class.html)
class, which itself is built using
an [IconTheme](https://docs.flutter.io/flutter/widgets/IconTheme-class.html),
an [InkWell](https://docs.flutter.io/flutter/material/InkWell-class.html),
a [Padding](https://docs.flutter.io/flutter/widgets/Padding-class.html),
a [Center](https://docs.flutter.io/flutter/widgets/Center-class.html),
a [Material](https://docs.flutter.io/flutter/material/Material-class.html),
an [AnimatedDefaultTextStyle](https://docs.flutter.io/flutter/widgets/AnimatedDefaultTextStyle-class.html),
and a [ConstrainedBox](https://docs.flutter.io/flutter/widgets/ConstrainedBox-class.html).
The [InkWell](https://docs.flutter.io/flutter/material/InkWell-class.html)
is built using a [GestureDetector](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html).
The [Material](https://docs.flutter.io/flutter/material/Material-class.html)
is built using an [AnimatedDefaultTextStyle](https://docs.flutter.io/flutter/widgets/AnimatedDefaultTextStyle-class.html),
a [NotificationListener](https://docs.flutter.io/flutter/widgets/NotificationListener-class.html),
and an [AnimatedPhysicalModel](https://docs.flutter.io/flutter/widgets/AnimatedPhysicalModel-class.html).
And so on. It's widgets all the way down.

* Functional programming: Entire applications can be built with only
[StatelessWidget](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html)s,
which are essentially functions that describe how arguments map to other
functions, bottoming out in primitives that compute layouts or paint graphics.
(Such applications can't easily have state, so are typically non-interactive.)
For example, the [Icon](https://docs.flutter.io/flutter/widgets/Icon-class.html)
widget is essentially a function that maps its arguments
([color](https://docs.flutter.io/flutter/widgets/Icon/color.html),
[icon](https://docs.flutter.io/flutter/widgets/Icon/icon.html),
[size](https://docs.flutter.io/flutter/widgets/Icon/size.html)) into layout
primitives. Additionally, heavy use is made of immutable data structures,
including the entire
[Widget](https://docs.flutter.io/flutter/widgets/Widget-class.html) class
hierarchy as well as numerous supporting classes such as
[Rect](https://docs.flutter.io/flutter/dart-ui/Rect-class.html) and
[TextStyle](https://docs.flutter.io/flutter/painting/TextStyle-class.html). On a
smaller scale, Dart's
[Iterable](https://docs.flutter.io/flutter/dart-core/Iterable-class.html) API,
which makes heavy use of the functional style (map, reduce, where, etc), is
frequently used to process lists of values in the framework.

* Event-driven programming: User interactions are represented by event objects
that are dispatched to callbacks registered with event handlers. Screen updates
are triggered by a similar callback mechanism. The
[Listenable](https://docs.flutter.io/flutter/foundation/Listenable-class.html)
class, which is used as the basis of the animation system, formalises a
subscription model for events with multiple listeners.

* Class-based object-orientated programming: Most of the APIs of the framework
are built using classes with inheritance. We use an approach whereby we define
very high-level APIs in our base classes, then specialise them iteratively in
subclasses. For example, our render objects have a base class
([RenderObject](https://docs.flutter.io/flutter/rendering/RenderObject-class.html))
that is agnostic regarding the coordinate system, and then we have a subclass
([RenderBox](https://docs.flutter.io/flutter/rendering/RenderBox-class.html))
that introduces the opinion that the geometry should be based on the Cartesian
coordinate system (x/width and y/height).

* Prototype-based object-orientated programming: The
[ScrollPhysics](https://docs.flutter.io/flutter/widgets/ScrollPhysics-class.html)
class chains instances to compose the physics that apply to scrolling
dynamically at runtime. This lets the system compose, for example, paging
physics with platform-specific physics, without the platform having to be
selected at compile time.

* Imperative programming: Straightforward imperative programming, usually
paired with state encapsulated within an object, is used where it provides the
most intuitive solution. For example, tests are written in an imperative style,
first describing the situation under test, then listing the invariants that the
test must match, then advancing the clock or inserting events as necessary for
the test.

* Reactive programming: The widget and element trees are sometimes described as
reactive, because new inputs provided in a widget's constructor are immediately
propagated as changes to lower-level widgets by the widget's build method, and
changes made in the lower widgets (e.g., in response to user input) propagate
back up the tree via event handlers. Aspects of both functional-reactive and
imperative-reactive are present in the framework, depending on the needs of the
widgets. Widgets with build methods that consist of just an expression
describing how the widget reacts to changes in its configuration are functional
reactive widgets (e.g., the Material
[Divider](https://docs.flutter.io/flutter/material/Divider-class.html) class).
Widgets whose build methods construct a list of children over several
statements, describing how the widget reacts to changes in its configuration,
are imperative reactive widgets (e.g., the
[Chip](https://docs.flutter.io/flutter/material/Chip-class.html) class).

* Declarative programming: The build methods of widgets are often a single
expression with multiple levels of nested constructors, written using a strictly
declarative subset of Dart. Such nested expressions could be mechanically
transformed to or from any suitably expressive markup language. For example,
the
[UserAccountsDrawerHeader](https://docs.flutter.io/flutter/material/UserAccountsDrawerHeader-class.html)
widget has a long build method (20+ lines), consisting of a single nested
expression. This can also be combined with the imperative style to build UIs
that would be harder to describe in a pure-declarative approach.

* Generic programming: Types can be used to help developers catch programming
errors early. The Flutter framework uses generic programming to help in this
regard. For example, the
[State](https://docs.flutter.io/flutter/widgets/State-class.html) class is
parameterized in terms of the type of its associated widget, so that the Dart
analyzer can catch mismatches of states and widgets. Similarly, the
[GlobalKey](https://docs.flutter.io/flutter/widgets/GlobalKey-class.html) class
takes a type parameter so that it can access a remote widget's state in a
type-safe manner (using runtime checking), the
[Route](https://docs.flutter.io/flutter/widgets/Route-class.html) interface is
parameterized with the type that it is expected to use when
[popped](https://docs.flutter.io/flutter/widgets/Navigator/pop.html), and
collections such as
[List](https://docs.flutter.io/flutter/dart-core/List-class.html)s,
[Map](https://docs.flutter.io/flutter/dart-core/Map-class.html)s, and
[Set](https://docs.flutter.io/flutter/dart-core/Set-class.html)s are all
parameterized so that mismatched elements can be caught early either during
analysis or at runtime during debugging.

* Concurrent programming: Flutter makes heavy use of
[Future](https://docs.flutter.io/flutter/dart-async/Future-class.html)s and
other asynchronous APIs. For example, the animation system reports when an
animation is finished by completing a future. The image loading system similarly
uses futures to report when a load is complete.

* Constraint programming: The layout system in Flutter uses a weak form of
constraint programming to determine the geometry of a scene. Constraints (e.g.,
for cartesian boxes, a minimum and maximum width and a minimum and maximum
height) are passed from parent to child, and the child selects a resulting
geometry (e.g., for cartesian boxes, a size, specifically a width and a height)
that fulfills those constraints. By using this technique, Flutter can usually
lay out an entire scene with a single pass.

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

* If your application doesn't have a Drawer but does use the Material Components
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
