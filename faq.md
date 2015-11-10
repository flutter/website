---
layout: page
title: Flutter FAQ
nav_title: FAQ
permalink: /faq/
---

## What does Flutter do?

Flutter gives developers an easy and productive way to build and deploy
cross-platform, high-performance mobile apps on both Android and iOS.

Flutter gives users beautiful, fast, and jitter-free app experiences.

## What does Flutter provide?

Flutter has three main components:

* a heavily optimized, mobile-first 2D rendering engine (with excellent support
for text)
* a functional-reactive framework (optional, you can bring-your-own
framework)
* a set of Material Design widgets (optional, you can bring-your-own
widgets), libraries, tools, and a plugin for Atom

## What makes Flutter unique?

Flutter is different than most other options for building cross-platform
mobile apps because Flutter uses neither WebView nor the OEM widgets
that shipped with the device. Instead, Flutter uses its own high-performance
rendering engine to draw widgets.

Flutter also offers developers a highly productive and fast development
experience, fast runtime and engine performance, and beautifully designed
widgets that make for beautiful apps.

## Why would I want to invest in learning Flutter?

Flutter is an easy way to use a single codebase to deliver beautiful mobile
apps that run on both Android and iOS. Flutter gives developers quick
edit/debug cycles for an enjoyable low-friction workflow.

## What are Flutter's guiding principles?

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

## How is Flutter related to Sky?

Sky was the codename of an earlier version of Flutter.

## What devices and OS versions does Flutter run on?

Flutter apps run on Android Jelly Bean, v16, 4.1.x or newer, and iOS 5 or newer.
We test on a variety of low-end to high-end phones and tablets, but we don't yet
have an official device compatibility guarantee.

## What technology is Flutter built with?

