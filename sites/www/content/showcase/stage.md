---
title: STAGE
description: Learn how streaming platform STAGE uses Flutter and Firebase to cut release time in half while serving 1.8 million daily active users.
headline: STAGE
summary: STAGE uses Firebase and Flutter to cut release time in half
appName: STAGE
companyName: STAGE
logo: images/third_party/case_studies/stage/logo.png
card: images/third_party/case_studies/stage/case_study_card.png
poster: images/third_party/case_studies/stage/case_study_poster.png
locations:
  - Asia
platforms:
  - Mobile
  - Desktop
industries:
  - Travel & Lifestyle
successMetrics:
  - perc: 50
    desc: increase in developer efficiency
  - perc: 100
    desc: faster app release cycles
  - perc: 100
    desc: faster feature releases
tags:
  - android
  - ios
  - desktop
publishDate: 2023-12-14
---

**Introduction**

[STAGE](https://play.google.com/store/apps/details?id=in.stage) is a feature-rich streaming platform catering to a wide range of Indian dialects and languages. From poetry to movies to motivational content, STAGE offers almost every form of entertainment on their platform to over 1.8 million daily active users.

**Challenges**

To fulfill their mission of providing tailored content to a wide range of Indian audiences, STAGE needed to offer apps for a variety of platforms, including iOS, Android, macOS, and Android TV. But with a small development team, they needed a highly efficient way to build this multi-platform app, with infrastructure that could store and deliver their content to users securely and in real time for a smooth viewing experience that would help them stand out in the competitive streaming market.

<Image src="images/third_party/case_studies/stage/case_study_body_1.png" format="fullwidth" alt="" />

**Solution**

After a month of trying to build each app in parallel, the team learned about [Flutter](https://flutter.dev/) in a [Google Developer Group](https://developers.google.com/community/gdg). It seemed like a promising solution, as it would allow them to develop all of their apps from a single codebase, saving them a considerable amount of time. They were also excited about features like hot reload, which allows developers to immediately see the results of their code changes in the app, allowing for faster development and painless debugging. Flutter’s rich set of customizable widgets also makes it easy to build beautiful and responsive user interfaces.

The team found Flutter very easy to learn, in part because it uses a single programming language, Dart, for both front-end and back-end development. The Flutter community helped STAGE’s small developer team get up to speed quickly.

STAGE decided to pair Flutter’s front-end tools with [Firebase](https://firebase.google.com/)’s complementary back-end services for full-lifecycle support. They used Firebase’s fully managed back-end services to get to market faster, with [Realtime Database](https://firebase.google.com/products/realtime-database) and [Cloud Storage](https://firebase.google.com/products/storage) at the heart to store, sync, and deliver content to users in real time, which is especially critical for live broadcasts. They used [Authentication](https://firebase.google.com/products/auth) to set up a secure user sign-in flow, [Cloud Functions](https://firebase.google.com/products/functions) to automate backend tasks, and integrated Google Analytics to better understand their user behavior.

In addition to infrastructure products, Firebase also provides tools to improve app quality and drive business growth. The STAGE team used testing and monitoring products [Test Lab](https://firebase.google.com/products/test-lab) and [Crashlytics](https://firebase.google.com/products/crashlytics) to ensure their app was performant and stable on a variety of devices, and engagement products like [Cloud Messaging](https://firebase.google.com/products/cloud-messaging) to deliver personalized notifications.

Recently, STAGE used [Remote Config](https://firebase.google.com/products/remote-config) and [A/B Testing](https://firebase.google.com/products/ab-testing) to evaluate various free-trial offers with different audience segments. [Remote Config](https://firebase.google.com/products/remote-config) allowed them to personalize the offers to match user behavior and preferences, and optimize them based on early insights - without requiring an app update. The test was easy to set up and quick to run, and the team was able to roll out the best offers to scale the campaign, which helped increase user conversions by 25%.

Next up, STAGE plans to build a full-featured desktop app with Flutter and Firebase, with support for LG and Samsung TVs coming soon.

*“Flutter is a powerful and flexible mobile development framework with a wide range of built-in widgets and tools that make it easy to build beautiful, feature-rich multi platform apps. We love how it pairs with Firebase to not only give us the infrastructure we need for the backbone of our app, but also tools to help us improve quality, engage users, and test new ideas safely.”*

\- Mrinal, Flutter Lead, STAGE
