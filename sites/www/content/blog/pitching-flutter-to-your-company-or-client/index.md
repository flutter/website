---
title: "Pitching Flutter to your company or client"
description: "The business case for Flutter"
publishDate: 2018-11-01
author: wmleler1
image: images/1OOmIZ2plXASJUl49v6TlDA.gif
category: tutorial
layout: blog
---

It has been over a year since [What’s Revolutionary about Flutter](https://hackernoon.com/whats-revolutionary-about-flutter-946915b09514) was published (it is still a good introduction). When I wrote that article, few mobile developers had heard about Flutter, but things have come a long way since then. Now I can’t keep up with all the articles and videos being created about Flutter by an active, vibrant, even *exploding* community. [Developers have discovered Flutter](https://twitter.com/timsneath/status/1024684022574669824), and [they *love it*](https://medium.com/flutter-io/what-weve-learned-from-the-july-2018-flutter-user-survey-cbbf1e04370c). Here’s an animated GIF of just one of the [wonderful apps created using Flutter](https://itsallwidgets.com/), by [Reflectly](https://medium.com/reflectly-engineering/reflectly-from-react-native-to-flutter-2e3dffced2ea):

<DashImage figure src="images/1OOmIZ2plXASJUl49v6TlDA.gif" alt="Reflectly intelligent journaling Flutter app" caption="Reflectly intelligent journaling Flutter app" />

Developers often tell me that one of their biggest challenges now is convincing their company management — or if they are an agency or freelancer, convincing their clients — to try Flutter. These decision-makers are not as eager to adopt the latest technology, just for technology’s sake. They are typically tech savvy, but that is not their only concern. They want to know if using something new will help their company succeed; for example, by bringing in new customers or reducing risks.

This article is aimed at two groups:

* Developers who want to help their management understand why they should use Flutter. Even if a developer is familiar with Flutter, they still need solid arguments to present to management.

* Developers who want to decide for themselves whether to develop a product with Flutter.

This article will also discuss reasons why a specific mobile app might not be a good target for Flutter, so an informed decision can be made.

## What is Flutter?

The tagline for Flutter (kind of a written elevator pitch) is
> **Build beautiful native apps in record time**

Let’s break this tagline up into four parts and discuss them one by one:

1. Build

1. Beautiful

1. Native apps

1. In record time

## 1. Build

Flutter is currently focused on building mobile apps for iOS and Android.

However, there is a larger, longer-term vision that sets Flutter apart from current mobile frameworks: Flutter is not just a *framework*, it is a *complete SDK* for building apps that interact using a screen. That means that Flutter contains everything needed to create a user interface, including the renderer and the things to be rendered (which Flutter calls **widgets**).

In many ways, Flutter is similar to game engines such as [Unity](https://unity3d.com/) or [Unreal](https://www.unrealengine.com/), which also supply their own renderer and the things to be rendered (and other software). But instead of building *games*, Flutter builds *apps*.

The fact that Flutter is a complete SDK means that it can be ported to run on virtually any hardware that includes a display. The Flutter renderer uses [Skia, a popular open-source graphics engine](https://en.wikipedia.org/wiki/Skia_Graphics_Engine) that is easy to use on different devices.

<DashImage figure src="images/1_3mc2w0ZoMF86d5kbuvWwA.webp" alt="Flutter on desktop and Raspberry Pi" caption="Flutter on desktop and Raspberry Pi" />

While at Google we have been focused on mobile apps, various third parties have done ports of Flutter to [desktop computers](https://github.com/google/flutter-desktop-embedding) (macOS shown at left, Windows, Linux, and [others](https://groups.google.com/forum/?pli=1#!forum/flutter-desktop-embedding-dev)), to [TVs](https://groups.google.com/forum/#!topic/flutter-dev/0Yf-b8fwGZs) (here’s a [video of Flutter running on an Nvidia Shield TV](https://youtu.be/crODae5bIew)), and to the Raspberry Pi (shown at bottom left). Internally, Flutter is also used to build user interfaces for [Fuchsia](https://github.com/fuchsia-mirror).

Increasingly, apps will expand beyond mobile phones. It will be common to access apps across multiple devices, including home assistants (Google Home Hub, Lenovo Smart Display, etc.), interactive displays in cars, home appliances (refrigerators), wearables (watches, clothing), and other [IoT](https://en.wikipedia.org/wiki/Internet_of_things) devices. In 2017 there were 8.4 billion such devices online. By 2020 (less than two years from now) [IDC estimates](https://www.businesswire.com/news/home/20131003005687/en/Internet-Poised-Change-IDC) that there will be over 30 billion (compared to 5 billion mobile phones). Many of these devices will have interactive screens. Flutter’s architecture has all the ingredients to create [powerful and beautiful user interfaces for these new devices](https://www.forbes.com/sites/forbesnycouncil/2018/07/26/why-you-should-start-looking-at-googles-flutter-and-fuchsia-now/#228e36cca309).

<DashImage figure src="images/10cJ-ZDludFJ-rcVp92lI8A.webp" alt="Screens everywhere!" caption="Screens everywhere!" />

And of course, Flutter is completely free and open source.

## 2. Beautiful

How can you ensure the mobile app you are creating will succeed when it is competing against [3.8 million apps in the Google Play Store and 2 million apps in the Apple App Store](https://www.statista.com/statistics/276623/number-of-apps-available-in-leading-app-stores/)? Even if you manage to convince a user to download your app, there is only a 3% chance that they will be actively using it 30 days later. Gartner Inc. says that [only 0.01% of all published mobile apps become a financial success](https://www.forbes.com/sites/connieguglielmo/2014/01/13/mobile-apps-may-not-pave-the-way-to-developer-riches-sales-average-less-than-1250-a-day/#78025d324890). Developers need all the help they can get.

<DashImage figure src="images/1vFj6DgGFh43jJS6sX2ZxWw.jpeg" alt="Alibaba (left) and Topline (right)" caption="Alibaba (left) and Topline (right)" />

<DashImage figure src="images/1HyTUK7HxEJfJZofdMGcSJA.gif" alt="2Dimensions" caption="2Dimensions" />

Studies have shown that having an [appealing design can be very important](https://medium.com/coffee-and-junk/design-psychology-aesthetic-usability-effect-494ed0f22571). If you look at the most popular mobile apps from the last few years, they each have their own design aesthetic. In addition, beautiful apps win awards, which provides valuable publicity.

As just a few examples, the Flutter apps shown to the left include apps [from Alibaba](https://hackernoon.com/making-the-most-of-flutter-from-basics-to-customization-433171581d01) (the largest e-commerce company in the world), the [Topline recording app](https://www.abbeyroad.com/apps) from Abbey Road Studios, and a demo app of amazing [realtime animations from 2Dimensions](https://apkpure.com/2dimensions-showcase-unreleased/com.two_dimensions.showcaseapp).

Increasingly, companies want their mobile apps to complement their company branding, just like they do for their website and web apps. This requires a *high degree of customization*.

Finally, designers often have great ideas that — by the time they are implemented — are badly watered down because of toolkit limitations. Flutter helps you *say yes to your designer* to build apps that implement their vision.

You can see more Flutter apps in the [Flutter showcase](https://flutter.io/showcase/) (and hundreds more on the [It’s All Widgets site](https://itsallwidgets.com/)). This includes the beautiful [Reflectly journaling app](https://reflectly.app/), shown at the beginning of this article using an animated GIF, but you should install it from the app stores onto your [Android](https://play.google.com/store/apps/details?id=com.reflectlyApp) or [Apple](https://itunes.apple.com/us/app/reflectly-mindfulness-journal/id1241229134) phone. Be sure to read about [their experiences switching their app to Flutter](https://medium.com/reflectly-engineering/reflectly-from-react-native-to-flutter-2e3dffced2ea).

## 3. Native apps

Mobile developers might be surprised by this point. In the world of mobile apps, the term “native app” is often used to refer to an app that targets platform APIs directly using specific languages. And just to make things more confusing, frameworks like React Native and Xamarin use the term “native” to mean that they can use the platform widgets.

Other areas of computing don’t really use the term “native” as it is used in mobile. For example, you can install Linux on either Windows and macOS computers (and many other kinds), but you wouldn’t call Windows or macOS “native” and Linux a “cross-platform” or “hybrid” solution. People consider Linux just as native as Windows or macOS, *because it is*.

A more precise [definition of “native” for computing](https://en.oxforddictionaries.com/definition/native) is:
> “Designed for or built into a given system, **especially denoting the language associated with a given processor**, computer, or compiler, and programs written in it.”

Flutter apps are compiled to native machine ([ARM](https://en.wikipedia.org/wiki/ARM_architecture)) code on both iOS and Android.

The advantages of native apps are plentiful. Native apps start up faster, and most importantly they are smoother and less likely to suffer from jerkiness or stutter (*jank is not beautiful*). Native apps also give the developer more control over the behavior of their app.

In order to receive the advantages of native apps, mobile developers have typically built two separate apps using separate tools and languages. Often, this means having distinct teams of developers for each platform, who then have to coordinate with each other. This raises costs significantly, increases risks, and slows the time to market. Flutter allows developers to consolidate into a single codebase, unify their development teams, reduce risk, and speed time-to-market. All while getting the benefits of a native app.

<DashImage figure src="images/1EJba6N3Cb1qa1DUdcc0-kQ.webp" alt="Which one is “native”? Both!" caption="Which one is “native”? Both!" />

What about the widgets? Because [Flutter provides its own widgets](https://medium.com/flutter-io/why-flutter-doesnt-use-oem-widgets-94746e812510), you might be afraid that Flutter apps will look or feel uncannily different than apps developed using the platform widgets and tools.

To the left, the iOS platform settings screen is compared to the same screen created using Flutter. Even though there are a few small differences at the pixel level, the bottom line is that Flutter makes it easy to create screens that look and feel like platform screens.

Because platforms change between different OS versions, even a platform native app will typically look different on distinct versions of an OS. It is virtually meaningless for Flutter to try to be “pixel perfect”.

Flutter’s widgets adapt to the platform they are running on to provide the proper look and feel, including icons, colors, layout, fonts, scrolling behavior, and so forth. Instead of being “pixel perfect” a more important goal for a Flutter app is to conform to the design guidelines for the platform, and to feel familiar and comfortable to the user.

The high platform fidelity of Flutter apps is possible because Flutter is a complete SDK that renders directly to the platform canvas. Your app does not depend on the platform’s widgets, fonts, etc. that might change out from underneath it.

Flutter also avoids the need for [compatibility libraries](https://developer.android.com/topic/libraries/support-library/). For example, here is a Flutter app that uses Material Design widgets, on a phone running Android Jelly Bean (4.1.2). This phone came out *two years before* Material Design was even created, so the phone has no built-in widgets for Material Design at all. But your Flutter app will run the same as it does on a more modern phone with a more recent OS, and look great.

<DashImage figure src="images/1-ehN32qJg_iFuBjuMdUYew.webp" />

Without Flutter, you would have to deal with these problems yourself. This means more testing on older versions of the OS, and workarounds for platforms that don’t provide features that your app uses. Developers tell us that testing is dramatically easier using Flutter.

In summary, Flutter not only provides the advantages of native apps, it provides additional important benefits:

* Flutter apps will run on older versions of each platform OS. For example, if you, the developer, test your Flutter app on a recent version of Android, it will look the same on older versions. This allows Flutter apps to run well on older phones, with far less testing.

* New releases of the platform OS will also never break your app, unless a change breaks something on which Flutter depends (this is extremely rare, and would be a bug in Flutter, not in your app).

* Your app will not look dramatically different because of modifications made to the OS made by manufacturers or carriers (a common example is changes to the default fonts).

* Most importantly, Flutter gives you, the developer, complete control over what your app looks like, *down to the pixel*, on all platforms and versions.

* If desired, you can explicitly make a Flutter app look different on iOS and Android. Even if you don’t do this, the Flutter widgets adapt to the design guidelines for each platform.

* Flutter can do this using a single codebase for both platforms. Or you can [add platform native code for each platform](https://flutter.io/platform-channels/) to a Flutter app, if desired.

## 4. In record time

Last, but certainly not least, Flutter lets you develop *better* apps *faster*. The most popular (and even hyped) feature of Flutter is its *stateful hot reload*. Not only is it amazingly fast (usually sub-second), it is stateful, which means if you change some code deep down in your app, after you recompile you don’t have to navigate back into the same place or manually recreate your state in order to see the effect of the change.

<DashImage figure src="images/1DDzx3KU38jeAs2gWYc1KVQ.gif" alt="Stateful hot reload!" caption="Stateful hot reload!" />

Flutter’s stateful hot reload is made possible by advanced compiler technology (developed by some of the same people who built the [V8 compiler](https://en.wikipedia.org/wiki/Chrome_V8) for JavaScript and [Strongtalk](https://en.wikipedia.org/wiki/Strongtalk) for Smalltalk) and the fact that Flutter is native and based on reactive views.

In addition to speeding things up, many developers report that Flutter dramatically changes the way they code. They can try out new ideas and new layouts quickly. They can make changes requested by their stakeholders right in front of them.

We also find that it helps designers get exactly what they want. They can play with various parameters until it looks just right. Indeed, designers who know how to use CSS in web apps tell us that it is [easy for them to learn](https://youtu.be/BJCqRpvvTrM) how to make changes themselves to layouts in Flutter .

To really appreciate this, [watch a Flutter app live coded](https://youtu.be/iflV0D0d1zQ) in real time, or try Flutter yourself to build a real app. Join a Flutter hackathon and see how quickly you can learn Flutter and build a working app in it.

As discussed in the last section, Flutter apps also require less testing, which means that you can test and deliver new features for your app much more quickly. For example, JD.com tells us:
> We were able to develop the same features with half of the development resource. With the same number of engineers, each release can now have more features.

Likewise, [Alibaba](https://hackernoon.com/making-the-most-of-flutter-from-basics-to-customization-433171581d01) tells us that using Flutter, the average time to add a new feature went from a month down to two weeks.

<DashImage figure src="images/1CPLZMvIh93Amt_RvTJ8lPg.webp" alt="Hamilton, the app" caption="Hamilton, the app" />

In [the Hamilton app](https://youtu.be/kfd-oLypqFI), the developers actually made a major change to the app *the night before* they released it, with the confidence that the app would be rock solid. That app, built in three short months, was featured on both app stores. Plus Flutter makes it easier for them continue to add new features frequently, to keep their users active and coming back for more.

That’s how you build a successful mobile app.

<DashImage figure src="images/1PyYYwZB4TXMqF7W3SHVv0w.jpeg" />

Not only is it easy and fast to build and modify your apps, it is just as fast to update the Flutter widgets. A common concern about Flutter not using the platform widgets is that Flutter will struggle to keep up with the platforms as they release new widgets or improve old ones.

However, when Apple announced their new iPhone X with its notch, Flutter was able to add support for the notch before the phone itself was released.

And this doesn’t only apply to iOS features. When Google announced a [significant revamp of Material Design](https://material.io/design/material-theming/) at I/O 2018, Flutter was already updated to fully implement the new features. The ability of Flutter to be quickly customized made this possible.

The bottom line is that developers frequently report that they are between two and three times more productive using Flutter, and that they build better apps that are more successful.

## Risks and limitations

There are always a few tradeoffs, and Flutter is no exception. Here are some reasons why Flutter may not be the best tool for a specific app, so that you can make an informed decision.

Because Flutter apps include the Flutter widgets and renderer, this makes the resulting apps slightly larger than apps that utilize the platform widgets and renderer. Up until recently, a Flutter app had a minimum size of 6.7MB, but that has been [reduced to a little over 4MB](https://twitter.com/flutter_wm/status/1025747957608411137). We plan to make further optimizations in the future.

One of the major benefits of Flutter is that a single codebase can be used to release apps on both mobile platforms (although Flutter is also used to build apps for only a single platform). However, there are some apps that are tightly tied to one specific platform or are primarily a wrapper around a platform-provided view, such as an app that is mainly a background service to provide notifications. These apps can be written in Flutter, but they will not see as much benefit from it.

A question we are often asked is whether Flutter is here to stay. There are multiple reasons why the answer is an *emphatic yes*. First, Google is itself a heavy user of Flutter, including for both customer-facing and internal apps (with more apps being developed). For example, the recently released Google Ads mobile app (formerly called AdWords) is written in Flutter. Google is solidly behind Flutter and is committed to its success.

Second, the fact that major apps have typically been built on two separate platforms means that companies have often considered it less risky to (for example) first build an iOS app, and then build an Android app later if there is enough demand. With Flutter, [apps can be released simultaneously on both platforms](https://medium.com/flutter-community/porting-a-75-000-line-native-ios-app-to-flutter-57c6571c57b4) with virtually identical features, circumventing that risk and increasing the potential market for an app. This can be a big benefit to Android.

Another potential issue is that Flutter is comparatively new. It will naturally take a little time for Flutter to catch up to the incumbent tools, both in terms of features and community support. Presently, there are some features provided by the platforms that will take some time for Flutter to implement. Google is putting the resources into Flutter to add these features.

If you want deeper information on why it is worthwhile to try Flutter, read [What’s Revolutionary about Flutter](https://hackernoon.com/whats-revolutionary-about-flutter-946915b09514) and [Why Flutter uses Dart](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf). And read the results of [our latest user study](https://medium.com/flutter-io/what-weve-learned-from-the-july-2018-flutter-user-survey-cbbf1e04370c) to see what users of Flutter think about it.

## How to get started

When you are ready to try Flutter, here some helpful things:

1. [https://flutter.io/get-started/](https://flutter.io/get-started/) — this guide helps you install Flutter, configure your editor, go for a test drive, and write your first app.

1. Watch some [Flutter videos on YouTube](https://www.youtube.com/results?search_query=Flutter).

1. There are a set of guides for devs who are familiar with one (or more) of the following: [Android](https://flutter.io/flutter-for-android/), [iOS](https://flutter.io/flutter-for-ios/), [React Native](https://flutter.io/flutter-for-react-native/), [Xamarin](https://flutter.io/flutter-for-xamarin-forms/).

1. Or if you are new to mobile development, there are also tutorials, such as: [Building Layouts in Flutter](https://flutter.io/tutorials/layout/), [Add Interactivity](https://flutter.io/tutorials/interactive/), and [A Tour of the Flutter Widget Framework](https://flutter.io/widgets-intro/) (including reactive principles, if you are not familiar with them).

1. A valuable resource is the [Flutter cookbook](https://flutter.io/cookbook/). Also the [Widget catalog](https://flutter.io/widgets/) and [the FAQ](https://flutter.io/faq/).

1. Similarly, look at the apps in [It’s All Widgets](https://itsallwidgets.com/). Many of these are open source, so you can see code for published apps. And once you write your own Flutter apps, be sure to submit them.

1. To get a list of the best articles about Flutter delivered to your inbox each week, [subscribe to Flutter Weekly](https://flutterweekly.net/).

1. There are a bunch of lovely [codelabs for Flutter](https://codelabs.developers.google.com/?cat=Flutter), and if that isn’t enough there is a [free online video course on Flutter](https://www.udacity.com/course/build-native-mobile-apps-with-flutter--ud905) from Udacity.

1. And [plenty of other documentation here](https://flutter.io/get-started/learn-more/).

To get involved in the Flutter community, you can find us on [Twitter](https://twitter.com/flutterio), [Gitter](https://gitter.im/flutter/flutter), and [Stack Overflow](https://stackoverflow.com/tags/flutter). You should subscribe to the [Flutter Dev mailing list](https://groups.google.com/forum/#!forum/flutter-dev). And find a local Flutter Meetup or Study Jam, and see if there are any mobile app hackathons happening near you.

## Conclusions

Flutter provides high-velocity development that makes you more productive and helps you build better apps. It is an expressive, highly flexible, and customizable toolkit that gives you, the developer, awesome amounts of control. And it creates fast and smooth native iOS and Android apps from a single codebase.

Flutter will save you money and reduce risks. It is free and open source. Flutter will also help you make more money. You can go after both the Android and iOS markets simultaneously, and create better apps in less time.

Developers also say (*and this is one of my favorite things*) that [Flutter makes mobile development fun again](https://medium.com/@matthew.smith_66715/why-we-chose-flutter-and-how-its-changed-our-company-for-the-better-271ddd25da60). An outstanding [92% of developers](https://medium.com/flutter-io/what-weve-learned-from-the-july-2018-flutter-user-survey-cbbf1e04370c) who use Flutter say they are *satisfied* or *very satisfied* with it. This number has been steadily increasing, and remember that these results are all from the alpha and beta versions of Flutter, *before* the 1.0 release.

Finally, Flutter looks to the future. It is the only native mobile toolkit that supports reactive views, a programming paradigm that helps build better apps, and also enables things like super-fast stateful hot reload. And because it is a complete SDK, Flutter can remain relevant by being ported to new platforms as they become popular.
