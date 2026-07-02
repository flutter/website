---
title: KQED
description: Learn how Bay Area public media station KQED used Flutter to rebuild their 4.8 star rated mobile app, reducing codebase size by 70%, and building a unified CarPlay and Android Auto audio experience.
headline: KQED
summary: KQED transitions to Flutter, raising app store ratings to 4.8 stars and increasing feature cadence by 55%
appName: KQED
companyName: KQED
logo: images/third_party/case_studies/kqed/kqed.png
card: images/third_party/case_studies/kqed/kqed.png
locations:
  - North America
platforms:
  - Mobile
  - Web
industries:
  - Media and Entertainment
tags:
  - mobile
  - android
  - ios
  - web
publishDate: 2026-06-24
successMetrics:
  - text: 4.8
    desc: App Store & Google Play rating
  - text: 60%
    desc: increase in developer productivity
  - text: 70%
    desc: reduction in overall codebase size
---

<Image src="images/third_party/case_studies/kqed/1.png" format="fullwidth" alt="KQED homepage" />

[KQED](https://www.kqed.org/?utm_source=flutter_blog&utm_medium=referral&utm_campaign=flutter_showcase_2026&utm_content=kqed_org_link) is Northern California’s public media source for trustworthy news, local stories, NPR & PBS programs, podcasts, live radio, and community events. Serving the San Francisco Bay Area across on-air broadcast, the web, and mobile, KQED is powered by its members to inform, inspire, and connect the community.

KQED needed to modernize its mobile experience.
Initially, the team sought to quickly launch an updated app
to meet the needs of users and internal stakeholders.
Today, the goal is to make it easy for Bay Area audiences
to access trusted local news, live radio, podcasts, and video in one place,
while building daily habits and strengthening membership support.

**Why Flutter?**

As a nonprofit organization, KQED has limited resources. The team did not have large platform-specific groups or the ability to maintain separate iOS and Android codebases long term. "Writing and maintaining a single codebase allows us to reach more users with less time spent on platform specifics," the team noted.

Before adopting Flutter, KQED reevaluated their options after experiencing common issues with other solutions. Rather than jumping straight into a full rebuild, the team started by defining their constraints. They needed to support reliable live audio streaming with a small development capacity.

To mitigate risk, they built a lightweight proof-of-concept focused on a content feed, navigation, and background audio playback. Once they confirmed that Flutter met their performance standards and supported stable streaming, they committed to the rewrite.

**Their solution**

Working with their strategic technology partner [Uptech Studio](https://www.uptechstudio.com/?utm_source=other&utm_medium=other&utm_campaign=flutterdev&utm_content=textlink-inline), KQED rebuilt their mobile application from the ground up in just three months. Flutter’s Hot Reload and Hot Restart features proved to be a developer favorite, making it easy and fun to iterate on UI/design tweaks.

<Image src="images/third_party/case_studies/kqed/3.png" format="fullwidth" alt="KQED news view" />

A key highlight of the solution is the KQED CarPlay and Android Auto integration, which brings live radio, podcast episodes, and show browsing to the dashboard screen. The team developed the following capabilities to serve their users:

* **CarPlay:** The team forked the `flutter_carplay` plugin to extend it, using Apple's template-based UI system driven by Riverpod providers.  
* **Android Auto:** The team leveraged the `audio_service` package, which implements the native Java `MediaBrowserServiceCompat` and handles playback callbacks.

All core business logic, including podcast fetching, playback state, and analytics, lives entirely in shared Dart code. The native car layers act as thin shells that translate platform requests into calls on the existing Flutter audio infrastructure.

<Image src="images/third_party/case_studies/kqed/4.png" format="fullwidth" alt="KQED radio view" />

With technical debt reduced, KQED is focusing on innovation. Their immediate roadmap includes the rollout of a daily Bay Area news word search game, [*Foggy Find*](https://www.kqed.org/games/foggy-find/?utm_source=flutter_blog&utm_medium=referral&utm_campaign=flutter_showcase_2026&utm_content=foggy_find_link). The team is using *Foggy Find* as a strategic launchpad to experiment with Flutter web and casual games.

By compiling the game directly for the web, they can test user engagement, drive browser-based acquisition, and iterate quickly outside of app store review cycles.

**Results**

The migration to Flutter has been transformative for both users and the engineering team:

* **Ratings surge:** User ratings on the App Store and Google Play jumped from a struggling 2.0 stars to a 4.8-star average.  
* **Developer efficiency:** Moving to a single codebase improved internal developer productivity by 60%.  
* **Codebase reduction:** Writing and maintaining logic once resulted in a 70% decrease in overall codebase size.  
* **Velocity boost:** Feature release cadence increased by 55%, with a 13x increase in the number of features offered.

<br />

***"Ultimately, Flutter didn't just change our codebase; it fundamentally changed how fast we can deliver value to our users."***

<br />
<br />
