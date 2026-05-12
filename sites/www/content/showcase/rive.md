---
title: Rive
description: Rive rewrote their powerful animation tool entirely in Flutter to enable developers to create beautiful, multi-platform illustrations.
headline: Rive
summary: Rive rewrote their powerful animation tool entirely in Flutter to enable developers to create beautiful, multi-platform illustrations.
companyName: Rive
logo: images/third_party/case_studies/rive/logo.png
card: images/third_party/case_studies/rive/case_study_card.png
videoEmbedUrl: "https://www.youtube.com/embed/eODLolzspwY"
locations:
  - North America
platforms:
  - Web
  - Desktop
industries:
  - Productivity
tags:
  - web
publishDate: 2021-11-05
---

**Goal**

[Rive](https://rive.app/) allows developers to create and ship beautiful, interactive animations to any platform. Their open-source runtimes make it possible for creators to animate once, then launch on any platform they want.

However, this wasn’t always the case. In the beginning, the team spent a lot of their time managing the development cycle: maintaining different client-side web packages for a lot of the UI functionality, a custom build process, custom dev ops, custom testing, linting, language servers, and more — all from separate packages that needed maintenance and constant updating.

Instead, the team wanted a framework that encompassed all of these things, ensuring compatibility across these aspects of the workflow so they could focus more on development and less on maintenance. And in order to support their robust user interface with glitch-free animations in real-time, Rive needed a tool that could handle heavy graphics rendering across multiple browsers and platforms. That’s when they turned to Flutter.

**Why Flutter?**

The first version of Rive was written entirely with JavaScript ES5 and DOM, which worked great for web, but not much else. So next they tried React with ES6. They used webpack and an early version of CanvasKit, but it was a significant effort to maintain all the different platforms.

Around the same time, Rive was working with the Flutter team on the Flutter Interact event. The more they learned about Flutter, the better fit it sounded like for Rive. It offered a cohesive platform with excellent tooling, a strongly typed programming language, and strong language analysis tools including a standardized formatter, built-in linting, language servers for popular editing environments, and the ability to test directly from editing environments.

**Their solution**

The team decided to give Flutter a shot. They built a prototype with Canvaskit in Flutter, and immediately noticed an improvement. In addition to offering a true multi-platform solution, it also became much easier to onboard new engineers. They also really liked the built-in testing capabilities, which made it much easier to maintain the quality and stability of the app.

**Results**

Rive launched their editor built entirely in Flutter. Their codebase is now much easier to maintain, and allows engineers to onboard and start writing code immediately.

They’ve also found that it’s very easy to add custom pieces in Flutter. Feature-building is easier and more fun, and designers are much better able to tinker and build out prototypes. This has allowed them to develop much richer experiences in Rive, including animations, interactive graphics, and fluid and reactive layouts.

The general stability of the app has improved, too. Thanks to the built-in testing features, they now run thousands of tests per build, which has given them the confidence to move to a daily release cycle.

Based on their success, the team is now working on launching a desktop application for MacOS. For this release, the team says they don’t even have to do much customization, as the abstraction has already been done.They’ve also found that it’s very easy to add custom pieces in Flutter. Feature-building is easier and more fun, and designers are much better able to tinker and build out prototypes. This has allowed them to develop much richer experiences in Rive, including animations, interactive graphics, and fluid and reactive layouts.
