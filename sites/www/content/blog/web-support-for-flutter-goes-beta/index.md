---
title: "Web support for Flutter goes beta"
description: "Posted by Mariam Hasnany, Product Manager, Flutter"
publishDate: 2019-12-11
author: mariam_hasnany
image: images/0M7sTluUPVsk6DcnU.webp
category: announcement
layout: blog
---

We’re pleased to announce that web support for Flutter is now in beta!

## Why did we bring Flutter to the web?

Developers build apps that need to run both on mobile and web. It’s important to us that you can design and build what you want, and know that with Flutter it will work beautifully anywhere you need. As a developer, learning a single set of skills that can easily transfer across multiple platforms is desirable. Web support for Flutter enables developers to use the same code, ship features faster, and ensure consistency for their experiences across devices. Additionally, a powerful Dart compiler for the web and a Flutter architecture that is designed with portability in mind makes it easier to create delightful interactive web experiences using Flutter.

## More than a preview

Since releasing web support as a [tech preview](https://medium.com/flutter/bringing-flutter-to-the-web-904de05f0df0) at Google I/O this year, and the start of the [early adopter program](https://medium.com/flutter/flutter-for-web-early-adopter-program-now-open-9f1fb146e4c4) in July, we’ve been working hard to support the growing interest in extending Flutter’s web support both at Google and in the wider public.

### So, what does beta for web mean?

With the Flutter 1.12 release, Flutter’s web support graduates from technical preview to beta. When you’re on the beta channel and have enabled web support, creating a new Flutter project not only includes Android and iOS host apps, but now also includes a web/ directory that contains everything you need to compile and run the same project code in a browser.

We believe Flutter’s web support is starting to stabilize and is ready for more adventurous developers to start using for a number of scenarios. As we move into this next stage of development, we will continue to make changes and improve accessibility, test coverage, and more.

## Scenarios to try

As we’ve been developing Flutter’s support for running on the web, we have particularly focused on a number of scenarios that we think are well suited for the characteristics of Flutter. We believe that our feature set is complete enough to enable developers to build rich, interactive web experiences. While working with our early adopter partners, we have been validating and refining support for the following scenarios.

**Connected, standalone app**

Flutter can enable developers to build a single app from the same code across both mobile and browser experiences. [Journey](https://startyourjourney.io/), one of our early adopters, used Flutter to build an app across multiple platforms.

<DashImage figure src="images/0E9vaDY0XLc4dCR2J.webp" alt="Journey, a social app, recently launched a cross-platform app using Flutter" caption="Journey, a social app, recently launched a cross-platform app using Flutter" />

Luke O’Brien, Founder of Journey, states “*Four months ago I was about to build Journey for Android-only for the MVP. I discovered Flutter and thought, ‘This is too good to be true’, but decided to run with it. It has been the best decision I have made to date. Flutter has cut development time in half (probably more than half) and we’ve now launched across Android, iOS, and web — doubling user-growth potential. It’s difficult to overstate the impact Flutter has had in turning my vision into reality.’*

**Embedded interactive content**

One scenario is embedding a rich, data-centric, mini app within a parent site; there is no need for navigation services or other app-like functionality. Embedding a new car configurator, a crossword puzzle, or interactive data visualizations into an existing website are just a few key examples that fit this scenario. Early adopter [AEI Studio’s showcase](https://studio.aei.dev/showcase/) of chatbots embedded Flutter within their web chat dialog showcasing animations, text input by keyboard, and more.

<DashImage figure src="images/0M7sTluUPVsk6DcnU.webp" alt="Weatherbot is one of AEI Studio’s chatbots that embed Flutter within their web chat dialog" caption="Weatherbot is one of AEI Studio’s chatbots that embed Flutter within their web chat dialog" />

**Lite apps**

Even though Flutter’s custom mobile runtime is still able to provide a smoother experience today, sometimes the friction of app installation impedes users from getting started. An existing Flutter app that has a lightweight web experience gives companies the best of both worlds. Although the primary consumption of the app would be on mobile, a lite web app could provide a less feature rich experience with related functionality using the same tools, frameworks, UI components, and business logic.

**Companion apps**

A companion app is a web experience built using Flutter to support your primary consumption mobile app. For example, using Flutter to build a web app that enables admins or internal users to create content or manage the backend for your existing Flutter mobile app. Although this web app is considered a separate experience, it can leverage much of the same code from the mobile app.

## Plugins are here!

Flutter has a concept of plugins, which allows you to talk to native libraries for the platform you are running on. When running your Flutter app on the web, you can get full access to existing JS libraries. We do all the JS-interop code behind the scenes so the plugin works as you’d expect on both mobile and web. We’ve already implemented a handful of the top-requested plugins so they work consistently across your native and web applications. Now, you can also [write your own plugins](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-5e26c689ea1) as [Ben Hagan](https://github.com/cbenhagen) did for video_player, and [Hadrien Lejard](https://github.com/lejard-h) did for the sentry package. The following packages are updated:

* [shared_preferences](https://pub.dev/packages/shared_preferences)

* [firebase_core](https://pub.dev/packages/firebase_core)

* [firebase_auth](https://pub.dev/packages/firebase_auth)

* [google_sign_in](https://pub.dev/packages/google_sign_in)

* [url_launcher](https://pub.dev/packages/google_sign_in)

* [video_player](https://pub.dev/packages/video_player)

* [sentry](https://pub.dev/packages/sentry)

We have also added new platform tagging and filtering on the pub.dev package repository.

First, on a package detail page, we list which platforms the package supports. This makes it easy to identify if a package has web support.

<DashImage figure src="images/05vkz66kMYk5DTfSS.webp" alt="*pub.dev package detail page showing SDK and platform compatibility tags*" caption="*pub.dev package detail page showing SDK and platform compatibility tags*" />

The search UI also has new filters, so you can find packages that have web support. This is based on the new [platform manifest tags](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms) that are now available in Flutter 1.12.

<DashImage figure src="images/0QApzX3FOYgAGCFRK.webp" alt="*pub.dev search UI showing SDK and platform filter support*" caption="*pub.dev search UI showing SDK and platform filter support*" />

## Road to stable

We made a lot of progress with beta, but we still have a lot of work to do. Our performance work is not complete and we are working on broadening our scope for accessibility, browser compatibility and more.

**Accessibility**

We have accessibility support on mobile browsers through TalkBack on Android and VoiceOver on iOS. Some of the features that are already implemented for assistive technologies across platforms include things like UI traversal and traversal order, UI interaction cues like tappable, labels, editable, incremental, image, live region, and checkable. And, we’re working on adding screen reader support for desktop web browsers.

**Browser support**

As Flutter evolves from a mobile-only framework to also covering desktop ux idioms, Flutter’s support for desktop web browsers will improve and feel more seamless. We plan to support and test for Chrome, Edge, Firefox, and Safari on desktop and mobile browsers.

**Test coverage**

Since the preview, we increased our test coverage both on the framework and on the Flutter web engine. As of today, we run automated tests on Chrome, and we manually test Safari. There is still more testing work to do, and regressions may crop up in untested scenarios.

## Try Flutter’s web support, contribute, and share!

Now is the perfect time to try Flutter’s web support! Go to flutter.dev/web to get started, and find examples, documentation, and more. If you’ve already experimented with Flutter’s web support, you can [switch to the beta channel](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels).

There are over 1800 Flutter plugins that exist today; however, most are for iOS or Android. You can help bridge the gap between mobile and web by adding web support to existing plugins or by building your own. To help guide you, we published an article about [how to write a web plugin](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-5e26c689ea1).

## Closing thoughts

We hope that you are excited about Flutter’s web support advancing to the beta channel, and feel our commitment as we get closer to a production-quality release of web support.

We [welcome feedback](https://flutter.io/support/), and hope that you share what you’re working on using #Flutter. We truly enjoy seeing how you use Flutter to build beautiful, interactive web experiences!
