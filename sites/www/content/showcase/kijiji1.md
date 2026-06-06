---
title: Kijiji
description: >-
  Since 2005, Kijiji has been a leader in helping millions of Canadians buy and sell locally and
  sustainably across 400 categories including Autos, Real Estate, Home, Electronics, Services, Pets and
  Auto parts.
headline: Kijiji
summary: Kijiji launches features faster with Flutter
appName: Kijiji
companyName: Kijiji
logo: images/third_party/case_studies/kijiji1/logo.webp
card: images/third_party/case_studies/kijiji1/case_study_card.png
poster: images/third_party/case_studies/kijiji1/case_study_poster.png
locations:
  - North America
platforms:
  - Mobile
industries:
  - Travel & Lifestyle
successMetrics:
  - perc: 50
    desc: reduction in time required to launch new features
  - perc: 64
    desc: reduction in size of codebase
tags:
  - android
  - ios
publishDate: 2023-03-28
---

**Goal**

With nearly 11 million monthly active users, the Kijiji mobile app needs to be fast, reliable, and consistent across platforms. However, after several years, Kijiji’s native apps had grown to millions of lines of code and incurred a significant amount of technical debt. The team needed a way to streamline their codebase, reach feature parity between platforms, and keep the app running smoothly for users.

**Why Flutter?**

The team considered several native and cross-platform solutions, and on a recommendation from senior leadership, decided to look into Flutter. As an experiment, they ran a two-day internal hackathon with every web, backend, and mobile developer at Kijiji to rebuild and reimagine their existing feature sets in Flutter.

“We were really impressed with the ability Flutter gave our team to be creative and create the changes our customers were looking for effectively and efficiently,” said Mike Baxter, Chief Technology Officer at Kijiji.

After the hackathon, they gathered feedback on the developers' experiences. Across the board, the development team really enjoyed working with Flutter and it was apparent it would help the team overcome many of their existing concerns, so they decided to make the switch.

<Image src="images/third_party/case_studies/kijiji1/case_study_body_1.png" format="fullwidth" alt="" />

**Their solution**

Kijiji hired an experienced Flutter architect to lead the team in rebuilding their mobile apps.

Rebuilding their native apps in Flutter allowed them to wipe out their technical debt and start with a clean slate. Building cross-platform from the start also allowed them to deploy features with parity on iOS and Android, which had been a challenge in the past. Platform-specific constraints sometimes made it tough to maintain a consistent experience cross-platform, but Flutter made it easier to deploy in tandem.

For example, in their native apps, the team had created a large number of custom views and reusable components throughout the codebase. But for those components to actually be reusable, they had to overload them with functionality to make them applicable to every scenario. Not only did that involve a lot of extra code, it meant that if one custom view broke, it would break in multiple places throughout the app.

When they migrated to Flutter, the team chose to leverage widgets instead, keeping each widget and component self-contained. That allowed multiple developers to work on different parts of the app at once without stepping on anyone's toes. It also constrained the components to the functionality that is required and reduced the amount of code they needed to write.

“*Flutter is a first-class development environment. Even if you are a native developer, the ramp-up is relatively quick, and the software truly enabled our team to modernize our app and create a more seamless customer experience.*”

-Mike Baxter, Chief Technology Officer, Kijiji

**Results**

Migrating to Flutter has saved Kijiji a significant amount of development time, enabling them to quickly offer an improved app experience for Canadians. The original Kijiji native apps took about 2-3 years to build for each platform, or about 6 development years in total. Flutter enabled them to recreate the core features of the Kijiji mobile app in just 9 months. While it used to take an average of 2-4 sprints to release a major feature, Flutter has allowed them to launch new features in half the time, freeing the team to innovate, iterate and go to market faster with new features their customers are asking for.

The team has also been able to hire talented developers more quickly by standing out from the competition. Their original mobile team consisted of 4 iOS and 4 Android developers, hired over a period of 2 years, but they were able to hire 12 experienced Flutter developers within 6 months.

Finally, the Kijiji team were able to drastically reduce the number of libraries and dependencies they relied on for a more streamlined experience. They were able to reduce their codebase from over 2.5M lines of code in their native Android app to approximately 900k with 100% code coverage, making it much easier to maintain and avoid future technical debt. After final feature validation, the Kijiji team rolled out their new Flutter app to users on March 7/23.
