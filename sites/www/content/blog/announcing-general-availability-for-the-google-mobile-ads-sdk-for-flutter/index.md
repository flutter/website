---
title: "Announcing General Availability for the Google Mobile Ads SDK for Flutter"
description: "There are many ways for apps to make money: accepting payments as a storefront for a physical business; offering subscriptions or in-app…"
publishDate: 2021-11-16
author: zoeyfan
image: images/0zOegrJCYTuapgWgf.webp
category: announcement
layout: blog
---

<DashImage figure src="images/0zOegrJCYTuapgWgf.webp" />

There are many ways for apps to make money: accepting payments as a storefront for a physical business; offering subscriptions or in-app purchases; or including ads directly in your application. Today, we are excited to announce the [Google Mobile Ads SDK for Flutter](https://pub.dev/packages/google_mobile_ads) is now generally available, after a six-month beta period. Great news for Flutter apps that require the presence of in-app ads!

## Supported Ads Formats

The Google Mobile Ads (GMA) SDK for Flutter works on both iOS and Android, and supports loading and displaying all Google [mobile ads formats](https://developers.google.com/admob/flutter/quick-start), including:

**Banner Ads:** A rectangular ad that occupies a spot within an app’s layout. These ads stay on screen while users interact with the app, either anchored at the top or bottom of the screen, or inline with content as the user scrolls. In addition to the standard fixed-sized banner ads, we also support adaptive banner ads, which shows the most optimal banner size based on the device’s width and height.

**Interstitial Ads:** A full-screen ad that covers the whole screen of your app. These ads work best when placed at natural breaks or transitions in your app.

**Rewarded Video Ads:** A rewarded ad unit that allows you to reward users with in-app items for interacting with video ads, playable ads, and surveys. This is one of the most popular ad formats among game developers.

**Native Ads:** A highly customizable format that allows you to design ads to match the look and the feel of your app content.

**App Open Ads:** An ad format that monetizes your mobile app loading experience. App open ads are served when a user opens or switches back to your app.

<DashImage figure src="images/0RZUZCrtJ7df_hnjI.webp" />

## Google AdMob and Ad Manager

We partnered with the Google Ads team to build this plugin as the official ads solution for Flutter developers. The GMA SDK for Flutter unifies support for both **Google AdMob and Google Ad Manager** into a single plugin.

If you are not familiar with Google’s ads services, you might not know that [AdMob](https://admob.google.com/home/) and [Ad Manager](https://admanager.google.com/home) are two different products with different monetization capabilities. The AdMob platform is designed for mobile developers who want to earn money from ads and gain actionable insights to grow the app business. The Ad Manager platform is designed for publishers who have significant direct sales or multiple inventory types.

[The GMA SDK for Flutter](https://pub.dev/packages/google_mobile_ads) unifies these products to help meet your monetization needs by sharing code across iOS and Android and not having to rewrite your code as your needs grow.

<DashImage figure src="images/0_i1bA47tKTTOaFAU.webp" />

## Mediation and Bidding

This release also includes a preview of a new mediation feature to help you optimize ad performance. [**Mediation**](https://developers.google.com/admob/flutter/mediation/get-started) helps you manage multiple ad sources used to serve ads to your apps in one place. In addition to Google demand, this lets you also serve ads from non-Google ad networks. Using mediation, you can send incoming ad requests to multiple ad sources and find the best available sources to fill the requests. In addition to traditional mediation, it also supports bidding, which enables ad sources to compete in a real-time auction to fill your ad requests. This helps ensure that you’re getting the highest revenue for your impressions.

The GMA SDK for Flutter offers the same ads features that are available for both iOS and Android apps. You can use the same tooling to manage your campaigns, track your ads performance, and so on.

## Early Adopters

We’ve been working with a few early adopters who were eager to get started with ads support using Flutter ahead of our production release. One of these developers is Lotum, who recently rewrote their very successful word game “[4 Pics 1 Word](https://play.google.com/store/apps/details?id=de.lotum.whatsinthefoto.us&hl=en_US&gl=US)”, a top-grossing app in 50 countries, with over 50 million installs of the Android version alone. They chose Flutter for the rewrite and used the GMA SDK for Flutter to display interstitials and rewarded videos.

In the words of Petra Langenbacher, the app’s Flutter developer:

*“We’ve been fine-tuning and optimizing our app for years, and we wondered whether a big rewrite might impact our revenue or user base. But we’ve been pleasantly surprised to see that wasn’t the case at all: we’ve been able to make these changes without any negative impact!”*

Thank you to Lotum and all the other early adopters who provided us with valuable feedback. We appreciate your help with this initial release.

## Other Monetization Features

Besides ads, Flutter offers other ways to monetize apps. For example, the [In-App Purchase](https://pub.dev/packages/in_app_purchase) plugin allows you to offer additional content in your app like premium services, digital goods, and subscriptions. Flutter’s [Pay](https://pub.dev/packages/pay) plugin lets your app integrate with Google Pay on Android devices and Apple Pay on iOS. This makes it quick and easy to support both platforms with a seamless experience for your users to pay for things like groceries, retail merchandise, and food delivery.

For more about our Ads or other monetization offerings, [please check out our newly refreshed website](https://flutter.dev/monetization), where you can find samples, codelabs, and documentation!

Building a Flutter app is just the start. With our suite of monetization features, we hope to help you launch a successful business with Flutter!
