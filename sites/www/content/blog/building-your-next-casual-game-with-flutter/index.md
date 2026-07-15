---
title: "Building your next casual game with Flutter"
description: "Free & open source multi-platform 2D game development in Flutter"
publishDate: 2023-11-15
author: zoeyfan
image: images/03DmGJe1yD4eKdnfs.webp
category: announcements
layout: blog
---

Today I’m excited to introduce you to a major update of the [Flutter Casual Games Toolkit](https://flutter.dev/games), a collection of new templates and new developer resources to make game developers more productive with Flutter.

Flutter is Google’s open source UI framework for building beautiful multi-platform applications. Today, Flutter is used in more than one million apps ranging from early stage startups to large companies like ByteDance, Tencent, BMW, and Google, to deliver beautiful, performant, and portable experiences across platforms, from a single codebase.

Over the past few years, we’ve seen a growing community around casual game development. Tens of thousands of games have been published using Flutter, from simple but fun puzzles to more complex arcade games. Some of our favorites include Etermax’s [Trivia Crack](https://triviacrack.com/), Lotum’s [4 Pics 1 Word](https://flutter.dev/showcase/lotum) (word guess game), Dong Digital’s [Brick Mania](https://play.google.com/store/apps/details?id=net.countrymania.brick&hl=en) (arcade game), Onrizon’s [StopotS](https://play.google.com/store/apps/details?id=com.gartic.StopotS&hl=en) (categories game), the [retro pinball game](https://pinball.flutter.dev/) we built in Flutter for I/O, and [PUBG](https://flutter.dev/showcase/pubg-mobile) mobile who uses Flutter in their social and menu screens.

<DashImage figure src="images/03DmGJe1yD4eKdnfs.webp" alt="An animated gif showing multiple Flutter-based games such as Trivia Crack, Debertz, and Landover running on mobile, web and desktop devices." caption="An animated gif showing multiple Flutter-based games such as Trivia Crack, Debertz, and Landover running on mobile, web and desktop devices." />


## Why choose Flutter for casual games

Flutter is a great choice for game developers. First, it’s free and open source, giving you fine-grained control over your game’s rendering and input handling logic. This allows you to debug issues at their core and customize the engine to your needs. Flutter’s openness also extends to our ecosystem. All [Flutter plugins and packages](https://pub.dev) are also available for integration at no cost.

Second, developing in Flutter is highly productive. Flutter introduced a revolutionary capability called [hot-reload](https://docs.flutter.dev/tools/hot-reload#how-to-perform-a-hot-reload) that allows developers to see instant UI updates after making code changes, thus making the development process more iterative and efficient. Besides, Flutter supports multi-platform game development, so you can build your game for **iOS and Android, web, and desktop** all from a single, shared codebase. This saves you time and effort, and allows your game to reach a wider audience from day one.

Finally, Flutter games load fast and are generally very performant, even on low-end devices or in browsers. Bundle sizes can be smaller because the Flutter engine only adds a few megabytes to your game.

## The updated Flutter Casual Games Toolkit

Since we released the first version of the toolkit in 2022, we’ve seen a lot of excitement from the Flutter community, but we have also heard strong feedback that you want more resources and guidance in developing a successful game. So we are updating the Flutter Casual Games Toolkit with new game templates, and resources to help you easily build casual games in Flutter. Just to highlight a few updates:

### Templates for multiple game genres

We added three new game templates to provide a starting point for building a casual game. First, you will find a [basic template](https://github.com/flutter/games/tree/main/templates/basic) that has a simple UI for the main menu, settings screen, simple level selection, and audio integration.

<DashImage figure src="images/0_MYAbH0pmAhJ3D6B.webp" alt="An animated gif showing the basic template" caption="An animated gif showing the basic template" />


Second, you will find a [Card game template](https://github.com/flutter/games/tree/main/templates/card) that builds on top of the base template and adds basic drag and drop of cards, and is ready for multiplayer integration.

<DashImage figure src="images/00GvQrqyBDG2NVb42.webp" alt="An animated gif showing the card template" caption="An animated gif showing the card template" />


Third, we partnered with the open source game engine [Flame](https://flame-engine.org) (built on top of Flutter), to provide an [endless runner template](https://github.com/flutter/games/tree/main/templates/endless_runner). While you can already use *only* Flutter to build many turn-based games such as card games, word puzzles, and board games that respond to simple user input, you might also want to build real-time games such as endless runners, shooters, and racing games that require a game loop. In those cases, you can use Flame to implement play steering, collision detection, parallax, spawning, and different visual effects.

<DashImage figure src="images/0SDayAkeAnC_NtiLU.webp" alt="An animated gif showing the endless runner template" caption="An animated gif showing the endless runner template" />


To use these templates, simply check out the [repo](https://github.com/flutter/games), and start building your game using the template that is the closest to what you want.

### Developer resources for game service integrations

The toolkit includes developer guides for integrating necessary services to make your game more successful. For example, we included a few new Cookbook recipes and codelabs to show you how to:

* Build a [multiplayer game](https://docs.flutter.dev/cookbook/games/firestore-multiplayer) with Cloud Firestore.

* Make your game more engaging with [leaderboards and achievements](https://docs.flutter.dev/cookbook/games/achievements-leaderboard).

* Monetize your game with [in-game ads](https://docs.flutter.dev/cookbook/games/google-mobile-ads) and [in-app purchases](https://codelabs.developers.google.com/codelabs/flutter-in-app-purchases#0).

* Add a user authentication flow with [Firebase Authentication](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps#0).

* Collect analytics about crashes and errors with [Firebase Crashlytics](https://firebase.flutter.dev/docs/crashlytics/overview/).

The Flutter Casual Games Toolkit, like Flutter, is available for free ([BSD 3 License](https://github.com/flutter/flutter/blob/master/LICENSE)) and is open source. You can learn more and get started at flutter.dev/games. We hope to release further updates to the toolkit with more genre-specific templates and developer resources. Please email us at [flutter-games@google.com](mailto:flutter-games@google.com) to tell us what else would make your game development experience easier!

## Start building your games in Flutter

We’re excited to see what you build with the Flutter Casual Games Toolkit. Whether you’re a seasoned game developer or just getting started, we have the tools and resources you need to create amazing casual games. So what are you waiting for? Start building today!