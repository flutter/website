---
title: "Flutter Spring 2020 Update"
description: >-
  Continued momentum and enterprise growth, new release model
publishDate: 2020-04-22
author: timsneath
image: images/0T39T7UB0oJVIQy_H.webp
category: announcement
layout: blog
---

*Authored by Tim Sneath and Patrick Sosinski*

For the engineers, product managers, UX researchers, technical writers, and developer relations engineers here at Google that work on Flutter, the last couple of months have been filled with various challenges; like most of you, we are all grappling with very different daily routines than normal. And yet, as an open source project, we are able to continue to develop using publicly available tools. Within the limitations of sometimes challenging and certainly novel working environments, along with the need to care for dependents, we’re continuing to make progress against our spring backlog and have also learned plenty about contributing “from the outside”! We hope that you’re also able to make progress and stay healthy and safe.

<DashImage figure src="images/0T39T7UB0oJVIQy_H.webp" />

## Flutter momentum

We continue to see fast growth in Flutter usage, with over **two million developers having used Flutter** in the sixteen months since we released. Despite these unprecedented circumstances, in March we saw 10% month-over-month growth, with nearly half a million developers now using Flutter each month.

Some other interesting statistics:

* 60% of you are developing with Windows, 27% are using macOS, and 13% are using Linux.

* 35% of you work for a startup, 26% are enterprise developers, 19% are self-employed, and 7% work for design agencies.

* 78% of Flutter developers use the stable channel, 11% use beta, and 11% use either dev or master.

* The top five territories for Flutter are India, China, the United States, the EU, and Brazil.

* There are approximately 50,000 Flutter apps published in the Play Store, with nearly 10,000 uploaded in the last month alone.

