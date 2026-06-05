---
title: QuintoAndar
description: As the company scaled, QuintoAndar turned to Flutter to bring their mobile apps up to speed with their web experience.
headline: QuintoAndar
summary: Achieving feature parity at QuintoAndar with Flutter
companyName: QuintoAndar
logo: images/third_party/case_studies/quintoandar/logo.png
card: images/third_party/case_studies/quintoandar/case_study_card.png
poster: images/third_party/case_studies/quintoandar/case_study_poster.png
locations:
  - South America
platforms:
  - Mobile
industries:
  - Banking & Finance
  - Travel & Lifestyle
successMetrics:
  - perc: 14
    desc: >-
        (3.8⭐️  to 4.5⭐️)

        increase in Play Store store rating
tags:
  - mobile
  - android
  - ios
publishDate: 2021-11-05
---

**Goal**

Since 2012, Brazilian real estate marketplace [QuintoAndar](https://www.quintoandar.com.br/) has connected thousands of renters and landlords through its web, [Android](https://play.google.com/store/apps/details?id=br.com.quintoandar.inquilinos), and [iOS](https://apps.apple.com/us/app/quintoandar-im%C3%B3veis/id1109011232) platforms. But as the company grew, its apps began to diverge, with unbalanced teams threatening an imbalance between the apps, too.

Because 90% of their users accessed the site via web, QuintoAndar’s mobile apps originally took a backseat in terms of priority. In fact, the Android app was basically just a portal to the web version — using [Trusted Web Activity](https://developer.chrome.com/docs/android/trusted-web-activity/) (TWA), they were able to quickly and easily get an app on the Play Store with just the small team they had at the time. But as they grew, users starting asking for a more robust mobile experience. When 27% of their Android reviews mentioned the need for a true mobile app, the team knew it was time to make a change.

The mobile teams were also extremely understaffed compared to the web team. While there were 30 project teams assigned to the web version, only one team was assigned to iOS. With that kind of disparity, there was just no way for the mobile apps to work at the same rate as the web app.

And finally, QuintoAndar worried that the developers on the mobile teams would be permanently playing catch-up. At QuintoAndar, teams are given the freedom to experiment and find new solutions, but they worried that their mobile teams would become execution-only as they scrambled to implement the web team’s new features.

What they needed was a way for all their developers to work collectively, solving problems and building features for all three platforms at once, without relegating one team to continuously playing catch-up. What they needed, in other words, was Flutter.

**Why Flutter?**

Before making a decision, QuintoAndar did some research to find out what other companies were doing. They noticed that most were using either React Native or Flutter, so the team decided to develop a proof of concept with each of the top two technologies.

As a test, they built out a set of features in both React Native and Flutter, then compared them in terms of perfomance, modularization, ease of learning, look and feel, and several other metrics. Although the team had expected React Native to be a better fit for their needs, Flutter emerged the clear winner, and they decided to move forward with it right away.

<Image src="images/third_party/case_studies/quintoandar/case_study_body_1.png" format="fullwidth" alt="" />

**Their Solution**

Their first project was to develop a new Android app in Flutter with the same native look and feel. To see how the new Flutter version compared to the original TWA version, they used a [staged roll-out](https://support.google.com/googleplay/android-developer/answer/6346149) and monitored the results with a tool called [appbot](https://appbot.co/). After they had released the Flutter version to 50% of their user base, the results were clear — the ratings and reviews for the Flutter version were noticeably more positive than before, which gave QuintoAndar the confidence to roll out the new app to their entire user base.

***"Flutter let us keep our culture of autonomous teams with ownership of the features they deliver throughout the product development process, while delivering a great experience to our mobile users."***

\- Augusto Souza, Senior Software Engineering Manager, QuintoAndar

**Results**

Sure enough, once they released the Flutter version to everyone, [QuintoAndar’s ratings improved dramatically](https://medium.com/quintoandar-tech-blog/why-flutter-will-help-scale-quintoandars-mobile-presence-ab8888bf1c58). Within five months, their Play Store rating increased from 3.8 to 4.5, where it has stayed ever since.

Meanwhile, QuintoAndar has gone all-in on Flutter, investing in training more than 35 new Flutter developers, creating an internal training course, and even launching a mentorship program. New developers are given hands-on learning opportunities that provide real value to the company, under the supervision of a more experience Flutter developer. Flutter has given all developers at QuintoAndar the opportunity to take initiative and solve problems for their customers, no matter what platform they might be on.
