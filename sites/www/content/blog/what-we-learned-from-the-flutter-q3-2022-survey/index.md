---
title: "What we learned from the Flutter Q3 2022 survey"
description: "About Firebase SDKs, quick fixes and refactorings, and target platforms"
publishDate: 2022-12-08
author: jayoung-lee
image: images/0XaZXV1SPtqbuZhFc.webp
category: announcement
layout: blog
---

More than 10,000 Flutter developers have been participating in the quarterly user survey in the past couple years to give feedback to the Flutter team. The most recent quarter was no exception — the Flutter team wanted to collect developer feedback about four topics: 1) Firebase SDKs, 2) quick fixes and refactorings, 3) target platforms, and 4) desktop support. Of these four topics, the survey presented each respondent with two random topics. Thanks to those who responded!

This article covers the results about the first three topics. We’ll cover the last topic (desktop development) in another article.

Before jumping into the results of the first three special topics, we’d like to report that Flutter developers continue to love the framework. Of the survey respondents, 55% are *very satisfied* with Flutter, and an additional 38% are *somewhat satisfied* with Flutter. This brings the total of satisfied developers to 93%. This has been consistent over the last three quarters. The percentage of *very satisfied* developers had a slight drop to 55%. We plan to track this metric and study what might reduce developer satisfaction from *very satisfied* to *somewhat satisfied*.

<DashImage figure src="images/0jYeqpOHh1OgqKmqW.webp" alt="Figure 1. Satisfaction with Flutter over time" caption="Figure 1. Satisfaction with Flutter over time" />

