---
title: "Announcing Flutter Release Preview 1"
description: "Community momentum builds on the path to release"
publishDate: 2018-06-20
author: timsneath
image: images/1PEcgvfvQj4Gd1hFBBfCX_g.webp
category: release
layout: blog
---

Today, we’re delighted to announce **Flutter Release Preview 1**, signaling a new phase of development for Flutter as we move into the final stages of stabilization for 1.0.

## Flutter progress since Google I/O

Google I/O last month was something of a celebration for the Flutter team: having reached beta, it was good to meet with many developers who are learning, prototyping, or building with Flutter. Through the various technical sessions, we covered topics like [UI design with Flutter and Material](https://www.youtube.com/watch?v=hA0hrpR-o8U), [mobile development with Flutter and Firebase](https://www.youtube.com/watch?v=p4yLzYwy_4g), and [architectural practices for complex Flutter apps](https://www.youtube.com/watch?v=RS36gBEp8OI).

It was also good to showcase some of the [early apps that are using Flutter](https://flutter.io/showcase), as this video highlight reel demonstrates:

<YoutubeEmbed id="ul7IbPvWBwc" title="Flutter at I/O: Sandbox Highlight Reel" fullwidth="true"/>


In the aftermath of Google I/O, we continue to see rapid growth in the Flutter ecosystem, with a **50% increase in active Flutter users**.

One common measure of popularity and momentum is the number of GitHub stars, and we’ve also seen growth here, with Flutter recently becoming one of the [top 100 software repos on GitHub](https://github.com/timsneath/github-tracker). Indeed, even compared to many other popular open source projects, Flutter has been growing rapidly since the first beta in February, as shown in this graph ([source](https://github.com/timsneath/r-github-stars/blob/master/flutterStars.R)):

<DashImage figure src="images/1bE4ebdAs3EnxgqV2m2y_7g.webp" />


In the weeks following I/O, we have been greatly encouraged by the number of user groups, meetups, and events that have sprung up all over the world. We’ve seen over 150 individual Flutter events taking place across fifty countries: from [New York City](https://www.meetup.com/flutter-nyc/?_cookie-check=ovV9o45C3PiCO2ts) to [Uyo, Nigeria](https://twitter.com/Esidemsam/status/1000023177081344000); from [Tokyo and Osaka in Japan](https://flutter-jp.connpass.com/) to [Nuremberg, Germany](https://twitter.com/search?q=flutter%20extended&src=typd).

<DashImage figure src="images/0-1m66Jxnec3s8Qnb.webp" alt="Flutter events happening around the world" caption="Flutter events happening around the world" />


In addition to these worldwide community events, we’re also starting to see early adopters of Flutter publish their work to the Apple and Google stores. At Google I/O, we highlighted some [apps and endorsements such as Alibaba, Groupon, and Google AdWords](https://flutter.io/showcase); it’s since been fun to see both larger and smaller-scale apps starting to appear from the community. Here are a few diverse examples from around the world:

* Suez Canal Authority (Egypt): [Android](https://play.google.com/store/apps/details?id=com.suezcanal.obour), [iOS](https://itunes.apple.com/us/app/elnasr-bridge/id1347983514?mt=8)

* CARTUNE (Japan): [Android](https://play.google.com/store/apps/details?id=me.cartune.android)

* Reflectly (Denmark): [Android](https://play.google.com/store/apps/details?id=com.reflectlyApp)

* Tengwar (Middle Earth Elvish script) transcriber (Germany): [Android](https://play.google.com/store/apps/details?id=com.woalk.apps.tengwar.de), [iOS](https://itunes.apple.com/us/app/tengwar-umschreiber/id1367958873?mt=8)

* Beer Me Up (France) — [Android](https://play.google.com/store/apps/details?id=com.benoitletondor.beermeup), [iOS](https://itunes.apple.com/us/app/beer-me-up-your-beer-logging/id1393867499)

## Announcing Flutter Release Preview 1

Today we’re taking another big step forward, with the immediate availability of [Flutter Release Preview 1](https://flutter.io/).

<DashImage figure src="images/1PEcgvfvQj4Gd1hFBBfCX_g.webp" />


The shift from *beta* to *release preview* signals our confidence in the stability and quality of what we have, and our focus on bug fixing and stabilization.

We’re making this announcement during the keynote of the [GMTC Global Front-End Conference in Beijing, China](https://gmtc.geekbang.org/), a gathering of around a thousand front-end and mobile developers sponsored by GK Tech and InfoQ China. China is a logical venue for this announcement, as we’ve seen particularly strong adoption for Flutter by leading companies there. In particular, Alibaba has now deployed their Flutter-based app to millions of devices, and Tencent is currently rolling out their NOW app with Flutter.

We are encouraged by the growing number of contributions we’re seeing from the broader community. External contributions to Release Preview 1 include Flutter support for [hardware keyboard and barcode scanners](https://github.com/flutter/flutter/issues/11177), [video recording](https://github.com/flutter/plugins/pull/458), and including a [folder of image or font assets](https://github.com/flutter/flutter/issues/4890). In addition, we’re seeing many new packages contributed to the [package site](https://pub.dartlang.org/flutter), such as [Flutter Platform Widgets](https://pub.dartlang.org/packages/flutter_platform_widgets), a set of widgets that automatically adapt for iOS or Android; [mlkit](https://pub.dartlang.org/packages/mlkit), a wrapper for the Firebase MLKit APIs; and [Sequence Animation](https://pub.dartlang.org/packages/flutter_sequence_animation), which helps with constructing a series of connected animations.

As for the Flutter team, our focus has shifted slightly towards scenario completeness. We’ve continued to improve the [video player package](https://pub.dartlang.org/packages/video_player#-changelog-tab-), with broader format support and reliability improvements. We’ve further extended Firebase support to include [Firebase Dynamic Links](https://pub.dartlang.org/packages/firebase_dynamic_links#-readme-tab-), an app solution for creating and handling links across multiple platforms. We’ve broadened support to include [32-bit iOS devices](https://github.com/flutter/engine/wiki/iOS-Builds-Supporting-ARMv7) with ARMv7 chips, enabling apps written with Flutter to run on older devices (like the iPad Mini and iPhone 5c) that remain popular across the world.

Lastly, we’ve added experimental instructions on [adding Flutter widgets to an existing Android or iOS app](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps). While some iOS and Android apps in production already use this approach, we are working on improving our documentation and tooling to make it much easier to develop a mixed app. Keep an eye on [this wiki article](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps) to follow our progress.

How do you [upgrade](https://flutter.io/upgrading/) to Flutter Release Preview 1? If you’re on the beta channel already, it just takes one command:

```bash
$ flutter upgrade
```


### Tooling for Flutter Release Preview 1

We continue to make significant improvements to Flutter tools, with a new update of the [Flutter extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) adding a new outline view, statement completion, and the ability to launch emulators directly from Visual Studio Code.

<DashImage figure src="images/19g1lJx2vzCJ2mdMKCaHsnA.webp" alt="Flutter Studio, a web-based community tool for building Flutter screens" caption="Flutter Studio, a web-based community tool for building Flutter screens" />


Google is not the only organization working on Flutter tooling. One community effort that shows early promise is [Flutter Studio](https://flutterstudio.app/), a web-based tool for creating Flutter-based user interfaces. The tool has property editors for each of the 50+ Flutter widgets it supports, so it’s a good way to explore the widget catalog. The tool itself is written in [Dart](https://dartlang.org) — the same language used to build Flutter apps. You can read more about how it was built on [the developer’s blog](https://medium.com/@pmutisya/flutter-studio-version-2-41cce10fcf3d), where he also talks about his positive experiences with building a large web app with Dart.

## Flutter in China

China has the third largest population of developers using Flutter, after the USA and India. We are hugely appreciative of the local developers who have helped us with China-based mirrors of the pub package site and community-maintained translations of the code labs. A [Flutter in China website](https://flutter-io.cn) is now available — launched jointly with the community to help developers in China build their skills.

<DashImage figure src="images/1LZ8v_AJHi69RCnxq7EeftQ.webp" alt="Flutter in China website" caption="Flutter in China website" />


## Conclusion

It’s been fun to watch others encounter Flutter for the first time. [This article from an iOS developer](https://medium.com/@seenickcode/what-it-was-like-to-write-a-full-blown-flutter-app-330d8202825b) who has recently completed porting an iOS app to Flutter is a positive endorsement of the project’s readiness for real-world production usage:
> “I haven’t been this excited about a technology since Ruby on Rails or Go… After dedicating years to learning iOS app dev in-depth, it killed me that I was alienating so many Android friends out there. Also, learning other cross platform frameworks at the time was super unattractive to me because of what was available… Writing a Flutter app has been a litmus test and Flutter passed the test. Flutter is something I feel like I can really invest in and most importantly, really enjoy using.”

As we get ever closer to publishing our first release from the “stable” channel, we’re ready for more developers to build and deploy solutions that use this Release Preview. There are plenty of training offerings to help you learn Flutter: from [I/O sessions](https://www.youtube.com/playlist?list=PL0o58xSX-Jvi6zBDe7SW4W6h5hauQ-xxF) to [newsletters](https://flutterweekly.net/) to [hands-on videos](https://www.youtube.com/watch?v=syd0c9Vi2hg) to [developer shows](https://www.youtube.com/watch?v=yr8F2S3Amas). And we have [discussion groups](https://groups.google.com/forum/#!forum/flutter-dev), [chat rooms](https://gitter.im/flutter/flutter), and [community support](https://stackoverflow.com/questions/tagged/flutter) available to get you through any stumbling blocks you may encounter. We’re ready for you!