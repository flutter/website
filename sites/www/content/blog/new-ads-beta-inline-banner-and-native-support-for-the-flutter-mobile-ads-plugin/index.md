---
title: "New ad formats for Flutter"
description: "Beta program opens for inline banner and native ads support"
publishDate: 2020-11-11
author: haddadniaj
image: images/10kWrLLh_g2Ywwgcs_iAL-w.webp
category: announcement
layout: blog
---

There are many ways that mobile app developers get paid for their work. Monetizing apps via ads is one popular path for many mobile developers, including those using Flutter.

[Native ad format support](https://github.com/flutter/flutter/issues/12114), in particular, is one of the top five requested features for Flutter. The previously available Google ads plugin (also known as the `firebase_admob` plugin) provided by the Flutter team supported overlay banner, interstitial, and rewarded video, but couldn’t render formats such as inline banner or native ads.

<DashImage figure src="images/10kWrLLh_g2Ywwgcs_iAL-w.webp" />


## Inline Banner and Native Ads

As the name suggests, inline banner ads let you integrate an ad unit as a part of the Flutter view, instead of overlaying the banner on top of the UI. Similarly, native ads allow you to design an ad experience that feels like a natural part of your app content. Some developers let us know that the lack of inline banner and native ads would hinder their ability to create beautiful and natural ads experiences, and others indicated that not having these features could potentially block them from adopting Flutter into their applications.

In response to your requests, we’ve been developing support for these formats. One year ago, we started collaborating closely with Google Ads to implement a robust and trustworthy inline ads solution for Flutter. We also refactored the plugin code entirely to improve performance and stability. Today, after completing our implementation and a round of alpha testing, we are glad to announce invite-only access to a beta release of this updated plugin.

With this beta, we built upon the existing plugin and added support for new formats across AdMob & Ad Manager. As with all beta releases, there are still kinks to work out, and feature support may change without notice. If selected for the beta, we strongly recommend that you thoroughly test the integration within your apps, before shipping to your users.

## Apply now

To apply for our beta test, please fill out [our application form](https://forms.gle/5d1MfrbaCLX9PS2Z9). We’re particularly looking for customers who have an existing Flutter app in the store and are willing to use our beta release in their production app, in partnership with our team. If you are accepted into the beta you will receive an email with further instructions.

Based on the results of this beta, we expect to open this up to a broader audience in early 2021.

We hope that inline banner and native ads help you unlock more revenue growth for your Flutter apps.

Happy coding and advertising!