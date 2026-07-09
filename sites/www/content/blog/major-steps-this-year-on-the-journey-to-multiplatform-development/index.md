---
title: "Major steps this year on the journey to multiplatform development"
description: "Today, we’re happy to announce two new SDK releases — Dart 3.2 and Flutter 3.16 — and a major refresh of the Flutter Casual Games Toolkit."
publishDate: 2023-11-15
author: mit-mit
image: images/0iomk4DoJwIXI44jX.webp
category: announcements
layout: blog
---

Today, we’re happy to announce two new SDK releases — Dart 3.2 and Flutter 3.16 — and a major refresh of the Flutter Casual Games Toolkit.

<DashImage figure src="images/1r2pc1eaUCaAe21EK-OlGpg.webp" alt="Flutter 3.16" caption="Flutter 3.16" />


## The Flutter and Dart value proposition

At the beginning of the year at Flutter Forward in Nairobi, Kenya, we introduced new roadmaps for Flutter and Dart. Both roadmaps focused on four high-level themes: breakthrough graphics experiences, seamless integration with web and mobile platforms, early to new and emerging architectures, and continued focus on developer experience.

<DashImage figure src="images/0iomk4DoJwIXI44jX.webp" alt="Four high-level themes from Flutter Forward" caption="Four high-level themes from Flutter Forward" />


