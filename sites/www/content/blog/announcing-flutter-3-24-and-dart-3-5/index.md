---
title: "Announcing Flutter 3.24 and Dart 3.5"
description: "An early look at Flutter GPU, web enhancements, and more!"
publishDate: 2024-08-06
author: mit-mit
image: images/1jzRGig761LnPlvokq2FaVA.gif
category: release
layout: blog
---

Today, we’re unveiling [Flutter 3.24](https://medium.com/p/6c040f87d1e4/edit) and [Dart 3.5](https://medium.com/dartlang/dart-3.5-6ca36259fa2f) alongside the last stop [in the I/O 2024 Connect series,](https://ioconnectchina.googlecnapps.cn/) happening in just a few hours in China — one of Flutter’s most prolific communities in the world, making this moment very special.

<DashImage figure src="images/1jzRGig761LnPlvokq2FaVA.gif" />


We kicked off [Google I/O](https://io.google/2024/) in May with an [exciting slew of updates](https://medium.com/flutter/io24-5e211f708a37), including the graduation of support for WebAssembly compilation to the stable channel, improvements to Impeller, and an early look at the future of Dart macros.

The Flutter 3.24 and Dart 3.5 releases build upon our mission to help you craft stunning, performant apps that reach users across mobile, web, and desktop — all from a single, shared codebase. They include an early preview of the new Flutter GPU API, enhancements to element embedding on the web, and several exciting updates for those interested in building for the iOS ecosystem, including early support for Swift Package Manager, and updated functionality to Cupertino widgets.

Let’s jump in!

## Impeller: Raising the bar for multi-platform graphics performance

Historically, cross-platform frameworks have required compromise on visuals, due to a reliance on high-level abstractions offered by the underlying platforms. Flutter has taken a different approach, with its own rendering layer that offers hardware-accelerated graphics and smooth performance on every device. We’ve made substantial progress with [Impeller](https://docs.flutter.dev/perf/impeller) and [shaders](https://docs.flutter.dev/ui/design/graphics/fragment-shaders), unlocking exciting new possibilities in graphics — like 3D.

We’re excited to share an early preview of the new [Flutter GPU API](https://github.com/flutter/engine/blob/main/docs/impeller/Flutter-GPU.md), a powerful, low-level graphics API integrated directly into the Flutter SDK. The API allows you to define custom raster pipelines and submit draw calls directly to the GPU, making it possible to create specialized renderers like 2D Canvas alternatives, 3D scene graphs, or even particle systems for visually stunning, performant, and immersive experiences without the engine-level bulk typically needed.

<DashImage figure src="images/0QC1D0LdTgLynDOnV.webp" alt="3D animation of a sci-fi space helmet rendered in flutter_scene." caption="3D animation of a sci-fi space helmet rendered in flutter_scene." />


Given how low-level the API is, we expect a learning curve for developers who don’t have significant experience developing graphics. That’s why we’re investing in rendering packages, like the new `flutter_scene` package, which leverages the Flutter GPU API to allow importing animated glTF models and constructing 3D scenes, enabling you to easily build 3D apps and games in Flutter and Dart, like the one below.

<YoutubeEmbed id="Y-DFVKPikVM" title="3D scene demo" fullwidth="true"/>


While the Flutter GPU API offers exciting possibilities, it’s still in early preview and we might make breaking changes to the API. We recommend developing against Flutter’s main channel when using Flutter GPU. Learn more in the blog post [Introducing Flutter GPU & Flutter Scene](https://medium.com/flutter/getting-started-with-flutter-gpu-f33d497b7c11).

## Flutter for iOS and macOS: making it easier to deliver beautiful, fast apps for the Apple ecosystem

It’s our goal to empower you to build exceptional apps that feel native and perform flawlessly. Part of that work is optimizing performance as well as maximizing Flutter’s compatibility with the underlying platforms, including accessing the full power of the Apple ecosystem.

In this release, we’ve introduced early support for Swift Package Manager, unlocking access to the thriving Swift package ecosystem, and empowering Flutter plugins to leverage a wealth of pre-built functionality to accelerate development. Once Swift Package Manager (SPM) is widely adopted by plugin developers, it should simplify the Flutter installation process itself, and lower the barrier to entry for newcomers, particularly those that aren’t familiar with the iOS ecosystem. We encourage plugin authors to [try adding support for SPM to your plugins,](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-plugin-authors#how-to-add-swift-package-manager-support-to-an-existing-flutter-plugin) and provide [feedback](https://github.com/flutter/flutter/issues) on your experience.

Next, we want to enable you to always say “yes” to your designers and deliver high-fidelity experiences on iOS. To address this, we’ve embarked on a journey to modernize and expand our Cupertino widget library, resolving [15 issues](https://github.com/flutter/flutter/issues?q=is%3Aissue+is%3Aclosed+label%3A%22f%3A+cupertino%22+sort%3Aupdated-desc+closed%3A2024-04-01..2024-07-01+) across Cupertino, and adding 37 missing Cupertino widgets in the [widget catalog](https://docs.flutter.dev/ui/widgets/cupertino).

Finally, we’ve added [platform view](https://docs.flutter.dev/platform-integration/macos/platform-views) and [webview](https://docs.flutter.dev/platform-integration/web/web-content-in-flutter) support for Flutter macOS apps, allowing for seamless integration of native macOS UI components directly into your Flutter app for a more complete and polished user experience.

Looking forward, we’re excited to invest more in additional Cupertino widget fidelity, land Swift Package Manager with our ecosystem, and provide other investments that make it even easier to integrate and interoperate with Apple’s platforms.

## Highlighting the global impact of the vibrant Flutter community

We also want to acknowledge that these releases wouldn’t be possible without contributions from the community, including you! This set of releases consist of almost 1,500 commits from over 167 unique contributors, including 49 *new* contributors. We’re inspired by the continued high levels of activity, commitment, and growth in the Flutter community, including those actively building the framework. Thank you!

The impact of our collective work is showing up all over the world in incredible apps and experiences that millions of people use every day. For instance, here is a sneak peek at a [case study](https://flutter.dev/showcase/xiaomi) showing how and why a small team at a Chinese technology company, Xiaomi, used Flutter to develop a companion app for the firm’s popular new EV, the [Xiaomi SU7.](https://www.mi.com/global/discover/article?id=3263&ref=renatomitra.com)

<YoutubeEmbed id="wfD7ZQhwACU" title="Xiaomi (Flutter Developer Stories)" fullwidth="true"/>


Several other exciting examples of Flutter apps popping up all over the world:

* [**SNCF Connect**](https://flutter.dev/showcase/sncf-connect), the French railway, and owners of the largest Flutter app in Europe at over 150 screens, partnered with the Olympics to deliver many updates to the Flutter app that enabled millions of visitors to travel across France during the Olympic games.

* [**Wolt**](https://flutter.dev/showcase/wolt), part of DoorDash International, used Flutter to expand into the merchant retail market.

* [**Whirlpool**](https://flutter.dev/showcase/whirlpool), a Fortune 500 company with a worldwide presence, is exploring new sales channels in Brazil using Flutter.

* [**Monta**](https://flutter.dev/showcase/monta), a Danish EV charging ecosystem startup, brought their first mobile app to market in just 3 months with Flutter, and later successfully ported their web app to Flutter too.

## Wrap up

The above are just a few of many new features and updates to Flutter and Dart in these releases, and you can learn more in the [Flutter 3.24 technical blog](https://medium.com/p/6c040f87d1e4/edit) post and in the [Dart 3.5 blog post](https://medium.com/dartlang/dart-3.5-6ca36259fa2f).

Looking ahead, we’re filled with excitement for the future of Flutter. We remain committed to our mission, and we’re grateful to you — whether a contributor, community member, or Flutter developer — for being part of this amazing journey. We can’t wait to see what you build next!