Flutter is built with C, C++, Dart, Skia (a 2D rendering engine),
[Mojo IPC](https://github.com/domokit/mojo), and
Blink's text rendering system. See this [architecture diagram](https://docs.google.com/presentation/d/1cw7A4HbvM_Abv320rVgPVGiUP2msVs7tfGbkgdrTy0I/edit#slide=id.gbb3c3233b_0_162) for a better
picture of the main components.

## How does Flutter run my code on Android?

The engine's C/C++ code is compiled with Android's NDK, and the majority of the
framework and application code is running on the Dart VM. The Dart VM generates
JIT-compiled optimized native code on the device. (In other words, the Dart VM
is not an interpreter.)

## How does Flutter run my code on iOS?

The engine's C/C++ code is compiled with LLVM, and any Dart code is AOT-compiled
into native code. The app runs using the native instruction set (no interpreter
is involved).

## Does Flutter run on the web?

No. We do not plan to provide a web version of Flutter.

## What operating systems can I use to build a Flutter app?

Flutter supports development on Linux and Mac. Windows support is planned.

## What kinds of apps can I build with Flutter?

Flutter is optimized for 2D mobile apps that want to run on both Android and iOS.
Apps that use Material Design are particularly well suited for Flutter.

## What kind of app performance can I expect?

You can expect excellent performance. Flutter is
designed to help developers easily achieve a constant 60fps. Flutter apps run
via natively compiled code, no interpreters are involved.

## Can I use Flutter to build desktop apps?

We are focused on mobile-first use cases. However, Flutter is open source and we
encourage the community to use Flutter in a variety of interesting ways.

## Can I use Flutter inside of my existing native app?

Yes, you can embed a Flutter view in your existing Android or iOS app.
You can learn more about this at [[docs coming soon]]. If you want to do this, we
encourage you to email our mailing list:
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

## Can I access native services and APIs like sensors and local storage?

Yes. Flutter gives developers access to any service or API that the host
operating system provides, via Mojo's IPC system. You can learn more about this
at [[docs coming soon]]. If you want to do this, we encourage you to email our
mailing list: [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

## Can I interop with my mobile platform's default programming language?

Yes. Flutter uses Mojo's IPC system to interop between Flutter's app code and
the host operating system. You can learn more about this at [[docs coming soon]].
If you want to do this, we encourage you to email our mailing list:
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

## Does Flutter come with a framework?

Yes! Flutter ships with a functional-reactive style framework, inspired by
React. However, Flutter's framework is designed to be optional and layered.
Developers can choose to use only parts of the framework, or a different
framework.

## Does Flutter come with widgets?

Yes! Flutter ships with a set of high quality Material Design widgets, layouts,
and themes. You can see a collection of those widgets at [[docs coming soon]]. Of
course, these widgets are optional. Flutter is designed to make it easy to
create your own widgets, or customize the existing widgets.

## Can I extend and customize the bundled widgets?

Absolutely. Flutter's widget system was designed to be easily customizable. You
can see an example of that at [[docs coming soon]].

## Does Flutter come with a testing framework?

Flutter apps are tested with the
[test package](https://pub.dartlang.org/packages/test). Learn more about
testing with Flutter here [[docs coming soon]].

## Does Flutter come with a dependency injection framework or solution?

Not at this time. Please share your ideas at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

## Does Flutter come with a reflection/mirrors system?

Not at this time. Because Flutter apps are pre-compiled for iOS, and binary size
is always a concern with mobile apps, we disabled dart:mirrors. We are curious
what you might need reflection/mirrors for, please email us at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

## How do I do internationalization (i18n), localization (l10n), and accessibility (a11y) in Flutter?

These capabilities are very much on our radar, but we have not yet
started on the APIs. We are currently building the core
framework with these capabilities in mind.

## How do I write parallel and/or concurrent apps for Flutter?

Flutter supports isolates. Isolates are separate heaps in Flutter's VM, and they
are able to run in parallel (usually implemented as separate threads). Isolates
communicate by sending and receiving asynchronous messages. Flutter does not
currently have a shared-memory parallelism solution, although we are evaluating
solutions for this.

## Can I use JSON/XML/protobuffers/etc with Flutter?

Absolutely. There are libraries in
[pub.dartlang.org](https://pub.dartlang.org) for JSON, XML,
protobufs, and many other utilities and formats.

## How do I write well-styled code for Flutter?

Flutter has an
[opinionated style guide](https://github.com/flutter/engine/blob/master/sky/specs/style-guide.md),
which we encourage you to check out.

## Does Flutter use my system's OEM widgets?

No. Flutter provides a set of Material Design widgets, managed and rendered by
Flutter's framework and engine.

## How do I deploy a Flutter app?

Flutter apps are most commonly deployed via the mobile platform's store (such as
Apple's App Store and Google's Play Store). We plan to deliver tools to easily
to [generate an .ipa](https://github.com/flutter/flutter/issues/46)
and easily [generate an .apk](https://github.com/flutter/flutter/issues/45).

## Can I update my app over the network, outside of the Play Store?

Yes. On Android, you can update your app over the network (via HTTP), without
first publishing to the Play Store. This can be useful because it doesn't bother
the user with a notification, ensures your users are on the latest version,
makes it easier to run A/B experiments, and more.

Unfortunately, due to iOS restrictions, updating your Flutter app over the
network is not possible. We are curious how much you use this feature, please
let us know at [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

## What if I don't want to build my app with Material Design?

Flutter's widget system is designed to be extensible, and it's supported and
possible to create your own set of widgets using our base classes.

## Does Flutter work with any editors or IDEs?

We are building a
[Flutter plugin for Atom](https://atom.io/packages/dartlang). Today, it
can syntax highlight, code
complete, refactor, launch apps, create new apps from a template, show type
hierarchies, jump to definition, and more.

## Can I build 3D (OpenGL) apps with Flutter?

Today we don't support for 3D via OpenGL ES or similar. We have long-term plans
to expose an optimized 3D API, but right now we're focused on 2D.

## How big is the Flutter engine?

As of November, 2015, we measured the size of a minimal Flutter app, bundled as
an APK, to be approximately 8MB. For this simple app that used Material Design
widgets, the core engine is approximately 5MB, the framework + app code is
approximately 400kb, necessary Java code is 330k, and there is approximately
2.5MB of ICU data. We are working to get this smaller.

## Where can I get support?

If you think you've encountered a bug, please file it in our
[issue tracker](https://github.com/flutter/flutter/issues). We
encourage you to use [Stack Overflow](https://stackoverflow.com/) for "HOWTO"
type questions. For discussions,
please join our mailing list at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com).

## How do I get involved?

Flutter is open source, and we encourage you to contribute. You can start by
simply filing issues for feature requests and bugs in our
[issue tracker](https://github.com/flutter/flutter/issues). You
should also join our mailing list at
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com) and let us
know how you're using Flutter and what you'd like to do with it. If you're
interested in contributing code, you can start by reading our
[Contributing guide](https://github.com/flutter/flutter/blob/master/CONTRIBUTING.md).

## Should I build my next production app with Flutter?

As of November 2015, Flutter is still being developed heavily and is not yet at
1.0. While lower levels of the system are changing less, we envision changing
parts of the system based on early adopter feedback.

## I heard Apple rejects apps built with third-party frameworks, is that true? Will Apple reject my Flutter app?

We can't speak for Apple, but Apple's policies have changed, and they have
allowed apps built with systems like Flutter. Of course, Apple is in ultimately
in charge of their ecosystem, but our goal is to continue to do everything we
can to ensure Flutter apps can be deployed into Apple's App Store.

## What language is Flutter written in?

We looked at a lot of languages and runtimes, and ultimately adopted Dart for
the framework and widgets. The underlying graphics framework and the Dart
virtual machine are implemented in C/C++.

## Why did Flutter choose to use Dart?

Dart gives us a scalable language and a feature set that supports simple scripts
all the way up to full-featured apps. We wanted something that would be
instantly familiar to JavaScript, Java, and C# developers. Dart's robust core
libraries meant that we didn't need to write a lot of core library code.

We also wanted our apps to be extremely fast, and in our experience the Dart VM
has very impressive performance. We also really liked the Dart VM's other
features like the Observatory (a real-time VM profiler, debugger, and
introspection tool) and snapshots (a binary form of the app that's quick to
load).

Very important was the requirement to run fast on iOS. The Dart VM supports an
ahead-of-time compilation mode, meaning we can compile Dart code to native code
and ship a Flutter app to Apple's App Store.

In short, we adopted Dart because it was the best language that we could find
that we wanted to code in every day.

## Can Flutter run any Dart code?

Flutter should be able to run most Dart code that does not import (transitively,
or directly) dart:mirrors or dart:html.

## Who works on Flutter?

Flutter is an open source project. Currently, the bulk of the development is done
by engineers at Google. If you're excited about Flutter, we encourage you to join
the community and contribute to Flutter!
