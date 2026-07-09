---
title: "Announcing the Flutter Casual Games Toolkit"
description: "A starter kit of resources to help you get from concept to launch"
publishDate: 2022-05-12
author: zoeyfan
image: images/1rIXhQTkBae35i5YkSN8soQ.webp
category: announcements
layout: blog
---

For most developers, Flutter is an app framework. But there’s also a growing community around casual game development, taking advantage of the hardware-accelerated graphics support provided by Flutter.

Over the past year, thousands of Flutter games have been published. For example, Lotum, the game company behind the all-time popular word puzzle game [4 Pics 1 Word](https://flutter.dev/showcase/lotum), rewrote the entire game in Flutter. [Flame](https://flame-engine.org/), a community-driven open-source game engine built on top of Flutter, has been steadily growing both its contributors and users.

<DashImage figure src="images/1rIXhQTkBae35i5YkSN8soQ.webp" alt="Mobile games developed in Flutter" caption="Mobile games developed in Flutter" />


To understand how we might provide better support, we [interviewed several developers](https://medium.com/flutter/perspectives-from-early-adopters-of-flutter-as-a-game-development-tool-f95fb3406d51) who have successfully built and released Flutter mobile games. We asked what they love about creating games using Flutter, and their answers revealed several themes:

* Flutter is simple to learn and easy to use for building UIs and casual games

* Flutter allows them to look into the framework source code (no “black boxes”) and have full control of the canvas

* Flutter has an open ecosystem where you can find (and leverage) many useful packages, plugins, and libraries

* Flutter is portable — you write your code once and the game compiles to be multiplatform by default

Meanwhile, study participants mentioned that the biggest challenge in creating a Flutter game is finding resources and learning materials to get started and integrate with platform gaming services. To address these needs, we’re releasing a new starter toolkit to accelerate your game development.

The [Flutter Casual Games Toolkit](http://flutter.dev/games) offers a specialized template (developed by [Filip Hracek](https://github.com/filiph)) that you can use to build your own game. This starter project provides pre-built “bells & whistles” such as a main menu, a settings page, sound support, and so on, but leaves the fun part to you: building the game!

<DashImage figure src="images/0NwJbJ1BD7MvehPAA.webp" alt="Tic-Tac-Toe game running on a mobile device" caption="Tic-Tac-Toe game running on a mobile device" />


### Video Tutorial

To get started, check out the [video tutorial](https://youtu.be/zGgeBNiRy-8) on how to use the game template. It gives you a step-by-step guide on building a [Tic-Tac-Toe game](https://github.com/filiph/tictactoe) (also available for download from the [iOS](https://apps.apple.com/us/app/tic-tac-toe-puzzle-game/id1611729977)/[Android](https://play.google.com/store/apps/details?id=dev.flutter.tictactoe) stores). To see all the nitty-gritty details that Filip experienced as he developed the game, check out his [raw dev log](https://docs.google.com/document/d/e/2PACX-1vRM-pZYVNOcJhCh5-ZHt8jGwWpNvx4KtpJZECHmaUPn9PIOgdTThK5OBRblCM6PQC4skqDRdW0lJnyM/pub).

### Pre-integrated services

In addition to the common UI and functional elements you might need for a game, you get pre-integrated modules and sample code for critical services required for game development. For example, the game template integrates the Apple Game Center and Google Play Games Services so you can easily display features like leaderboards and achievements.

If you plan to monetize your game, the template uses the [Google Mobile Ads SDK](https://pub.dev/packages/google_mobile_ads), and shows you how to implement sample Ads. The template also uses the [In-App purchase](https://pub.dev/packages/in_app_purchase) package allowing you to offer players additional content in your game like premium experiences, digital goods, and subscriptions.

Lastly, the game template includes [Firebase Crashlytics](https://pub.dev/packages/firebase_crashlytics), so you can gain more insights into any crashes or errors that might occur in your game. All the source code for the game template can be found in this [Flutter samples repository](https://github.com/flutter/samples/tree/master/game_template#readme) on GitHub.

### Flutter Game Discord Channel

One of the strengths of Flutter is its helpful and welcoming community. To chat with other Flutter game developers, ask questions, and share best practices, consider joining the [dedicated game channel](https://discord.gg/WY5NwwjBQz) on r/FlutterDev’s Discord server! Big thanks to Flutter community member @Miyoyo for helping create this community space to support Flutter game developers! (By the way, if you are already a member of the r/FlutterDev community, here is a [direct link](https://discord.com/channels/420324994703163402/964110538986651658).)

### Google Ads and Cloud Credits

If your game needs Cloud or Firebase services, or you want to promote your game to more users with Ads, you can get up to $900 in credits offered by the [Google Ads](https://ads.google.com/intl/en_us/home/flutter/#!/) and [Cloud](https://cloud.google.com/free?utm_source=flutter&utm_medium=display&utm_campaign=FY22-Q2-flutter-games_get-started&utm_content=-&utm_term=-) teams (terms and limits apply)!

### Start with mobile, but go beyond

We’ve learned from past research that the majority of Flutter games today are casual mobile games, so we prioritized mobile scenarios when designing the Flutter Casual Games Toolkit.

This doesn’t mean that your creativity should be limited to mobile platforms. In fact, the sample [Tic-Tac-Toe game](https://github.com/filiph/tictactoe) can run on the [web](https://filiph.github.io/tictactoe/) and desktop as well!

<DashImage figure src="images/1sTD5PMhST3_73n4vnVcWBQ.webp" alt="Tic-Tac-Toe game running on the web and desktop" caption="Tic-Tac-Toe game running on the web and desktop" />


Meanwhile, we recently added support for the community-driven game engine Flame on DartPad, so you can explore[ building games with Flame](https://dartpad.dev/?id=3e52ca7b51ba15f989ad880b8b3314a2) on DartPad without downloading the SDK. What’s more, the web-based [pinball game,](https://pinball.flutter.dev/) written by Very Good Ventures (VGV) and launched at Google I/O, was built in Flutter using the Flame engine! To learn how the pinball game was created, check out [the Pinball article](https://medium.com/flutter/i-o-pinball-powered-by-flutter-and-firebase-d22423f3f5d) from the VGV team or [view the code](https://github.com/flutter/pinball).

<DashImage figure src="images/0zJekiBgTaE-VTXfa.webp" alt="Web-based pinball game" caption="Web-based pinball game" />


Game development is a new but exciting scenario for Flutter! Going forward, we hope to add more codelabs and other resources to help you develop your games. This is our first attempt at making it easier for you, and we are fully aware that there may be many areas for improvement. We’ve recently started collaborating with community member [@wolfenrain](https://github.com/wolfenrain) to triage game-related issues. Please file an issue (or vote on an existing issue) on GitHub if you need product features that you hope the Flutter SDK can better support.

### flutter.dev/games

Please check out the dedicated [game development](http://flutter.dev/games) page, where you can learn more about the above-mentioned resources, and also find links to [documentation](http://docs.flutter.dev/resources/games-toolkit), and references to libraries, packages, and tools recommended by game development experts in the Flutter community.

Since the launch of Flutter 1.0, you have continued to amaze us with great apps, and now we can’t wait to see what exciting games you will launch with Flutter!