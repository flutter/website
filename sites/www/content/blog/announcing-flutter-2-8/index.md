---
title: "Announcing Flutter 2.8"
description: "A new release of Flutter: and a look back on a year of growth"
publishDate: 2021-12-08
author: timsneath
image: images/0_hVZ_qoWPxzQK3ws.png
category: releases
layout: blog
---

Just in time for the holidays, today we’re announcing a big update to Flutter, with a number of new features and improvements that refine the experience for mobile and web developers and bring us closer to stable support for desktop.

<DashImage figure src="images/0_hVZ_qoWPxzQK3ws.png" />


Flutter aims to change how apps are built. It unites mobile, web, desktop, and embedded development into a single toolkit: letting developers focus first on what they want to build, rather than which platforms they want to target; offering a high-performance, high-productivity framework that shortens the inner loop for developers; and enabling one codebase to target multiple platforms and form factors.

## New features and improvements: faster and more productive

One of the major areas of focus for this release is **mobile performance**. Ideally great performance would come for free, but in practice any complex app needs optimization to make sure it uses the underlying hardware and libraries well. That includes startup performance, which can be constrained by network bandwidth or other initialization costs; memory usage, particularly on memory-constrained devices; and graphics rendering. We’ve been using some of our experiences with large Google apps like [Google Pay](https://flutter.dev/showcase/google-pay) to invest both in making Flutter itself more performant, and in giving you better tooling to guide profiling and optimization of your own app. Your apps should start faster and use less memory just by upgrading to Flutter 2.8.

The latest update makes it easier than ever to **connect apps to back-end services**, such as Firebase and Google Cloud. It adds [production-quality support for Google Ads](https://flutter.dev/monetization) and major upgrades to the camera and embedded web plugins. The release also includes [Dart 2.15](https://medium.com/dartlang/dart-2-15-7e7a598e508a), which adds major improvements to concurrency, new language features like constructor tearoffs and enhanced enumerations, and optimizations that deliver a 10% reduction in memory utilization.

<DashImage figure src="images/1YeJGwc8CcHF7v2rg1-inMA.png" alt="With the new developer productivity enhancements to Flutter, an app can support sign-in to multiple authentication services with just a single drop-in widget." caption="With the new developer productivity enhancements to Flutter, an app can support sign-in to multiple authentication services with just a single drop-in widget." />


Another big theme of investment in this release that you’ll see us carry forward into future releases is further **improving developer productivity**. With features like stateful hot reload, we’ve always focused on creating a tight inner loop for developers. We’re now starting to explore some higher-level abstractions that make it easier for developers to get running faster. For example, in this release we’re adding a sign-in widget that uses Firebase to handle authentication. With this widget, you don’t have to worry about all the edge cases of sign-in, such as two-factor authentication or reset password user flows, nor about the complexities of supporting Google, Apple, Twitter, or Facebook as an auth provider. Features like this, building on the core foundations of Flutter, have the potential to transform how developers build apps, combining the development speed of low-code solutions with the flexibility and power of a full UI framework.

Both Flutter 2.8 and Dart 2.15 are available now, and should be an easy upgrade for existing apps running the previous version. For greater detail, we have a technical blog post covering the enhancements in each of [Dart](https://medium.com/dartlang/dart-2-15-7e7a598e508a) and [Flutter](https://medium.com/flutter/whats-new-in-flutter-2-8-d085b763d181).

## Casual game development with Flame

For most developers, Flutter is an app framework. But there’s also a growing ecosystem around casual game development, taking advantage of the hardware-accelerated graphics support provided by Flutter.

Today, we are thrilled to celebrate the [1.0 release of Flame](https://flame-engine.org/), a modular 2D game engine built on top of Flutter. Flame provides what you need to build games quickly: as well as a game loop, it also includes core primitives such as a component system, animated sprites and images, collision detection, a world camera, an effects system, and gesture and input support.

Flame is modular and can also be extended with packages that offer integrations to other libraries, for instance Rive (for animations), audioplayers (for music and sound effects), Forge2D (a Box2D-style physics engine), Tiled (tile maps editor), Fire Atlas (a sprite sheet and animation editor). Together, Flame and the broader ecosystem offer a strong set of services for a casual or 2D game developer.

<DashImage figure src="images/1cHEQ6vW829J09wMaOTCiNA.png" />


<DashImage figure src="images/1I_1j9GuOmp3HY8ODOkXdbQ.png" />


<DashImage figure src="images/1h25t5nbufPWhips6raHknQ.png" alt="*[Tomb Toad](https://play.google.com/store/apps/details?id=com.crescentmoongames.tombtoad), [Gravity Runner](https://play.google.com/store/apps/details?id=xyz.fireslime.gravitational_waves) and [Bonfire](https://bonfire-engine.github.io/examples/bonfire/#/): three examples of games built with Flame.*" caption="*[Tomb Toad](https://play.google.com/store/apps/details?id=com.crescentmoongames.tombtoad), [Gravity Runner](https://play.google.com/store/apps/details?id=xyz.fireslime.gravitational_waves) and [Bonfire](https://bonfire-engine.github.io/examples/bonfire/#/): three examples of games built with Flame.*" />


Flame is created by [Blue Fire](https://dev.to/blue-fire/fireslime-is-now-blue-fire-405g), a group of contributors focusing on creating open source packages and plugins for Flutter and Dart. We’re delighted to partner with them and encourage you to check out Flame if you’re interested in game development.

## Flutter’s continued momentum

We’re amazed to see how fast Flutter continues to grow, with a flourishing ecosystem of apps and tools that build on top of the core framework. At this year’s Google I/O event, [we noted](https://medium.com/flutter/announcing-flutter-2-2-at-google-i-o-2021-92f0fcbd7ef9) that there were already over 200,000 apps built with Flutter in the Play Store. In just over six months since that event, **the number of Flutter apps has nearly doubled**, **with more than 375,000 Flutter apps now in the Play Store**.

<DashImage figure src="images/1U69So9lK-pKoIngVnhbAaw.png" alt="Flutter supports Android, iOS, iPadOS, web, Windows, macOS and Linux: so you don’t have to rewrite your app just to target a different device or form factor." caption="Flutter supports Android, iOS, iPadOS, web, Windows, macOS and Linux: so you don’t have to rewrite your app just to target a different device or form factor." />


Flutter isn’t just used on Android, of course. According to independent mobile analyst firm [AppAnnie](https://www.appannie.com/en/), apps using Flutter on iOS include top brands and apps including [BMW](https://itunes.apple.com/app/id1519457734), [eBay](https://itunes.apple.com/app/id1456156090), [WeChat](https://apps.apple.com/us/app/wechat/id414478124), [SHEIN](https://apps.apple.com/us/app/shein-online-fashion/id878577184), [Philips Hue](https://apps.apple.com/app/id1055281310), [Norton](https://apps.apple.com/app/id1278474169), [trip.com](https://apps.apple.com/app/id681752345) and [Greggs](https://apps.apple.com/gb/app/greggs/id1098233626). On the web, Flutter is finding a home for app experiences, benefitting design tools like [FlutterFlow](https://flutterflow.io/) and [Rive](https://rive.app/). On desktop, the Ubuntu engineering team continues to build a variety of [new experiences with Flutter](https://github.com/canonical?q=&type=&language=dart&sort=), including a new installer and firmware updater. Even games like [PUBG](https://apps.apple.com/us/app/pubg-mobile-arcane/id1330123889) are finding that Flutter is a great fit for UI screens.

Ecosystems take a long time to build, but Flutter is now the most popular multi-platform toolkit, as measured independently by [Statista](https://www.statista.com/statistics/869224/worldwide-software-developer-working-hours/), [JetBrains](https://www.jetbrains.com/lp/devecosystem-2021/miscellaneous/#Technology_which-cross-platform-mobile-frameworks-do-you-use-two-years), [SlashData](https://www.slashdata.co/reports/?category=mobile-desktop), and [Stack Overflow](https://insights.stackoverflow.com/trends?tags=flutter%2Creact-native%2Ccordova%2Cxamarin). We don’t take that for granted, but the growth of Flutter’s popularity leads to an ever broader ecosystem of [packages](https://pub.dev) and tools that support it.

## Looking back at 2021, looking forward to 2022

Over the course of this difficult last year, our own engineering teams have been busy. As well as the features in Flutter 2.8, we’ve rewritten our developer tools, shipped null-safety and web support, completed FFI for native code integration, added initial [Material You support](https://material.io/blog/announcing-material-you), and worked hard to improve performance and quality. We’ve closed out almost 20,000 issues in total. We’ve created [a smart new website](https://flutter.dev) to better showcase Flutter. And we’ve spent a considerable amount of effort over the last few months overhauling our engineering infrastructure to increase engineer productivity and expand testing.

As we look ahead to 2022, we hope to be able to get out and see some of you in person. We’re expecting to invest more in the core developer experience, including language enhancements, documentation updates, and higher-level abstractions that make it easier to build sophisticated apps with Flutter. We’re going to complete our stable desktop support and further expand our work on the web. And we’re planning to expand interoperability with other platforms and portability to new targets. We’re still only getting started!

## A few closing thoughts and a dedication

We want to dedicate this Flutter 2.8 release to Kevin Gray, [a developer at Very Good Ventures who sadly passed away just a week ago.](https://verygood.ventures/blog/remembering-our-friend-and-teammate-kevin-gray) Kevin has been a key contributor to the success of Flutter since the earliest days; he was the developer behind many of the early Flutter demos, including one of our first high-profile customer wins, the first ever demo of Flutter on desktop, and the first Flutter demo featured at a Google I/O keynote. He was a talented, caring, funny, and kind man and those who knew him will readily agree that he leaves a gaping hole. As we grieve, we also celebrate his life, and we remember him publicly so that his impact may be known by all. Flutter wouldn’t be what it is without him.

Kevin, we miss you already. Thank you for all you did for Flutter, and for your friendship. To his family and friends, we send you our love.

To our broader community of Flutter developers and supporters, we’re grateful for you. We hope that Flutter 2.8 gives you plenty to explore. And if you haven’t yet learned Flutter, join the nearly 40,000 developers who are currently working their way through the [Flutter Apprentice book](https://store.raywenderlich.com/products/flutter-apprentice-google), which is available for free to everyone until early January. We wish you a happy and safe holiday season.