* The most popular framework packages used in Flutter apps are [http](https://pub.dev/packages/http), [shared_preferences](https://pub.dev/packages/shared_preferences), [intl](https://pub.dev/packages/intl), [meta](https://pub.dev/packages/meta), [path_provider](https://pub.dev/packages/path_provider) and [pedantic](https://pub.dev/packages/pedantic).

* The most popular third-party packages used in Flutter apps are [provider](https://pub.dev/packages/provider), [rxdart](https://pub.dev/packages/rxdart), [cached_network_image](https://pub.dev/packages/cached_network_image), [sqflite](https://pub.dev/packages/sqflite), [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) and [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons).

## Flutter in the enterprise

Flutter usage is growing fast among enterprise customers in particular, and our research continues to show that the ability to build highly-branded experiences that support multiple platforms is a key reason why larger companies select Flutter. One recent example is [Nubank](https://nubank.com.br/en/), the largest digital bank outside Asia with over 20 million customers. After conducting [a detailed investigation and analysis](https://cdn.nubank.com.br/mobile/taskforce/nubank-mobile-architecture-task-force-mission-report.pdf) of their choices for app development, Nubank selected Flutter and have since been able to unify their front-end development team on a single framework, enabling them to ship new features simultaneously on both iOS and Android.

Check out their developer story below, which explains some of the benefits they’re seeing with Flutter:

<YoutubeEmbed id="vnj2i6RNo3g" title="Nubank (Flutter Developer Stories)" fullwidth="true"/>

One common request from enterprises is professional components. We’re partnering with [SyncFusion](https://www.syncfusion.com/), whose Essential Studio product now includes a range of [high-quality Flutter components](https://www.syncfusion.com/flutter-widgets) including charting, PDF manipulation and barcode generation. With their [2020.1 release](https://www.businesswire.com/news/home/20200421005174/en/Syncfusion-Introduces-New-Flutter-Widgets-Web-Compatibility), all components support Android, iOS *and* web out of the box, and they now have a [web-based preview](https://flutter.syncfusion.com/#/) of their controls.

## Updating our release process

Lastly, as we look towards our next stable release, we wanted to share some changes we’re making to our release model that we think will further improve stability and predictability of our releases.

Today’s release process was designed to be simple and low maintenance. This process served Flutter well when we were a smaller team and a more nascent framework, but at our current scale, we have encountered some issues affecting Flutter contributors and developers including:

* lack of clarity on when the release would be built, and therefore what code was in it

* lack of testing for branches causing hotfix releases to have regressions

Starting with the April release of Flutter, we are moving to a branching model with a stabilization period for beta and stable releases. We will now branch at the beginning of the month for a beta release and stabilize this release by cherry-picking any critical fixes. Roughly once a quarter, the current beta branch will be promoted to our stable release. We will continue to do hotfixes on this release if necessary. Our infrastructure now supports testing against branches, meaning we can validate cherrypicks and will accept some requests based on severity.

We also took this opportunity to align the Flutter and Dart release processes and channels. As a result, Dart has added [a beta channel](https://dart.dev/get-dart#release-channels), and moving forward releases will be synced (for example, Flutter beta releases will contain a Dart beta release).

If you’re already shipping a Flutter app based on the stable channel, we encourage you to test your app on beta candidate releases and influence the quality of the stable release by reporting any issues. You can also escalate regressions or blocking bugs on the stable channel following the new [Flutter cherry-pick process](https://github.com/flutter/flutter/wiki/Flutter-Cherrypick-Process) on the Flutter wiki.

We think this new process will both provide higher confidence in the quality and predictability of our releases, and an easier way to deliver hotfixes to the stable channel.

## Versioning changes

As a part of this branching model, we are making some minor changes to the way releases are versioned.

The full technical details can be found at the [Flutter build release channels](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels) wiki page; a quick summary follows:

*Non-stable release versions* will be annotated with `.pre` in the version string to denote their pre-release status. Given a version string of `x.y.z-n.m.pre`, `dev` channel builds will increment `n` each time a new one is built from `master`.

* `1.18.0–1.0.pre`: first `dev` build after `master` moves to `1.18`

* `1.18.0–2.0.pre`: next `dev` build from a more recent point on `master`

*Beta releases* will be built from a `dev` release point, as above. When we do cherry-picks on one of these releases, the `m` version will increment. For example, if we took the 15th `dev` build from `master` as our `1.18` release from `beta`, the versioning would look like:

* `1.18.0–15.0.pre`: initial `beta` candidate (same release that went to `dev`)

* `1.18.0–15.1.pre`: subsequent build on the (now)`beta` branch with some cherry-picks

* `1.18.0–15.2.pre`: second subsequent build

*Stable releases* will be versioned `x.y.0`. Subsequent hotfix releases, if necessary, will increment the patch number. `x.y.1`, `x.y.2`, etc.)

* `1.18.0–15.4.pre`: last beta build on branch

* `1.18.0`: stable release, same bits as `1.18.0–15.4-pre`

* `1.18.1`: potential hotfix of `1.18.0`

## What’s next?

Our first release using this new versioning model will be **our next stable release, which we plan to ship next week**. Come back then for a full rundown of all the new features.

In the meantime, check out some of the other announcements we’ve made over the last couple of weeks. Last week, we announced [CodePen support of Flutter](https://medium.com/flutter/announcing-codepen-support-for-flutter-bb346406fe50). We are enjoying seeing the pens that various creators have built over the last few days. Here are a few of our favorites:

* [Twitter clone](https://codepen.io/mkiisoft/pen/KKdgdad) (mkiisoft)

* [Generative abstract art](https://codepen.io/rx-labz/pen/WNQoNem) (rxlabz)

* [Chakra animation](https://codepen.io/tahatesser/pen/GRpqbRY) (tahatesser)

* [Rotating carousel](https://codepen.io/joshuadeguzman/pen/jObrzJB) (joshuadeguzman)

* [Nougat animation](https://codepen.io/phillywiggins/pen/gOaPNPY) (phillywiggins)

* [Double pendulum](https://codepen.io/abhilas-csc/pen/qBOZKPj) (abhilas-csc)

<DashImage figure src="images/0vX4VeEgvAD364f_2.webp" />

And if you’re looking for Flutter learning resources, we now have [a free introductory Flutter training course](https://medium.com/flutter/learn-flutter-for-free-c9bc3b898c4d) available online. This ten hour course presented by Angela Yu provides tutorials and labs to help you get started on your Flutter journey.

See you next week. In the meantime, stay home and stay healthy!
