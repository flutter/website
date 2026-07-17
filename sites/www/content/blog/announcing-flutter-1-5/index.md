---
title: "Announcing Flutter 1.5"
description: >-
  With Google I/O 2019 just around the corner,
  we’re pleased to announce the availability of
  our new stable build, Flutter 1.5
publishDate: 2019-05-07
author: csells
image: images/1udBMeDS6NNhlgbXYyHA_iA.webp
category: release
layout: blog
---

With Google I/O 2019 just around the corner, we’re pleased to announce the availability of our new stable build, Flutter 1.5. With 336 contributors world-wide and more than 1,700 commits, this is our biggest release yet! With this release, we continue to focus on quality and stability, fixing the highest impact issues submitted by the community while continuing to follow [the Flutter 2019 Roadmap](https://github.com/flutter/flutter/wiki/Roadmap).

<DashImage figure src="images/1udBMeDS6NNhlgbXYyHA_iA.webp" />

## What’s new?

[The Flutter 1.5.4 release](https://github.com/flutter/flutter/wiki/Release-Notes-Flutter-1.5.4) comes with a number of updates for the iOS and Material widgets, increased support for our experiments in web and desktop, a number of important updates to our plugins and tools as well as fixes to two regressions from Flutter 1.2. However, the most requested new feature in Flutter 1.5 is [the In-App Purchase plugin](https://pub.dartlang.org/packages/in_app_purchase), which is now available in beta for Android and iOS.

<DashImage figure src="images/1WNHFzXBcxTZVLYKHj5Pu_w.webp" alt="In-App Purchase plugin beta in action" caption="In-App Purchase plugin beta in action" />

The IAP plugin integrates with the underlying in-app purchase services provided for both Android and iOS, allowing your Flutter app to easily show in-app products that are available for sale, allow users to purchase products and show in-app products that the user currently owns.

One final notable change is this release is support for a recent [update](https://developer.apple.com/news/?id=03202019a) to the Apple Store policy. This policy change requires all new iOS apps and iOS app updates to target the 12.1 version of the iOS SDK. While we’ve supported the iOS 12.1 SDK since its release, this release also builds all dependencies with the latest Apple SDK. To take advantage of this, we recommend that you use the Flutter 1.5 release or greater moving forward for all updates and new apps that you ship to the Apple store.

## On the road to Google I/O

This year’s Google I/O is going to have even more Flutter in it! For example, [the Flutter Create contest](https://flutter.dev/create) has closed and we had hundreds of entries! The judges did a lot of work to sort through all of the entries and pick the prize winners. We’ll showcase the best entries at I/O and announce the winner, including the Grand Prize winner who gets a fully-loaded Apple iMac Pro worth over $10,000. I can only assume they’ll use it to build more gorgeous Flutter apps even faster…

If you’d like to participate in Flutter at I/O, you can watch the talks in person or via livestream:

* [Beyond Mobile: Material Design, Adaptable UIs, and Flutter](https://events.google.com/io/schedule/events/1d9c02ed-bdc5-4a32-90bc-7316d6d1fb55)

* [Beyond Mobile: Building Flutter Apps for iOS, Android, Chrome OS, and Web](https://events.google.com/io/schedule/events/03d8425c-54ca-437b-bac7-ece76cca8347)

* [Pragmatic State Management in Flutter](https://events.google.com/io/schedule/events/0cedc311-b646-4b29-b952-d7c7a832bfbd)

* [Dart: Multi-Platform, Productive, Fast — Pick 3](https://events.google.com/io/schedule/events/664c8a66-50d8-41d5-933c-0983f878b377)

* [Building for iOS with Flutter](https://events.google.com/io/schedule/events/37261739-76c8-45fe-a8a8-5cd9b1a894c2)

Should these talks inspire you to give Flutter a try, there are [lots of Codelabs](https://flutter.dev/docs/codelabs) that lead you through the experience, including several new ones being released at I/O!

And finally, if you happen to be at I/O in person and you want to talk with the Flutter team directly, you can come to our Sandbox, join us in the Codelab space or visit with us at several sessions set aside specifically for that purpose:

* [Flutter Office Hours or #AskFlutter](https://events.google.com/io/schedule/events/e1d97fc3-0077-4b88-a0ca-6811e2612766-bundle) (1)

* [Flutter Office Hours or #AskFlutter](https://events.google.com/io/schedule/events/620c8218-1e23-481e-9bed-76d2ffd31c9c-bundle) (2)

* [Flutter and Dart Team Meets the Community](https://events.google.com/io/schedule/events/00b99297-b183-4b05-aa94-dbaff635b8e1)

* [Material Design Components: Web/iOS/Flutter Office Hours](https://events.google.com/io/schedule/events/b442b962-80af-48bc-b24d-2e15e5b87d96-bundle) (1)

* [Material Design Components: Web/iOS/Flutter Office Hours](https://events.google.com/io/schedule/events/5184c64c-3051-449d-8779-1d1c9edb438e-bundle) (2)

* [Material Design Components: Web/iOS/Flutter Office Hours](https://events.google.com/io/schedule/events/9d4bc7fa-2225-43e9-ae52-0f63dd8b00d8-bundle) (3)

However you’re finding out about Flutter 1.5, the team hopes that you enjoy this release. What are you going to build?
