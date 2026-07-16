---
title: "Dart & Flutter momentum at Google I/O 2025"
description: "Today at the Google I/O conference, hosted at Shoreline Amphitheatre in Mountain View, California, we shared how Flutter continues to gain…"
publishDate: 2025-05-21
author: mit-mit
image: images/0XtA6olQqCpKPyrdO.webp
category: event
layout: blog
---

Today at the Google I/O conference, hosted at Shoreline Amphitheatre in Mountain View, California, we shared how Flutter continues to gain momentum as a production-grade app framework trusted by some of the world’s largest brands.

<YoutubeEmbed id="v6Rzo5khNE8" title="What's new in Flutter" fullwidth="true"/>


First, according to the JetBrains [State of the Developer Ecosystem](https://www.jetbrains.com/lp/devecosystem-2024/) survey, Flutter has been the most used multi-platform app framework, since 2021.

Second, according to app intelligence provider AppTopia, Flutter accounts for nearly 30% of all new free iOS apps.
> *“Apptopia tracks millions of apps in the Apple AppStore and Google Play Store, and analyzes and detects which developer SDKs were used to create the apps. Flutter is one of the most popular SDKs we track: In the Apple AppStore it has grown steadily in usage from around 10% of all tracked free apps in 2021 to nearly 30% of all tracked free apps in 2024!”*
> — Apptopia Inc.

## Customer updates

Here are a few of the brands and apps that exemplify this growth, and the unique power of Flutter and its ability to target any platform from a single, shared source code base.

* **NotebookLM**: A new AI-powered research and writing assistant, made by Google Labs, just launched their mobile apps built with Flutter. Previously, this was only available as a website, but the team received many requests for mobile apps. With development speed and time-to-market being critical, Flutter was a natural choice. We’re excited about its [public release](https://blog.google/technology/ai/notebooklm-app/) this week.

* **Google Cloud**: The Google Cloud team took their existing iOS/Android apps, and switched to Flutter for building a range of new features like their new Cloud Assist, with the goal of writing once and deploying everywhere. They found tremendous value in the UI and logic consistency they get from having a single, shared codebase and felt Flutter offers native-like performance and feel without compromises.

* **Universal**: We announced last year how Universal Destinations & Experiences uses Flutter for their [iOS and Android Apps at their parks](https://flutter.dev/showcase/universal-studios) in Orlando, Hollywood, and Osaka. At their newest theme park, Universal Epic Universe in Orlando, they are now also using Flutter to power their guest-facing self-service dining kiosks. They were able to take their app, and reimagine it as a kiosk interface — with rich animations and smooth transitions. This is a great showcase of just how flexible and powerful Flutter really is.

* **Reflection.app**: Powered by [a complete Google stack](https://www.reflection.app/blog/google-gemini-vertex-ai-firebase-journaling-app) — Flutter, Firebase, and Gemini — to deliver a thoughtful journaling experience to their users.

* **teamLab**: Based in Tokyo, [teamLab](https://youtu.be/OyS812ZoTzw) creates solutions for digital content production, urban planning, and architectural space design. Their museum apps allow visitors to read more about the exhibits, and even interact digitally with the pieces on the phone. So far they have seen 35 million users of this new experience.

* **1080 Motion:** Another example is 1080 Motion, out of Sweden, who offer state-of-the-art training and rehabilitation for professional athletes around the world. Their customers receive real time performance feedback on hardware that delivers individualized workouts tailored for that athlete, on that day.

* **GE Appliances:** GE Appliances is using Flutter to revolutionize the UIs on small screens found on modern appliances equipped with an LCD screen. Their team, comprising many embedded and JavaScript developers, found Dart easy to learn, which accelerated adoption and allowed them to become productive quickly. In the future, they plan to expand on its embedded starting point by building user-facing mobile apps with Dart and Flutter.

## Evolving the Dart language

Dart is a key ingredient to Flutter’s success. Our ability to evolve Dart and Flutter together is a core enabler of Flutter’s industry leading developer experience and production quality.

We continue to evolve the Dart language — here’s a visualization of all the improvements we’ve made, since our major null safety feature, back in 2021.

<DashImage figure src="images/0XtA6olQqCpKPyrdO.webp" alt="Dart language evolution" caption="Dart language evolution" />


## Null-aware elements

Today [in Dart 3.8](https://medium.com/dartlang/announcing-dart-3-8-724eaaec9f47), we’re adding **null-aware elements**, which allows you to include an element in a collection *only* if its runtime value is non-null. You can use this feature to rewrite code like this:

```dart
// Code without null-aware elements.
var listWithoutNullAwareElements = [
if (promotableNullableValue != null)
  promotableNullableValue,
if (nullable.value != null)
  nullable.value!,
if (nullable.value case var value?)
  value,
];

With null-aware elements, remove all those if statements:
// Code with null-aware elements.
var listWithNullAwareElements = [
  ?promotableNullableValue,
  ?nullable.value,
  ?nullable.value,
];
```


## Dot shorthands

We also shared the news that we’re working on a new language feature called [**dot shorthands**](https://github.com/dart-lang/language/issues/357) — projected to release later this year — for addressing duplication in Flutter code with a new shorter syntax for selecting a member on a type that is known based on the context:

```dart
// Code without dot shorthands.
Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisSize: MainAxisSize.min,
  children: […],
);

// Code with dot shorthands.
Column(
  crossAxisAlignment: .stretch,
  mainAxisSize: .min,
  children: […],
);
```


## Updating the developer experience

We take the Dart and Flutter developer experience very seriously and have several updates.

### Property editor

One of the trickiest parts of any framework is learning what all the available APIs are. This can be overwhelming at first. Great developer tooling can really help here — today we’re announcing a new property editor feature, available today in Flutter 3.32.

<DashImage figure src="images/0XzkfOCEYvTEHsSyh.gif" alt="Property editor in VS Code" caption="Property editor in VS Code" />


When you select a widget in your IDE, it shows the primary layout properties without having to read docs or go to declaration. You can then easily change them directly in the property editor, and have those changes propagate to the source code.

### Pub.dev improvements

We’ve also made several improvements to [pub.dev](https://pub.dev), the Dart package manager: We added dark mode support for better contrast, a new download counts feature that helps you understand how much a package is used, and how that use is distributed over the available versions.

A brand new feature we’re announcing this week is Trending Packages, which shows packages that have a significant recent uptick in usage. This can be used for discovering new packages that might be of interest.

<DashImage figure src="images/0BkRheYyGtlw1zwLZ.webp" alt="pub.dev trending packages" caption="pub.dev trending packages" />


### Improved formatting

The Dart formatter is used by most Dart developers. Earlier this year, we added new functionality to make it automatically manage trailing commas. Based on your feedback, we made a number of adjustments in this week’s Dart 3.8 release, and added a new configuration option to tell the formatter to never remove trailing commas if you prefer to manually maintain these.

### Dart cross-compilation

Next, we’ve also improved the Dart compiler with the ability to compile Dart executables for Linux from Windows or macOS. This is particularly useful when targeting smaller embedded devices, like a Raspberry Pi. Before this, if you didn’t have a Linux machine, you had to compile Dart on the Raspberry Pi itself.

## Integrating more deeply with platforms

### Direct native interoperability

Last year we announced a new initiative — direct native interop — with a vision of eventually allowing you to access native APIs as easily as you access your own Dart code. Today we shared several updates:

* **Thread merge**: Historically, the Flutter engine has used two separate threads — the platform thread and the UI thread. The vast majority of platform APIs must be accessed on the platform thread, but the Dart code was running on the UI thread, making calling platform API directly from Dart cumbersome. This work is now completed in stable for Android & iOS, and in Flutter 3.33 beta for Windows and macOS. Work to merge threads on Linux is underway. For details see the [tracking issue](https://github.com/flutter/flutter/issues/150525).

* **Native assets/build hooks**: Sometimes you need to talk to third party libraries written in another language — for example, a machine learning library written in C. [Build hooks](https://github.com/dart-lang/sdk/issues/50565) (formerly known as native assets) support bundling native code with Dart packages, and as of today, is available in preview in the main channel.

* **ffigen/jnigen**: We continue to improve the ffigen & jnigen wrapper generators, and hope to share more news about these in the second half of the year.

### Great on Android

* **Impeller**: As of 3.29, Android has joined iOS in using Impeller as its default renderer, with the exception being a small set of nearly 10 year old Android devices which have a very old graphics stack. To support these devices, we will continue to use Skia on Android API-level 28 and lower.

* **Edge-to-edge**: As of Flutter 3.27, we made Android’s edge-to-edge UI system Flutter’s default. This support opens up the entire height of the display to Flutter apps running on devices that have no system bars at the top or bottom of the display. This had delicate implications on how Flutter thinks about things like SafeAreas and system UI.

* **Scribe**: This year we also added support for Android’s “Scribe” feature, which converts raw handwriting into actual text.

* **Material updates**: We’ve delivered numerous updates to Material, including supporting new page transitions, updated progress indicators and sliders, and other areas of polish.

### Great on iOS

We want developers building for iOS to be able to deliver beautiful, feature-rich apps, so this year we’ve been hard at work improving fidelity for iOS and improving Flutter’s integration with the Apple developer ecosystem:

* **Cupertino update**: A large investment in the Cupertino library has been made to improve its fidelity and expand its coverage. We revisited spring and scrolling physics, landed numerous updates to widgets such as our bottom sheets, collapsible widgets, navigation bars, (especially those with search fields), and more.

* **Swift Package Manager**: We are migrating from Cocoapods to Swift Package Manager to simplify our dev setups. This transition is ongoing, but over 150 plugins have added Swift Package Manager support and we’re happy to announce that that includes all Firebase plugins. We aim to complete the transition to Swift Package Manager soon!

* **Squircles**: And, one more thing… We’re added new support for one of Apple’s unique shapes, known as a *squircle*, which blends the arcs of several different shapes! The precise algorithm to the iOS squircle remains a mystery to many, but that hasn’t stopped us from creating our take on it, to the highest possible fidelity. You can find this in the stable channel today as the [RSuperellipse](https://api.flutter.dev/flutter/dart-ui/RSuperellipse-class.html) class and we’re already including it in our Cupertino widgets where appropriate.

### Great on web

* **WebAssembly**: Last year we announced support for compiling Flutter web apps WasmGC — to make apps start faster, and render frames up to twice as fast in complicated scenarios.

* **Accessibility**: We’ve done a lot of work on our accessibility system, both in terms of performance, and have added an entire new Semantics Roles system that Flutter converts to standard aria labels on the web.

* **Stateful hot reload**: If you’ve built Flutter apps for mobile and wanted to take those experiences to the web, you’ve probably felt the absence of Flutter’s flagship feature — stateful hot reload — when working on Flutter web apps. Today, we announced that stateful hot reload for Flutter web is available in preview in all channels. One place you can experience it right away is in [DartPad](https://dartpad.dev).

## Expanding the ecosystem

Google is proud to support Flutter, but so much of the value for Flutter developers comes from our larger community.

### Canonical

One big contributor is Canonical, the folks behind Ubuntu. They use Flutter themselves for Ubuntu’s first-party app marketplace, and have been excited to contribute toward Flutter’s overall quality on desktop, including contributing feature work for multi-window support.

<DashImage figure src="images/0DyOOI5cfR4759Ka2.webp" alt="Multi-window support running on Linux" caption="Multi-window support running on Linux" />


They have also contributed to the desktop implementation of Flutter’s significant [thread merge](https://github.com/flutter/flutter/issues/150525). And they have fixed many issues related to accessibility, text input, focus, and keyboard & mouse events.

### LG

Another company with a business-critical interest in Flutter is LG. Last year, LG announced plans to rewrite many of their core webOS system apps in Flutter. This year, LG is excited to announce a significant expansion of their investment in Flutter, aiming to complete the development of a new webOS-Flutter SDK, which will allow developers to release Flutter apps to the LG Content Store. They are targeting an official launch in the first half of next year.

## Embracing AI

We have lots of news in the exciting and fast-paced field of AI, both for AI-powered applications and AI-powered development.

### Introducing Firebase AI Logic

Vertex AI in Firebase is now known as Firebase AI Logic. And among many new things, it now allows you to use Vertex AI Gemini API (billing required with the pay-as-you-go Blaze pricing plan), or the newly added Gemini Developer API (billing optional with the no-cost Spark pricing plan) all from one single Dart SDK. For more details, see the [Firebase blog](https://firebase.blog/posts/2025/05/building-ai-apps).

### DartPad and Gemini

We’ve added Gemini support directly into [DartPad](https://dartpad.dev/), which brings the power of Gemini code assistance right to your finger-tips with no setup or installation necessary.

<DashImage figure src="images/1bvMcF-Tc30i2dMr2jFfECA.webp" alt="Gemini-powered code generation in DartPad" caption="Gemini-powered code generation in DartPad" />


That feature was built using the [Gemini API](https://ai.google.dev/). Its full source code is available in the DartPad GitHub repo and serves as a demonstration of how you can create AI-powered development tools.

### Android Studio, VSCode, IntelliJ IDEA and Gemini

Another place that now has Gemini support is Android Studio. The Flutter and Android Studio teams [collaborated](https://medium.com/flutter/gemini-in-android-studio-now-speaks-fluent-flutter-915dfec98274) on this so, as of the most recent Android Studio release (Meerkat Feature Drop), Gemini support for Dart and Flutter is now first-class.

And if you’re a VSCode or IntelliJ IDEA user, rest easy. The [Gemini Code Assist](https://codeassist.google/) extension and a Google account brings Gemini-powered code assistance to your workflows right in VS Code.

### MCP

MCP is an exciting new open protocol that is gaining a lot of momentum for enabling AI agents to access and interact with various data sources and tools in a standardized way.

<DashImage figure src="images/0n4GWT45AkStIiLZy.webp" alt="Model Context Protocol" caption="Model Context Protocol" />


We are currently experimenting to see if it can enable us to provide more accurate and relevant code generation and allow tooling for complex tasks like fixing layout issues, managing dependencies, or even resolving runtime errors.

## Wrap up

A big thank you to all of you who have made Flutter what it is. We’re proud to continue the journey with you all to build the world’s best app framework.

Have a great I/O, check out the [great session videos](https://io.google/2025/explore?topics=Flutter), and have fun with Flutter!