As shown in **Figure 2**, our respondents love the core framework, Android support, and Material widgets. Our biggest opportunity lies with Cupertino widgets and web support. We continue to study what’s needed to improve developer experience in these areas and further invest to advance it. If you want to participate in future user studies, you can sign up at [flutter.dev/research-signup](https://flutter.dev/research-signup).

<DashImage figure src="images/0XaZXV1SPtqbuZhFc.webp" alt="Figure 2. Satisfaction with subsystems" caption="Figure 2. Satisfaction with subsystems" />

## Firebase SDKs for Flutter

Flutter developers use [Firebase SDKs for Flutter](https://pub.dev/publishers/firebase.google.com/packages) (aka FlutterFire) for tools and services that Firebase provides. These include authentication, databases, analytics, and messaging. Currently, fifteen stable [Firebase plugin packages](https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins) are available on pub.dev. Because of the great adoption of these packages, we wanted to explore what kind of learning materials would increase their usability.

The most useful information we learned was the problems developers had when trying to use various Firebase packages. As shown in **Figure 3**, Developers cited “not enough real-world examples” as the most common issue that they faced when trying a new Firebase package (14.2%). This was particularly problematic for complex packages with many moving parts, like `firebase_messaging` or `firebase_dynamic_links`. To address this, we’ll be adding more [sample apps to the Firebase docs](https://firebase.google.com/docs/samples). We’re adding two types of sample apps. The first, “quickstart samples”, will cover the use of a specific Firebase package. The second will provide more complex, real-world example apps that use multiple Firebase packages.

<DashImage figure src="images/0hdD0EJyfncwlgAtW.webp" alt="Figure 3. Problems with adopting a new Firebase SDK for Flutter" caption="Figure 3. Problems with adopting a new Firebase SDK for Flutter" />

In the survey, a number of developers also selected “API design was too complicated or inconvenient”. This finding was consistent across many packages, like `firebase_database`, `firebase_in_app_messaging`, including the packages mentioned in the previous section. We found this result notable. Though some APIs are simple and small, the concepts they cover, like asynchronous data, aren’t. With this in mind, we will strive to simplify learning materials. Furthermore, we will aim to make new and existing APIs for tools and services as easy to understand as possible.

“Overall quality of documentation was low” was the last of the top three issues. To respond to this need, we plan to improve the Firebase documentation for Flutter developers. We will add new sections in the Firebase documentation for the Firebase UI packages, such as Firebase UI for Auth, and more code samples throughout. The changes will roll out throughout the coming quarters.

## Quick fixes and refactorings

In the [first survey of 2022](https://medium.com/flutter/does-flutter-boost-developer-productivity-475f713724b3), developers indicated that quick fixes and refactorings are the top missing or insufficiently-supported features in our IDEs. As you can see in **Figure 4**, we support quick fixes and refactorings in the IDE, but we wanted to identify *why* developers think that the IDEs are missing or not supporting these features.

<DashImage figure src="images/08Ewc1lTs1hnn1Y0w.webp" alt="Figure 4. Quick fixes and refactorings in VS Code" caption="Figure 4. Quick fixes and refactorings in VS Code" />

First, we learned that more than half of the respondents think that quick fixes and refactorings work fine (53.1%), as shown in **Figure 5**. Yet, 34.6% said more features need to be added. This was almost three times more than the number of developers who asked us to fix bugs (12.4%).

<DashImage figure src="images/0CfG7t7ePTA-LlwyZ.webp" alt="Figure 5. The current status of quick fixes and refactorings" caption="Figure 5. The current status of quick fixes and refactorings" />

We then asked those who want new features what general category of quick fixes or refactoring features they needed. Before designing the question, we reviewed all the relevant GitHub issues and did a quick [Twitter survey](https://twitter.com/craig_labenz/status/1547650452023435%20267?s=20&t=hOjRR_RImDoyIP38CqsjLA) to organize various feature requests into groups. You can see the list of groups in **Figure 6.**

<DashImage figure src="images/0rbSxslPyUG71IB-Y.webp" alt="Figure 6. Importance of quick fixes and various refactorings features" caption="Figure 6. Importance of quick fixes and various refactorings features" />

From this question, we learned that respondents found adding more quick fixes for “fixing compilation errors, warnings, or lints” to be more important than others (76.4% “very important”), though it doesn’t reduce the importance of other features. We also learned that respondents found “extracting or moving widgets” to be more important than other refactorings (69.2% “very important”). We now know that, although we support extracting and moving widgets, developers want more options, such as extracting a widget to a new file. This matches various GitHub issues filed: [flutter/flutter-intellij/issues/5591](https://github.com/flutter/flutter-intellij/issues/5591), [Dart-Code/Dart-Code/issues/1831](https://github.com/Dart-Code/Dart-Code/issues/1831), [flutter-intellij/issues/4540](https://github.com/flutter/flutter-intellij/issues/4540), [dart-lang/sdk/issues/35767](https://github.com/dart-lang/sdk/issues/35767), and others. In addition, developers also want more features for restructuring libraries, classes, or methods (61.9% “very important”), as well as managing imports (59.7% “very important”).

All of this information was greatly valued by the Dart Analyzer team, who will be reviewing the diagnostics to identify opportunities for additional fixes. The team has already started adding some new fixes for diagnostics (to be released with Dart 2.19), with more planned for future releases.

## Target platforms

Flutter developers can build production quality apps for six platforms: Android, iOS, web, Windows, macOS, and Linux. In this section of the survey, we wanted to know which of the six platforms developers target, and whether they use Flutter for multiplatform development at a team-level. Our questions asked first about the platforms on which developers write code and then asked about additional platforms their team targets.

As shown in **Figure 7**, most developers target Android (91.7%), iOS (61.3%), and web (35.5%). Some overlap occurred, as this question allowed for multiple answers. Counting the number of platforms selected, only 24% of the developers targeted only one platform in the last month. Of the respondents, 76% developed for two or more platforms, with(32% developing for three or more).

<DashImage figure src="images/0WHlC27Td3vNoiDFc.webp" alt="Figure 7. Target platforms developers are actively building and app for" caption="Figure 7. Target platforms developers are actively building and app for" />

In addition, we wanted to know how many of the developers were on a development team, where teammates developed for a platform that’s different from their own. For example, developer A targets Android and developer B targets iOS. As shown in **Figure 8**, 40% of the developers said they had a coworker who’s working on a different platform than theirs. This increased to 61%, when we filtered for the developers who said they themselves were developing for only one platform.

<DashImage figure src="images/0DWsq2C8LftK67nYq.webp" alt="Figure 8. Teammates developing for an additional platform" caption="Figure 8. Teammates developing for an additional platform" />

When combined, we could calculate that 91% of the Flutter teams are active multiplatform development teams (24%*0.61 + 76%). At least 72% of the respondents developed apps for both Android and iOS. Of the total respondents, 34% targeted iOS, Android, and the web and 12% targeted iOS, Android, the web, and Windows.

## What’s next?

We want to deliver a great development experience that maximizes productivity. The insights we gain from this and other surveys are invaluable. We’ll use these results to prioritize engineering tasks and education content that’s useful to the Flutter developers.

We’ll be back in 2023 with more survey results. Before then, we will publish a separate article about what we learned from the research about desktop support. See you in the next article!
