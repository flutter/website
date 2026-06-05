---
title: Nubank
description: After meticulously researching the top cross-platform technologies to help them scale, Nubank chose Flutter to help them launch more features, faster.
headline: Nubank
summary: Scaling with integrity at Nubank with Flutter
companyName: Nubank
logo: images/third_party/case_studies/nubank/logo.jpg
card: images/third_party/case_studies/nubank/case_study_card.png
videoEmbedUrl: "https://www.youtube.com/embed/vnj2i6RNo3g"
locations:
  - South America
platforms:
  - Mobile
industries:
  - Banking & Finance
successMetrics:
  - perc: 30
    desc: better merge success rate compared to iOS
  - perc: 600
    desc: faster merge rate
tags:
  - mobile
  - android
  - ios
publishDate: 2021-11-05
---

**Goal**

Nubank is the largest independent digital bank outside of Asia, giving over 48 million people a safe and accessible way to manage their financial lives from the palm of their hand. Using cloud technology and a streamlined UI, their goal is to take the complexity out of banking for everyday people.

The company has grown extremely rapidly, and they needed a way to develop and ship new products quickly without sacrificing quality. Unfortunately, Nubank struggled to find enough native mobile specialists to keep up with their ambitious pace. As a result, their iOS and Android teams were often lopsided, leading to one platform launching a feature before the other. Besides which, writing every feature twice began to feel like a waste of time.

Nubank came to the conclusion that specialized teams don’t scale well, and began to look for a way to have single teams developing features end-to-end. With one hybrid platform, backend developers would be able to contribute to the mobile frontend, and products could ship much more quickly. All they needed to do was find the right cross-platform technology for Nubank’s needs.

**Why Flutter?**

Nubank [assembled a task force](https://building.nubank.com.br/why-we-think-flutter-will-help-us-scale-mobile-development-at-nubank/) to investigate a few of the most popular hybrid platforms for mobile, including Kotlin Native, React Native, and Flutter. The goal was to find a solution that allowed their teams to work autonomously, developing the mobile app and delivering value on a single architecture, programming language, and set of conventions.

The task force, made up of Nubank’s most experienced mobile developers, evaluated their options based on 11 major priorities. These included the developer experience, long-term viability of the platform, incremental abstraction cost, non-linear abstraction risk, and the ability for the app to look and feel the same on iOS and Android.

To do this, they assigned each of the candidate platforms a score in each of these areas through hands-on testing, conversations with specialists, feedback sessions, internal usability testing, and more.

For the usability tests, the task force watched developers of all levels and backgrounds take a one-hour test. The developers were given a working app, development environment, platform documentation, and a few tasks to code, such as building a “shortcut” button. Then, after the test, they answered a short questionnaire.

As the task force discovered, developers loved Flutter. Compared to the other options, it offered better hot reload abilities, strong documentation, and a more stable API. And it was just plain fun to use. So with their research complete, the task force published a [54-page report](https://cdn.nubank.com.br/mobile/taskforce/nubank-mobile-architecture-task-force-mission-report.pdf) naming their recommended platform: Flutter.

<Image src="images/third_party/case_studies/nubank/case_study_body_1.png" format="fullwidth" alt="" />

**Their Solution**

The choice was clear. Flutter shone in almost every category, outperforming other platforms in terms of developer experience, documentation, API stability, lack of platform specialization, and more. The team also [loved Flutter’s testing capabilities](https://www.youtube.com/watch?v=vnj2i6RNo3g), especially the built-in testing infrastructure for unit, integration, and end-to-end tests without the need for rendering to the screen.

With their decision made, Flutter became Nubank’s go-to solution for mobile development. Since then, all new features have been written in Flutter, with legacy features migrated over time.

***“Flutter had everything we needed right out of the box: good documentation on how to integrate our app, and a hot reload that really works, support from the community, and tooling.”***

\- Igor Borges, Software Engineer, Nubank

***“Having Flutter as our main technology has significantly reduced the barrier, allowing new engineers to be able to contribute to our app within days after being onboarded.”***

\- Noe Branagan, Engineering Manager, Nubank

**Results**

Flutter has been a [game-changer for Nubank](https://building.nubank.com.br/scaling-with-flutter/), allowing them to continue to scale without sacrificing quality. Many of their engineers have been able to transition to full-stack, increasing developer productivity and enjoyment at the same time. And because the Flutter onboarding process is so simple, new engineers are able to contribute to the app within days of being onboarded. Even non-mobile engineers can become productive in just a few weeks.

Their build time has also improved dramatically. Using Flutter, Nubank launched a new life insurance feature in just three months — their fastest launch ever. Previously, developing and launching a new product would take them anywhere from several months to an entire year. To speed up development even more, Nubank also adopted an experimental internal developer tool using Flutter Desktop that reduces laptop battery usage by skipping emulators. It also helps with quick testing in different device dimensions.

In fact, Flutter has led to performance improvements across the board. With Flutter, Nubank’s merge success rate is 30% better than it was with native platforms. On average, Flutter pull requests take just 9.9 minutes to merge, compared to an average of 70.45 minutes on all platforms. Flutter has also given Nubank more insights, like the ability to measure app size by feature of package, and correlate metrics with other systems.

It also provides more UI consistency. Using native tools, Nubank used to have multiple and inconsistent component libraries. Now, they have their own design system, which product teams can extend and customize. They also created a tool to dynamically deliver new content to their app, allowing them to localize content without releasing a new version of the app.

At Nubank, Flutter is now a part of the culture for good.
