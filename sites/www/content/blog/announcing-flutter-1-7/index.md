---
title: "Announcing Flutter 1.7"
description: "Continued refinement and polish for mobile platforms"
publishDate: 2019-07-09
author: timsneath
image: images/1PzRLnOtNMtoO59dPPz--hA.webp
category: release
layout: blog
---

Today we’re pleased to **announce the general availability of Flutter 1.7**, a smaller release after the major feature announcements at Google I/O. Flutter 1.7 contains support for AndroidX and for updated Play Store requirements, a number of new and enhanced components, and bug fixes to customer-reported issues.

<DashImage figure src="images/1PzRLnOtNMtoO59dPPz--hA.webp" />


If you already have Flutter on your system and you’re on the default stable channel, you can upgrade to version 1.7 by running `flutter upgrade` from the command line. The updated release is also included in [a new installation](https://flutter.dev/docs/get-started/install) of Flutter.

## AndroidX Support for New Apps

[AndroidX](https://developer.android.com/jetpack/androidx) is a new open source support library from the Jetpack team that helps Android apps stay updated with the latest components without sacrificing backward compatibility. Now that AndroidX is itself stable and many Flutter packages have been updated to support it, Flutter supports [creating new Flutter projects with AndroidX](https://github.com/flutter/flutter/pull/31028), which reduces the work needed to integrate with other parts of the Android ecosystem.

When creating a Flutter project, you can add the `--androidx` flag to ensure the generated project targets the new support library. Information about migrating existing projects to AndroidX can be found [on flutter.dev](https://flutter.dev/docs/development/packages-and-plugins/androidx-compatibility#for-plugin-maintainers-migrating-a-flutter-plugin-to-androidx). We’re actively working on bringing AndroidX / Jetifier support for apps with mixed AndroidX / Android Support libraries, such as in add-to-app cases, and will have more to share on this front in a forthcoming post.

## Support for Android app bundles and 64-bit Android apps

From August 1st, 2019, Android apps that use native code and target Android 9 Pie will be [required to provide a 64-bit version](https://developer.android.com/distribute/best-practices/develop/64-bit) in addition to the 32-bit version when publishing to the Google Play Store. While Flutter has long supported generating 64-bit Android apps, version 1.7 adds support for creating [Android App Bundles](https://developer.android.com/guide/app-bundle) that target both 64-bit and 32-bit from a single submission. See the updated [documentation on publishing Flutter-based Android apps](https://flutter.dev/docs/deployment/android) to learn how to do this, as well as how to create separate APK files for both 32-bit and 64-bit devices.

## New widgets and framework enhancements

We want your apps to look great and feel natural, regardless of what platform you’re targeting. Correspondingly, we continue to update and enhance the widgets available for both Android and iOS.

This release features a new [`RangeSlider`](https://github.com/flutter/flutter/pull/31681) control that lets you select a range of values on a single slider (for example a minimum and maximum temperature value):

<DashImage figure src="images/1rruCdwqtc2p3SXaMzUuE0Q.webp" alt="The new, themeable RangeSlider widget supports continuous or discrete styles" caption="The new, themeable RangeSlider widget supports continuous or discrete styles" />


The [updated `SnackBar` widget](https://github.com/flutter/flutter/pull/31275) supports an updated look in the Material spec, and a [number](https://github.com/flutter/flutter/pull/31294) [of](https://github.com/flutter/flutter/pull/32177) [new](https://github.com/flutter/flutter/pull/31929) [samples](https://github.com/flutter/flutter/pull/32703) are added [to the](https://github.com/flutter/flutter/pull/34679) [documentation](https://github.com/flutter/flutter/pull/32530).

For [Cupertino](https://flutter.dev/docs/development/ui/widgets/cupertino), the Flutter library for building pixel-perfect iOS applications, we’ve made a number of updates. In particular, we’ve improved the fidelity of the [`CupertinoPicker` and `CupertinoDateTimePicker` widgets](https://github.com/flutter/flutter/pull/31464), and added support for localization to non-English languages.

We also made major improvements to the [text selection and editing experience on iOS](https://flutter.dev/docs/resources/platform-adaptations#text-editing), regardless of whether you’re using the Material or Cupertino design language. Also, a [new sample](https://github.com/flutter/samples/tree/master/platform_design) demonstrates how to make more significant platform adaptations across iOS and Android while retaining the same codebase.

Text rendering gets a big upgrade with support for rich [typography features](https://api.flutter.dev/flutter/painting/TextStyle/fontFeatures.html), including tabular and old-style numbers, slashed zeros, and stylistic sets, as [this demo](https://github.com/timsneath/typography) shows:

<DashImage figure src="images/00tdr7sHesqXfjWwK.webp" alt="With Flutter, you can now add sophisticated typography with OpenType font feature support" caption="With Flutter, you can now add sophisticated typography with OpenType font feature support" />


Lastly, we’ve added support for [game controllers](https://github.com/flutter/flutter/pull/33868). Could this lead to some fun Flutter apps? You tell us!

## Focus on the Fundamentals

Flutter 1.7 represents a lot of hard work by the team to respond to customer-reported issues, with [over 1,250 issues closed in the two months](https://github.com/flutter/flutter/issues?q=is%3Aissue+is%3Aclosed+closed%3A2019-04-22..2019-06-21+sort%3Areactions-%2B1-desc) since our last stable release.

With the rapid growth in Flutter, we’re seeing lots of new issues reported, and to be transparent, the bug process that worked well when our project was smaller is not working so well now. As a result, our open issue count has increased significantly over the last few months, despite our progress in closing triaged issues. We’re working to increase staffing in this area, which will help with faster triaging of new bugs, closing and merging duplicate issues and redirecting support requests to [StackOverflow](https://stackoverflow.com/questions/tagged/flutter).

In recent surveys, many of you said that you’d like to see us continue to invest in documentation and error messages. One key part of that work is to provide better structure for our errors which tools like VSCode and Android Studio can take advantage of in the future. You can see examples of this work [in issue 34684](https://github.com/flutter/flutter/pull/34684).

We also fixed the top crashing bug, which was an error when the Flutter tool is unable to write to the Flutter directory. Flutter now fails gracefully if the user doesn’t have write permissions, with clearer indications on how to fix the problem.

In terms of documentation, we have an ever increasing list of samples that can be created directly from the flutter create tool. From the command line, you can run a command such as:

```bash
flutter create --sample=material.AppBar.1 mysample
```


If a sample can be created in this way, you’ll see a “Sample in the App” tab in the documentation, as in [this example for the AppBar widget](https://master-api.flutter.dev/flutter/material/AppBar-class.html):

<DashImage figure src="images/1rARvCCVpn-cp1XoP5gXt9Q.webp" />


We’re also continuing to embed the popular [Widget of the Week](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG) videos directly into the documentation, as an easy way to grok the various widgets in Flutter’s toolkit.

Behind the scenes, you’ll see lots of underlying work to create infrastructure towards enabling Flutter on macOS and Windows, with further support for important concepts like right-click and unique platform infrastructure such as [MSBuild](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild?view=vs-2019). Support for non-mobile platforms is not yet available in the stable channel, however.

Lastly, when you’re building Flutter apps on the Mac, we now have support for [the new Xcode build system](https://github.com/flutter/flutter/pull/33684). This is on by default for new projects, and [easy to enable for existing projects](https://github.com/flutter/flutter/issues/20685#issuecomment-509731873).

## An ever-growing Flutter community

As ever, it’s exciting to see Flutter continue to grow in popularity and usage, and we also celebrate the ways customers large and small are using Flutter. Since I/O, the team has been busy with various events around the world: from [GMTC](https://gmtc2019.geekbang.org/) in China to meetups and presentations in New York and Mexico; it’s been great to meet with many of you and hear about some of the apps that you’re building.

We’ve talked about [Reflectly](https://www.forbes.com/sites/heatherfarmbrough/2018/05/01/reflectly-wants-to-be-an-adidas-of-the-mind/#572291294204) before: a small Danish company who built a beautiful mindfulness app for iOS and Android. Their app was just featured as Apple’s App of the Day on their US iPhone app store, demonstrating how Flutter apps are more than capable of delivering reference-quality experiences:

<YoutubeEmbed id="6ZpETbJjipQ" title="Reflectly App (Flutter Developer Story)" fullwidth="true"/>


And at the [WeAreDevelopers](https://events.wearedevelopers.com/) conference in Berlin, [BMW announced their new Flutter-based app](https://youtu.be/80pRyn7fZRk?t=1234), currently in development. Here’s what Guy Duncan, CTO Connected Company at BMW, had to say:
> *“By combining Dart and Flutter we have the first true cross-platform mobile toolkit; we feel it is a game changer to ensure feature parity for digital touchpoints and IoT.*
> *By moving forward with world class tooling, automation and modern functional programming patterns we can improve feature cycle time, security, and cost of delivery of features for the business.”*

Beyond apps, of course the open source community is what makes Flutter such a fun place to work, with so many [resources](https://flutterx.com/), [plugins](https://pub.dev/flutter), [events](https://flutterevents.com/) and [meetups](https://www.meetup.com/topics/flutter/). We continue to be amazed by how you’re using Flutter and are honored to be able to share the fun with you all!

<DashImage figure src="images/1mz1byB5RNbLttBIDGINljg.jpeg" alt="Photo credit: [@damian2048](https://twitter.com/damian2048)" caption="Photo credit: [@damian2048](https://twitter.com/damian2048)" />
