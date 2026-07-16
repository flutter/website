---
title: "Perspectives from early adopters of Flutter as a game development tool"
description: "How user research shaped the Flutter Casual Game Toolkit"
publishDate: 2022-05-12
author: taodong
image: images/0ZrpkIfhAQ0MW1RYp.webp
category: story
layout: blog
---

## Introduction

During this week’s Google I/O, we unveiled the [Flutter Casual Game Toolkit](https://flutter.dev/games), a set of resources to support game builders in the Flutter community. Up until that point, Flutter hadn’t focused on game development as an officially supported use case, though we had been impressed by success stories such as the popular word puzzle game [4 Pics 1 Word](https://apps.apple.com/app/4-pics-1-word/id595558452) and community efforts such as the [Flame](https://flame-engine.org/) engine. *So why did we decide it’s time to officially get behind game development, and how did we determine what the initial release of the Toolkit should include?* In this post, we share a couple user studies we conducted with the early adopters of Flutter as a game development tool, and explain how their perspectives shaped our strategy and the design of the Toolkit.

We started our investigation with an interview study, where we met individually with 6 developers (referred to as P01 to P06) who had successfully built and released Flutter games. We had two objectives for this study. The first was to understand which types of resources can be most helpful for getting started on Flutter game development. The second was to better understand Flutter developers’ motivations, needs, and pain points in game development and leverage that understanding to strategically plan our long-term investment in this area. To complement the qualitative research findings from the interviews, we also ran a survey on the topic in the broad Flutter user community.

In the rest of the article, we first summarize the main findings from both the interview and survey studies, and then we share recommendations on market positioning, documentation and learning resources, and potential long-term investments to support Flutter game developers.

## Findings from developer interviews

### Background of Flutter game developers

In general, we found two archetypes of Flutter game developers that exist today:

* **App-game hybrid developers**: They’re Flutter app developers, but they’re also leveraging Flutter to build relatively simple games without using another tool. (P02, P04, and P05)

* **Computational artists and graphics enthusiasts**: They’re primarily attracted by the high degree of control over graphics offered by Flutter, but they might not be using Flutter for app development. (P01 and P03)

The following table provides more detail about the background of the developers we interviewed in this study. Several were referred to us by the Flame team.

```markdown

ID | Background | Types of games | Experience with game engines
-- | -- | -- | --
P01 | BFA in hand-drawn animation;  Developed video game graphic pipeline tools at small video game studio; Mobile game developer since 2011. | Puzzle | Unity, Godot, Flame
P02 | 10 years software development experience mostly in web; P03’s company migrated mobile app stack from Xamarin to Flutter; Started own consulting firm in 2018 and a client requested a mobile game in Flutter after reading P02’s blog post about Flame. | Puzzle | Microsoft XNA, Unity, Flame
P03 | Uses C# and C++ at work for 3D modeling. Started developing a new game engine and were into graphic pipelines. P03 started with Flutter in 2019 on a 1-month side game project. | 2D Shooter, Platform game | Unity, Unreal, Godot, Flame
P04 | Has experience in Java, frontend development with Angular. 2 years ago, P04 started mobile development with Kotlin/Android. | Platform game | Flame, some exposure to Unity and Unreal
P05 & P06 | Established a game studio specializing in casual games for over 15 years. P05 & P06 worked on the same game and were interviewed together. | Word puzzle | None

```

### Perceived benefits of using Flutter to develop games

Participants named multiple benefits of using Flutter to develop games. We list those mentioned by multiple participants below:

* **Simplicity**: Participants believed Flutter was easier to get started with and less overwhelming than larger game engines, such as Unity and Unreal, for building 2D casual games. (P03, P04)

* **Control**: Participants appreciated the ability to see Flutter’s source code from within the IDE, and have full and direct control of the canvas. (P01, P02, P04)

* **Ecosystem**: Developers can leverage packages in the Flutter ecosystem such as data persistence and audio playback. (P01, P02, P03, P04) Specifically, P01 considered Flutter’s audio capabilities superior to other cross-platform UI toolkits.

* **Cross-platform:** Participants appreciated the ease of deploying to iOS and Android and thought it delivered “a true single codebase.” (P01) This was, however, not mentioned frequently, since game engines are often cross-platform.

* **Ease of building UI:** A Flutter game can easily leverage any Flutter widget in its UI. (P04, P05) This is especially useful for games that are more app-like and don’t require using a game engine (for example, a word puzzle game that P05 and P06 built).

* **Learning opportunities**: Flutter and Flame’s open source nature provides an opportunity to develop a good understanding of game engines and the graphics pipeline through building games. (P03)

* **The Flame game engine:** Participants who use Flame generally speak positively about the project in both its capabilities and the support that Flame provides. P04 specifically built a game on Flutter because he discovered Flame.

### Perceived challenges of using Flutter to develop games

As an emerging use case, developing games on Flutter is not without challenges. Participants highlighted the following issues they experienced in their respective projects:

* Integration and ecosystem:
– Difficulty integrating with Play game services. (P01, P03)
– Missing good options for offline-first databases with conflict management. (P05)
– Guidance is needed to select the best audio plugin that can play audio in foreground and background simultaneously. (P05)
Assets: finding and creating high-quality game assets are time consuming. (P02, P03, P04)
> *It’s probably the most time-consuming process. If I don’t find the assets that go along with each other, the game doesn’t look exactly how I wanted. And since I’m not that good at making art, finding the right assets is the most challenging task for me. (P03)*

* Flame-specific challenges:
  * Participants noted that Flame’s documentation is not beginner friendly. In particular, [Forge2D](https://github.com/flame-engine/forge2d) (part of Flame) could use better documentation. (P03, P04)
  * Participants noted that collision detection in Flame is too basic. It doesn’t handle physics after two objects have collided, unless you use Forge2D. (P03)

* Missing features in Flutter’s SDK and tooling:
– Lacking 3D support. (P02, P03) However, this doesn’t seem critical to these participants.
– No direct shader access for filters, effects, layers, or compositing. (P01, P02) This is somewhat important to participants who’re into computer graphics.
– Lacks user-space APIs to control refresh rate, such as 120hz. (P01, P02)
– Not sure if Flutter has GPU debugging tools that provide visibility into the frame buffer. Xcode has great OpenGL debugging tools. (P01)

* Performance and bundle size:
– DevTools isn’t always helpful in diagnosing performance issues on a game with a game loop. (P02)
– Animation janks are present on low-end iOS devices. The shader warm-up workaround is useful but labor-intensive. (P05) There’s also no video tutorial on how to do this. (P03)
– Lack of support on adapting app rendering qualities to the performance characteristics of the device. (P05)
– Web bundle size is too large for web gaming platforms, such as Facebook Instant Game. (P05)

### Comparing Flutter with alternative game development tools

All participants had limited experiences with other game engines due to the selection criteria of this study. However, they offered their impressions regarding onboarding, sense of control, and package ecosystems.

First, participants had the impression that Flutter/Flame was easier to get started with and understand than bigger game engines such as Unity and Unreal. (P01, P02, P03, P04) Participants found that many features in Unity or Unreal weren’t related to the kinds of games they were building.

Second, since our participants were experienced coders, they found it difficult to gain the control they needed from the low-code development environment in Unity or Unreal.
> *I really like getting in and having full nitty-gritty control of things. So, with Flutter, the Flame engine’s pretty wide open. I feel like I have real full control, whereas in Unity, everything’s buried. They try to automate things for casual users. (P01)*

Last but not least, Flutter’s ecosystem was considered an advantage over other lightweight game engines such as [Godot](https://godotengine.org/) (P02, P03). For example, P03 said with `package:hive`, data persistence on the native platform was easy. He suspected that native coding would probably be necessary with Godot.

## Useful resource for first-time Flutter game developers

All participants mentioned needing better documentation and learning resources when starting developing games in Flutter. To prioritize, we asked participants to assess the importance of different kinds of resources for game development by categorizing them into three buckets: *Must-Have*, *Should-Have*, and *Could Have*. The following lists show the resulting buckets:

The “Must-Have” resources include:

* **A sample game** with common game-specific techniques (such as audio support) and platform gaming services (such as Google Play services) pre-integrated.

* **A dedicated website** that includes all game-development resources and recommendations on third-party services (such as packages, asset marketplaces).

* **How-to video(s)** that covers basic game development concepts (such as the game loop), integration with backend, game support, and monetization services. P03 was also interested in long-form videos such as [the boring show](https://www.youtube.com/playlist?list=PLjxrf2q8roU3ahJVrSgAnPjzkpGmL9Czl) to go through the whole process of game development including troubleshooting:
> *I feel that two different kinds of [video] content will be better. One would be something very short, similar to Widget of the Week, and then something similar to the Boring Flutter Show where you kind of go into the whole process and go through all the steps of creating that game. (P03)*

The “Should-Have” resources include:

* A dedicated Flutter for Games discord channel that is more general than the Flame team’s Discord.

The “Could-Have” resources include:

* Codelabs

* Instructor-led workshops

* Credits for Google services (such as GCP, Ads, Firebase)

* Direct access to dedicated support

Based on the valuable input from participants, we prioritized the “Must-Have” resources in the initial release of the Casual Game Toolkit.

## Findings from the survey

As mentioned, we conducted a complementary survey to get a broader view on game development in the Flutter community. The following figure shows the high-level results:

### Flutter users are interested in using Flutter for game development

It’s unsurprising that many Flutter users (62.4%) didn’t know that they could use Flutter to write games. However, 39.2% were interested in learning more.

<DashImage figure src="images/0n0cpV0PkueLSiSYx.webp" />


The wide interest in building games with Flutter is also reflected in the fact that many Flutter users are no strangers to game development in general. Out of 936 respondents, 500+ had experience with Unity, 130+ with Unreal, 120+ with [Flame](https://docs.flame-engine.org/1.0.0/#), and 80+ with Godot. It’s encouraging to see that many developers are already equipped with game development skills.

### Many Flutter game developers are just getting started

We then asked those who were either aware of or interested in Flutter’s ability to build games to tell us where they’re at in their game development process. Within this group, 43.2% hadn’t started a concrete game project yet, suggesting the need for getting-started support.

<DashImage figure src="images/0ZrpkIfhAQ0MW1RYp.webp" />


### There are more Flutter games out there than we thought

We asked respondents to point us to any games they have built with Flutter. To our pleasant surprise, we received 148 responses. Many of those games were 2D puzzles or [platform games](https://www.google.com/search?q=platformers+definition&oq=platform&aqs=chrome.0.69i59j46i67i433j69i64l3j69i65j69i60j69i61.2458j0j7&sourceid=chrome&ie=UTF-8), while a handful of them had attempted pseudo-3D effects using Flutter.

It seems to be entirely possible to build highly successful mobile games with Flutter. For example, [Kelimelik](https://play.google.com/store/apps/details?id=com.he2apps.kelimelik&hl=en_US&gl=US), a Flutter game we learned about through this survey, had 4.5 stars on Google Play with more than 356,000 reviews and 5,000,000 installs at the time of writing!

<DashImage figure src="images/1gq-r9Mn1BzgKL8XYLnFsEQ.webp" />


### Flutter users want more documentation for game development

When we asked respondents what had blocked them from making progress in their game projects, we received 31 responses. Many of them are related to lack of documentation:

* “not enough tutorial and I didn’t understand it enough”

* “not enough resources/tutorials/documentation (flutter flame)”

* “The documentation is not very friendly to beginner game devs. There is still much that can be done to create a very clean introduction to Flame components with common scenarios in tutorials or and case study walk-throughs to get the started.”

This feedback echoes what we learned from the interview study. Survey respondents also mentioned issues such as lacking 3D support, difficulty working with shaders, and performance problems with specific hardware, and visual effects (such as shadows).

## Recommendations

Our research results have shown the potential of developing 2D casual games on Flutter. Some Flutter users have tried and succeeded in shipping top-rated games, and many more are interested in getting started in the coming months.

To set up those new game developers for success, it’s crucial that we position Flutter appropriately in relation to other game development tools on the market, and leverage the open and participatory nature of Flutter to mature its support for game development.

With that, we’d like to make a few recommendations directed not only to the Flutter team at Google, but also to package authors, tool builders, and content creators from Flutter’s community at large.

## Market positioning

The research results suggest three dimensions we need to consider when we position Flutter in the market of game development tools:

**Types of games**:

* Targeting 2D casual games is a good starting point.

* Puzzles and platform games are successful sub-genres of games that have been developed in Flutter.

**Types of developers**:

* Flutter app developers who want to leverage the casual game development capabilities of Flutter (such as P02, P04, and P05).

* Computational artists and graphics enthusiasts (such as P01 and P03), who are attracted by the high degree of control and openness offered by Flutter.

**Types of game development teams**:

* We can focus on indie game developers and hybrid game/app agencies that have fewer specialized roles and can benefit more from Flutter’s cross-platform capabilities.

### Documentation and learning resources

Based on the user input from the interview study, we believe the creators and educators in the Flutter community can make the most impact by focusing on creating open-source sample games, how-to videos, and curated resource lists for game development. The Flutter Casual Game Toolkit we released at I/O is our first attempt at organizing resources along these lines and raising their visibility among Flutter users.

### Potential investment in Flutter APIs and capabilities

During the study, participants pointed out several major product features that they hope the Flutter SDK can better support in the future:

* Usability and support for shaders ([GitHub issue](https://github.com/flutter/flutter/issues/93800)). Alternatively, it might be enough if library maintainers (for example, Flame) directly use the shader APIs (for example, P03 wants a higher level abstraction in a game engine).

* Web app bundle size. One participant called out problems with expanding the game to web-based gaming platforms (such as Facebook Instant Game). Because web bundle size is too large, they eventually chose the HTML rendering backend over the faster but larger Canvas Kit backend. (P05)

* Windows / Steam support. Multiple participants expressed strong interest in trying out the new Windows support for their game. One mentioned that Windows is the most important platform to support, especially if you plan on releasing your game on Steam. (P03) However, this scenario remains ambiguous given that no participants nor our team members have tested game development on Windows or integration with Steam.

In addition to these three areas of improvements, we’ve recently started collaborating with community members to triage game-related issues and label them as [a: gamedev](https://github.com/flutter/flutter/labels/a%3A%20gamedev).

## Conclusions

What we learned from this pair of studies, including Flutter users’ wide interest in game development and Flutter’s simplicity and high degree of control appreciated by existing Flutter game developers, gave the team confidence in pursuing game development as a viable use case. The Casual Game Toolkit is our first investment in this space, and we look forward to hearing how our community members take advantage of it in our follow-up research.

## Acknowledgement

[Zoey Fan](https://medium.com/@zoeyfan_43394), [Christopher Fujino](https://twitter.com/chrisfujino), and [JaYoung Lee](https://medium.com/@jayoung.lee) contributed to this research, and [Shams Zakhour](https://medium.com/@shaza) edited this article. We’d like to thank our users who participated in this research and the Flame team for their support in participant recruiting.
