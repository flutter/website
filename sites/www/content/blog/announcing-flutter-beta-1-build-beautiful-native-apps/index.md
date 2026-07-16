---
title: "Announcing Flutter beta 1: Build beautiful native apps"
description: "Today, as part of Mobile World Congress 2018, we are excited to announce the first beta release of Flutter. Flutter is Google’s new mobile…"
publishDate: 2018-02-27
author: sethladd
image: images/1qo6Fo51uAmD3B3d6VfcbAQ.webp
category: release
layout: blog
---

Today, as part of Mobile World Congress 2018, we are excited to announce the first beta release of [Flutter](https://flutter.io/?utm_source=google&utm_medium=blog&utm_campaign=beta_announcement). Flutter is Google’s new mobile UI framework that helps developers craft high-quality native interfaces for both iOS and Android. [Get started](https://flutter.io/get-started/?utm_source=google&utm_medium=blog&utm_campaign=beta_get_started) today at [flutter.io](https://flutter.io/?utm_source=google&utm_medium=blog&utm_campaign=beta_announcement) to build beautiful native apps in record time.

<YoutubeEmbed id="fq4N0hgOWzU" title="Introducing Flutter" fullwidth="true"/>


Flutter targets the sweet spot of mobile development: performance and platform integrations of native mobile, with high-velocity development and multi-platform reach of portable UI toolkits.

<DashImage figure src="images/1qo6Fo51uAmD3B3d6VfcbAQ.webp" />


Designed for both new and experienced mobile developers, Flutter can help you build beautiful and successful apps in record time with benefits such as:

* **High-velocity development** with features like stateful Hot Reload, a new reactive framework, rich widget set, and integrated tooling.

* **Expressive and flexible designs** with composable widget sets, rich animation libraries, and a layered, extensible architecture.

* **High-quality experiences** across devices and platforms with our portable, GPU-accelerated renderer and high-performance, native ARM code runtime.

Since our alpha release last year, we delivered, with help from our community, features such as screen reader support and other accessibility features, right-to-left text, localization and internationalization, iPhone X and iOS 11 support, inline video, additional image format support, running Flutter code in the background, and much more.

Our tools also improved significantly, with support for [Android Studio](https://plugins.jetbrains.com/plugin/9212-flutter), [Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code), new refactorings to help you manage your widget code, platform interop to expose the power of mobile platforms to Flutter code, improved stateful hot reloads, and a new [widget inspector](https://flutter.io/inspector/) to help you browse the widget tree.

<DashImage figure src="images/0QcURHTZejNbiWHwB.webp" alt="Flutter’s new widget inspector helps you visualize your widget tree." caption="Flutter’s new widget inspector helps you visualize your widget tree." />


Thanks to the many new features across the framework and tools, teams across Google (such as AdWords) and around the world have been successful with Flutter. Flutter has been used in production apps with millions of installs, apps built with Flutter have been featured in the App Store and Play Store (for example, [Hamilton: The Musical](https://www.blog.google/topics/developers/it-must-be-nice-have-hamilton-your-phone/)), and startups and agencies have been successful with Flutter.

For example, [Codemate](https://www.codemate.com/), a development agency in Finland, attributes Flutter’s high-velocity dev cycle and customizable UI toolkit to their ability to quickly build a beautiful app for [Hookle](https://www.hookle.net/). “We now confidently recommend Flutter to help our clients perform better and deliver more value to their users across mobile.”, said Toni Piirainen, CEO of Codemate.

<DashImage figure src="images/1VIYiGwYgYQAebs0ouJTW6g.webp" alt="Apps built with Flutter deliver quality, performance, and customized designs across platforms." caption="Apps built with Flutter deliver quality, performance, and customized designs across platforms." />


Flutter’s beta also [works with a pre-release](https://github.com/flutter/flutter/wiki/Trying-the-preview-of-Dart-2-in-Flutter) of [Dart 2](https://medium.com/@asandholm/announcing-dart-2-80ba01f43b6), with improved support for declaring UI in code with minimal language ceremony. For example, Dart 2 infers `new` and `const` to remove boilerplate when building UI. Here is an example:

```dart
// Before Dart 2
Widget build(BuildContext context) {
  return new Container(
    height: 56.0,
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: new BoxDecoration(color: Colors.blue[500]),
    child: new Row(
      ...
    ),
  );
}

// After Dart 2
Widget build(BuildContext context) =>
  Container(
    height: 56.0,
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(color: Colors.blue[500]),
    child: Row(
      ...
    ),
  );
```

We’re thrilled to see Flutter’s ecosystem thriving. There are now over [1000 packages that work with Flutter](https://pub.dartlang.org/flutter) (for example: [SQLite](https://pub.dartlang.org/packages/sqflite), [Firebase](https://github.com/flutter/plugins/blob/master/FlutterFire.md), [Facebook Connect](https://pub.dartlang.org/packages/flutter_facebook_connect), [shared preferences](https://pub.dartlang.org/packages/shared_preferences), [GraphQL](https://pub.dartlang.org/packages/graphql_client), and lots more), over 1700 people in our [chat](https://gitter.im/flutter/flutter), and we’re delighted to see our community launch new sites such as [Flutter Institute](https://flutter.institute/), [Start Flutter](https://startflutter.com/), and [Flutter Rocks](https://flutter.rocks/). Plus, you can now subscribe to the new [Flutter Weekly newsletter](https://flutterweekly.net/), edited and published by our community.

As we look forward to our 1.0 release, we are focused on stabilization and scenario completion. Our roadmap, largely influenced by our community, currently tracks features such as making it easier to [embed Flutter into an existing app](https://github.com/flutter/flutter/issues/14821), [inline WebView](https://github.com/flutter/flutter/issues/730), [improved routing and navigation APIs](https://github.com/flutter/flutter/labels/prod%3A%20routes), [additional Firebase support](https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22plugin%3A+firebase%22?), [inline maps](https://github.com/flutter/flutter/issues/73), a [smaller core engine](https://github.com/flutter/flutter/issues/12456), and more. We expect to release new betas approximately every four weeks, and we highly encourage you to vote (👍) on issues important to you and your app via our [issue tracker](https://flutter.io/issues).

Now is the perfect time to try Flutter. You can go from zero to your first running Flutter app quickly with our [Getting Started guide](https://flutter.io/get-started/?utm_source=google&utm_medium=blog&utm_campaign=beta_get_started). If you already have Flutter installed, you can switch to the beta channel using [these instructions](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels).

We want to extend our sincere thanks for your support, feedback, and many contributions. We look forward to continuing this journey with everyone, and we can’t wait to see what you build!

*Hello, developers in China! This post is also [available in Chinese](https://developers.googleblog.cn/2018/02/flutter-beta1.html).*
