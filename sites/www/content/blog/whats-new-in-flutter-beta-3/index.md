---
title: "What’s New in Flutter Beta 3"
description: "This week marks the release of the third beta for Flutter, our toolkit for building beautiful mobile UI for iOS and Android. In our…"
publishDate: 2018-05-07
author: timsneath
image: images/0Sdp8z8g2G2spsW3j.png
category: releases
layout: blog
---

This week marks the release of the third beta for Flutter, our toolkit for building beautiful mobile UI for iOS and Android. In [our announcement over at the Google Developer site](https://developers.googleblog.com/2018/05/ready-for-production-apps-flutter-beta-3.html), we provide a broader overview of the Flutter project and showcase some examples of how customers are using it to create amazing applications. In this blog post, we’ll take a deeper look at the specific improvements we’ve made in Beta 3 itself.

As mentioned when we shipped [our first beta at Mobile World Congress](https://medium.com/flutter-io/announcing-flutter-beta-1-build-beautiful-native-apps-dc142aea74c0) in February, our intent is to continue to ship releases that are at least of beta quality on approximately a monthly cadence. This release (v0.3.2) is the third release in that lineage, and demonstrates continued progress towards completing the 1.0 release.

Our work in this release has focused on three primary areas: fundamentals, ecosystem and tooling.

### Fundamentals

Let’s start with the fundamentals, where we’ve improved the built-in UI widgets, completed the remaining feature work for Dart 2, and introduced a new embedding API.

In Flutter Beta 3, we’ve made a number of improvements to the **Material Design widgets** to enable greater flexibility and customization. For example:

* We added a [BottomAppBar](https://docs.flutter.io/flutter/material/BottomAppBar-class.html) component;

* Support for [Chips](https://docs.flutter.io/flutter/material/Chip-class.html) has been greatly improved and expanded;

* [InputDecorator](https://docs.flutter.io/flutter/material/InputDecorator-class.html) now supports filled/underlined and outlined modes;

* [FloatingActionButton](https://docs.flutter.io/flutter/material/FloatingActionButton-class.html) now offers greater positioning flexibility;

* [Slider](https://docs.flutter.io/flutter/material/Slider-class.html) now offers customization of colors and shapes of the thumb and value indicators.

Additionally, we’ve added support for animated resources in formats like GIF and WebP, ready for your best meme apps to be published to the app stores!

We also made a number of updates to the Flutter Gallery application to demonstrate these and other changes. For example:

* We’ve [updated the text fields d](https://github.com/flutter/flutter/pull/15362)emo to demonstrate the new InputDecorator features;

* We’ve added a new [Backdrop demo](https://github.com/flutter/flutter/pull/15579/);

* We’ve added demos for [OutlineButton](https://docs.flutter.io/flutter/material/OutlineButton-class.html) and the new Checkbox [tristate property](https://docs.flutter.io/flutter/material/Checkbox/tristate.html);

* We’ve added custom [selection indicators](https://github.com/flutter/flutter/pull/15323) to the scrollable tabs demo.

We’ve completed the work to enable **Dart 2**, [our reboot of the Dart language that is optimized for client development](https://medium.com/@asandholm/announcing-dart-2-80ba01f43b6). As of this release, Dart 2 is feature complete and enabled by default.

In this release, Dart 2 adds some syntactic sugar to help with instantiating widgets in Flutter. The *new* keyword is now entirely optional: there should be no need to use it any longer, and it’s a bug if the compiler complains. A *build()* method like this is easier than ever to write:

```dart
Widget build(BuildContext context) => Scaffold(
  appBar: AppBar(
    title: Text(widget.title),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.info),
        onPressed: _aboutAction,
      ),
      IconButton(
        icon: Icon(Icons.share),
        onPressed: _shareAction,
      )
    ],
  ),
  body: Center(
    child: _body(),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: _refresh,
    tooltip: 'Refresh',
    child: Icon(Icons.refresh),
  ),
);
```

The *const* keyword becomes optional for any child constructors within an existing *const* scope. During the first two betas, we identified scenarios where it was difficult to infer from the context whether an object’s children are immutable, so we require the *const* keyword at the top level to make the constant nature of the code explicit. Once you’ve declared a section as *const*, however, the children are automatically *const* without requiring further declaration, so now a statement like the following is valid:

```dart
const comments = <Comment>[
  Comment(
    "Creating apps is just faster and more fun with Flutter.",
    "Posse Inc."),
  Comment(
    "Yesterday I was trying #Flutter for the first time, today I published an application.",
    "@CristianDudca"),
  Comment(
    "This weekend: Met and fell in love with Flutter.",
    "@FIREYOSE"),
];
```

In other areas, we’ve made improvements to the accessibility support for apps that use Flutter, including improving support for screen readers, large text and contrast capabilities, as well as starting to [document our accessibility support](https://flutter.io/accessibility/). We’re also ready for apps that are offered in languages with right-to-left scripts. In addition to supporting right-to-left text, controls mirror where appropriate (for example the left ‘back’ button has inverted direction and justification in languages like Arabic).

We’ve also [rewritten the Flutter engine’s threading model](https://github.com/flutter/engine/pull/4932) to make it possible to host multiple FlutterViews within a single application. This is part of our larger focus on making it easier to add Flutter to your existing app — work that continues [in progress](https://github.com/flutter/flutter/issues/14821).

### Ecosystem

We launched an initial suite of Firebase plugins at Google I/O last year. Several of those plugins are reaching their 1.0 milestone this week: [Realtime Database](https://pub.dartlang.org/packages/firebase_database), [Firebase Analytics](https://pub.dartlang.org/packages/firebase_analytics), [Firebase Messaging](https://pub.dartlang.org/packages/firebase_messaging), and [Firebase Core](https://pub.dartlang.org/packages/firebase_core). In addition, we have added new, fully-featured plugins for [Remote Config](https://pub.dartlang.org/packages/firebase_remote_config), [Cloud Firestore](https://pub.dartlang.org/packages/cloud_firestore), and [Performance Monitoring](https://pub.dartlang.org/packages/firebase_performance). For an overview of our Firebase support, please see the [FlutterFire page](https://github.com/flutter/plugins/blob/master/FlutterFire.md).

Our support for ads powered by [AdMob by Google](https://www.google.com/admob/) is graduating to beta, enabling you to monetize your Flutter-based applications. The [AdMob plugin](https://pub.dartlang.org/packages/firebase_admob) supports loading and displaying banner, interstitial (full-screen), and rewarded video ads using the [AdMob API](https://firebase.google.com/docs/admob/).

There are many other packages that have recently been made available for Flutter, some [contributed by the Flutter team](https://pub.dartlang.org/packages?q=email%3Aflutter-dev%40googlegroups.com) directly, others by community members. As mentioned in our I/O announcement post, Flutter is a first-class toolkit for [Material](http://material.io/components), which means the Material and Flutter teams have partnered to deliver even more support for Material Design.

### Tooling

We continue to release regular updates to the **Flutter plugin for Android Studio and IntelliJ** to improve the development experience. In particular, we’ve [redesigned the UI Inspector](https://groups.google.com/forum/#!topic/flutter-dev/N6nOno1m3Mk) with a new “Just My Widgets” feature that filters out auto-generated widgets. You can also run your Flutter app in profile mode, which adds frames-per-second and memory usage displays.

**Visual Studio Code is now considered a [fully-supported development environment](https://flutter.io/get-started/editor/#vscode)** for Flutter, in addition to the Android Studio support mentioned above. Flutter support is enabled through the [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) extension, available through the Visual Studio Marketplace. The latest version of our Visual Studio Code extension supports Flutter Beta 3 features including Dart 2, and the changelog is [here](https://dartcode.org/releases/v2-12/).

Other notable features in this release for both Android Studio and Visual Studio Code include a broader set of refactorings. This includes an Extract Widget refactor that creates a new Widget class and inserts a call to its constructor in the original position:

<DashImage figure src="images/0Sdp8z8g2G2spsW3j.png" />


### Connecting with us

There are a few ways to get in touch with us and find out what’s going on with Flutter.

* We post announcements and have discussions in the [flutter-dev](https://groups.google.com/d/forum/flutter-dev) group, and are also active on Twitter as @[flutterio](https://twitter.com/flutterio);

* The best place to post technical questions is [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter), where there are plenty of experts on standby to help, including Google engineers;

* If you spot a bug that you think we need to take a look at, you can file it at our [GitHub repo](https://github.com/flutter/flutter/issues). This is also a good place to [upvote other suggestions](https://github.com/flutter/flutter/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc) that you think we should prioritize;

* Lastly, if you have a Flutter app that you’d like to show us, we’d love to see it! We’re always looking for new demos and [cool examples to share with others](https://flutter.io/showcase/). [Use this form](https://docs.google.com/forms/d/e/1FAIpQLScP5iDNGrlVXdGxmRDzjCnqXS0KUDld-3cR-njAL0kDO2ULFg/viewform) to tell us what you’re working on!