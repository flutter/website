---
title: "Introducing Flutter 3"
description: "The culmination of our journey to multiplatform UI development on phone, desktop, and web"
publishDate: 2022-05-11
author: timsneath
image: images/0ZQ9Xa7CINFVMA95w.png
category: releases
layout: blog
---

*We’re delighted to announce the launch of Flutter 3 as part of the Google I/O keynote. Flutter 3 completes our roadmap from a mobile-centric to a multiplatform framework, with the availability of macOS and Linux desktop app support, along with improvements to Firebase integration, new productivity and performance features, and support for Apple Silicon.*

<DashImage figure src="images/0ZQ9Xa7CINFVMA95w.png" />


## The journey to Flutter 3

We started Flutter as an attempt to revolutionize app development: combining the iterative development model of the web with hardware-accelerated graphics rendering and pixel-level control that were previously the preserve of games. Over the last four years since Flutter 1.0 beta, we’ve gradually built on these foundations, adding new framework capabilities and new widgets, deeper integration with the underlying platforms, a rich library of packages and many performance and tooling improvements.

<DashImage figure src="images/0pL2z2iYzWPrMu5hw.png" />


As the product has matured, more of you have started to build apps with it. Today there are over 500,000 apps built with Flutter. Analytics from research firms like [data.ai](https://www.data.ai/en/), along with public testimonials, show Flutter is used by a [broad list of customers](https://flutter.dev/showcase) in many segments: from social apps like [WeChat](https://play.google.com/store/apps/details?id=com.tencent.mm&hl=en_US&gl=US) to finance and banking apps like [Betterment](https://apps.apple.com/us/app/betterment-investing-saving/id393156562) and [Nubank](https://play.google.com/store/apps/details?id=com.nu.production&hl=en_US&gl=US); from commerce apps like [SHEIN](https://play.google.com/store/apps/details?id=com.zzkko&hl=en_US&gl=US) and [trip.com](https://apps.apple.com/us/app/trip-com-hotels-flights-trains/id681752345) to lifestyle apps like [Fastic](https://fastic.com/) and [Tabcorp](https://auspreneur.com.au/tabcorp-adopts-googles-flutter-platform/); from companion apps like [My BMW](https://www.press.bmwgroup.com/global/article/detail/T0328610EN/the-my-bmw-app:-new-features-and-tech-insights-for-march-2021?language=en) to public institutions such as the [Brazil government](https://apps.apple.com/app/id1506827551).
> # Today there are over 500,000 apps built with Flutter.

<YoutubeEmbed id="8RmsstcNE1Y" title="ByteDance - Building for any Screen with Flutter (Flutter Dev Story)" fullwidth="true"/>


Developers tell us that Flutter helps build beautiful apps more quickly for more platforms. In our most recent user study:

* 91% of developers agreed that Flutter reduced the time it took to build and publish an app.

* 85% of developers agreed that Flutter made their app more beautiful than before.

* 85% agreed that it enabled them to publish their app for more platforms than before.

In a [recent blog post by Sonos](https://tech-blog.sonos.com/posts/renovating-setup-with-flutter/) discussing their revamped setup experience, they emphasized the second of these:
> “It is not an exaggeration to say that [Flutter] has unlocked a degree of “*premium*” unlike anything our team had delivered before. Most important to our designers, the ease with which new UIs can be built means that our team spends less time saying “no” to specs and more time iterating on them. If this sounds worth it, we’d recommend giving Flutter a try — we’re glad we did.”

## Introducing Flutter 3

Today, we’re introducing Flutter 3**,** which is the culmination of our journey to fill out the platforms supported by Flutter. With Flutter 3, you can build beautiful experiences for six platforms from a single codebase, giving developers unparalleled productivity and enabling startups to bring new ideas to the full addressable market from day one.

In previous releases, we supplemented iOS and Android with [web](https://medium.com/flutter/flutter-web-support-hits-the-stable-milestone-d6b84e83b425) and [Windows support](https://medium.com/flutter/announcing-flutter-for-windows-6979d0d01fed), and now **Flutter 3 adds stable support for macOS and Linux apps**. Adding platform support requires more than rendering pixels: it includes new input and interaction models, compilation and build support, accessibility and internationalization, and platform-specific integration. Our goal is to give you the flexibility to take full advantage of the underlying operating system while sharing as much UI and logic as you choose.

On macOS, we’ve invested in supporting both Intel and Apple Silicon, with [Universal Binary](https://developer.apple.com/documentation/apple-silicon/building-a-universal-macos-binary) support that allows apps to package executables that run natively on both architectures. On Linux, Canonical and Google have collaborated to offer a highly-integrated, best-of-breed option for development.

A great example of how Flutter enables beautiful desktop experiences is [Superlist](https://superlist.com/), which launches in beta today. Superlist provides supercharged collaboration, through a new app that combines lists, tasks, and freeform content into a fresh take on to-do lists and personal planning. The Superlist team selected Flutter for its ability to deliver a fast, highly-branded desktop experience, and we think their progress to date demonstrates why it has proven to be a great choice.

<YoutubeEmbed id="YRuQj7mlH2I" title="Superlist Google I/O - Flutter & Superlist" fullwidth="true"/>


Flutter 3 also improves on many of the fundamentals, with improved performance, Material You support, and productivity updates.

In addition to the work mentioned above, with this version, Flutter is fully native on [Apple silicon](https://support.apple.com/en-us/HT211814) for *development*. While Flutter has been compatible with M1-powered Apple devices since their release, Flutter now takes full advantage of [Dart’s support for Apple silicon](https://medium.com/dartlang/announcing-dart-2-14-b48b9bb2fb67), enabling much faster compilation on M1-powered devices and support for [universal binaries](https://developer.apple.com/documentation/apple-silicon/building-a-universal-macos-binary) ****for macOS apps.

Our work for [Material Design 3](https://m3.material.io/) is largely complete in this release, allowing developers to take advantage of an adaptable, cross-platform design system that offers dynamic color schemes and updated visual components:

<DashImage figure src="images/0LM_w2DE9aM-_9J0Z.png" />


Our detailed technical blog post expands on these and the many other new features in Flutter 3.

Flutter is powered by Dart, a high-productivity, portable language for multiplatform development. Our work on Dart in this cycle includes new language features that reduce boilerplate and aid readability, experimental RISC-V support, an upgraded linter, and new documentation. For further details on all the new improvements in Dart 2.17, check out the [dedicated blog](https://medium.com/dartlang).

## Firebase and Flutter

Of course, there’s more to building an app than a UI framework. App publishers need a comprehensive suite of tools to help you build, release, and operate your apps, including services like authentication, data storage, cloud functions, and device testing. There are a variety of services that support Flutter, including [Sentry](https://docs.sentry.io/platforms/flutter/), [AppWrite](https://appwrite.io/docs/getting-started-for-flutter), and [AWS Amplify](https://docs.amplify.aws/start/q/integration/flutter/).

Google’s offering for app services is Firebase, and [developer benchmarking studies by SlashData](https://www.slashdata.co/developer-program-benchmarking/?) show that 62% of Flutter developers use Firebase in their apps. So over the last few releases, we’ve been working with Firebase to expand and better integrate Flutter as a first-class integration. That has included bringing the Firebase plugins for Flutter to 1.0, adding better documentation and tooling, and new widgets like [FlutterFire UI](https://pub.dev/packages/flutterfire_ui) that provide developers with reusable UI for auth and profile screens.

Today we’re announcing the graduation of Flutter/Firebase integration to a fully-supported core part of the Firebase offering. We’re moving the source code and documentation into the main Firebase repo and site, and you can count on us evolving Firebase support for Flutter in lockstep with Android and iOS.

In addition, we’ve made major improvements to support Flutter apps using Crashlytics, Firebase’s popular real-time crash reporting service. With the updates to the [Flutter Crashlytics plugin](https://firebase.google.com/docs/crashlytics), you can track fatal errors in real time, giving you the same set of features that are available to other iOS and Android developers. This includes important alerting and metrics like “crash-free users” that help you stay on top of your app’s stability. The Crashlytics analysis pipeline has been upgraded to improve clustering of Flutter crashes, making it faster to triage, prioritize, and fix issues. And lastly, we streamlined the plugin setup process so that it only requires a couple of steps to get up and running with Crashlytics, right from your Dart code.

## Flutter Casual Games Toolkit

For most developers, Flutter is an app framework. But there’s also a growing community around casual game development, taking advantage of the hardware-accelerated graphics support provided by Flutter along with open source game engines like [Flame](https://flame-engine.org/). We want to make it easier for casual game developers to get started, so at I/O today we’re announcing the [Casual Games Toolkit](https://flutter.dev/games), which provides a starter kit of templates and best practices along with credits for ads and cloud services.

<DashImage figure src="images/0wK4YI3N-Hh2vtDQ2.png" />


Although Flutter isn’t designed for high-intensity 3D action gaming, even some of those games have turned to Flutter for non-game UI, including popular games like [PUBG Mobile](https://play.google.com/store/apps/details?id=com.tencent.ig) that have hundreds of millions of users. And for I/O we thought we’d see how far we could push our technology, so we’ve created a fun pinball game that is powered by Firebase and Flutter’s web support. I/O Pinball provides a custom table designed around four of Google’s favorite mascots: Flutter’s Dash, Firebase’s Sparky, the Android robot, and the Chrome dinosaur, and lets you compete with others for the high score. We think it’s a fun way to showcase Flutter’s versatility.

<DashImage figure src="images/087xQ1AYdEF2YrmQ1.png" />


## Sponsored by Google, powered by community

One thing we love about Flutter is that it’s not just a Google product — it’s an “everybody” product. Open source means that we can all participate and have a stake in its success, whether by contributing new code or documentation, creating packages that give the core framework new superpowers, writing books and training courses that teach others, or helping organize events and user groups.

To showcase the community at its best, we recently sponsored a Puzzle Hack challenge in collaboration with DevPost, offering developers the chance to showcase their skills by reimagining the classic sliding puzzle with Flutter. This proved a fantastic demonstration of how web, desktop, and mobile come together: now we can all play the games online or via the stores.

We put together this video to showcase some of our favorite submissions and prize winners; we think you’ll enjoy it:

<YoutubeEmbed id="l6hw4o6_Wcs" title="Puzzle App Hackathon winners and more!" fullwidth="true"/>


Thank you for your support of Flutter, and welcome to Flutter 3!

<DashImage figure src="images/1mt5JTb-02GrFFtCnW20Tqg.png" />
