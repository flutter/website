---
title: "Landing Flutter 3.22 and Dart 3.4 at Google I/O 2024"
description: "Major milestones for Flutter web apps, graphics performance upgrades, productivity experiments, and more"
publishDate: 2024-05-14
author: mit-mit
image: images/1Mq-Uj8c8l7rrpPxYQ6Gemw.gif
category: events
layout: blog
---

It’s been a particularly busy last few months in Dart & Flutter air traffic control, but we’re happy to announce that Flutter 3.22 and Dart 3.4 have landed and are available today, just in time for this year’s [Google I/O](https://io.google/2024/)!

We remain committed to providing a strong language and framework pairing, enabling you to build beautiful, rich, and fast apps from a single, shared code base — so you can deliver apps to users on mobile, web, and desktop — without having to fragment your product roadmap.

<DashImage figure src="images/1Mq-Uj8c8l7rrpPxYQ6Gemw.gif" />


Flutter 3.22 and Dart 3.4 offer performance improvements and platform-specific refinements that bring us closer to that vision. We’re particularly excited to share more about our journey with Wasm, but you’ll find so much more, including an improved Impeller rendering engine, smoother visuals and reduced CPU usage on iOS, enhanced platform navigation with Android’s predictive back gesture, expanded monetization options with the Google Mobile Ads SDK, and a new powerful deep link validator in DevTools. Dart developers will enjoy streamlined API migration with `dart fix` directly in the IDE and new DevTools capabilities for advanced profiling. Plus, you can now preview the Vertex AI for Firebase Dart SDK, integrating AI-powered features with robust security measures.

Today, we’ll also spotlight top companies using Flutter to increase productivity and build performant experiences. We’ll highlight just a few particularly exciting features that move us closer to our goal to deliver native-like performance across platforms, and include selected updates on our investments in productivity, developer experience, and games.

If you want more details on everything included in the releases, check out the dedicated [Flutter](https://medium.com/flutter/fbde6c164fe3) and [Dart](https://medium.com/dartlang/dart-3-4-bd8d23b4462a) posts. It’s time to Dash!

## Flutter in action

Flutter developers are busy launching large, new apps into the app stores. Let’s look at a few.

<DashImage figure src="images/0cF6UE3y05YTyMBQn.png" />


### Helping large, enterprise-scale applications deliver on mobile and the web

* In the United Kingdom, financial institution [Virgin Money](https://uk.virginmoney.com/) is [using Flutter](http://flutter.dev/showcase/virgin-money) across their suite of mobile banking and credit card apps to unify app development processes, speed up change, and enable an industry-leading user experience.

* US insurance company [GEICO](https://www.geico.com/about/corporate/at-a-glance/) recently [shared](https://www.geico.com/techblog/flutter-as-the-multi-channel-ux-framework/) that Flutter helped them improve branded user experiences across iOS, Android, and the web, reduce the size of their codebase, and increase development efficiency, all at scale.

* [Universal Studios Destinations & Experiences](https://corporate.universaldestinationsandexperiences.com/) released new Flutter mobile apps for their Hollywood, Osaka, and Orlando parks. Watch the video below to learn why they chose Flutter and to see how it’s performing so far.

<YoutubeEmbed id="JTk2Exr7FO4" title="How Universal Destinations & Experiences build next generation experiences with #Flutter" fullwidth="true"/>


### Going beyond mobile and the web

* The [Canonical](https://canonical.com/) team has been working with Flutter [since 2021](https://ubuntu.com/blog/flutter-and-ubuntu-so-far) to enable support for the Flutter [ecosystem](https://pub.dev/publishers/canonical.com/packages) in Ubuntu. Over the past year the Canonical team has rebuilt the Ubuntu Installer from the ground up with Flutter.

* [LG](https://www.lg.com/us) has chosen Flutter to enhance their smart TV operating system, webOS. Flutter’s performance, productivity, and strong ecosystem allow LG to rapidly develop and deploy webOS system apps that run smoothly. By 2025, Flutter will power system apps on tens of millions of LG TVs worldwide.

We’re inspired by these success stories, and are committed to making Flutter even better. Let’s dive into the latest product updates to show what we’re doing to enable you to build even more amazing apps, games, and experiences.

## WebAssembly: Chasing native performance on the web

Today we’re announcing support in our stable release for [compiling](https://docs.flutter.dev/platform-integration/web/wasm) Flutter web apps to WebAssembly (Wasm). This is an exciting new instruction format for web browsers, which provides a portable, platform neutral, binary code format.

Our support for Wasm has been a deep, multi-year investment. First we partnered with the Chrome team on defining support in WebAssembly for high-level, managed languages like Dart, which commonly use garbage collection. This resulted in the [WasmGC](https://developer.chrome.com/blog/wasmgc/) [proposal](https://github.com/WebAssembly/gc/blob/main/proposals/gc/Overview.md), which is now a full and finalized standard, with runtime implementations available in Chrome (Chromium 119 and later) and Firefox (120 and later), and with other browser vendors expected to follow. Next, we added a brand new Dart compiler backend to generate WasmGC code, and the Dart & Flutter teams collaborated to run both the compiled app code and the Flutter rendering engine as Wasm modules with efficient Wasm to Wasm interop.

So what’s the net result? We’re seeing much improved performance, approaching what we have on mobile and desktop devices running machine code. In our internal benchmarks (in Chrome on an M1 MacBook), the frame rendering time of [Wonderous](https://flutter.gskinner.com/wonderous/) improved by 2x in the general case and by 3x for the 99% worst case performance. Improved rendering performance is critical in demanding apps that feature animations and rich transitions, where exceeding the frame budget (the time allocated to render the next frame) causes very visible jank. Wasm has the potential to eliminate that, as illustrated by the juxtaposition below of the Wonderous app running with our traditional JS compilation compared to Wasm compilation.

<DashImage figure src="images/0ebpdPSPlak3EwoAU.gif" alt="*Comparing the rendering speed of Javascript vs Wasm for the [Wonderous](https://flutter.gskinner.com/wonderous/) demo application.*" caption="*Comparing the rendering speed of Javascript vs Wasm for the [Wonderous](https://flutter.gskinner.com/wonderous/) demo application.*" />


Wasm compilation for Flutter web apps is available in stable today. To get started, check out our [Dart Wasm documentation](https://dart.dev/web/wasm) and [Flutter Wasm documentation](https://docs.flutter.dev/platform-integration/web/wasm).

## Dart macros: raising the development abstraction level

We’re committed to providing a best-in-class developer experience. That means tackling long standing pain-points for Dart developers, like serializing JSON data.

It’s a prevalent pattern that’s equal parts trivial and tedious. Current solutions mean either slogging through encoding and decoding boilerplate manually, or layering on extra tooling in the form of code generation solutions like the [JsonSerializable](https://docs.flutter.dev/data-and-backend/serialization/json#serializing-json-using-code-generation-libraries) package.

Today, we’re announcing a preview of a better option for JSON: the [JsonCodable](https://dart.dev/go/json-codable) macro.

Macros are code that creates more code. They’re like code generation, except the macro system is *built into Dart* and happens *in real-time* as you are editing and running the code. It’s an integrated experience without delays, fully supporting our existing developer workflows such as hot reload, as illustrated by this screencast:

<DashImage figure src="images/0rWeEWxzBvcmOFNM4.gif" alt="*Screencast showing the experience of using a macro: Initially no toJson code completion exists, but after adding @JsonCodable to the class, the toJson code completion shows up immediately.*" caption="*Screencast showing the experience of using a macro: Initially no toJson code completion exists, but after adding @JsonCodable to the class, the toJson code completion shows up immediately.*" />


We’re excited to see macros solve all kinds of problems for our developers. Take, for example, data classes, the [highest voted](https://github.com/dart-lang/language/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc) Dart language feature. Beyond specific applications, our eventual goal is to have a macro system in Dart that allows users to create their own macros and raise the abstraction level of Dart programming.

Designing and implementing such a powerful macro system is a large task, so there is currently no date set for a stable release — for more details check out the [Dart 3.4 post](https://medium.com/dartlang/dart-3-4-bd8d23b4462a). In the meantime, try out a preview of the `JsonCodable` macro today. For more information, check out[ macros documentation](http://dart.dev/go/json-codable).

## New resources for Flutter game development

<DashImage figure src="images/0F19xflZ4BfoCekFQ.png" />


We’re seeing promising results from our early investment in games, including success stories from industry leaders like [Etermax](http://flutter.dev/showcase/etermax) and [Supercell](http://flutter.dev/showcase/supercell), who are each leveraging Flutter’s power and flexibility to efficiently deliver delightful user experiences and expand their reach.

Today, we’re excited to continue to build on that momentum with these new resources for Flutter game developers:

* The [SoLoud audio engine](https://pub.dev/packages/flutter_soloud) is now available: We’ve collaborated with the Flutter community (@[Marco Bavagnoli](https://github.com/alnitak)) to create a free and portable audio engine that delivers low-latency, high-performance sound, essential for many games. We also created a new [sound and music codelab](https://codelabs.developers.google.com/codelabs/flutter-codelab-soloud#0) that uses SoLoud.

* Learn how to [generate expansive crossword-style grids](https://codelabs.developers.google.com/codelabs/flutter-word-puzzle#0) of interlocking words without compromising the user experience, and [craft game mechanics in a Flutter and Flame game using a 2D physics simulation](https://codelabs.developers.google.com/codelabs/flutter-flame-forge2d#0) along the lines of Box2D called [Forge2D](https://pub.dev/packages/forge2d).

* A new guide for [optimizing Flutter web-based game loading speed](https://medium.com/flutter/best-practices-for-optimizing-flutter-web-loading-speed-7cc0df14ce5c): Long load times are a major deterrent in web-based games. Follow this guide (authored by [Cheng Lin](https://twitter.com/chenglinlim)) to optimize your loading speed so that players don’t abandon your game because it loads slowly.

## Empowering sustainable game development

In January 2024, inspired by the [story](https://www.youtube.com/watch?v=qgOlg173gcI&pp=ygUWR2xvYmFsIENpdGl6ZW4gRmx1dHRlcg%3D%3D) behind their use of Flutter, we partnered with Global Citizen to challenge our communities to design, build, and publish sustainability games using Flutter. These games are meant to inspire and empower players to take small, but meaningful actions for the environment. Today, we’re announcing [the 10 winners](https://medium.com/flutter/announcing-the-winners-of-the-global-gamers-challenge-1ccf4d271226).

<YoutubeEmbed id="_GgqdB9md1w" title="" fullwidth="true"/>


Congrats to all of the winners!

## Much more to explore

That’s all we have time to spotlight today, but there are many more exciting improvements that we didn’t touch on. Here are a few more things to know:

* You can ****preview [**the Vertex AI for Firebase Dart SDK**](https://firebase.google.com/docs/vertex-ai/get-started?platform=flutter) to use the Gemini API for AI-driven features in a Dart or Flutter app. The SDK is integrated with Firebase App Check, which protects your API calls, and safeguards your backend infrastructure from serious threats like billing fraud, phishing, and app impersonation. For details, see our [AI page](http://flutter.dev/ai).

* **Impeller**, our [next-gen rendering engine](https://docs.flutter.dev/perf/impeller), is now feature complete on Android.

* **Android’s [predictive back](https://developer.android.com/guide/navigation/custom-back/predictive-back-gesture)** gesture is now supported both when navigating within a Flutter app, and when navigating to another app or to the homescreen.

* **Platform views** on iOS have been performance optimized, reducing CPU usage by up to 50%.

* The **Google Mobile Ads SDK** has been extended to support more ad partners and mediation options.

* DevTools has a new **deep link validator** that helps you identify and troubleshoot errors in Android deep link configuration, so you can more easily connect web experiences to a Flutter app.

* **Dart fix**, our API migration tool, can now be invoked directly from the IDE.

* **DevTools** now supports advanced filtering and CPU samples in the timeline.

Head over to the [Flutter technical post](https://medium.com/flutter/fbde6c164fe3) and the [Dart 3.4 post](https://medium.com/dartlang/dart-3-4-bd8d23b4462a) for more details on each of these, and more.

As always, we’re incredibly grateful for your continued support, passion, enthusiasm, and feedback. This project wouldn’t be possible without you, and we can’t wait to see how you continue to push Flutter forward.

Flutter over and out. We hope to see you on board again soon!