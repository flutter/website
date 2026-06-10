---
title: Google Pay
description: As Google Pay expanded to new regions — each with its own unique user dynamics, geography, and challenges — the team needed a more efficient way to make platform changes at scale.
headline: Google Pay
summary: Going global at Google Pay with Flutter
companyName: Google Pay
logo: images/third_party/case_studies/google-pay/logo.png
card: images/third_party/case_studies/google-pay/case_study_card.png
poster: images/third_party/case_studies/google-pay/case_study_poster.png
locations:
  - North America
platforms:
  - Mobile
industries:
  - Banking & Finance
  - Google
successMetrics:
  - perc: 70
    desc: reduction in engineering effort
  - perc: 35
    desc: reduction in lines of code
tags:
  - mobile
  - android
  - ios
publishDate: 2021-11-04
---

**Goal**

With 100 million users in dozens of countries, [Google Pay](https://pay.google.com/) allows users around the world to pay, save, manage expenses, and more. But to do that, they relied on 1.7 million lines of code between their [Android](https://play.google.com/store/apps/details?id=com.google.android.apps.walletnfcrel) and [iOS](https://apps.apple.com/us/app/google-pay-save-pay-manage/id1193357041) apps — an amount that didn’t feel sustainable as Google Pay continued to expand to new countries, each of which would require its own unique features.

To make things even more challenging, many of those new regions had a large number of iOS users, while their existing users were almost exclusively Android. That meant they would not only need to hire more iOS engineers, they would need to continue building every feature twice — once for Android, and once for iOS.

So instead, they opted to invest in a cross-platform framework that would enable them to do more with less: Flutter.

**Why Flutter?**

The team initially tested Flutter as an [Add-to-app](https://flutter.dev/docs/development/add-to-app) possibility, but the opportunity to rewrite the whole app was too big to ignore.

While it meant a heavy upfront investment of engineering resources, it would allow the team to unify their engineering leadership, shift their work away from endlessly patching holes, and increase the speed and efficiency of their client development for faster response and implementation times.

Above all, migrating to Flutter would enable fast, resource-efficient scaling of Google Pay around the world. Whereas building out features on both Android and iOS required double the effort, Flutter would only require about 1.2 times as much work. So they decided to take the plunge.

<Image src="images/third_party/case_studies/google-pay/case_study_body_1.png" format="fullwidth" alt="" />

**Their Solution**

Rebuilding Google Pay on Flutter didn’t come without its challenges. First, they would need to retrain the team on a new language, platform, and approach to the user interface. Then, they would need to rewrite the app as it was changing, because it was constantly being updated. And finally, they would need to jump through all of the necessary security reviews and audits for a second time where the app was already launched.

But before any of that, they had to prove the concept. So in 2019, they spent several months building the case for migrating Google Pay to Flutter. A small team of three senior software engineers from Android and iOS came together, writing and rewriting until they had a vertical slice of the app — home page, chat, and payments (with critical native plugins).

Then they ran a few small sprints for other engineers to give them an opportunity to provide feedback. Flutter was a hit — the team loved that they could get instant feedback while developing, as well as the number of high-quality widgets they could leverage to make development easier.

Once they had the green light from senior management, they brought in 50 engineers and gave them six months to retrain and rewrite the app for a beta launch in Singapore.

The launch was a success. Encouraged, they brought in another 100 engineers to help them relaunch Google Pay in India and the US on the Flutter codebase, as well. It was a race against time: They needed to rewrite an existing app with nearly 300 features and beta test it, then launch to over 100 million monthly active users, all while maintaining the legacy app.

***“Everyone loved Flutter — you could see the thrill on people’s faces as they talked about how fast it was to build a user interface.”***

\- David Ko, Engineering Director, Google Pay

**Results**

Despite these challenges, the team launched Google Pay for beta testing in India in early August.

The rebuilt Google Pay app is smaller, more efficient to manage, and easier to update. Despite adding several new features, the new codebase is 35% smaller than the original implementations — 1.1 million lines of code instead of 1.7 million. At the same time, the team estimates that they’ve saved about 60-70% of their engineers’ time because Flutter is just so much easier to manage.

The team — now at nearly 180 software engineers — is still gathering feedback on the India beta test, but the results are looking promising. The India beta will roll out to all of the over 100 million Indian users later this year, bringing with it a fresh user interface and all of the features their users have come to know and love.

With Flutter, Google Pay 3.0 will be able to scale quickly and efficiently across iOS and Android, starting with a major relaunch of Google Pay in the US this year. This technology provides a foundation for the team to build on as they expand Google Pay 3.0 to the rest of the world in 2021.