In May at Google I/O, we [announced](https://www.youtube.com/watch?v=yRlwOdCK7Ho&t=11s) significant progress towards that vision, including (but not limited to) improving rendering performance on iOS (with Impeller), supporting element embedding on the web, and the finalization of the journey towards 100% null safety in Dart 3.

As we approach the end of the year, here’s another update on the progress made since then.

## Delivering user value with Flutter and Dart

With every new feature, improvement, or bug fix, the overall goal remains unchanged: to provide a strong language and framework pairing, enabling you to build beautiful, rich, and fast apps. And you can do so from a single, shared code base — delivering to app users on mobile, web, and desktop — without having to fragment your product roadmap. We also remain committed to open source, with no licensing costs, and seek to develop rich ecosystems powered by openness and collaboration.

This goal continues to resonate with developers both inside Google, and across Flutter’s far reaching ecosystem across the globe. Lots of great Google apps built with Flutter shipped this year:

* As we announced at Flutter Forward, the **Google Classroom** team uses Flutter for their mobile apps, which are now live on iOS and in beta on Android. They are seeing greatly [improved performance](https://www.youtube.com/watch?v=_5CIATSDSPI&t=5s), powered by the new [Impeller](https://docs.flutter.dev/perf/impeller) rendering engine.

* **YouTube Create**, another new Flutter app released by Google, is [available in beta](https://t.co/rn0yN2Sk9X) in 8 countries. This app leverages the flexibility of the Flutter widget library to offer a complete video editing experience with filters, effects, and music & voiceover editing.

* With **Google Earth** 10 — now powered by Flutter — users can easily create, collaborate, and organize maps and geospatial data not only on the web, but also on Android and iOS mobile and tablet devices! Check out the [Google Earth post](https://medium.com/google-earth/a-fresh-look-for-google-earth-507d218b42d3) for more details about the new design, and stay tuned for a future blog post detailing how the Earth team built their app using Flutter.

<DashImage figure src="images/0Vd72-ykzg8BadAGp.webp" alt="*Screenshots from Classroom (left), YouTube Create (middle), and Google Earth (right)*" caption="*Screenshots from Classroom (left), YouTube Create (middle), and Google Earth (right)*" />


Flutter adoption also continues to grow outside of Google, across the globe:

* Apps that shipped this year include banking apps like [Skandia](https://flutter.dev/showcase/skandia) in Sweden and [Credit Agricole](https://flutter.dev/showcase/credit-agricole) in Poland, the US [MarketWatch](https://flutter.dev/showcase/dow-jones) Virtual Stock Exchange investment education app, the [CZ](https://www.youtube.com/watch?v=OTn8Ngp2X8Q) health insurance app in the Netherlands, and Canada’s [Kijiji](https://flutter.dev/showcase/kijiji1) classifieds marketplace app. A common theme is that these teams chose Flutter to enable a consistent feature set across Android and iOS while still delivering a rich and compelling UI experience.

* Further east, Tencent launched [Cloud Chat](https://flutter.dev/showcase/tencent-cloud-chat), a rich new Chat SDK and UI library currently ranked number one in China’s chat service market that is expanding internationally.

* In Brazil, the SOMA fashion group initiated a major digital refresh of their Farm brand and, in the process, realized the flexibility of Flutter enabled them to scale this to other brands in the group, too. In the US, Caribou Coffee combined Flutter with Firebase to accelerate their productivity, while Lucid Motors reported that Flutter allowed them to not only deliver two mobile apps with a small team, but also that Flutters’ web support enabled internal sharing of prototypes.

We’re delighted to witness the evolution of these apps. Read on to see the continued progress we’re making in the core framework.

## Breakthrough graphics performance

We firmly believe that multiplatform development shouldn’t imply a degradation of experience for developers or end users. So we go to great lengths to deliver on this aspiration. At Flutter Forward, we introduced the Impeller engine — a complete redesign and reimplementation of the graphics rendering architecture for speed and power. In Flutter 3.10, we announced that Impeller was enabled by default on iOS. Today, in Flutter 3.16, we’re pleased to share that Impeller on Android is ready for preview feedback on the stable channel. Performance has improved dramatically over the year; compared to a year ago rasterization performance measured in the Flutter Gallery benchmark is roughly twice as fast with Impeller on Vulkan. For details on how to enable Impeller, see the [Flutter 3.16 post](https://medium.com/flutter/whats-new-in-flutter-3-16-dba6cb1015d1).

<DashImage figure src="images/0vtUIXYkW6Bt9fvaI.webp" alt="Flutter Gallery benchmark showing a 2x+ improvement over the past year with Impeller on Vulkan" caption="Flutter Gallery benchmark showing a 2x+ improvement over the past year with Impeller on Vulkan" />


### Casual Games Toolkit

One category of apps that especially benefits from fast and powerful graphics rendering is games. In 2022, we published the initial Flutter [Casual Games Toolkit](https://docs.flutter.dev/resources/games-toolkit). Today, we’re announcing a major update featuring a selection of new templates, from card games to runner-type games, and a set of game service developer resources for topics such as leaderboards, monetization, and telemetry. For more details, check out the [Casual Games Toolkit blog post](https://medium.com/flutter/building-your-next-casual-game-with-flutter-716ef457e440).

<DashImage figure src="images/03DmGJe1yD4eKdnfs.webp" alt="An animated gif showing multiple Flutter-based games such as Trivia Crack, Debertz, and Landover running on mobile, web and desktop devices." caption="An animated gif showing multiple Flutter-based games such as Trivia Crack, Debertz, and Landover running on mobile, web and desktop devices." />


## Seamless integration

While Flutter apps generally feature very high levels of shared code across platforms — many developers report 95–99% sharing — we still believe it’s important to support platform-specific features. On iOS, [app extensions](https://developer.apple.com/app-extensions/) offer a way for users to interact with smaller versions of your app from other apps on their phone. In our last stable release, we launched [new resources](https://codelabs.developers.google.com/flutter-home-screen-widgets#0) to help you build home and lock screen widgets for your Flutter app. In Flutter 3.16, we added support for rendering [the UI for some iOS app extensions](https://docs.flutter.dev/platform-integration/ios/app-extensions) using Flutter, for example, the [share extension](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Share.html). Android 14 introduced a new [predictive back gesture](https://developer.android.com/guide/navigation/custom-back/predictive-back-gesture), which gives the user the ability to glimpse the system UI behind the app when using a back gesture (left swipe). Flutter 3.16 supports this gesture.

## Continued focus on developer experience

Modern devices come in a variety of form factors — such as phones, foldables, and tablets — which have a wide range of screen sizes, and support external input devices like keyboards and mice. To ensure that your users have a great user experience, it’s important to take this into account. We recently collaborated with the Android team on adding support for their [large screen guidelines](https://developer.android.com/docs/quality-guidelines/large-screen-app-quality). We’ve published[ learnings from adding large screen support](https://medium.com/flutter/developing-flutter-apps-for-large-screens-53b7b0e17f10), updated our reference app [Wonderous](https://wonderous.app) to support multiple screen sizes, and made several fixes in the Flutter framework to better support things like keyboard, mouse, and trackpad input. New APIs allow you to determine the display’s size and pixel ratio, and support multi-window rendering.

Throughout the year we’ve worked on completing support for [Material 3](https://m3.material.io/get-started), the latest version of the Material Design design system. Flutter’s Material widgets now fully support Material 3 and, in Flutter 3.16, Material 3 is now the default style. We find that Material adds a fresh look to apps; the new color schemes are both aesthetically pleasing and compliant with the contrast requirements for accessibility. For a hands-on experience, check out the [Material 3 gallery](https://flutter.github.io/samples/material_3.html).

<DashImage figure src="images/1ZACl0_Sm8xPguexZrc4vKA.webp" alt="Screenshots of the Material 3 demo" caption="Screenshots of the Material 3 demo" />


Two significant improvements to developer tooling include a new sidebar for VS Code and support for adding extensions to DevTools. The sidebar enables easy discovery of core Flutter tools actions such as creating a new project, invoking hot reload, opening DevTools, or selecting a target device. DevTools extensions provide a framework that [allows you to create](https://medium.com/p/c8bc1aaf8e5f/edit) new custom tools that plug into DevTools, and offers additional framework-specific functionality. [Provider](https://pub.dev/packages/provider), [Patrol](https://pub.dev/packages/patrol), and [ServerPod](https://pub.dev/packages/serverpod) are a few examples of frameworks developing DevTools extensions.

<DashImage figure src="images/0IWHCMv72Wj3NVy4f.webp" alt="*Screenshot of a DevTools extension for the framework Serverpod*" caption="*Screenshot of a DevTools extension for the framework Serverpod*" />


We rebooted the [Flutter Favorite](https://docs.flutter.dev/packages-and-plugins/favorites) program and designated [flame](https://pub.dev/packages/flame), [flutter_animate](https://pub.dev/packages/flutter_animate), [flutter_rust_bridge](https://pub.dev/packages/flutter_rust_bridge), [riverpod](https://pub.dev/packages/riverpod), [video_player](https://pub.dev/packages/video_player), [macos_ui](https://pub.dev/packages/macos_ui) and [fpdart](https://pub.dev/packages/fpdart) as new Flutter Favorites. In August, we held a first-time virtual summit for the package ecosystem, attended by more than 50 non-Googler and Googler contributors to [pub.dev](https://pub.dev).

We’ve also seen the arrival of several new powerful packages and plugins. A few of my personal favorites are the [CameraX support](https://github.com/flutter/packages/tree/main/packages/camera/camera_android_camerax#usage) in the camera plugin, the high-performance [2D scrollable TableView](https://pub.dev/packages/two_dimensional_scrollables), and the [flutterflow_ui](https://pub.dev/packages/flutterflow_ui) package, which allows designers and developers to create UI components with drag-and-drop, and then export them to Flutter widget code ([demo video](https://www.youtube.com/watch?v=yopCfhepAsM)). Furthermore, the google_maps package now supports [cloud map-styles](https://developers.google.com/maps/documentation/cloud-customization/overview), so developers can update their styles from the Google Cloud Console, and the [home_widget](https://pub.dev/packages/home_widget) package now supports creating [interactive iOS Home Screen Widgets](https://medium.com/@ABausG/interactive-homescreen-widgets-with-flutter-using-home-widget-83cb0706a417).

## New and emerging architectures

### Dart interoperability

Dart is based around a core promise of enabling multiplatform Dart code to run across a [wide range of platforms](https://dart.dev/overview#platform). However, this often needs to be complemented with the ability to interop with existing code, whether that code is from older projects or APIs available in other libraries or system APIs. To enable this, Dart offers [interop with native C APIs](https://dart.dev/guides/libraries/c-interop), and is working on expanding this to support interop with [Java + Kotlin](https://dart.dev/guides/libraries/java-interop) and [Objective C + Swift](https://dart.dev/guides/libraries/objective-c-interop). For more details, checkout today’s [Dart 3.2 blog post](https://medium.com/dartlang/dart-3-2-c8de8fe1b91f).

### The road to WebAssembly

Wasm (also known as [WebAssembly](https://webassembly.org/)) is an exciting new instruction format for web browsers, which provides a portable, platform-neutral, binary code format for execution in modern browsers. High-level, managed languages like Dart use garbage collection, which is being added to the WebAssembly standard. As of Chrome 119, [garbage collection support for WebAssembly](https://developer.chrome.com/blog/wasmgc/) (Wasm-GC) is enabled by default. Wasm-GC support is also coming in Firefox 120, their next stable release.

The Dart compiler support for Wasm is almost feature complete, and Flutter web now uses a new rendering engine that enables all rendering to happen in WebAssembly code. While there’s more work to do and support is still considered experimental, we’re already able to run some apps like the [Material 3 demo](https://flutterweb-wasm.web.app/). The [Dart 3.2 blog post](https://medium.com/dartlang/dart-3-2-c8de8fe1b91f) has more details.

## The power of a vibrant community

Today’s blog post provides a very small sampling of the thousands of improvements made over the past few quarters. More importantly, an increasing number of these improvements are coming from contributions made by developers outside of Google — the recently published [2023 GitHub Octoverse report](https://github.blog/2023-11-08-the-state-of-open-source-and-ai/) on open source activity lists the Flutter project in the top-3 among all GitHub open source projects.

<DashImage figure src="images/0PY9bV7cnRCdxV2jU.webp" />


We’ve had a great year thanks to your incredible support. We’re grateful for the diversity, enthusiasm, and kind spirit of the Dart and Flutter communities that play a critical role in making the product successful. We can’t wait to see what you build next. Until the next update, thanks 🙏, and have fun coding!