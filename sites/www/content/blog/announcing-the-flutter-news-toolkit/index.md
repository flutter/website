---
title: "Announcing the Flutter News Toolkit"
description: "An accelerated toolkit for building mobile apps for news and content"
publishDate: 2023-01-25
author: zoeyfan
image: images/0_Xb_zBUOvsH6CL9A.webp
category: announcements
layout: blog
---

<DashImage figure src="images/0_Xb_zBUOvsH6CL9A.webp" />


Google’s Flutter team has partnered closely with the [Google News Initiative (GNI)](https://newsinitiative.withgoogle.com/) in creating the [Flutter News Toolkit](https://github.com/flutter/news_toolkit) — a free, prebuilt Flutter app template — to accelerate news application development. Some early adopters have already built iOS and Android applications in as little as 6 weeks, claiming up to 80% time savings compared to traditional double-ended development on iOS and Android.

Three months ago, we announced the Toolkit in an early access period and received an overwhelming number of applications from organizations across the world, so we’re excited to announce the first version of the Flutter News Toolkit is now generally available!

### Why did we build the Flutter News Toolkit?

Nowadays, most people turn to smartphones for news. In addition to mobile websites, mobile apps can be a great way for news publishers to engage with existing readers, reach new audiences, and create new revenue streams. But it takes time and effort to design, implement and deploy mobile apps.

For news publishers who have limited financial and human resources, building apps from scratch is a major undertaking. Here at Google, we want to help developers be successful and productive, so we’re investing in a toolkit that offers all the common functionalities news publishers need, so they can focus on differentiating their brand and content without writing boilerplate code.

### What features are included in the Flutter News Toolkit?

We collaborated with industry experts and news publishers globally to identify essential features and user workflows for a news application template. With these pre-built, out-of-the-box features, news publishers only need to connect their data source and customize the UI to reflect their brand.

Using best practices from [News Consumer Insights](https://news-consumer-insights.appspot.com/), The Flutter News Toolkit includes features, such as:

* **User onboarding:** re-engage your audience with push notifications permissions; acquire ad tracking permissions

* **Account creation/login:** authenticate through your platform and user social networks (such as Google login); create passwordless accounts

* **Content feeds and content pages**: display news articles, videos, pictures, ads, and newsletter sign-up prompts

* **Monetization**: easily add subscriptions and different ad formats

* **Search**: allow user searches for articles by keyword or click into popular searches

* **Settings:** allow user preferences for notifications, login, and ads tracking

You can use these pre-integrated features out-of-the-box, or easily modify and swap them with other functionalities you prefer.

<DashImage figure src="images/1HOaHUtxwx2S4urCrztI88g.webp" alt="*Sample features provided in the Flutter News Toolkit*" caption="*Sample features provided in the Flutter News Toolkit*" />


### Early adopters

The Flutter News Toolkit has already begun helping news publishers across the globe accelerate mobile strategy and achieve business goals. For example,

* The Standard (one of Kenya’s largest news publishers) claimed time savings of up to 80% when they built [The Standard News](https://play.google.com/store/apps/details?id=ke.co.group.standard.thestandardkenya.thestandard&hl=en&gl=US).

* Commerce enablement company AnyMind Group built apps for [Khaosod Online](https://play.google.com/store/apps/details?id=co.th.khaosod.mobile&hl=en&gl=US) (one of Thailand’s largest news sites) in 2 weeks;

* [Boldsports](https://play.google.com/store/apps/details?id=ng.boldsports.news.template&hl=en&gl=US), a Nigerian-based sports news start-up, created an early version within just a few days;

* Hespress (one of Morocco’s largest news sites) finished its [English app](https://play.google.com/store/apps/details?id=com.hespress.english&hl=en&gl=US) development within 6 weeks and also reported that the new app drove 93% higher organic user acquisition organically and 50% growth in ad revenue within two months of launching the app.

Let’s hear from some of them in their own words.

<YoutubeEmbed id="YnJwjZ3jCTc" title="FOO041 v8" fullwidth="true"/>


### Get Started

If you have been waiting to get access to the Flutter News Toolkit, the wait is over! You can now directly access the [code hosted on Github](https://github.com/flutter/news_toolkit).

If you are interested in adopting the News Toolkit but need help customizing it to your needs, we’ve also got you covered! Just email us at [flutter-news-core-group@google.com](mailto:flutter-news-core-group@google.com), and we can recommend trusted Flutter agencies to help you with app creation using the Flutter News Toolkit.

Although the Flutter News Toolkit was originally designed for news organizations, anyone who wants to create flow-based content can use the sample code. Whether you want to create a company newsletter app (see [Medius](https://play.google.com/store/apps/details?id=au.com.dius.news) built by DiUS as an example) or a social media app, you’ll likely find pre-built features like user login, social sharing, and content feeds to be helpful to your app.

We plan to continue to improve the Flutter News Toolkit as we learn more from publishers and developers. Don’t forget to check out our [video tutorial](https://www.youtube.com/watch?v=dukRAS-OUMM) for more details on the [Flutter News Toolkit](https://github.com/flutter/news_toolkit)!

## FAQ

### What is Flutter?

Flutter is Google’s open-source UI toolkit for building beautiful apps for mobile, web, and desktop from a single codebase. Flutter significantly reduces the time required to build and publish an app. Today, Flutter is [the most popular cross-platform](https://www.statista.com/statistics/869224/worldwide-software-developer-working-hours/) development framework, with over 3 million developers around the world. There are more than 700,000 Flutter apps, including Alibaba, BMW, Google Pay, PUBG, Shein, and Wechat.

### Is Flutter easy to learn?

Yes, for developers who have knowledge of other programming languages such as Java, learning Flutter is quick. Besides, we have a wealth of [learning resources](https://flutter.dev/learn) available for you to get started.

### Can I use other non-Google services such as Ads, analytics, and subscriptions in the app?

Of course! The Flutter News Toolkit only aims to provide a sample. You are not required to use any service you don’t want. In fact, it is easy to remove or swap the existing integrations with other services. For example, if you want to use non-Google Ads services, you can find other [packages](https://pub.dev/packages?q=platform%3Aandroid+platform%3Aios+ads) on pub.dev.

### How much work am I required to do to launch the app?

While the news template can lower the barrier to entry for building news mobile applications, this solution still requires Flutter development work. The template doesn’t support no-code or wysiwyg functionality or tools (such as dashboards) for non-technical users to modify the app branding and styling.

We have mapped out the deployment process at a high-level with an assumption of 2 Flutter engineers working on the project. As an example, early adopters like Hespress finished their application development within 6 weeks. But we also have customers like AnyMind launched the app within 2 weeks with 1 engineer.

<DashImage figure src="images/0n4yFaH37OzEQ9Ys8.webp" alt="*Deployment process at a high-level*" caption="*Deployment process at a high-level*" />


### If I don’t have an in-house development team, how can I use the template?

We can recommend trusted Flutter agencies who can help you take the template to the finish line. You can email [flutter-news-core-group@google.com](mailto:flutter-news-core-group@google.com) for more information. As a disclaimer, Google is not associated with these agencies, and we do not take any revenue share from them.
