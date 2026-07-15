---
title: "Announcing Flutter 2.2 at Google I/O 2021"
description: "Growing momentum for the leading UI toolkit for multiplatform development"
publishDate: 2021-05-18
author: timsneath
image: images/0NCBwYFewFf602uvF.webp
category: events
layout: blog
---

At Google I/O today, we announced [Flutter 2.2](https://flutter.dev/docs/whats-new), our latest release of the open source toolkit for building beautiful apps for any device from a single platform. Flutter 2.2 is the best version of Flutter yet, with updates that make it easier than ever for developers to monetize their apps through in-app purchases, payments and ads; to connect to cloud services and APIs that extend apps to support new capabilities; and with tooling and language features that allow developers to eliminate a whole class of errors, increase app performance and reduce package size.

<DashImage figure src="images/0NCBwYFewFf602uvF.webp" />


## Building on the foundation of Flutter 2

Flutter 2.2 is built on the foundation of Flutter 2, which extended Flutter from its mobile roots to incorporate web, desktop, and embedded usage. It is uniquely designed for a world of ambient computing, where users have a wide variety of different devices and form factors and are looking for consistent experiences that span across their daily lives. With Flutter 2.2, enterprises, startups, and entrepreneurs alike can build high-quality solutions that can reach the full potential of their addressable market, allowing creative inspiration (rather than target platform) to be the only limiting factor.
> # Flutter is now the most popular framework for cross-platform development.

A recent mobile developer study highlights the growth of Flutter. Analyst firm [SlashData](https://www.slashdata.co/)’s [Mobile Developer Population Forecast 2021](https://www.slashdata.co/reports/?category=mobile-desktop) shows that Flutter is now the most popular framework for cross-platform development, with 45% of developers selecting it, representing 47% growth between Q1 2020 and Q1 2021. Our own data confirms this shift towards Flutter; in the last 30 days, more than one in eight of the new apps in the Play Store are built with Flutter.

At I/O, we shared that there are now over 200,000 apps in the Play Store alone built using Flutter. These apps come from companies like Tencent, whose [WeChat](https://apps.apple.com/us/app/wechat/id414478124) messaging app is used by over 1.2 billion users on iOS and Android; [ByteDance](https://www.bytedance.com/en/products/), originators of TikTok, who have now built 70 distinct apps using Flutter; and other apps from companies including [BMW](https://www.press.bmwgroup.com/global/article/detail/T0328610EN/the-my-bmw-app:-new-features-and-tech-insights-for-march-2021?language=en), [SHEIN](https://apps.apple.com/app/id878577184), [Grab](https://apps.apple.com/app/id647268330) and [DiDi](https://play.google.com/store/apps/details?id=com.xiaojukeji.didi.global.customer&hl=None). Of course, Flutter isn’t just used by large corporations. Some of the most innovative apps are coming from names you might not have heard of: for example, [Wombo](https://play.google.com/store/apps/details?id=com.womboai.wombo&hl=None), the viral singing selfie app; [Fastic](https://play.google.com/store/apps/details?id=de.fastic.app&hl=None), the intermittent fasting app, and [Kite](https://play.google.com/store/apps/details?id=com.zerodha.kite3&hl=None), a beautiful investment trading app.

## Introducing Flutter 2.2

The Flutter 2.2 release is focused on improvements to the development experience to help you deliver more reliable, performant apps to your customers.

Sound null safety is now the default for new projects. Null safety adds protection against null reference exceptions, giving developers the means to express non-nullable types in their code. And since Dart’s implementation is *sound*, the compiler can eliminate null checks at runtime, providing increased performance for your apps. The ecosystem has responded quickly, with around 5,000 packages already updated to support null safety.

There are lots of performance improvements in this release also: for web apps, we offer background caching using service workers; for Android apps, Flutter supports deferred components; for iOS, we’ve been working on tooling to precompile shaders to eliminate or reduce first-run jank. We’ve also added a number of new features to the DevTools suite that help you understand how memory is allocated in your apps, as well as support for third-party tools extensions.

Additionally, we’ve been working on a few important areas of polish, such as improved accessibility for web targets.

Our work extends beyond the core of Flutter. We’ve also been partnering with other Google teams to help integrate Flutter into our broader developer stack. In particular, we continue to build trusted services that help developers responsibly monetize their apps. Our [new ads SDK](https://developers.google.com/admob/flutter/quick-start) is updated in this release with null safety and support for adaptive banner formats. We’re also introducing a [new payment plugin](http://pub.dev/packages/pay), built in partnership with the Google Pay team, that lets you take payment for physical goods on both iOS and Android. And we have updated our [in-app purchases plugin](https://pub.dev/packages/in_app_purchase), along with a matching [codelab](https://codelabs.developers.google.com/codelabs/flutter-in-app-purchases).

As the “secret sauce” that powers Flutter, [Dart](https://dart.dev) also gets an update in this release. Dart 2.13 expands support for native interoperability, with support for arrays and packed structs in FFI. It also includes support for type aliases, which increase readability and provide a gentle pathway for certain refactoring scenarios. We continue to add integrations for the broader ecosystem, with a Dart [GitHub Action](https://github.com/marketplace/actions/setup-dart-sdk) and a curated [Docker Official Image](https://hub.docker.com/_/dart) that is optimized for cloud-based deployment of business logic.

## More than a Google project

While Google continues to be the primary contributor to the Flutter project, we’re delighted to see the growth of the broader ecosystem around Flutter.

<DashImage figure src="images/1zroRqBB-vjUR_UCvYCKSUg.webp" />


One area of particular growth over recent months has been the broadening of Flutter to an ever growing number of platforms and operating systems. At Flutter Engage, we announced that [Toyota is bringing Flutter to their next generation vehicle infotainment systems](https://medium.com/googleplaydev/seamless-multi-platform-app-development-with-flutter-ea0e8003b0f9#f53d). And last month, Canonical shipped their first release of [Ubuntu with integrated support for Flutter](https://ubuntu.com/blog/ubuntu-21-04-is-here), with Snap integration and support for Wayland.

Two new partners demonstrate this ever-growing ecosystem. [Samsung is porting Flutter to Tizen](https://github.com/flutter-tizen/flutter-tizen), with an open source repository that others can also contribute to. And [Sony is leading the effort to deliver a solution for embedded Linux](https://github.com/sony/flutter-embedded-linux).

Designers benefit also from the open source nature of this project, with the announcement from [Adobe of its updated XD to Flutter plugin](https://medium.com/adobetech/announcing-xd-to-flutter-v2-0-82d09f3909a7). Adobe XD provides designers a great way to experiment and iterate, and now with enhanced Flutter support, designers and developers can collaborate on the same assets, putting great ideas into production faster than ever.

Lastly, Microsoft continues to collaborate with us; besides the work the Surface team has been doing to build foldable experiences with Flutter, this week sees the [alpha of Flutter support for UWP apps](https://flutter.dev/desktop#windows-uwp) built for Windows 10. We’re excited to see more apps that take advantage of the platform adaptations built into Flutter to provide a great experience across mobile, desktop, web and beyond.

## Building Great Experiences

More than anything, we built Flutter to help developers build great experiences. We are animated by the idea that app development can be better: that we can empower you by removing traditional impediments to reaching your audience.

We love seeing how you put Flutter to work. One example comes in the form of a project from the US Veterans Administration. The video below shows how their Flutter app is helping them provide rehabilitation for soldiers with post-traumatic stress disorders.

<YoutubeEmbed id="2S-KkvFuLWs" title="STAIR (Flutter Developer Stories)" fullwidth="true"/>


With a [wide variety of workshops, presentations and on-demand sessions about Flutter](https://events.google.com/io/program/content?4=topic_flutter) at Google I/O, we’re excited to share our work with all of you. And don’t forget to check out our fun [photo booth web app](https://photobooth.flutter.dev), built with Flutter, which lets you create a selfie with our Dash mascot and her friends!

<DashImage figure src="images/0ZdwECz0chT1hOq6Y.webp" />
