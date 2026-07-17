---
title: "Announcing Flutter 1.17"
description: >-
  Includes Metal support for faster iOS performance,
  new Material components, new Network tracking tooling, and more!
publishDate: 2020-05-06
author: csells
image: images/14MIF2GwByNG1MJ7DNslb3Q.webp
category: release
layout: blog
---

*Posted by Chris Sells, Product Manager, Flutter developer experience*

Today we’re pleased to announce Flutter 1.17, our first stable release of 2020.

This year has been a challenging one for everyone. Our goal is to ship stable releases on a roughly quarterly cadence; however, this release took a little longer because we’ve been [retooling our infrastructure for a new release process](https://medium.com/p/f723d898d7af#d6e5). We continue to make quality our #1 priority and believe that the new release model will improve our ability to service the stable branch with quality hotfixes. This release is full of fixes, with an unprecedented 6,339 issues closed since our 1.12 stable release. A great deal of this increase is due to [our partnership with Nevercode](https://blog.codemagic.io/flutter-and-codemagic-join-forces-on-github/), which has given us increased responsiveness when it comes to responding to customer issues. So far this year, we’ve closed more bugs than have been opened, resulting in a net decrease of ~800 issues. Many of these bugs were fixed by the 3,164 PRs we merged from 231 contributors. These are huge numbers and our heartfelt thanks goes out to everyone for their hard work and continued contributions during this challenging time.

If you’re interested in the full list of PRs we’ve merged in this release, you can see that on [the flutter.dev site](https://flutter.dev/docs/development/tools/sdk/release-notes/changelogs/changelog-1.17.0). In addition to the quality improvements, we’ve managed to sneak some new features into this release as well, including Metal support on iOS, new Material components, new Network tracking tooling and more! This release also includes Dart 2.8, about which you can [read more on the Dart blog](https://medium.com/dartlang/announcing-dart-2-8-7750918db0a).

## Mobile performance and size improvements

A major focus of this release has been continued overall work on performance and memory improvements. Just by upgrading your app to this release, your users should see faster animations, smaller apps and lower memory utilization. In this release, you’ll see a [20%-37% speedup](https://github.com/flutter/flutter/pull/48900) for the default navigation case (opaque routes with no transparency). You’ll also see up to a 40% reduction in CPU/GPU usage for simple iOS animations, depending on the hardware (detailed in [PR 14104](https://github.com/flutter/engine/pull/14104) and in [PR 13976](https://github.com/flutter/engine/pull/13976)).

This release also provides a considerable app size improvement due to [several](https://github.com/dart-lang/sdk/commit/f56b0f690789b6f0e2e5bc1340abf4eba414b7a0) [fixes](https://github.com/dart-lang/sdk/commit/a2bb7301c5795e6b28089a8dc96e6ab5ca798e22) [that](https://github.com/dart-lang/sdk/commit/d77f4913a18ecce8c4be95cbaa4299ff1521dc10) [add](https://github.com/dart-lang/sdk/commit/e2faac751e1ef3707730e6e48f4d8f22ecbf35c3) [up](https://github.com/dart-lang/sdk/commit/8e7ffafbafc8203361111ddcafe0e0fcc372edf8) to a big result. For example, the Flutter Gallery sample for Android was 9.6MB at the end of 2019 and is now 8.1MB, which is an 18.5% reduction.

For memory usage, this release brings [a 70% memory reduction](https://github.com/flutter/engine/pull/14265) in fast scrolling through large images, which can also result in a performance increase depending on how much memory the device has.

<DashImage figure src="images/0vwCZv9MQd_BLv7ii.webp" alt="*Test app memory usage for PRs merged over time (shorter bars are better)*" caption="*Test app memory usage for PRs merged over time (shorter bars are better)*" />

However the broadest performance improvement is the support for Metal in iOS.

## Metal support improves performance by 50% on iOS

Apple’s support for Metal on iOS provides nearly direct access to the underlying GPU and is Apple’s recommended graphics API. On the iOS devices that fully support Metal, Flutter now uses it by default, making your Flutter apps run faster most of the time, increasing [rendering speeds by about 50% on average](https://github.com/flutter/flutter/issues/53768) (depending on your workload).

<DashImage figure src="images/0YPmVAVbn2SqtHpRF.webp" alt="*Test iOS app frame rendering time for OpenGL vs. Metal (shorter bars are better)*" caption="*Test iOS app frame rendering time for OpenGL vs. Metal (shorter bars are better)*" />

For the devices that don’t support Metal fully (those prior to the A7 processor or those running iOS versions prior to 10), Flutter uses OpenGL as it has in the past, providing native rendering speeds for older devices. For more details, check out [the Metal on iOS FAQ on the Flutter wiki](https://github.com/flutter/flutter/wiki/Metal-on-iOS-FAQ).

## Material widgets: NavigationRail, DatePicker and more

We continue to evolve and improve the Material design system implemented in Flutter, based on feedback from internal and external customers. In this release, we’ve added [`NavigationRail`](https://master-api.flutter.dev/flutter/material/NavigationRail-class.html), a new widget that offers a responsive app navigation model. It was [designed](https://material.io/components/navigation-rail) and implemented by the Google Material Design team. The `NavigationRail` is great for apps that can switch between mobile and desktop form factors because it’s very easy to swap in for a `BottomNavigator` as your app’s screen size increases.

<DashImage figure src="images/0qB_uRnhlu9bb2C5i.webp" alt="The new NavigationRail widget" caption="The new NavigationRail widget" />

To see the `NavigationRail` in action, check out [the web_dashboard sample](https://github.com/flutter/samples/tree/master/experimental/web_dashboard) or try it [on DartPad](https://dartpad.dev/b9c6cd345fd1cff643353c1f4902f888).

In addition to the new widget, this release includes updates to the Material [`DatePicker`](https://api.flutter.dev/flutter/material/showDatePicker.html) and text selection overflow widgets.

<DashImage figure src="images/1Iy0WlfOaCAvgFwWwe4SKwQ.webp" alt="Updated Material DatePicker widget" caption="Updated Material DatePicker widget" />

This `DatePicker` release includes new visuals to match the [updated Material guidelines](https://material.io/components/pickers/#mobile-pickers) as well as a new text input mode. You can read about the details in the [Material Date Picker Redesign](https://flutter.dev/go/material-date-picker-redesign) specification.

<DashImage figure src="images/0RMNYoiBJv-U3OC5C.gif" alt="Updated text selection overflow on Android" caption="Updated text selection overflow on Android" />

<DashImage figure src="images/0vaELGcqyjmgMMF7W.webp" alt="Updated text selection overflow on iOS" caption="Updated text selection overflow on iOS" />

The text selection menu now has improved fidelity for [Android](https://github.com/flutter/flutter/pull/49391) and [iOS](https://github.com/flutter/flutter/pull/54140) when the buttons are longer than can be displayed without overflow. This is particularly noticeable in locales where the menu item words can be longer.

In the same timeframe as Flutter 1.17 but delivered out-of-band, we have also shipped [the new Animations Package](https://pub.dev/packages/animations) that provides pre-built animations that implement [the new Material motion specification](https://material.io/design/motion/the-motion-system.html).

<DashImage figure src="images/14MIF2GwByNG1MJ7DNslb3Q.webp" alt="*Examples of Container transforms from the Animations package*" caption="*Examples of Container transforms from the Animations package*" />

In [the Implementing Motion blog post](https://medium.com/google-design/implementing-motion-9f2839002016), the Material Design team defines four transition patterns that describe animations between components and fullscreen views: Container transform, Shared axis, Fade through, and Fade. While these animations have always been possible in Flutter, the Animations package makes it considerably easier to implement them. Drop them into your app and delight your users today!

## Material Text Scale: Modernizing Flutter Text Theming

In this release, the Flutter team has completed their implementation of the [Type Scale portion of the 2018 Material Design specification](https://material.io/design/typography/the-type-system.html#type-scale) while not breaking existing Flutter apps. Opt-in support for the new configurations — but not the new names — was added in [PR 22330](https://github.com/flutter/flutter/pull/22330), in October 2018. The existing text style names were not changed because doing so was a breaking API change that would likely affect most applications. This release updates the TextTheme API to match the current Material spec, but maintains the old names so that your code doesn’t break. The old names have been deprecated however, so you will get warnings to encourage you to adopt the new names.

The names and configurations of the 2018 Material TextStyles are summarized by the following table.

<DashImage figure src="images/1Jlt_w6Bs7KAae42rYkFlwg.webp" />

Notice that the `TextStyles` called `body1` and `body2` in the Material Design specification are called `bodyText1` and `bodyText2` in the Flutter `TextTheme` API. Similarly, the `TextStyles` called `H1-H6` in the specification are called `headline1-headline6` in the `TextTheme` API.

## Google Fonts for Flutter

Text and fonts go hand in hand, so if you’re excited about the new Material Text Scale implementation, then you’re probably also going to be excited about [the new Google Fonts for Flutter v1.0 release](https://medium.com/flutter/introducing-google-fonts-for-flutter-v-1-0-0-c0e993617118).

<DashImage figure src="images/0_Vc08nu8x7JFksB0.gif" alt="Google Fonts are easy to use in your Flutter apps" caption="Google Fonts are easy to use in your Flutter apps" />

Google Fonts allows developers to easily experiment with and use any of the fonts from fonts.google.com in their app. When the app is ready to publish, the developer then decides whether the user receives the font by downloading it from the API, or it’s pre-bundled with the app package.

## Accessibility and Internationalization

Lastly, an important area of continued focus is accessibility, since we consider it a priority that Flutter apps are available to the broadest possible audience. In this release, we’ve done work across the board, including accessibility fixes for [scrolling](https://github.com/flutter/flutter/issues/43883), [text](https://github.com/flutter/flutter/issues/52487) [fields](https://github.com/flutter/flutter/issues/53065), and [other input widgets](https://github.com/flutter/flutter/issues/49259). You’ll see a full list of the accessibility issues closed in this release on [GitHub](https://github.com/flutter/flutter/issues?q=is%3Aclosed+is%3Aissue+label%3A%22a%3A+accessibility%22+closed%3A2019-11-25..2020-04-02). We encourage you to test your own apps for accessibility and have also updated our documentation in this release with [some recommended best practices](https://flutter.dev/docs/development/accessibility-and-localization/accessibility).

On the internationalization front, we’ve been working on some issues affecting Samsung keyboard IMEs that affected text input in various East Asian languages. We’re pleased to report that we’ve completed this work, and [Korean developers in particular should find a lot to celebrate](https://github.com/flutter/flutter/issues/42273) in this release.

## Tooling: Dart DevTools port to Flutter, Fast Start for Android and more

This release brings us very close to swapping out the current version of Dart DevTools with the new Flutter version. If you’d like to give it a try, start DevTools and click the “beaker” icon in the upper-right corner of DevTools.

<DashImage figure src="images/0vjV5MYcLgBJmj_Ix.webp" />

While you’re using the pre-release version of Dart DevTools implemented with Flutter, you’re likely to notice all kinds of improvements, but the biggest one is the new **Network** tab.

<DashImage figure src="images/1BitMBFadDAEiHFN5Al1mjQ.webp" />

If you’re not seeing the Network tab in the prerelease version of Dart DevTools (for example, if you’re running it from the command line), you can update it manually using the following command:

```bash
$ pub global activate devtools
```

The Network tab shows you network traffic for your Flutter app once you press the Record button. Further, if you’d like to catch network traffic starting immediately from when you start your app, you can include this line of code in your `main()` method:

```dart
void main() {
  // enable network traffic logging
  HttpClient.enableTimelineLogging = true;
  runApp(MyApp());
}
```

In addition to an updated Dart DevTools, this release also adds support for [an experimental “fast start” option](https://github.com/flutter/flutter/pull/46140), which allows you to start your Flutter app debugging as much as 70% faster when targeting Android. You can access this option via `flutter run --fast-start -d <your Android device>`. This option installs a generic Android app that only depends on your plugin code, excluding any Dart code or assets. This allows repeated `flutter run` commands to start up faster, since changes to Dart code or assets don’t require the APK to be rebuilt. This option bundles your app into a generic Android “wrapper” that doesn’t actually get installed on your device, which is different from our normal start options. Furthermore, there are some cases where it won’t work, e.g. when you’re using plugins that access background execution. On the other hand, if your Android debugging startup time is getting you down, give it a try.

Another change to note if you’re targeting Android is that now AndroidX is the only option when creating a new Flutter project. [AndroidX](https://developer.android.com/jetpack/androidx) libraries provide advanced Android functionality known as [Android Jetpack](https://developer.android.com/jetpack/?gclid=Cj0KCQjwka_1BRCPARIsAMlUmEpxmZqWZyO2NTx1F_aYYRm0EUtwl6Rlr2ViKXwZpsQKo7ailItPdJkaAhnNEALw_wcB). In the last release, we deprecated the original Android Support Library and moved to AndroidX as the default for all new projects. With this release, the --`androidx` flag to `flutter create` is now the only option available. While existing applications that don’t use AndroidX can continue to be compiled with Flutter, [now is a great time](https://flutter.dev/docs/development/androidx-migration) to migrate over to the new library.

If you’re an Android Studio or IntelliJ user, you’ll find that the Hot Reload feature is more resilient. Prior to this change, if you had any analysis errors, Hot Reload wouldn’t reload your code. This can be pretty frustrating if the analysis error is something that didn’t affect the code that you’re currently running, like in unit tests. With [this change](https://groups.google.com/forum/m/#!topic/flutter-announce/tTgQcTgqrKg), analysis errors aren’t enough to keep Hot Reload from working, depending instead on compiler errors from the VM.

If you’d like earlier access to changes like these in the Flutter plugin for Android Studio or IntelliJ, we now have a dev channel for the IntelliJ plugin that you may opt into for a faster cadence of updates. The goal with the Dev Channel is to gather feedback from Flutter developers on new IDE integration features before we make them more broadly available. If you’re adventurous and would like to provide early feedback to the Flutter tooling team, please [sign up today](https://groups.google.com/forum/m/#!topic/flutter-announce/tTgQcTgqrKg)!

For Visual Studio Code users, we recommend the new **Dart: List Outdated Packages** command that runs [the new ‘pub outdated’ command](https://medium.com/dartlang/announcing-dart-2-8-7750918db0a).

<DashImage figure src="images/0kfSA8iTjVjrsPIyG.webp" />

This command is meant to help you track down versioning issues in your dependencies.

Last but not least, if you find yourself with a Flutter crash, you’ll be prompted to file the bug by the tools.

<DashImage figure src="images/1OU1YDFMKeSUiaavoWohEUA.webp" />

These bug reports are closely watched by the team for severity and frequency, so please do log them when prompted.

## Customer Shoutout: MGM and Superformula

Of course, Flutter exists to enable beautiful application experiences. One example of a digital agency doing amazing things is [Superformula](https://superformula.com/flutter/), who has recently worked with MGM Resorts to deliver [a major update to their mobile application](https://www2.mgmresorts.com/app/), having completely rebuilt it in Flutter. They report that “adding Flutter to our core offerings has unlocked added speed and flexibility, which translates to real, measurable value for both our clients and their users.”

<DashImage figure src="images/0nT-kBS1YB0XqZE4C.webp" />

Superformula worked with the MGM Resorts design team to create a new MGM design language for all major web, mobile, and kiosk experiences. With a smaller team and all-new Flutter codebase, they were able to get the app rebuilt and shipped to both app stores much faster than they were able to before, resulting in a 9% increase in booking conversions for MGM.

## Breaking Changes

As always, we try to minimize the number of breaking changes with each new release of Flutter while still balancing our ability to ensure that Flutter provides an intuitive, flexible API that can support new idioms on new platforms. In [a user survey last year](https://medium.com/p/3659b02303a5#4bad), you told us that you were tolerant of carefully-considered breaking changes that improve the framework. So we’re continuing to gently evolve the API. These are the breaking changes in this release.

* [#42100](https://github.com/flutter/flutter/pull/42100) [Run secondary animation of previous route when using pushReplacement(…](https://groups.google.com/g/flutter-announce/c/y0SvesRHlcE/m/39TuR5FVDQAJ)

* [#45940](https://github.com/flutter/flutter/pull/45940) Deprecate UpdateLiveRegionEvent

* [#49389](https://github.com/flutter/flutter/pull/49389) Defer image decoding when scrolling fast

* [#49391](https://github.com/flutter/flutter/pull/49391) Text Selection Overflow (Android)

* [#49771](https://github.com/flutter/flutter/pull/49771) [Assert cache hints are not set for null painters](https://groups.google.com/g/flutter-announce/c/gDfazJIBdDo/m/d5AC8gR3FQAJ)

* [#50318](https://github.com/flutter/flutter/pull/50318) [Live image cache](https://groups.google.com/g/flutter-announce/c/IdfjYvRBR4c/m/1_JxffXTGAAJ)

* [#50354](https://github.com/flutter/flutter/pull/50354) [Use strut box heights to calculate selection rectangles in order to ensure that they remain within visible bounds](https://groups.google.com/g/flutter-announce/c/hVP699NQ7PQ/m/BgVgmsAdFwAJ)

* [#50733](https://github.com/flutter/flutter/pull/50733) Generate message lookup in gen_l10n

* [#51435](https://github.com/flutter/flutter/pull/51435) remove isinitialroute from RouteSettings

* [#52781](https://github.com/flutter/flutter/pull/52781) Move mouse_tracking.dart to rendering

* [#44930](https://github.com/flutter/flutter/pull/44930) [Navigator 2.0: Refactor the imperative api to continue working in the new navigation system](https://groups.google.com/g/flutter-announce/c/DSAeObWGpoY)

## Conclusion

As our mobile support continues to mature while we bring the [web closer to production quality](https://medium.com/flutter/flutter-web-support-updates-8b14bfe6a908), Flutter brings with it the promise of solving a problem that our industry has wrestled with for decades: how can you build great apps from a single source code base across multiple platforms? With all of the power and capability that Flutter provides, we think we’re on a good path to answer that question. What are you going to build?
