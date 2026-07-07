---
title: "What’s New in Flutter 2.0"
description: "Flutter web and Null Safety move to stable, Flutter desktop moves to beta and so much more!"
publishDate: 2021-03-03
author: csells
image: images/0KQZef4s2-koToHMA.png
category: releases
layout: blog
---

## What’s New in Flutter 2

Today, we’re pleased to announce the release of Flutter 2. It’s been a little more than two years since the Flutter 1.0 release, but in that short time, we’ve closed 24,541 issues and merged 17,039 PRs from 765 contributors. Just since the Flutter 1.22 release in September, we’ve closed 5807 issues and merged 4091 PRs from 298 contributors. Special thanks go out to our volunteer contributors who generously give their spare time to improve the Flutter project. The top volunteer contributors for the Flutter 2 release were [xu-baolin](https://github.com/xu-baolin) with 46 PRs, [a14n](https://github.com/a14n) with 32 PRs that focused on bringing Flutter to null safety, and [hamdikahloun](https://github.com/hamdikahloun) with 20 PRs that improved a number of the Flutter plugins. But it’s not just coders that contribute to the Flutter project; a great set of volunteer PR reviewers were also responsible for reviewing 1525 PRs, including [hamdikahloun](https://github.com/hamdikahloun) (again!), [CareF](https://github.com/CareF) and [YazeedAlKhalaf](https://github.com/YazeedAlKhalaf) (who’s only 16!). Flutter is truly a community effort and we couldn’t have gotten to version 2 without the issue raisers, PR contributors, and code reviewers. This release is for all of you.

There are a lot of exciting things happening as part of the Flutter 2 release. For an overview of what’s new across Flutter 2 and Dart 2.12, as well as how our customers and partners are using Flutter 2, see [Announcing Flutter 2](https://developers.googleblog.com/2021/03/announcing-flutter-2.html). For a detailed look at Dart 2.12, see [Announcing Dart 2.12](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87). For how best to take advantage of Flutter web now that it’s recommended for production use, see [Flutter web support hits the stable milestone](https://medium.com/flutter/web-post-d6b84e83b425).

And, to see what’s new in Flutter 2 itself, keep reading!

## Web

As of today, Flutter’s web support has transitioned from beta to the stable channel. With this initial stable release, Flutter pushes reusability of code to another level with the support of the web platform. So now when you create a Flutter app in stable, web is just another device target for your app.

<DashImage figure src="images/0KQZef4s2-koToHMA.png" alt="[Moi Mobiili](https://www.moi.fi/), a modern Mobile Virtual Network Operator striving for operational excellence through digitalization, chose Flutter to build their Mun Moi Account manager app and recently launched their web app." caption="[Moi Mobiili](https://www.moi.fi/), a modern Mobile Virtual Network Operator striving for operational excellence through digitalization, chose Flutter to build their Mun Moi Account manager app and recently launched their web app." />


By leveraging the web platform’s many strengths, Flutter built a foundation for building rich interactive web applications. We primarily focused on performance and improvements to our rendering fidelity. In addition to our HTML renderer, we added a new CanvasKit-based renderer. We’ve also added web-specific features, such as a [Link widget](https://pub.dev/documentation/url_launcher/latest/link/Link-class.html), to make sure your app running in the browser feels like a web app.

Find more details about this stable release in [Flutter’s web support blog post](https://medium.com/flutter/web-post-d6b84e83b425).

## Sound Null Safety

Sound null safety is a significant addition to the Dart language, which further strengthens the type system by distinguishing nullable types from non-nullable types. This enables developers to prevent null error crashes, a common reason for apps to crash. By incorporating null checks into the type system, these errors can be caught during development, thus preventing crashes in production. Sound null safety is fully supported in stable as of Flutter 2, which contains Dart 2.12. For more details, see the [Dart 2.12 blog post](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87).

The pub.dev package repository already has [more than 1,000 null safe](https://pub.dev/packages?q=&null-safe=1) packages published, including hundreds of packages by the [Dart](https://pub.dev/packages?q=publisher%3Adart.dev&sort=popularity&null-safe=1), [Flutter](https://pub.dev/packages?q=publisher%3Aflutter.dev&sort=popularity&null-safe=1), [Firebase](https://pub.dev/packages?q=publisher%3Afirebase.google.com&sort=popularity&null-safe=1), and [Material](https://pub.dev/packages?q=publisher%3Amaterial.io&sort=popularity&null-safe=1) teams. If you are a package author, review the [migration guide](https://dart.dev/null-safety/migration-guide) and consider migrating today.

## Desktop

In this release, we’re pleased to announce that Flutter’s desktop support is available in the stable channel under an early release flag. What this means is that we’re ready for you to give it a try as a deployment target for your Flutter apps: you can think of it as a “beta snapshot” that previews the final stable release coming later this year.

To bring Flutter desktop to this degree of quality, there have been improvements both big and small, starting with working to ensure that text editing operates like the native experience on each of the supported platforms, including foundational features like [text selection pivot points](https://github.com/flutter/flutter/pull/71756) and being able to stop propagation of[ a keyboard event once it’s been handled](https://github.com/flutter/flutter/issues/33521). On the mouse input side, dragging with a high precision pointing device now starts immediately instead of waiting for the lag needed when handling touch input. Also, a built-in context menu has been added to the TextField and TextFormField widgets for [Material](https://github.com/flutter/flutter/pull/74286) and [Cupertino](https://github.com/flutter/flutter/pull/73882) design languages. Finally, [grab handles have been added](https://github.com/flutter/flutter/pull/74299) to the ReorderableListView widget.

<DashImage figure src="images/0uxIQpd8XEMIsyePK.gif" alt="The ReorderableListView now has grab handles for easy drag ’n’ drop with a mouse" caption="The ReorderableListView now has grab handles for easy drag ’n’ drop with a mouse" />


The ReorderableListView was always good at moving items around with very little effort on your part as a developer, but it required the user to initiate a drag using a long-press. That made sense on a mobile device, but few desktop users would think to long-press on an item with their mouse to move it around, so this release includes a grab handle suitable for mouse or touch input. Another improvement for platform-idiomatic functionality is [an updated scrollbar](https://github.com/flutter/flutter/pull/71664) that shows up correctly for the desktop form-factor.

<DashImage figure src="images/0n6Lap1ZNfF-RL-Dd.gif" alt="This release includes an updated Scrollbar widget that works great in a desktop environment" caption="This release includes an updated Scrollbar widget that works great in a desktop environment" />


The Scrollbar widget has been updated to provide the interactive features that are expected on the desktop, including the ability to drag the thumb, click on the track to page up and down, and to show a track when the mouse hovers over any part of the scrollbar. Furthermore, since the Scrollbar is themeable using [the new ScrollbarTheme class](https://api.flutter.dev/flutter/material/ScrollbarTheme-class.html), you can style it to match your app’s look and feel.

For additional desktop-specific functionality, this release also enables command-line argument handling for Flutter apps so that simple things like a double-click on a data file in the Windows File Explorer can be used to open the file in your app. We’ve also worked hard to make resizing much smoother for both [Windows](https://github.com/flutter/engine/pull/23701) and [macOS](https://github.com/flutter/engine/pull/23924), and to enable IME (Input Method Editors) for international users.

<DashImage figure src="images/0W1aGfw-fJXfFiqWR.gif" alt="Flutter desktop now supports intuitive IME input" caption="Flutter desktop now supports intuitive IME input" />


In addition, we have provided [updated docs on what you need to do to begin preparing your desktop app for deployment to the appropriate OS-specific stores](https://flutter.dev/desktop#distribution). Give them a try and please provide feedback if we’ve missed anything.

When it comes to trying the beta for Flutter desktop, you can access it by switching to the beta channel as expected as well as setting the config flags for the platforms you’re targeting according to [the directions on flutter.dev](https://flutter.dev/desktop#create-a-new-project). In addition, we’ve also made a snapshot of the beta bits available on the stable channel. If you use ‘flutter config’ to enable one of the desktop config settings (for example, `enable-macos-desktop`), then you can try out the beta functionality of the desktop support w/o having to go through the lengthy process of moving to the beta channel and pulling down all the latest beta of the Flutter SDK, building the tools, etc. This is great for giving it a try or using the desktop support as a simple “Flutter Emulator.”

However, if you choose to stay on the stable channel to access the desktop beta, you won’t get new features or bug fixes as quickly as switching to the beta or dev channels. So, if you’re actively targeting Windows, macOS, or Linux, we recommend switching to a channel that provides updates more quickly.

As we approach our first full production-quality release of Flutter desktop, we know we have more to do, including support for integration with native top-level menus, text editing that feels more like the experience of the individual platforms, and accessibility support, as well as general bug fixes and performance enhancements. If there are other things you think need doing before the desktop moves to production quality, [please be sure to provide your feedback](http://github.com/flutter/flutter/issues).

## Platform Adaptive Apps: Flutter Folio Sample

Now that Flutter supports three platforms for production apps (Android, iOS, and the web) and three more in beta (Windows, macOS, and Linux), a natural question arises: how do you write an app that adapts itself *well* to multiple different form factors (small, medium, and large screens), different input modes (touch, keyboard, and mouse) and different idioms (mobile, web, and desktop)? To answer this question for ourselves as well as for Flutter developers everywhere, we commissioned the Flutter Folio scrapbooking app.

<YoutubeEmbed id="x4xZkdlADWo" title="Flutter Folio Trailer" fullwidth="true"/>


Folio is meant to be a simple example of an app that you’d want to run well on multiple platforms from a single code base. And by “well,” we mean that it looks good on small, medium, and large screens, that it takes advantage of touch, keyboard, and mouse input, and that it works well for the idioms of the platform, (for example, by using links on the web and menus on desktop). We call this kind of app “platform adaptive” because it adapts well to whatever platform it’s running on.

If you’d like to see how you can make your own apps platform adaptive, you can check out [the source code for Folio](https://github.com/gskinnerTeam/flutter-folio). In the future, expect to find docs and codelabs that explore this topic more deeply. In the meantime, check out Aloïs Deniel’s [excellent blog post and video](https://aloisdeniel.com/#/posts/adaptative-ui) on this very topic.

## Google Mobile Ads to Beta

In addition to Flutter desktop moving to beta, today we’re excited to announce an open beta for[ Google Mobile Ads SDK for Flutter](https://pub.dev/packages/google_mobile_ads). This is a brand new plugin that provides inline banner and native ads, in addition to the existing overlay formats (overlay banner, interstitial, and rewarded video ads). This plugin unifies support for Ad Manager and Admob, so no matter what size publisher you are, this plugin can be tailored to your scenarios.

<DashImage figure src="images/0h4J8qtxzJXTg769G.png" />


We’ve been piloting this plugin with some of our early customers in a private beta program, and many of them have successfully launched their apps with these new formats. For example, Sua Musica (largest Latin American music platform for independent artists with more than 15k verified artists and 10M MAU) launched their new Flutter app with the Google Mobile Ads SDK for Flutter plugin. They saw an 350% increase on Impressions with a 43% increase on CTR and 13% increase on eCPM.

This [plugin](https://pub.dev/packages/google_mobile_ads) is available for you to use today. As part of Flutter Engage, Andrew Brogdon and Zoey Fan presented a session on “Monetizing apps with Flutter” ([available on the Flutter Engage](http://goo.gle/EngageOnDemand) site), where they talk about monetization strategies for apps built with Flutter, and how you can load ads in your Flutter app. Moreover, we created a new [Ads](http://flutter.dev/ads) page on flutter.dev where you can find all helpful resources such as the [plugin implementation guide](https://developers.google.com/admob/flutter), the [inline banner and native ads](https://codelabs.developers.google.com/codelabs/admob-inline-ads-in-flutter) codelab, and the [overlay banner, interstitial and rewarded video ads](https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter#0) codelab. Please be sure to check them out!

## New iOS features

Just because we’re continuing to increase the quality of support for other platforms, don’t think we’re forgetting iOS. In fact, this release brings with it 178 PRs merged that are iOS-related, including [23495](https://github.com/flutter/engine/pull/23495), which brings State Restoration to iOS, [67781](https://github.com/flutter/flutter/pull/67781), which fulfills a long-standing request to build an IPA directly from the command line without opening Xcode, and [69809](https://github.com/flutter/flutter/pull/69809), which updates the CocoaPods version to match the latest tooling. In addition, a few iOS widgets have been added to the Cupertino design language implementation.

A new [CupertinoSearchTextField](https://api.flutter.dev/flutter/cupertino/CupertinoSearchTextField-class.html) offers the iOS search bar UI.

<DashImage figure src="images/0sm8nQOLfY63_D6p8.png" />


The [CupertinoFormSection](https://api.flutter.dev/flutter/cupertino/CupertinoFormSection-class.html), [CupertinoFormRow](https://api.flutter.dev/flutter/cupertino/CupertinoFormRow-class.html), and [CupertinoTextFormFieldRow](https://api.flutter.dev/flutter/cupertino/CupertinoTextFormFieldRow-class.html) widgets make it easier to produce validated form fields with iOS’s sectioned visual aesthetics.

<DashImage figure src="images/0HwoWeVZall4b0VB5.png" />


In addition to the feature work for iOS, we’re continuing to [research performance improvements](https://github.com/flutter/flutter/issues/60267#issuecomment-762786388) for iOS and Flutter in general when it comes to shaders and animation. iOS continues to be a premier platform for Flutter and we’ll continue to work to bring important new features and performance improvements.

## New widgets: Autocomplete and ScaffoldMessenger

This release of Flutter comes with two additional new widgets, AutocompleteCore and ScaffoldMessenger. [AutocompleteCore](https://github.com/flutter/flutter/pull/62927) represents the minimal functionality required to get auto-complete functionality into your Flutter app.

<DashImage figure src="images/03GGvtXibNB3-X8jA.gif" />


Autocomplete is an often-requested feature for Flutter, so this release starts to provide this functionality. You can use it today, but if you’re curious about the design for the complete feature, check out [the autocomplete design document](https://docs.google.com/document/d/1fV4FDNdcza1ITU7hlgweCDUZdWyCqd-rjz_J7K2KkfY/).

Likewise, [the ScaffoldMessenger](https://github.com/flutter/flutter/pull/64101) was created to deal with a number of SnackBar-related issues, including the ability to easily create a SnackBar in response to an AppBar action, creating SnackBars to persist between Scaffold transitions, and being able to show SnackBars at the completion of an asynchronous action, even if the user has navigated to a page with a different Scaffold.

<DashImage figure src="images/0vGJ5uq6V58RaGO5o.gif" />


All of this goodness can be yours with a couple of lines of code that you should be using from now on to display your SnackBars:

```
final messenger = ScaffoldMessenger.of(context);
messenger.showSnackBar(SnackBar(content: Text(‘I can fly.’)));
```


As you might imagine, there’s more to it than that; for the details, check out [an excellent video from Kate Lovett on ScaffoldMessenger](https://www.youtube.com/watch?v=sYG7HAGu_Eg).

## Multiple Flutter instances with Add-to-App

We know from talking with many Flutter developers that a significant number of you don’t have the luxury of starting a brand new app but you *can* take advantage of Flutter by adding it to your existing iOS and Android apps. This feature, called [Add-to-App](https://flutter.dev/docs/development/add-to-app), is an excellent way to reuse your Flutter code across both mobile platforms while still preserving your existing native code base. However, for those of you doing that, we’ve sometimes heard that it’s unclear how to go beyond integrating the first screen into Flutter. Interweaving Flutter and native screens makes navigation states difficult to maintain, and integrating multiple Flutters at the view level uses a lot of memory.

In the past, additional Flutter instances had the same memory cost as the first instance. In Flutter 2, we’ve reduced the static memory cost of creating additional Flutter engines by ~99% to ~180kB per instance.

<DashImage figure src="images/0huNKqtnnHVtbYW3_.gif" />


The new APIs to enable this are in preview on the beta channel and are [documented on flutter.dev](https://flutter.dev/docs/development/add-to-app/multiple-flutters) along with [a set of sample projects demonstrating this new pattern](https://github.com/flutter/samples/tree/master/add_to_app/multiple_flutters). With this change, we no longer hesitate to recommend creating multiple instances of the Flutter engine in your native apps.

## Flutter Fix

Whenever any framework matures and gathers users with larger and larger code bases, the tendency over time is to avoid making any changes to the framework API to avoid breaking an increasing number of lines of code. With over 500,000 Flutter developers across a growing number of platforms, Flutter 2 is quickly falling into this category. However, for us to continue to improve Flutter over time, we want to be able to make breaking changes to the API. The question becomes, how to continue to improve the Flutter API without breaking our developers?

Our answer is [Flutter Fix](http://flutter.dev/docs/development/tools/flutter-fix).

Flutter Fix is a combination of things. First, there’s a new command-line option to the `dart` CLI tool called `dart fix`that knows where to look for a list of deprecated APIs and how to update code using those APIs. Second, it’s the list of available fixes itself, which is bundled with the Flutter SDK as of version 2. And finally, it’s an updated set of Flutter extensions for the VS Code, IntelliJ,and Android Studio IDEs that know how to expose that same list of available fixes as quick fixes with little light bulbs that will help you to change the code with a click of your mouse.

As an example, let’s say you had the following line of code in your app:

<DashImage figure src="images/1Ky80dLtF0OQ81U3ohMc5jg.png" alt="Creating a Flutter widget using a deprecated argument" caption="Creating a Flutter widget using a deprecated argument" />


Because the argument to this constructor is deprecated, it should be replaced with the following:

<DashImage figure src="images/1CsdmVrVcS7jYSBzldzIzzg.png" alt="Creating a Flutter widget with the deprecated argument replaced" caption="Creating a Flutter widget with the deprecated argument replaced" />


Even if you’re familiar with all of the many Flutter deprecations, the larger the number of changes you have to make in your code, the harder it is for you to apply all of the fixes and the easier it is to make mistakes; humans are not great at these kinds of repetitive tasks. But computers are; by executing the following command, you can see all of the fixes we know how to make across your entire project:

```
$ dart fix --dry-run
```


If you’d like to apply them in bulk, you can easily do so:

```
$ dart fix --apply
```


Or, if you’d like to apply these fixes interactively in your favorite IDE, you can do that, too.

<DashImage figure src="images/0I9GWJb-XsUhJUKrH.png" />


While we’ve been marking old APIs as deprecated for a number of years now, now that we have [a policy about when we will actually remove deprecated APIs](https://medium.com/flutter/deprecation-lifetime-in-flutter-e4d76ee738ad), Flutter 2 is the first time that we’ve done so. Even though we haven’t yet captured all of the deprecated APIs as data to feed Flutter Fix, we continue to add more from previously deprecated APIs and will continue to do so with future breaking changes. Our goal is to do our best to make Flutter’s API the best it can be while also keeping your code up to date as we do it.

## Flutter DevTools

To make it clear that DevTools is a tool that should be used for debugging your Flutter apps, we’ve renamed it to be Flutter DevTools when it’s debugging a Flutter app. In addition, we’ve done a lot of work to bring it to production quality worthy of Flutter 2.

One new feature that helps you zero in on your issues even before you’ve launched DevTools is the ability for Android Studio, IntelliJ, or Visual Studio Code to notice when there’s a common exception and offer to bring it up in DevTools to help you debug it. For example, the following shows an overflow exception has been thrown in your app, which brings up an option in Visual Studio Code to debug the issue in DevTools.

<DashImage figure src="images/0O7zZDDpTc9cK-2X0.png" alt="The Flutter IDE extensions notice when your app throws a layout overflow exception" caption="The Flutter IDE extensions notice when your app throws a layout overflow exception" />


Pressing that button brings you right to the Flutter Inspector in DevTools on the widget that’s causing the trouble so you can fix it. We’re only doing this for layout overflow exceptions today but our plan is to include this kind of handling for all kinds of common exceptions for which DevTools can be the solution.

Once you’ve got DevTools running, new error badges on the tabs help you track down specific issues in your app.

<DashImage figure src="images/0q1ug8VRx6ewqU_Ks.png" alt="The red dots in DevTools helps you focus on the parts of your app with errors" caption="The red dots in DevTools helps you focus on the parts of your app with errors" />


Another new feature in DevTools is the ability to easily see an image that’s at a higher resolution than it’s displayed, which helps track down excessive app size and memory usage. To enable this feature, enable the Invert Oversized Images in the Flutter Inspector.

<DashImage figure src="images/0xoGJox6uQxSbN3G3.png" alt="Enable the “Invert Oversized Images” option to highlight images that are bigger than they need to be" caption="Enable the “Invert Oversized Images” option to highlight images that are bigger than they need to be" />


Now, when you display an image that’s significantly larger in resolution than its display size, it will appear upside-down to make it easy to find in your app.

<DashImage figure src="images/0gqIT_20hrbHlG8d_.png" alt="The “Invert Oversized Images” option in action" caption="The “Invert Oversized Images” option in action" />


Also, by popular demand, in addition to showing details about flexible layouts in the Flutter Inspector’s Layout Explorer, we’ve added the capability to show fixed layouts as well, enabling you to debug layouts of all kinds.

<DashImage figure src="images/0oW2lFF9KTVUTaXeo.png" alt="The new Layout Explorer shows layout details for fixed as well as flex layouts" caption="The new Layout Explorer shows layout details for fixed as well as flex layouts" />


And that’s not all. Here’s just a summary of a few more of the new features in Flutter DevTools 2:

* Added average FPS information and usability improvements to the Flutter frames chart

* Calling out failed network requests in the network profiler with red error labels

* New memory view charts are faster, smaller and easier to use, including a new hovercard to describe activity at a specific time

* Added search and filtering to the Logging tab

* Track logs from before DevTools is started so you can see the complete logging history when you do start it up

* Renamed the “Performance” view to “CPU Profiler” to make it more clear what functionality it provides

* Added timing grid to CPU Profiler flame charts

* Renamed the “Timeline” view to “Performance” to make it more clear what functionality it provides

And that’s *still* not all. For the full set of changes, I recommend the following announcements:

* DevTools [0.9.4](https://groups.google.com/g/flutter-announce/c/mx_hBxuXM9Q/m/Kjy9dqS3AAAJ)

* DevTools [0.9.5](https://groups.google.com/g/flutter-announce/c/mNqTNPUwBKw/m/_1qyXwTBAQAJ)

* DevTools [0.9.6](https://groups.google.com/g/flutter-announce/c/Ta5HR39P3go/m/2a43w7iSCwAJ)

* DevTools [0.9.7](https://groups.google.com/g/flutter-announce/c/IJ97oJ2HpxM/m/909J9Kl8AQAJ)

* DevTools [2.0](https://groups.google.com/g/flutter-announce/c/0xQhJR4nQbI)

## Android Studio/IntelliJ Extension

The Flutter plugin for the IntelliJ family of IDEs has gained a number of new features for Flutter 2 as well. To start, there’s a new project wizard, which matches the new wizard style in IntelliJ.

<DashImage figure src="images/0RPj9uHm2n8Zx1w1X.png" />


<DashImage figure src="images/0vu31pLbeCjWZvvJI.png" />


Also, if you’re using IntelliJ or Android Studio on Linux to program against the [Flutter SDK installed from the Snap Store](https://snapcraft.io/flutter), the Flutter snap path has been added to the list of known SDK paths. This makes it easier for users of the Flutter snap to configure the Flutter SDK in Settings. Thanks to MarcusTomlinson@ for this contribution!

<DashImage figure src="images/0N86bmi_l8Zx-UOnE.png" alt="Android Studio on Linux is easier to use with the Flutter SDK installed via Snap" caption="Android Studio on Linux is easier to use with the Flutter SDK installed via Snap" />


There’s a lot more good stuff you can read about in the announcements for the recent updates:

* IntelliJ Plugin [M51](https://groups.google.com/g/flutter-announce/c/w65rD73R83Q/m/gV5p0qf2AAAJ)

* IntelliJ Plugin [M52](https://groups.google.com/g/flutter-announce/c/tQqqMOIg6V0/m/wj7Kbv4-AgAJ)

* IntelliJ Plugin [M53](https://groups.google.com/g/flutter-announce/c/V335xbsPWUs/m/14LSp05kAQAJ)

* IntelliJ Plugin [M54](https://groups.google.com/g/flutter-announce/c/-jYDrwG7PmA)

## Visual Studio Code Extension

The Flutter extension for Visual Studio Code has improved for Flutter 2 as well, starting with a number of testing enhancements, including the ability to re-run just failed tests.

<DashImage figure src="images/0htJEMRQ54MN7hfcl.png" />


After two years in development, the LSP (Language Server Protocol) support for Dart is rolling out now as the default way to get to the Dart analyzer for integration into Visual Studio Code for the Flutter extension. The LSP support enables a number of improvements for Flutter development, including the ability to apply all fixes of a certain kind in the current Dart file and to cause code completion to generate complete function calls, including parenthesis and required arguments.

<DashImage figure src="images/0YRyYVK1ObQ252jSL.gif" />


<DashImage figure src="images/0eQD12Fr7liueGZXF.gif" />


And the LSP support isn’t just for Dart; it also supports code completion in the `pubspec.yaml` and `analysis_options.yaml` files.

<DashImage figure src="images/0IOR7QJ3FOqaGWIn9.gif" />


These are just a few of the updates that the Visual Studio Code extension for Flutter has enjoyed recently. You can read the full list in these announcements:

* Visual Studio Code Plugin [v3.16](https://dartcode.org/releases/v3-16/)

* Visual Studio Code Plugin [v3.17](https://dartcode.org/releases/v3-17/)

* Visual Studio Code Plugin [v3.18](https://dartcode.org/releases/v3-18/)

* Visual Studio Code Plugin [v3.19](https://dartcode.org/releases/v3-19/)

* Visual Studio Code Plugin [v3.20](https://dartcode.org/releases/v3-20/)

## DartPad updated to support Flutter 2

This list of tooling updates would not be complete without a mention of DartPad, which has been updated to support Flutter 2.

<DashImage figure src="images/02bw4yhTolgWmIv1V.png" alt="DartPad has been updated for Flutter 2" caption="DartPad has been updated for Flutter 2" />


Now you can try the new null safe version of Flutter without leaving the comfort of your favorite browser.

## Ecosystem updates

The Flutter development experience includes more than the framework and the tools; it also includes the wide range of packages and plugins available for Flutter apps. In the time since the last Flutter stable release, much has happened in that space as well. For example, between the camera and the video_player plugins, nearly 30 PRs have been merged to greatly increase the quality of both. If you’ve had trouble using either of these in the past, you should have another look; we think you’ll find them much more robust.

Also, if you’re a Firebase user, we are pleased to announce that the most popular plugins have been brought to production quality, including null safety support, and [a full set of reference documentation and common usage tutorials](http://firebase.flutter.dev) for Android, iOS, web, and macOS. These plugins include the following:

* Core

* Authentication

* Cloud Firestore

* Cloud Functions

* Cloud Messaging

* Cloud Storage

* Crashlytics

Also, if you’re looking for crash reporting for your app, you may want to consider Sentry, which has [announced a new SDK for Flutter apps](https://blog.sentry.io/2021/03/03/with-flutter-and-sentry-you-can-put-all-your-eggs-in-one-repo/).

<DashImage figure src="images/0rGuUHqseWvUJ2FPl.png" alt="The Sentry crash reporting tool now supports Flutter" caption="The Sentry crash reporting tool now supports Flutter" />


With Sentry’s SDK for Flutter, you can be notified of errors that occur on Android, iOS, or native platforms in real-time. You can see the details in [the Sentry documentation](https://docs.sentry.io/platforms/flutter/).

In addition, if you haven’t yet seen [the Flutter Community “plus” plugins](http://plus.fluttercommunity.dev/), you’ll want to check them out. They’ve forked a number of the popular plugins initially developed by the Flutter team and have added null safety support, support for additional platforms and a whole new set of [documentation](https://plus.fluttercommunity.dev/docs/overview/) as well as beginning to fix appropriate issues from the flutter/plugins repository. This plugins include the following:

* Android Alarm+

* Android Intent+

* Battery+

* Connectivity+

* Device Info+

* Network Info+

* Package Info+

* Sensors+

* Share+

At this point, the set of Flutter-compatible packages and plugins numbers greater than 15,000, which makes it hard to find those you should consider first. For this reason, we publish the Pub Points (static analysis scoring), popularity rank, likes and, for exceptionally high quality, a special designation for those packages marked as a [Flutter Favorite](https://flutter.dev/docs/development/packages-and-plugins/favorites). In time for Flutter 2, we’ve added several new packages to the list of favorites:

* animated_text_kit

* bottom_navy_bar

* chopper

* font_awesome_flutter

* flutter_local_notifications

* just_audio

Congratulations to the authors of these packages! If you haven’t checked them out yet, or [the rest of the packages on the list](https://pub.dev/flutter/favorites), you should.

And last but certainly not least, for package authors or package users interested in whether the latest version of a package works on a recent version of Flutter, you’ll want to check out Codemagic’s new [pub.green](http://pub.green) site.

<DashImage figure src="images/0-Ichbk_jGmhmdj3B.png" alt="Codemagic’s new [pub.green](http://pub.green) site shows compatibility for the top packages with recent Flutter releases" caption="Codemagic’s new [pub.green](http://pub.green) site shows compatibility for the top packages with recent Flutter releases" />


The pub.green site tests the compatibility of Flutter and Dart packages available on pub.dev with different Flutter versions. Think of it as the “can I use” for Flutter. For more details, I recommend [the announcement blog post from the CodeMagic team](https://blog.codemagic.io/pub-green/).

## Breaking Changes

We’ve made the following breaking changes for Flutter 2, many of which can be automatically mitigated using the `dart fix` command or the quick fixes in your IDE of choice:

* [61366](https://github.com/flutter/flutter/pull/61366) Continue the clipBehavior breaking change

* [66700](https://github.com/flutter/flutter/pull/66700) Default FittedBox’s clipBehavior to none

* [68905](https://github.com/flutter/flutter/pull/68905) Remove nullOk parameter from Cupertino color resolution APIs

* [69808](https://github.com/flutter/flutter/pull/68908) Remove nullOk from Scaffold.of and ScaffoldMessenger.of, create maybeOf for both

* [68910](https://github.com/flutter/flutter/pull/68910) Remove nullOk parameter from Router.of and make it return a non-nullable value

* [68911](https://github.com/flutter/flutter/pull/68911) Add maybeLocaleOf to Localizations

* [68736](https://github.com/flutter/flutter/pull/68736) Remove nullOK in Media.queryOf

* [68917](https://github.com/flutter/flutter/pull/68917) Remove nullOk parameter from Focus.of, FocusTraversalOrder.of, and FocusTraversalGroup.of

* [68921 Remove nullOk parameter from Shortcuts.of, Actions.find, and Actions.handler](https://github.com/flutter/flutter/pull/68921)

* [68925](https://github.com/flutter/flutter/pull/68925) Remove nullOk parameter from AnimatedList.of and SliverAnimatedList.of

* [69620](https://github.com/flutter/flutter/pull/69620) Remove deprecated methods from BuildContex

* [70726](https://github.com/flutter/flutter/pull/70726) Remove the nullOk parameter from Navigator.of and add Navigator.maybeOft

* [72017](https://github.com/flutter/flutter/pull/72017) Remove deprecated CupertinoTextThemeData.brightness

* [72395](https://github.com/flutter/flutter/pull/72395) Remove deprecated [PointerEnterEvent, PointerExitEvent].fromHoverEvent

* [72532](https://github.com/flutter/flutter/pull/72532) Remove deprecated showDialog.child

* [72890](https://github.com/flutter/flutter/pull/72890) Remove deprecated Scaffold.resizeToAvoidBottomPadding

* [72893](https://github.com/flutter/flutter/pull/72893) Remove deprecated WidgetsBinding.[deferFirstFrameReport, allowFirstFrameReport]

* [72901](https://github.com/flutter/flutter/pull/72901) Remove deprecated StatefulElement.inheritFromElement

* [72903](https://github.com/flutter/flutter/pull/72903) Remove deprecated Element methods

* [73604](https://github.com/flutter/flutter/pull/73604) Remove deprecated CupertinoDialog

* [73745](https://github.com/flutter/flutter/pull/73745) Remove deprecated actionsForegroundColor from Cupertino[Sliver]NavigationBar

* [73746](https://github.com/flutter/flutter/pull/73746) Remove deprecated ButtonTheme.bar

* [73747](https://github.com/flutter/flutter/pull/73747) Remove span deprecations

* [73748](https://github.com/flutter/flutter/pull/73748) Remove deprecated RenderView.scheduleInitialFrame

* [73749](https://github.com/flutter/flutter/pull/73749) Remove deprecated Layer.findAll

* [75657](https://github.com/flutter/flutter/pull/74657) Remove vestigial nullOk parameter from Localizations.localeOf

* [74680](https://github.com/flutter/flutter/pull/74680) Remove nullOk from Actions.invoke, add Actions.maybeInvoke

## Summary

In closing, from all of us here on the Flutter Team at Google we want to say — thank you. Thank you ×150,000 for the more than 150,000 Flutter apps launched in the community in just the past two years. In case you missed it, we compiled a few of our favorite Flutter apps in this Mashup Video dedicated to you, the community, played at the opening of the Flutter Engage keynote.

<YoutubeEmbed id="A3ltMaM6noM" title="- YouTube" fullwidth="true"/>


Without your continued support and excitement for what we’re all creating, it wouldn’t have been possible to become one of the most vibrant global developer communities in the world. We can’t wait to see what you’ll build next.