---
title: "Announcing Flutter 1.12: What a year!"
description: "Posted by Chris Sells, Product Manager, Flutter developer experience"
publishDate: 2019-12-11
author: csells
image: images/1sW6TueDcNzw806cjigLJaA.webp
category: release
layout: blog
---

Today we’re pleased to announce version 1.12, the latest stable Flutter release. This makes 5 stable releases since our 1.0 release in December, 2018. It’s been an amazing year! We’ve closed 5,303 issues and merged 5,950 pull requests from 484 contributors. In the Flutter engine and framework, we’ve added support for Android App Bundles, iOS 13, implemented mouse and keyboard events, released the In-App Purchase plugin, merged [several](https://github.com/flutter/engine/pull/12385) [important](https://github.com/flutter/flutter/pull/36482) [performance](https://github.com/flutter/engine/pull/10182) [improvements](https://github.com/flutter/flutter/pull/37275), localized for 24 additional locales and created several new widgets. Furthermore, the Flutter tools have seen a great deal of improvement as well, with the release of Dart DevTools, which provides the widget inspector, memory and CPU profiling, and enhanced logging that can be used regardless of your editor/IDE of choice. Also, we’ve added auto-import of packages for referenced types, explicit ChromeOS support, UI Guides to make your build methods easier to read and write, and improved error messages with formatting, colors and more actionable wording.

And with each release, we’ve said the same thing — that we’re just getting started. This continues to be true in this, our biggest release yet, coming from 188 contributors, closing 4,571 issues and merging 1,905 PRs. As in previous releases, enhancements abound for both the Flutter framework, and the tooling.

## Flutter framework

This release includes a visual refresh to support iOS 13 that includes completed implementation of Dark Mode, new Cupertino widgets, several UX tweaks, and a greatly enhanced Add-to-App experience.

## iOS 13 dark mode completed

More big news in Flutter 1.12 is the completion of our work to support the iOS 13 look and feel. This includes complete dark mode support in the Cupertino widgets.

<DashImage figure src="images/1sW6TueDcNzw806cjigLJaA.webp" />

If you’ll notice in the screen shots above, dark mode support is much more than just swapping out the background color, but also adapting the rest of the colors to be a good match. Such deep attention to dark mode was a huge amount of work, but worth it to get pixel-perfect iOS design support across both dark and light mode.

Also, in our continuing goal for pixel-perfection for iOS 13, we’ve added two new widgets.

<DashImage figure src="images/1seN7hLXrHJDEN3lH-IBZmw.webp" alt="[CupertinoContextMenu](https://api.flutter.dev/flutter/cupertino/CupertinoContextMenu-class.html) and [CupertinoSlidingSegmentedControl](https://api.flutter.dev/flutter/cupertino/CupertinoSlidingSegmentedControl-class.html)" caption="[CupertinoContextMenu](https://api.flutter.dev/flutter/cupertino/CupertinoContextMenu-class.html) and [CupertinoSlidingSegmentedControl](https://api.flutter.dev/flutter/cupertino/CupertinoSlidingSegmentedControl-class.html)" />

And finally, in our quest to make a Flutter app feel as well as look native on iOS 13, we’ve [improved scrollbar fidelity](https://github.com/flutter/flutter/pull/41799), [provided for adaptive CupertinoAlertDialog padding](https://github.com/flutter/flutter/pull/42967), and [allowed for min/max date constraints on the CupertinoDatePicker](https://github.com/flutter/flutter/pull/44149).

## Add-to-App updated

Another improvement in our mobile support is an update to Add-to-App, which is the ability to integrate Flutter into an existing Android or iOS app. Here, we’ve been working on simplifying the integration flow to make adding a Flutter library to your app a better experience, including the addition of a new Flutter Module wizard in Android Studio.

<DashImage figure src="images/0bzkdx2Ls7IbhP1NZ.webp" />

With Flutter 1.12, Add-to-App is now officially supported for adding one fullscreen Flutter instance to your app. In supporting this functionality, we’ve also:

* Stabilized the APIs for platform integration in Java, Kotlin, Objective-C and Swift, including a new set of APIs for Android. See [the Android project migration docs](https://flutter.dev/go/android-project-migration) for details on changes.

* Added support for using plugins in embedded Flutter modules.

* Provided additional integration mechanisms via [Android AARs](https://flutter.dev/docs/development/add-to-app/android/project-setup#option-a---depend-on-the-android-archive-aar) and [iOS Frameworks](https://flutter.dev/docs/development/add-to-app/ios/project-setup#option-b---embed-frameworks-in-xcode) for better compatibility with existing build systems.

* Reworked the ‘flutter attach’ mechanism on the command-line tools, VSCode and IntelliJ plugins to easily attach onto a running Flutter module for debugging, DevTools and hot reload.

To try Add-to-App, see the [website documentation](https://flutter.dev/docs/development/add-to-app) or browse our [sample projects](https://github.com/flutter/samples/tree/master/experimental/add_to_app) demonstrating various integration scenarios.

## Dart 2.7

Of course, everything we do in Flutter is based on Dart, so if you haven’t already read about extension methods and safe string handling (including emojis), or want an update on null safety using non-nullable types, you can find that information in the [Dart 2.7 announcement](https://medium.com/dartlang/dart-2-7-a3710ec54e97).

## Beyond Flutter 1.12 stable

At the same time that Flutter is getting new features in the stable channel, it’s also getting new features beyond what you can do in stable, specifically a beta release of web support and an alpha release of macOS support.

## Web support available in beta

The Flutter 1.12 master, dev and beta channels all provide improved support for web.

<DashImage figure src="images/0KNWOPgP4ZIQaobWo.webp" />

One happy customer of Flutter on the web is [Rivet](https://rivet.area120.com/link/flutter), pictured above. Rivet is an education project that currently has a mobile app in production. They’re using Flutter and Firebase to build a web version of their app that they plan to launch in early 2020.

You can learn more about what other customers are doing with Flutter’s web support as well as the rest of the details in the [Flutter web blog post](https://medium.com/flutter/web-support-for-flutter-goes-beta-35b64a1217c0).

## macOS moving to alpha

macOS desktop support isn’t far behind, moving from tech preview to alpha, available now in both master and dev channels (in Flutter SDK 1.13).

<DashImage figure src="images/02cmIipg-JivBAlRW.webp" />

Pictured here at desktop size is [a new version of the Flutter Gallery](https://flutter.github.io/samples/#/) that’s been completely updated to support macOS in addition to Android, iOS, and web.

The macOS alpha represents a big step forward for Flutter’s desktop support, including the new DataTree and Split sample widgets, several plugins ported to macOS, support for building in both release and profiling mode, and a greatly simplified tooling story. If you’re running from the dev or master channel, you can gain access to the macOS tooling by enabling macOS desktop support in Flutter’s system-wide config:

`$ flutter config --enable-macos-desktop`

Creating a Flutter project that runs on macOS is now just like creating any other new Flutter project with ‘flutter create’.

<DashImage figure src="images/00IEDbMjBcAYcEayr.webp" alt="Notice the new macos directory created by default" caption="Notice the new macos directory created by default" />

In addition to the tooling support, we’ve also been working on the density that’s appropriate for desktop-sized apps. Mobile apps need relatively large controls to accommodate touch interactions whereas on desktop-sized devices, a user is more likely to be using a mouse. In bringing Flutter to the desktop, we’ve worked on allowing you to choose the density of your widgets to better accommodate the needs of your desktop users:

<DashImage figure src="images/0lz9RcWYLigKtCaFp.gif" alt="[Sample](https://github.com/gspencergoog/density_sample) demonstrating Flutter’s implementation of [the Material Density guidelines](https://material.io/design/layout/applying-density.html)" caption="[Sample](https://github.com/gspencergoog/density_sample) demonstrating Flutter’s implementation of [the Material Density guidelines](https://material.io/design/layout/applying-density.html)" />

And finally, to improve the experience of Flutter desktop apps, we’ve done a lot of work on keyboard navigation and keyboard access, including:

* [synchronizing modifier keys with key events](https://github.com/flutter/flutter/pull/43948)

* [managing item selection when a dropdown is opened](https://github.com/flutter/flutter/pull/43722)

* [adding a convenience accessor for primary focus](https://github.com/flutter/flutter/pull/43859)

* [adding keyboard navigation, hover and shortcuts for switches](https://github.com/flutter/flutter/pull/43384)

* [checkboxes and radio buttons](https://github.com/flutter/flutter/pull/43384)

* [automatic scrolling to keep focused items in view](https://github.com/flutter/flutter/pull/44965)

* [keyboard shortcut-based scrolling](https://github.com/flutter/flutter/pull/45019)

* [a new widget for handling focus and hover](https://github.com/flutter/flutter/pull/44867)

* [rewritten copy/paste and keyboard selection](https://github.com/flutter/flutter/pull/44130)

* [keyboard navigation of dropdowns](https://github.com/flutter/flutter/pull/42811)

* [visual density support](https://github.com/flutter/flutter/pull/43547)

* [adding macOS function key support](https://github.com/flutter/flutter/pull/44410)

In addition to the Flutter sample, we also recommend [the new Photos Search sample](https://github.com/flutter/samples/tree/master/experimental/desktop_photo_search), which shows off a lot of desktop goodness, including keyboard handling, the new widget density, the new plugins, and the new widgets.

For those of you curious about progress on Windows and Linux, they’re still in technical preview, but both benefit from a lot of the work to get macOS to alpha. We’ll share the updates to those platforms soon. For more details of where we are with desktop support in Flutter for macOS, Windows and Linux, please see [flutter.dev/desktop](https://flutter.dev/desktop).

## Flutter tooling

In addition to the Framework and Engine, we also have a lot to talk about for Flutter tooling. This includes a new version of DartPad with support for Flutter, augmented IntelliJ-based IDEs with a preview of a new feature we’re calling “Hot UI”, enhanced Dart DevTools with a new visual layout view, enabled simultaneous multi-device debugging in Visual Studio Code, improved the Android build process and better support for finding differences in rendered widgets between test runs.

## DartPad loves Flutter

If you aren’t already using [DartPad](https://dartpad.dev), you should try it out! It’s a great way to try Dart features without installing anything. Furthermore, with the new release of DartPad, now you get Flutter, too!

<DashImage figure src="images/0O2FY0bB-BCao1kH2.webp" />

The new DartPad leverages Flutter’s web support so that when you’re writing Flutter code on the left, you’re running a real, live Flutter (web) program on the right. The chief difference is that using DartPad, you can get started with Flutter without installing a thing.

In addition to the stand-alone DartPad playground, we’ve also started adding DartPad with Flutter support into our docs and in our codelabs (like [Basic Flutter layout concepts](https://flutter.dev/docs/codelabs/layout-basics) and [Implicit animations](https://flutter.dev/docs/codelabs/implicit-animations)), so that you can learn about Flutter from the comfort of your browser. For more information on DartPad, please check out our [DartPad announcement post](https://medium.com/dartlang/a-brand-new-dartpad-dev-with-flutter-support-16fe6027784).

## Build your widgets inline with Hot UI

If you install the Flutter tools locally on your own machine (and we hope you will), you’ll find a new feature previewed in the IntelliJ/Android Studio plugin for Flutter. It allows you to see and interact with your widgets directly in your IDE as you’re building them.

We call this feature “Hot UI” and, like Hot Reload, as you make the changes in your code, it updates the hosted UI directly. You can also interact with the hosted UI (like changing a color, as shown here) and that change goes directly into your code. To enable the Hot UI preview, you can [read the instructions on the Flutter wiki](https://github.com/flutter/flutter-intellij/wiki/HotUI-Getting-Started-instructions).

## Debug layout issues with the Layout Explorer

Whether you write the code by hand or let Hot UI write it for you, you’ve still got code and sometimes code has issues. Helping you track down and fix your issues is exactly why Dart DevTools was invented. In this new version of DevTools, we’ve added a feature called the “Layout Explorer” to augment the Inspector with a visual representation of your layout.

<DashImage figure src="images/0qQ342c4cR9qRce74.gif" />

Not only does the Layout Explorer help you to visualize the layout of the widgets in your running app, but if you’d like to experiment with changing the layout options, it allows you to do so interactively. We’re hoping the preview of this feature helps make it easier to understand and fix your layout issues. To enable this feature, see [the Layout Explorer docs](https://flutter.dev/docs/development/tools/devtools/inspector#flutter-layout-explorer).

## Multi-device debugging

When you’ve built and debugged your Flutter UI, you have most likely done it on a single device. Wouldn’t it be nice to be able to debug your app across multiple devices (physical or virtual) at the same time? With Flutter’s support for multi-session debugging in Visual Code, that’s just what you can do.

<DashImage figure src="images/1cEO7t2m1M3nH9RWx0CJtaQ.webp" />

Here we’ve got the same Flutter app running simultaneously on three separate debugging sessions. If we make a change in the code, Hot Reload makes sure that it’s reflected in all three apps. If we set a breakpoint, whichever app triggers that code gets stopped. If you’d like to stop debugging one, you can do so without stopping them all. You can learn how to configure this feature for [multiple device debugging on the wiki](https://github.com/flutter/flutter/wiki/Multi-device-debugging-in-VS-Code).

## Android build improvements

And finally, to continue to improve Android, we addressed some build problems in this release. Firstly, we made the Android build more robust, specifically around combining plugins using Support Libraries and those using AndroidX. We did this by moving the Flutter team’s plugins to AndroidX and [we recommend that apps and plugins move to AndroidX as well](https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration). However, for plugins that haven’t yet moved, if there is a build problem, we have an alternate code path in our build that uses Android Archive files and Jetifier. The build is slower, which is why it’s not the primary build mechanism, but we find that it solves about 95% of the build problems we’ve encountered.

Another issue we addressed was deprecating Proguard in favor of [R8](https://developer.android.com/studio/build/shrink-code), the new code optimizer from Google. Before this release, the app author had to configure ProGuard rules manually using guidance provided by the plugin author. In this release, plugins can define their rules in the source code and R8 consumes these rules automatically, saving the app developer that headache.

Furthermore, in our attempt to continue to make Flutter as slim as possible, we reduced the Hello, World app size for Android by 2.6% (reducing it from 3.8MB to 3.7MB). Every little bit helps!

## Golden image testing

The term “golden image” refers to a master image file that is considered the true rendering of a given widget, state, application, or other visual representation you have chosen to capture. In Flutter 1.12, we have implementations of the [GoldenFileComparator](https://api.flutter.dev/flutter/flutter_test/GoldenFileComparator-class.html) and [LocalFileComparator](https://api.flutter.dev/flutter/flutter_test/LocalFileComparator-class.html) classes that compare by pixels instead of bits, [eliminating false positives](https://github.com/flutter/flutter/issues/30036). These new implementations highlight visual differences to make it clear when there are differences between your golden image and the updates under testing.

<DashImage figure src="images/0RfJiqYXXSujb8WCs.webp" />

In this case, it’s clear that the differences between the master and the test image are all in the border, making it much easier to track down the discrepancy.

## Community

In addition to all of the work on Flutter and its associated tooling, the Flutter community continues to take Flutter into new and amazing directions! To see what developers in the community are doing, we’ve put together a little video.

<YoutubeEmbed id="tWCr9vlGz_8" title="Developers using Flutter around the world" fullwidth="true"/>

We’re so lucky to have such a great set of developers in the Flutter community. You make us all proud to be on the Flutter team!

## Flutter Favorite packages

When we released Flutter 1.0 in December, 2018, there were about 1000 packages on pub.dev that supported Flutter and we thought that was a huge number. As of this writing, that number has increased by more than 6x. With that many options, it’s sometimes hard to know which packages to choose. The overall score on pub.dev helps as well as the new [Verified Publishers](https://medium.com/dartlang/verified-publishers-98f05466558a) feature. Now, pub.dev is getting [a rating system](https://dart.dev/blog/announcing-dart-2-7-a-safer-more-expressive-dart#liking-packages-on-pub-dev), which should help even more.

Still, our users have asked again and again for a set of “recommended” packages and plugins. With that in mind, we’re pleased to announce [the Flutter Favorite program](https://flutter.dev/docs/development/packages-and-plugins/favorites).

<DashImage figure src="images/08Q2gB989P4yclIqD.webp" />

A Flutter Favorite package (or plugin) is one that we think that you should consider first when building your app. The “we” in that sentence is the Flutter Ecosystem Committee, a group of regionally-diverse individuals picked from the Flutter team at Google and from the Flutter community at large to address issues across the Flutter ecosystem. Their first job was to establish a high quality bar and to identify an initial set of packages that met that quality bar. The authors of those packages are able to use the Flutter Favorite logo in their package documentation. Furthermore, pub.dev has been updated to show the logo in search results and other places.

For details, see [the Flutter Favorite page on flutter.dev](https://flutter.dev/docs/development/packages-and-plugins/favorites). You can also see [the complete list of Flutter Favorite packages on pub.dev](https://pub.dev/flutter/favorites). The bottom line is that if you’re an app developer and you see that logo, you should have confidence in that package. If you’re a package author and you’ve been awarded the Flutter Favorite logo, thank you for your contribution to the Flutter ecosystem.

## Community tools

And speaking of contributions to be proud of, the Flutter community at large has been building a number of excellent tools as well; here’s just a selection.

<DashImage figure src="images/0mCfvSsh_GZmW2xYn.webp" alt="[Flutter Device Preview](https://github.com/aloisdeniel/flutter_device_preview)" caption="[Flutter Device Preview](https://github.com/aloisdeniel/flutter_device_preview)" />

<DashImage figure src="images/0ArEfmlujiPiVUD1v.webp" alt="[Widget Maker](https://www.widgetmaker.dev/)" caption="[Widget Maker](https://www.widgetmaker.dev/)" />

<DashImage figure src="images/1vJh-yghl3kJJdW0ZakbSzg.webp" alt="[Panache](https://rxlabz.github.io/panache/#/)" caption="[Panache](https://rxlabz.github.io/panache/#/)" />

## Featured tooling partner: Nevercode

In addition to a great set of community tools, the Flutter ecosystem has a great set of tooling partners as well. One notable partner has always been Nevercode, who have a whole new set of features in their latest release, including [a Visual Studio Code plugin called Remote Mac](https://marketplace.visualstudio.com/items?itemName=codemagic.remote-mac).

<DashImage figure src="images/0cmfHUry8I1ztX80M.webp" />

The Remote Mac extension lets you connect directly to a Mac that they’ve hosted in the cloud for purposes of testing your iOS and macOS Flutter code. For more details about Nevercode’s latest release, including new support for Flutter on the web and on macOS, new enterprise features and more, check out [their newest blog post](https://blog.codemagic.io/more-professional-capable-accessible/).

To see the progress being made by our other tooling partners, you should definitely [check out what Supernova, Rive and Adobe are up to in their latest releases](https://developers.googleblog.com/2019/12/flutter-ui-ambient-computing.html).

## Conclusion

This has definitely been a big year for Flutter and v1.12 is a big release. This blog post has been a whirlwind tour of what’s new in this release; if you’d like to check on your favorite pull release, see where we’ve been spending our time in this release by how many pull releases in each area or see what we broke, then we recommend [the Flutter 1.12 Release Notes](https://flutter.dev/docs/development/tools/sdk/release-notes/release-notes-1.12.13).

We hope you agree that Flutter is moving in the right direction and picking up speed. With all of these new features and new tools, where do you want your app to run today?
