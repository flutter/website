---
title: "Two Months of #FlutterGoodNewsWednesday"
description: "New apps and plugins, free training and tooling: oh my!"
publishDate: 2020-05-27
author: timsneath
image: images/0B33kcAC_6aXEEdVZ.webp
category: announcement
layout: blog
---

When we realized that this was going to be a very different spring without the usual events and connection points, we decided to find a new way to share our various announcements with you. A few of us put our heads together, and [#FlutterGoodNewsWednesday](https://twitter.com/hashtag/fluttergoodnewswednesday) was born. Each week for the last two months, we’ve shared something new that we hope made you smile. This week, we thought we’d follow up on some of the announcements we’ve made so far and share some further updates.

## Free introductory training for Flutter developers

We kicked things off with an announcement of a [free 10+ hour introductory course covering the basics of Flutter development](https://medium.com/flutter/learn-flutter-for-free-c9bc3b898c4d), created in partnership with Angela Yu of the App Brewery. We’re delighted to see that **over 75,000** of you have signed up for the course, with nearly 5,000 completions already (my thirteen year-old son is one of them!) For those of you on the course, hopefully you’ve discovered the Discord group where [Very Good Ventures](https://verygood.ventures/) and a team of volunteers have been providing concierge support. We’ve been learning from you too — in particular, understanding where some of the early pitfalls are to getting started; we’ll use this knowledge to improve the documentation and the product itself.

If you’ve almost completed this course, you might be wondering “what next”? We have a few recommendations for you that cover intermediate topics:

* [Part 2 of Angela’s course](https://www.udemy.com/course/flutter-bootcamp-with-dart/?referralCode=2B7724A180C0502A2547) covers calling web services and Firebase integration, more advanced widgets, state management, and animation.

* [Nick Manning’s Tourism & Co course](https://fluttercrashcourse.com/courses/tourismco) puts what you learn in Angela’s course into action with a real, working app example, including unit and integration testing, asynchronous web service invocation, JSON APIs and custom views.

* Similarly, [Andrea Bizotto’s REST API crash course](https://courses.codewithandrea.com/) builds on a popular API, showing how to call REST-based web services, cache returned data, and handle service degradation issues.

## CodePen Flutter support

We also shared about [CodePen’s adoption of Flutter](https://medium.com/flutter/announcing-codepen-support-for-flutter-bb346406fe50). To date we’ve seen nearly 5,000 Flutter pens created by designers and developers from around the world. Some of you have boggled our minds with what you’ve created. Here are a few favorites that crossed our radar in the last weeks:

* [Retro Boy Color](https://codepen.io/mkiisoft/full/bGVxrWK) (by [Mariano Zorrilla](https://codepen.io/mkiisoft))

* [Netflix Logo in Flutter](https://codepen.io/orestesgaolin/full/xxwzdgJ) (by [Dominik Roszkowski](https://codepen.io/orestesgaolin))

* [Flutter Space Program](https://codepen.io/orestesgaolin/full/qBOxpBK) (by [Dominik Roszkowski](https://codepen.io/orestesgaolin))

* [Draggable C curve](https://codepen.io/Darth_Paul/full/YzyrmGy) (by [Paul Thomas](https://codepen.io/Darth_Paul))

* [Liquid Polygon](https://codepen.io/blueaquilae/full/pojWyZg) (by [Robert Felker](https://codepen.io/blueaquilae))

* [Long shadow animations](https://codepen.io/jonathan_monga/full/wvKZbzG) (by [Jonathan Monga](https://codepen.io/jonathan_monga))

* [Trigonometric Flutter](https://codepen.io/Deven-Joshi/full/NWGdvgG) (by [Deven Joshi](https://codepen.io/Deven-Joshi))

* [Color Test](https://codepen.io/chiziaruhoma-ogbonda/full/oNjObRm) (by [Chiziaruhoma Ogbonda](https://codepen.io/chiziaruhoma-ogbonda/))

<DashImage figure src="images/0B33kcAC_6aXEEdVZ.webp" alt="New CodePens that use Flutter’s web support to showcase prototypes and experiments." caption="New CodePens that use Flutter’s web support to showcase prototypes and experiments." />

Keep exploring with CodePen: we have a challenge coming up for you!

## Flutter Momentum

For our third #FlutterGoodNewsWednesday blog post, [we shared some statistics about Flutter adoption, with two million developers now using Flutter](https://medium.com/flutter/flutter-spring-2020-update-f723d898d7af). There are now more developers using Flutter on a typical day than over the course of an entire week this time last year.

<DashImage figure src="images/0h3Nhe6QdketsMi-z.webp" alt="The New York Times Spelling Bee game, implemented with Flutter." caption="The New York Times Spelling Bee game, implemented with Flutter." />

At the time we shared that we’d seen about 50,000 apps uploaded to the Play Store. The pace of growth continues to accelerate, and we’re delighted to share that **a further 10,000 Flutter apps have been uploaded in the month since that post**. This level of momentum inspires us: thank you for your support!

A great example of one of those new apps is from the [New York Times games team](https://www.nytimes.com/subscription/games/lp8J6CG), who shared some of their experiences with Flutter [at the Google I/O ’19 event](https://developers.googleblog.com/2019/05/Flutter-io19.html). Their [Spelling Bee](https://www.nytimes.com/puzzles/spelling-bee) game is now rolling out to the iOS and Android stores as part of their [crossword app](https://play.google.com/store/apps/details?id=com.nytimes.crossword&hl=en_US): built entirely with Flutter, this addictive word game challenges you to make words out of a honeycomb of letters.

Since this blog post came out, we’ve [also released the results of our Q1 developer survey](https://medium.com/flutter/what-are-the-important-difficult-tasks-for-flutter-devs-q1-2020-survey-results-a5ef2305429b), which over 6,000 of you responded to. 94.5% of you say that you’re satisfied or very satisfied with Flutter, but we’re also learning more about areas of difficulty. One challenge reported in a previous survey was animation, and we’ve subsequently added a [series of videos](https://www.youtube.com/playlist?list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua) and [more detailed documentation](https://flutter.dev/docs/development/ui/animations) targeting that subsystem in greater detail.

## Web Progress Update

One area we’ve been working hard on over the last few months has been Flutter support for targeting web output. [As we reported in our web update](https://medium.com/flutter/flutter-web-support-updates-8b14bfe6a908), we are particularly focused on improving both performance and conformance. In the post we announced that Flutter now supports Progressive Web Applications, and in the intervening weeks we’ve been refining this feature substantially with [more sophisticated service worker caching](https://github.com/flutter/flutter/pull/56103) to improve first-load performance.

In the last week, we’ve also begun a [series of articles](https://medium.com/flutter/optimizing-performance-in-flutter-web-apps-with-tree-shaking-and-deferred-loading-535fbe3cd674) talking about [tips and tricks for maximizing performance of Flutter apps that run on the web](https://medium.com/flutter/improving-perceived-performance-with-image-placeholders-precaching-and-disabled-navigation-6b3601087a2b), based on learnings from optimizing the Flutter Gallery. Keep following this blog channel for more articles on this subject in the coming weeks!

## Flutter 1.17 and Dart 2.8

Perhaps the biggest news so far with this slew of announcements was the [release of Flutter 1.17](https://medium.com/flutter/announcing-flutter-1-17-4182d8af7f8e), including [Dart 2.8](https://medium.com/dartlang/announcing-dart-2-8-7750918db0a). Flutter 1.17 offers performance and memory improvements on all platforms, but you’ll see the biggest boosts on iOS, with the [adoption of Apple’s Metal subsystem](https://medium.com/flutter/announcing-flutter-1-17-4182d8af7f8e#f303) for graphics rendering. For Android too, you’ll see improvements, particularly with the new optional [fast start debugging mode](https://github.com/flutter/flutter/pull/46140), which offers a 3x speed boost with no changes to your code.

Beyond the new features mentioned in the blog post, one feature that some of you have discovered is the updated error display on release mode builds. For release mode builds only, we’ve [disabled the “red screen of death”](https://github.com/flutter/flutter/issues/40452) that appears when one of your widgets is incorrectly configured. Many of you told us you’d like to see a less… prominent message in the rare situation that you ship an application with a bug, and hopefully this changed default behavior is a better alternative. (For those of you who want something else, you can use the [ErrorWidget.builder](https://api.flutter.dev/flutter/widgets/ErrorWidget/builder.html) property to further customize this.)

It’s exciting to see that, as of the time of writing, **two-thirds of you have already upgraded to 1.17**. We’d encourage the rest of you to upgrade at your earliest convenience to take advantage of all that we’ve got to offer in this release!

In the intervening period, we’ve shipped one hotfix release for Flutter 1.17, and we plan further updates as required to improve stability and quality. You can find out which bug fixes are included in each hotfix release as well as learn how to ensure that you’re running the latest stable version by going to the [relevant wiki page](https://github.com/flutter/flutter/wiki/Hotfixes-to-the-Stable-Channel).

## Adobe XD Plugin Preview Availability

Another major piece of news for designers is the [first public preview of Adobe XD support for Flutter](https://medium.com/flutter/announcing-adobe-xd-support-for-flutter-4b3dd55ff40e), published by Adobe themselves.

This week, Adobe released an update to the plugin that [fixes a few opacity-related export bugs](https://github.com/AdobeXD/xd-to-flutter-plugin/blob/master/CHANGELOG.md) and aggressively combines shapes for cleaner Dart code. In addition, Adobe [shipped an XD update last week](https://theblog.adobe.com/xd-may-2020-offline-coediting-sharing-improvements/) that [includes new APIs for access to responsive layout](https://adobexdplatform.com/plugin-docs/changes.html#new-api-features). Once this is rolled out more broadly, stay tuned for a further update to the XD to Flutter plugin in the next few weeks that will improve flexibility of the generated Dart code.

## Plugins and Flutter Favorites

Most recently, last week we [announced our plans to take many of the Flutter team’s plugins to 1.0](https://medium.com/flutter/flutter-package-ecosystem-update-d50645f2d7bc), in addition to a new set of Flutter Favorites that includes [Sign in with Apple](https://pub.dev/packages/sign_in_with_apple).

But it’s always worth calling out some of the unsung heroes. With over 10,000 packages, it’s tough to recognize them all, but this week we’re going to highlight an informal top ten list of cool packages that aren’t (yet) Flutter Favorites but are nevertheless worthy of attention:

1. [fl_chart](https://pub.dev/packages/fl_chart) offers beautiful business charts, including line and bar charts, scatter plots, and pie charts.

1. [flutter_blurhash](https://pub.dev/packages/flutter_blurhash) provides quick placeholders for images that may take time to download.

1. [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) offers thousands of icons for easy inclusion in your Flutter app.

1. [fab_circular_menu](https://pub.dev/packages/fab_circular_menu) provides an attractive popup menu.

1. [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations) offers beautiful load animations for listviews, gridviews and columns.

1. [device_preview](https://pub.dev/packages/device_preview) constrains your app to a custom device shell, allowing you, for example, to preview an iPhone output from macOS.

1. [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator) allows you to transition through a carousel of infocards.

1. [flame](https://pub.dev/packages/flame) provides a small Flutter game engine with a large set of tutorials.

1. [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) is a popular CLI tool which greatly simplifies the task of updating your Flutter app’s launcher icon.

1. [smooth_star_rating](https://pub.dev/packages/smooth_star_rating) offers a compact control for selecting a star rating.

<DashImage figure src="images/1VB60_VnsDmTKBsewFgus_Q.webp" alt="Some of the over 10,000 plugins on pub.dev that add everything from business charts, to 2D games engine support to Flutter." caption="Some of the over 10,000 plugins on pub.dev that add everything from business charts, to 2D games engine support to Flutter." />

By the way, if you’re writing a package, make sure you haven’t missed our [article on tips and tricks for developing modern plugins](https://medium.com/flutter/modern-flutter-plugin-development-4c3ee015cf5a). And please fill out our [quarterly survey](https://google.qualtrics.com/jfe/form/SV_5oNFjVJWGRECS3z?Source=TwoMonths), which has a module focused on plugin development.

## Flutter Day

And last, but not least — we recently [announced Flutter Day](https://medium.com/flutter/save-the-date-flutter-day-june-25-2020-8e9f5fd03248), which will take place in just a few weeks time on June 25th. We’ll have three technical sessions, #AskFlutter, and a set of new and updated codelabs to work through, getting you ready for the community-led [#Hack20 hackathon](https://flutterhackathon.com/#/) event that kicks off in the weekend that follows.

## More Good News To Come

We’re not done: we have a number of announcements still in the pipeline as part of [#FlutterGoodNewsWednesday](https://twitter.com/hashtag/fluttergoodnewswednesday). So keep tuning in, and if you have some good news of your own to share with us, please don’t hesitate to do so.

You can reach us at any time on Twitter at [@flutterdev](https://twitter.com/flutterdev). We’d love to hear from you!
