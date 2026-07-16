---
title: "Adapting Wonderous to larger device formats"
description: "Using Flutter to design mobile applications that look beautiful on all devices"
publishDate: 2023-01-25
author: leighajarett
image: images/1RA_cBWkp9GOQsK_H0-Dg8w.gif
category: story
layout: blog
---

Today, we’re announcing the next version of Wonderous, which adds support for foldable devices, tablet, and tablet landscape. This iteration allowed us to test Flutter’s ability to **adapt to different device formats**, and the [code](https://github.com/gskinnerTeam/flutter-wonderous-app) repo on GitHub provides a reference for leveraging [adaptive design](https://docs.flutter.dev/development/ui/layout/building-adaptive-apps).

In this post, we’ll walk through some of what we learned. While our focus was on apps for handheld devices, many of these concepts can be adapted to desktop and web.

## Narrowing focus

When thinking through adaptive design, designers should first ask *“What form factors are we possibly supporting?”* Flutter supports nearly every device, but app creators should be explicit about what formats their app has been designed and tested for. Narrowing the focus allows designers to carefully consider how to optimize the digital experience for the canvas that is available. Without careful design, layouts suited for mobile can look unpolished on larger form factors.

## Taking advantage of extra real estate

When adapting the design of an app to larger screen sizes, designers should consider how to take advantage of the extra real estate. This might mean enhancing the presentation by showing a different layout. For example:

<DashImage figure src="images/1Y_ROvg5zl7edWeA-G6THzg.webp" alt="*iPad Pro 12.9-inch portrait and landscape*" caption="*iPad Pro 12.9-inch portrait and landscape*" />


Adding additional rows or columns:

<DashImage figure src="images/1G0_f2A0k1sK7aWmFbKAFlg.webp" alt="*iPad Pro 12.9-inch and iPhone 11*" caption="*iPad Pro 12.9-inch and iPhone 11*" />


Or changing columns to rows:

<DashImage figure src="images/1g3j3u2aTh1m5pR4M5CqX_w.webp" alt="*iPad Pro 12.9-inch portrait and landscape*" caption="*iPad Pro 12.9-inch portrait and landscape*" />


Alternatively, you might use the extra canvas to do more of the same. Wonderous features beautiful illustrations so the larger screen sizes allowed us to showcase even more of this work:

<DashImage figure src="images/1PpfHUeUH0sr5vDUUdcG81A.webp" alt="*iPhone 11, Samsung Fold4 closed, iPad Pro 12.9-inch*" caption="*iPhone 11, Samsung Fold4 closed, iPad Pro 12.9-inch*" />


**Consider approaches for how UI components can react**

As the screen becomes larger, you’ll need to consider how your app’s UI components will react. For example, you might scale the component to fit the available space:

<DashImage figure src="images/1IURgMIU9x8zzm-p6lZUNwg.webp" alt="*Samsung Fold4 open and iPhone 11*" caption="*Samsung Fold4 open and iPhone 11*" />


You might also consider keeping the content center weighted, or pinning certain assets to the device bounds:

<DashImage figure src="images/1RA_cBWkp9GOQsK_H0-Dg8w.gif" />


**Adaptive design with Flutter**

There are many features in the Flutter framework that were useful for adapting Wonderous. For example:

* Hot reload empowered the design team to make small adjustments in real time

* Dynamic padding and font sizes

* The [Flex](https://api.flutter.dev/flutter/widgets/Flex-class.html) widget dynamically displays either a row or a column

* [MediaQuery](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html) returns details like screen size and device orientation

You can read more specifics on the technical implementations on [gSkinner’s website](https://blog.gskinner.com/archives/2023/01/flutter-adapting-wonderous-for-landscape.html). You can also learn more about designing apps for larger screen sizes on Android in [Large screen app sizes](https://developer.android.com/docs/quality-guidelines/large-screen-app-quality) on the Android docs site.

We hope you’ll install Wonderous and leverage the code as a reference while developing your own apps. If you have any feedback on the app itself, please [file an issue on Github](https://github.com/gskinnerTeam/flutter-wonderous-app). If you have any thoughts on adaptive design with Flutter, feel free to send me a message on [Twitter](https://twitter.com/LeighaJarett) (@leighajarett) or [LinkedIn](https://www.linkedin.com/in/leighajarett/) (Leigha Jarett).
