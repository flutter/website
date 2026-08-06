---
title: "How we use user surveys to prioritize engineering effort in Flutter — October 2018 edition"
description: >-
  Learn how the Flutter team uses quarterly survey results to
  prioritize engineering investments and improve the developer experience.
publishDate: 2019-01-17
author:
  - jayoung-lee
  - taodong
image: images/1gKUzs2GxDWCBIS-i218_zQ.webp
category: announcement
layout: blog
---

## How we use user surveys to prioritize engineering effort in Flutter — October 2018 edition

Flutter UX research team is back to share the results of our latest user survey! This online survey was conducted from Oct 29th to Nov 12nd, *before Flutter 1.0 was announced*.

We received responses from 1,966 users, distributed in 108 different countries and regions. The number of respondents has almost doubled since the [last survey in July](https://medium.com/flutter-io/what-weve-learned-from-the-july-2018-flutter-user-survey-cbbf1e04370c), from 1,016. Thank you all for taking your time to answer the questions!

[What We’ve Learned from the July 2018 Flutter User Survey](https://medium.com/flutter-io/what-weve-learned-from-the-july-2018-flutter-user-survey-cbbf1e04370c)

## Are users satisfied with Flutter?

Our users were generally satisfied with Flutter. 93% of the respondents said that they are very satisfied or somewhat satisfied with Flutter, one percent point higher than the results from July 2018. Given that our user base has grown tremendously in 2018, we believe Flutter is doing well at keeping up with the expectations of incoming new users.

In addition, users still found Flutter very helpful or extremely helpful in reaching their full potential engineering velocity and implementing ideal UI (80% and 79% respectively), which are almost identical to the last survey’s results (79% and 80% respectively).

When it comes to performance of Flutter, 86% were very satisfied or somewhat satisfied. We asked this question to those who have used Flutter in “release” mode, which is mode optimized for fast startup, fast execution, and small package sizes with all debugging aids disabled. If you haven’t already, you can check out your app’s actual performance in [release mode](https://flutter.io/docs/testing/build-modes).

One other interesting finding was that a larger percentage of advanced Flutter users (self-reported) were more satisfied with the Dart programming language, as you can see in the graph below. This result may be interpreted in a couple ways. One possibility is that users appreciate Dart more as they gain more experience in the context of developing Flutter apps. The other possibility is that users new to Flutter are skeptical about learning a new language or need a better introduction to Dart to overcome the initial fear of learning a new language. As the user gains more experience, they discover that Dart is similar to many other object-oriented programming languages. Either way, it tells us that we need to support new users better so that they can quickly and easily transition to Dart, and understand the unique benefits of Dart for Flutter development.

<DashImage figure src="images/1cAJxrRQt1MrmnDJ2CkZrNQ.webp" alt="Satisfaction with Dart by self-reported level of experience with Flutter" caption="Satisfaction with Dart by self-reported level of experience with Flutter" />

We also found that the proportion of respondents using Flutter for their main job has increased from 23% to 30%, while the proportion evaluating Flutter for potential production has decreased from 45% to 40%. We’re glad that more developers seemed to have moved from evaluating Flutter to using Flutter in production.

<DashImage figure src="images/1gKUzs2GxDWCBIS-i218_zQ.webp" />

In terms of the packages and plugin ecosystem, the percentage of users who are somewhat or very satisfied has decreased to 74% from 83%. It was a somewhat surprising result, because there has been rapid growth in the number of packages available to Flutter developers. At the end of July, there were 420 packages, and there are now [over 1,200 packages](https://pub.dartlang.org/flutter/packages?q=dependency%3Aflutter). We attributed this decrease in satisfaction to growing expectations of the maturity of Flutter’s package ecosystem, as Flutter itself approached 1.0. We expect this measure to improve as we deliver and refine more first-party plugins such as WebView and Google Maps (added after this survey) and more community members contribute to Flutter’s ecosystem.

We also found that more users are working on Flutter apps that have already been released, compared to the survey in July (15% → 25%), and more users are working on a Flutter app that is about to be released within the next 6 months (52% → 60%). Even before Flutter 1.0 was released, over 3,000+ Flutter apps were available on the Play Store, and based on these survey results, we are looking forward to seeing many more Flutter apps in the near future. To check out some of the apps, refer to the collection of Flutter apps archived by the community, “[It’s all widgets](https://itsallwidgets.com/)”.

## How did the feedback from the last time turn into improvements?

Broad-scale surveys like this are an important way for us to capture user feedback, and we adjust our plans regularly based on this feedback. Hence, [the survey we ran in July](https://medium.com/flutter-io/what-weve-learned-from-the-july-2018-flutter-user-survey-cbbf1e04370c) had an impact on our journey to improve Flutter. We’d like to share some of our efforts to respond to your feedback.

First, users wanted Flutter to better support building iOS style UIs from the July survey. So we worked on many improvements to Cupertino widgets. Below are some changes that were made since the last survey.

<DashImage figure src="images/06d7cgqMRk3cxCH0V.webp" alt="[CupertinoActionSheet](https://docs.flutter.io/flutter/cupertino/CupertinoActionSheet-class.html)" caption="[CupertinoActionSheet](https://docs.flutter.io/flutter/cupertino/CupertinoActionSheet-class.html)" />

<DashImage figure src="images/08bFlQeCsOjn4dJOM.webp" alt="[CupertinoDatePicker](https://docs.flutter.io/flutter/cupertino/CupertinoDatePicker-class.html)" caption="[CupertinoDatePicker](https://docs.flutter.io/flutter/cupertino/CupertinoDatePicker-class.html)" />

<DashImage figure src="images/0RhjtQusRV-2jnKR1.webp" alt="[CupertinoSegmentedControl](https://docs.flutter.io/flutter/cupertino/CupertinoSegmentedControl-class.html)" caption="[CupertinoSegmentedControl](https://docs.flutter.io/flutter/cupertino/CupertinoSegmentedControl-class.html)" />

<DashImage figure src="images/0Hdrg2nvtSyrnyC9v.webp" alt="Hero Nav" caption="Hero Nav" />

<DashImage figure src="images/0sqHRiY_r9CnBz774.webp" alt="[CupertinoAlertDialog](https://docs.flutter.io/flutter/cupertino/CupertinoAlertDialog-class.html)" caption="[CupertinoAlertDialog](https://docs.flutter.io/flutter/cupertino/CupertinoAlertDialog-class.html)" />

For more information, please see the [change log](https://github.com/flutter/flutter/wiki/Changelog). We found that this led to **14%** increase in the proportion of users very satisfied or somewhat satisfied with Cupertino widgets (from 58% to 72%).

We also received lots of comments on the challenges in choosing and implementing state management from the last survey. In the redesigned Flutter.io website launched in November, we added [a new page](https://flutter.io/docs/development/data-and-backend/state-mgmt) to list useful resources on state management. We are working on a more substantial guide on state management. Please check the [flutter.io](https://flutter.io) website for further updates. To track improvements in this area, we started to measure ease of choosing state management patterns and will continue to monitor the metric in future surveys.

The effort in improving documentation was not limited to state management. From the last survey we learned that the hardest thing to do with the current documentation was to“find sample code”. Responding to the gap, our team has been adding more samples to the documentation. We hope you enjoy the new design of sample code added to the API docs as well. You can easily copy the code snippet using the “copy all” button, or visit the “Sample in an app” tab and create a full sample app from a command line, using the unique ID of the app.

<DashImage figure src="images/1gm1C-7frVIwrLDmSJIHOhQ.webp" alt="Sample code of a Card class. The clipboard icon on the upper right corner help you copy the entire code at once." caption="Sample code of a Card class. The clipboard icon on the upper right corner help you copy the entire code at once." />

<DashImage figure src="images/0c-MqZJ30E1AOVgrw.webp" alt="Sample app for a Card class. You can use the clipboard icon to copy the code for this app or use the command to create an app from the command line. See the gif below!" caption="Sample app for a Card class. You can use the clipboard icon to copy the code for this app or use the command to create an app from the command line. See the gif below!" />

<DashImage figure src="images/0-yT0Ipqt2zlSl--a.webp" alt="Create a sample app from the command line" caption="Create a sample app from the command line" />

## How are we prioritizing our engineering effort with users’ feedback this time?

If you participated in the survey, you might remember that in the last section of the survey, we asked you to choose the most and the least valuable feature from a list of six features and repeat that. The section was designed particularly to determine relative priorities of the potential features and to maximize the difference based on a well-established survey method called [Maxdiff](https://www.surveyanalytics.com/max-diff/).

Using the Maxdiff method, the survey forced respondents to make extreme decisions so that we can give different weights to the features being compared against one another. There were 21 features in the survey, which were sourced mostly from GitHub issues with high numbers of reactions. The features covered various topics like IDE tools, new plugins, Dart, etc. The results helped us prioritize our limited engineering resources. Please continue to vote on the [issues](https://github.com/flutter/flutter/issues) you care about, so that we can include emerging needs in future surveys.

In this article, we’d like to share the features that were relatively highly ranked in the survey, and briefly describe what we are going to do to respond to the high needs. Before you read, however, please note that we have other features that are not included in the survey, because they are already on our roadmap, for example, C/C++ integration (GitHub issue [#7053](https://github.com/flutter/flutter/issues/7053)), and plugin for Crashlytics (GitHub issue [#14765](https://github.com/flutter/flutter/issues/14765)).

Also, we would like to emphasize that while we take the survey results seriously, features may not be scheduled for implementation in the exact order in the survey results, because different features may require substantially different amounts of resources and have different challenges. We also prioritize features that may impact a greater number of end-users or where we have additional signals that suggest a feature is of high value.

For the features listed below, we do not have confirmed plans yet for the first half of 2019. However, these features are on our radar, and we would like to continue to actively investigate what is needed to meet the needs.

* [Ranked #1] Built-in support for queryable data storage

* [Ranked #2] Support for building Windows and macOS applications

* [Ranked #3] Support for dynamic platform theming mechanism (changing between Material and Cupertino, depending on runtime platform)

* [Ranked #4] Better support for saving and restoring state

* [Ranked #6] Built-in support for local notifications

* [Ranked #9] Ability for a Flutter app to register a URL handler for deep linking

* [Ranked #10] Built-in support for monitoring network connectivity status

* [Ranked #13] A better build system (e.g., support for codegen, integration with gradle, etc.)

* [Ranked #15] Testing framework for Flutter apps with platform-specific code (e.g., plugins)

* [Ranked #17] Network and cache insights tool

“No confirmed plan” does not mean that we have no plan at all. For example, we are currently researching what options are available for queryable data storage. Also, to support desktop applications, we are investing in supporting core desktop-class UI metaphors, such as mouse scrolling, hover effects, non-primary mouse buttons, and clipboard, as well as support for Android on ChromeOS and Hummingbird (Flutter on Web on desktop). There will be more work to be done beyond this year before we consider Flutter a serious option for writing desktop software.

Good news is that we have features with settled plans.

* [Ranked #5] Support for using Flutter to develop mobile web apps

* [Ranked #7] Code push / hot update for pushing out-of-store updates to apps

* [Ranked #8] Built-in support for in-app payments, including subscriptions

* [Ranked #14] Better performance (frame rendering) diagnosis tool (initial version is already released)

* [Ranked #16] Using control flow elements within a build method (e.g., to conditionally omit one or more elements)

* [Ranked #19] Better memory usage diagnosis tool

You will also be able to find 2019 roadmap on Flutter’s GitHub [Wiki](https://github.com/flutter/flutter/wiki/Roadmap) soon.

Flutter is an open-source project. The list above does not define what Flutter will contain. Instead, it is a list of what *we* will work on, because we consider these features important for the community and the end-users. We always welcome high-quality contributions from other parties, who have a different set of needs.

## What’s next?

We plan to run another user survey again and collect your feedback on various aspects of Flutter, especially after the launch of [Flutter 1.0](https://developers.googleblog.com/2018/12/flutter-10-googles-portable-ui-toolkit.html). Please look out for the next survey, which will be announced on the [flutter.io website](https://flutter.io) and community channels like Twitter ([@flutterio](https://www.twitter.com/flutterio)) and Reddit ([r/FlutterDev](https://www.reddit.com/r/FlutterDev/)).

Flutter’s UX research team is also doing a wide variety of user experience studies to make your experience with Flutter more pleasant. If you are interested in participating in our studies, you can [sign up](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform) for the future user experience studies.
