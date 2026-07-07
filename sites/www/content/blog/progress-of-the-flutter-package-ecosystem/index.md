---
title: "Progress of the Flutter Package Ecosystem"
description: "Continued growth, new Flutter Favorites, Ecosystem Virtual Summit and things to know"
publishDate: 2024-01-22
author: anderdobo
image: images/0tkq_040X0xa_Noms.png
category: announcements
layout: blog
---

## Progress of the Flutter and Dart Package Ecosystem

The Flutter and Dart package ecosystem remains a key enabler for developers to build beautiful, performant apps for any screen from a single codebase. The ecosystem grew 26% in 2023 from 38,000 packages in January to 48,000 at the end of December.

<DashImage figure src="images/0tkq_040X0xa_Noms.png" />


Pub.dev now has more than 700,000 monthly active users as of January 2024. The Flutter team remains keen and committed to supporting this growth into the future, and enabling developers to build with and contribute to Flutter and Dart. In this update, we’ll take a look at the newest Flutter Favorites, results of the Package Ecosystem Virtual Summit and share some notable updates and things to know.

## New Flutter Favorites

<DashImage figure src="images/0gI42oCiw6spGZfOy.png" />


The [Flutter Favorites](https://docs.flutter.dev/packages-and-plugins/favorites) program recognizes and helps developers discover the highest quality packages to consider using in their apps. We’re pleased to announce seven new Flutter Favorite packages that have demonstrated exceptional quality, popularity, and community engagement, making them invaluable tools for Flutter developers. Let’s dive into each:

1. **[flame](https://pub.dev/packages/flame):** A high-performance 2D game engine for Flutter. Its intuitive API and rich feature set make it an ideal choice for creating visually stunning and engaging games. Check out [this codelab](https://codelabs.developers.google.com/codelabs/flutter-flame-game) to try your hand at building a game with flame.

1. **[flutter_animate](https://pub.dev/packages/flutter_animate):** Bring your UI to life with this a powerful animation library that simplifies complex animations and makes them accessible to all Flutter developers. Its declarative syntax and extensive documentation make it a breeze to create smooth and expressive animations.

1. **[riverpod](https://pub.dev/packages/riverpod):** An elegant package that offers a powerful and intuitive approach to managing application state. Its streamlined API, performance, scalability, and testability make it a compelling choice for modern Flutter apps.

1. **[video_player](https://pub.dev/packages/video_player):** Essential for anyone looking to integrate video playback in their Flutter applications. It provides a widget to display video content. It supports a wide range of formats and sources, including network asset and file-based videos. This makes it a versatile tool for building multimedia-rich Flutter apps.

1. **[macos_ui](https://pub.dev/packages/macos_ui):** For developers targeting macOS, this package enables creation of applications with a design that feels right at home on that platform. It provides an extensive collection of widgets and components that are styled according to the macOS design language, ensuring that your Flutter app not only runs well on macOS, but also looks and feels native.

1. **[fpdart](https://pub.dev/packages/fpdart):** This package enables functional programming in Dart. It’s great for implementing business logic, for instance, where functional programming paradigms like immutability, pure functions, and higher-order functions, as well as fpdart’s use of Dart’s type system, helps in building more maintainable and predictable code.

1. **[flutter_rust_bridge](https://pub.dev/packages/flutter_rust_bridge):** For developers seeking to leverage the best of Rust and Flutter in their application, flutter_rust_bridge provides a seamless bridge between the two worlds. It enables native Rust code to interact with Flutter seamlessly, unlocking the potential of Rust’s performance and memory safety in Flutter apps.

## Sunsetting the Happy Paths program

We decided to sunset the Happy Paths program to enable a more dedicated focus on Flutter Favorites. The vision of Happy Paths recommendations was to help you to make informed decisions on finding and using packages to add functionality to your app. We are fortunate to have community initiatives such as [Flutter Gems](https://fluttergems.dev/) that are comprehensive resources for navigating well categorized package options. As we focus on the Flutter Favorites program, we will continue to evolve it with input and feedback from the Flutter and Dart community.

## Package Ecosystem Virtual Summit

<DashImage figure src="images/0NzfQsOUhVaeUcGB8.png" />


At the end of August 2023, we held a first-time [virtual summit](https://rsvp.withgoogle.com/events/flutter-package-ecosystem-summit-2023) for the Flutter and Dart package ecosystem, attended by more than 50 non-Googler and Googler contributors to [pub.dev](https://pub.dev/). We started with a relatively small invitee list to fit the unconference-style format, and to learn from this first-time event before figuring out what it might look like in the future. The goal was to bring contributors together in unconference-style discussions to plan, educate, learn, and share amongst the community. We had three discussion sessions, each on topics that were voted on by registered attendees in the weeks leading up to the summit. The three discussion topics were 1) Building high quality packages — best practices, and challenges, 2) Maintaining packages long term — sustainable models, and 3) Flutter and Dart DevTools Extensions. ****Respondents to the post-event survey gave us insightful feedback that we’ll incorporate in future event planning. Thank you! Overall, we consider this first summit a success. Going forward, we’re keen to partner with the community on similar standalone events, or sessions focused on the Flutter and Dart ecosystem, set within more general events.

## Updates to the Pigeon package

The [Pigeon package](https://pub.dev/packages/pigeon) is a code generation tool that streamlines setting up the communication between your Flutter app and platform-specific code. This makes Pigeon useful both 1) when writing custom integrations directly between a Flutter app and platform-native APIs, such as in an [add-to-app](https://docs.flutter.dev/add-to-app) scenario, and 2) when writing a [Flutter plugin](https://docs.flutter.dev/packages-and-plugins/developing-packages#types) to provide a Dart API surface for platform-native APIs. It’s maintained by the Flutter Team who has made the following notable improvements to the package over this year:

* Added support for Swift, Kotlin and C++ (C++ unlocked Windows support).

* Null safety is now enforced.

* Expanded support for primitive data types support. For example, `enums` were added as a supported type.

* Added nullable parameters.

* Added error handling on host and Flutter APIs.

* Improved the ergonomics of the tools to make them easier and more intuitive to use. For example, we added support for default parameters and named parameters.

There are a lot more developments between v5.0.0 in January and v15.0.2 in December than we can list here, so check out all the changes in the [change log](https://pub.dev/packages/pigeon/changelog)!

## Packages in DartPad

[DartPad](https://dartpad.dev/) supports a fixed set of packages that you can view by clicking the info icon in the bottom, right-hand corner of the screen. The Flutter and Dart team at Google reviews and prioritizes package requests on an ongoing basis. If you’d like a package to be added to DartPad, add your thumbs up to an [existing package suggestion](https://github.com/dart-lang/dart-pad/issues?q=is%3Aissue+is%3Aopen+label%3Asuggested-package+sort%3Areactions-%2B1-desc), if there is one, or [open a new issue](https://github.com/dart-lang/dart-pad/issues/new?assignees=&labels=&projects=&template=everything-else.md&title=) with your suggestion.

<DashImage figure src="images/0U2blC-2k01FIuCsZ.png" />


## Proposal for canonical topics on pub.dev

In 2023 we launched the ability for package authors to tag their package with 1–5 free text topics in the pubspec file. The goal was to improve discovery of packages by potential users by adding a form of package categorization. We’ve seen a healthy uptake of the feature with many packages tagged. We’re exploring a proposal to improve the feature by merging topics that are effectively the same (For example, `widget` and `widgets`). We invite the community to share feedback or contribute PRs to this [canonicalize topics issue](https://github.com/dart-lang/pub-dev/issues/7263).

<DashImage figure src="images/0BhBIcosj4JSij9xk.png" />


That’s it for now! To engage with the amazing community of package authors, check out the [#package-authors](https://discord.com/channels/608014603317936148/1014208569706561567) Discord channel (you first need to join the [Flutter Discord server](https://github.com/flutter/flutter/wiki/Chat)).