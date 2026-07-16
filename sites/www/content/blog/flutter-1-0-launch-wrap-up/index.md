---
title: "Flutter 1.0 Launch Wrap-up"
description: "A few reflections on Flutter Live, our global celebration of the Flutter 1.0 launch."
publishDate: 2018-12-28
author: csells
image: images/14_hWh5hMP6F3W6DZ-6OK2Q.webp
category: release
layout: blog
---

It’s been a couple of weeks now since Flutter Live, our global celebration of Flutter, and we thought we’d share a few reflections on the event. The Flutter team was blown away by the community excitement around [the release of Flutter 1.0](https://developers.googleblog.com/2018/12/flutter-10-googles-portable-ui-toolkit.html). Flutter lets you build fast, beautiful apps using tools that work with your favorite IDE/editor and an open source runtime that makes you a much more productive developer. The event was a wonderful moment to share our plans for Flutter, demonstrate some of the amazing ways partners are building on Flutter, and see Flutter community groups come together around the world.

## Flutter Momentum

Since [Flutter entered beta in February](https://medium.com/flutter-io/announcing-flutter-beta-1-build-beautiful-native-apps-dc142aea74c0) of this year, there have been apps built for more than 200 million users by 250,000+ developers.

In that short time, Flutter’s repository has already reached the top 25 on GitHub for active software repos. At Flutter Live, we shared that Flutter was the 34th most popular active software repo on GitHub, but since the event, it’s already moved to 21, ahead of Swift, Kubernetes, Angular and TypeScript. We continue to be humbled and amazed by the affection that developers have for Flutter.

And it’s clear that developers are using Flutter to build great things. Looking at apps like [Reflectly](https://reflectly.app/), [Topline from Abbey Road](https://youtu.be/_ACWeGGBP4E) and the brand new [History of Everything](https://medium.com/2dimensions/the-history-of-everything-981d989e1b45), you can feel how amazing they are in every pixel and in every motion. You can see that users agree by looking at the Google Play and Apple App Store ratings for these and [other popular Flutter apps](https://flutter.io/showcase).

The momentum rolled right into the Flutter Live event, as you can see here in the lead up to the keynote.

<YoutubeEmbed id="DpBWkYiSBtQ" title="Flutter Live Event Guides Highlights" fullwidth="true"/>


All of that was in preparation for the event itself, which is recapped in this 10-minute highlight reel.

<YoutubeEmbed id="D-o4BqJxmJE" title="Flutter Live Keynote Recap" fullwidth="true"/>


And if you haven’t seen it already, you can check out [the full playlist of content from Flutter Live](https://www.youtube.com/playlist?list=PLOU2XLYxmsILq4ysYNWXq5TOGLgYDJgVD).

## Flutter Community

Reaching Flutter 1.0 was not just a Google effort, but a whole community effort. The Flutter community has been invaluable in the development of Flutter and the related tooling, with more than 12,000 commits by 285 contributors. Flutter was developed in the open to encourage global participation, but the team never expected how strong and how quickly the community would grow. Little known fact: the development of the [Visual Studio Code plug-in for Flutter](https://dartcode.org/) was done by a single community developer: Danny Tuppeny (aka [DanTup](https://github.com/DanTup)). Danny did such an amazing job that now making Flutter work great in VSCode is his full-time job!

The inspiration that Flutter has on developers doesn’t stop there. Developers gathered en masse in viewing parties around the world in places like Estonia:

<YoutubeEmbed id="PcrIkshxnjo" title="Nevercode launches Codemagic - Flutter Live & Launch Party Aftermovie - December 4th, 2018" fullwidth="true"/>


China:

<YoutubeEmbed id="w68o_B76YlI" title="Flutter Live Beijing Sizzle Reel" fullwidth="true"/>


And Kampala, Uganda:

<DashImage figure src="images/0kS0qvDFLKFUHsmKl.webp" />


And thanks to all of the developers that posted to #MyFlutterStory! It was hard to pick the best contributions.

<YoutubeEmbed id="9WgQzB0UZOs" title="#MyFlutterStory - Stories From Developers Using Flutter" fullwidth="true"/>


These developers haven’t been idle. Looking at [the list of Flutter packages](https://pub.dartlang.org/packages?q=dependency%3Aflutter) on pub.dartlang.org shows over 1000 community-contributed packages that you can drop into your projects today. You can see a small sample of what the community is already building using these resources today:

<YoutubeEmbed id="REJDzio_h7o" title="Flutter App Highlight Reel" fullwidth="true"/>


But that’s not all — in addition to the existing set of packages to [add Firebase to your Flutter app](https://firebaseopensource.com/projects/flutter/plugins/), there’s also [the new Firebase MLKit](https://pub.dartlang.org/packages/firebase_ml_vision), which enables real-time image and feature recognition, and [the two new Square SDKs for Flutter](https://squareup.com/us/en/flutter) that allows you to take payments from a Square Reader or directly inside your app.

On the tooling side, you’re probably already familiar with the Flutter plugins for [Android Studio](https://flutter.io/docs/get-started/editor?tab=androidstudio) and [Visual Studio Code](https://flutter.io/docs/get-started/editor?tab=vscode), but did you know about [2Dimensions Flare](https://medium.com/2dimensions/flare-launch-d524067d34d8), which helps you build great vector animations for Flutter, or [Nevercode Codemagic](https://nevercode.io/blog/why-we-built-codemagic/), which provides testing and continuous deployment to the Google Play and Apple App Store for your Flutter app?

It’s clear that the Flutter community is strong and it’s getting stronger. To get started, you’ll find an excellent set of docs, samples, videos and codelabs provided on the Flutter site at [flutter.io](https://flutter.io). And when you’ve got questions about Flutter development, issues to report or features to request, [become a part of the Flutter community](https://flutter.io/community).

## Flutter Future

With the release of Flutter 1.0 that targets Android and iOS, the team is just getting started. If fact, there are already new features in beta for you to try out. If you want to add existing mobile platform components to your Flutter app, you can do so via [platform views](https://medium.com/flutter-community/flutter-platformview-how-to-create-flutter-widgets-from-native-views-366e378115b6), which have in turn been used to create the new [Web View](https://pub.dartlang.org/packages/webview_flutter) and [Google Maps](https://pub.dartlang.org/packages/google_maps_flutter) packages. Conversely, if you’d like to drop Flutter code into your existing mobile apps, you can do so with [the Add to App feature](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps), allowing you to leverage your current apps while still taking advantage of the power and beauty of Flutter. We’ll continue to add features to Flutter based on your [feedback](https://flutter.io/community).

From the beginning, Flutter has been a UI toolkit for all screens, not just mobile. We have begun to showcase this by demonstrating a preview of ongoing work to support Flutter on [desktop](https://github.com/google/flutter-desktop-embedding) devices running Linux, Mac or Windows, along with giving a sneak peek at a project codenamed “[Hummingbird](https://medium.com/flutter-io/hummingbird-building-flutter-for-the-web-e687c2a023a8)”, which lets you compile Flutter code to run on the standards-based web. These are experimental projects and we’re looking forward to putting this into your hands so that we can get your feedback.

So while we’ve got lots planned for Flutter in the future, it’s ready for you right now. What will you build?

<DashImage figure src="images/14_hWh5hMP6F3W6DZ-6OK2Q.webp" />
