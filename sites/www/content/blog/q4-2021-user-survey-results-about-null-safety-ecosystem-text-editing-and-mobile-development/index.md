---
title: "Q4 2021 user survey results: about null safety, ecosystem, text editing, and mobile development"
description: >-
  Last November, the Flutter UX team ran the 15th quarterly user survey. The
  survey was announced via Flutter’s IDE plugins, YouTube…
publishDate: 2022-02-22
author: jayoung-lee
image: images/0Zw_zyVq5CfP7Y09o.webp
category: announcement
layout: blog
---

Last November, the Flutter UX team ran the 15th quarterly user survey. The survey was announced via Flutter’s IDE plugins, YouTube, Twitter, and the website. Over 2 weeks, we were able to collect 10,105 responses, an all-time high, and we learned that Flutter developers continue to be satisfied with Flutter. The proportion of people positively satisfied with Flutter was 92%, which is stable since Q4 2019.

Through the survey, the Flutter team also learns what’s going well and what’s not going well with Flutter in more detail, and then sets priorities for future tasks. In this survey, we asked about the four following topics to get an in-depth understanding of these areas.

* Null safety

* Ecosystem

* Text editing

* Mobile development

To keep the survey short, we asked different questions to different cohorts, so you might not have seen all four topics. Regardless, we received meaningful, statistically significant feedback around these topics from everyone who participated. As an open source project, we try to be as transparent as possible about what data we collect, and so we’re here to share the results and our learnings.

## Dart null safety

The stable version of Dart null safety was [released](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87) in March 2021. It was one of the largest additions to the language, and we provided a migration tool and a [guide](https://dart.dev/null-safety/migration-guide) to help developers migrate existing code to null safety. We wanted to know how the migration experience has been for you, so that we can do better if we attempt to make similar language changes in the future.

Overall, 89.5% of those who have used Dart null safety in the past 6 months were satisfied with the feature. Those who had previous experience with null safety (such as Kotlin) were more likely to be satisfied with the feature (+3 percentage points). The biggest benefit of Dart null safety was “reduced bugs in code” (79.4%), followed by “easier-to-understand code” (49.7%).

<DashImage figure src="images/0rgxmarvcoWZXajfo.webp" alt="*79% of the users had experience with Dart null safety, and 90% were satisfied with it*" caption="*79% of the users had experience with Dart null safety, and 90% were satisfied with it*" />

<DashImage figure src="images/0onZxbszDrpFkZpHa.webp" alt="*Most users (79%) said that Dart null safety reduced bugs in their code*" caption="*Most users (79%) said that Dart null safety reduced bugs in their code*" />

Interestingly, 39.9% said that all their code has used null safety from the start. Given that the survey was fielded only after 8 months since the introduction of stable null safety, the survey showed how quickly Flutter and Dart has grown, welcoming new developers. This result also showed that 59% of those who migrated their code used the migration tool in one way or another (22.0% out of 22.0%+19.6%+6.7%).

<DashImage figure src="images/0rnrluPpgWlvPFw84.webp" alt="*40% of the users used null safety from the start, and 59% migrated their code to null safety*" caption="*40% of the users used null safety from the start, and 59% migrated their code to null safety*" />

Overall, the survey results supported continuing to evolve the Dart language to make it better. We will continue to make improvements and take your experience into consideration along the way. Please keep the feedback coming!

## Ecosystem

As Flutter continues to mature, its package and plugin ecosystem has improved. This improvement includes contributions from the community, as well as programs and promotions like [Flutter Favorites](https://docs.flutter.dev/development/packages-and-plugins/favorites), [Plus plugins](https://plus.fluttercommunity.dev/), and [Package of the Week](https://www.youtube.com/playlist?list=PLjxrf2q8roU1quF6ny8oFHJ2gBdrYN_AK). As shown below, satisfaction with the ecosystem improved by 7 percentage points over the last 2 years.

<DashImage figure src="images/09wOwZ1d4K6Yr3evt.webp" alt="*Satisfaction with Flutter’s package and plugin ecosystem has increased by 7.5 percent point over the last 2 years*" caption="*Satisfaction with Flutter’s package and plugin ecosystem has increased by 7.5 percent point over the last 2 years*" />

Nevertheless, we continue to hear from you that there still are many packages and plugins that need improvement. To better understand your needs, we asked “Did any Flutter or Dart package decrease your app development productivity in the last 3 months?” When 28.7% of 3,698 answered “Yes” to this question, we presented 42 different packages types, and asked which of the packages decreased productivity. The top 15 packages are below.

<DashImage figure src="images/0tySCnxRM1tJCRUFQ.webp" alt="*While various packages contributed to decreased productivity of developers. The top choice “Firebase” got votes from 22%.*" caption="*While various packages contributed to decreased productivity of developers. The top choice “Firebase” got votes from 22%.*" />

Firebase is widely used by Flutter users, which contributed to the relatively large number (22.1%). We’re continuing to invest into Firebase plugins (“[FlutterFire](https://firebase.flutter.dev/)” plugins). For example, last December, we [released stable versions of the FlutterFire plugins](https://medium.com/flutter/whats-new-in-flutter-2-8-d085b763d181) and standardized them. It means that all the FlutterFire plugins now use the same underlying version of the SDKs, and developers won’t run into version incompatibility issues when they mix and match the plugins. We plan to monitor this and we’re hoping to see Firebase become a more productive service for developers when we next field this question.

What’s also notable in the graph above was that 42 common items could not cover all the needs, and 19.2% chose to specify “Other” types of packages and plugins that decrease their productivity. It highlights that there are so many diverse needs that we can only solve as a community.

For these packages, the biggest challenge was with feature completeness — 23.1% said that packages have incomplete features, so they have to use multiple packages for similar functions or cannot fulfill their needs.

<DashImage figure src="images/0OlvN2DIgkndtxdUc.webp" alt="*Feature completeness of packages was the biggest contributor to the developers’ decreased productivity*" caption="*Feature completeness of packages was the biggest contributor to the developers’ decreased productivity*" />

The Flutter team has been working to improve the development process for our first-party plugins to make them easier to maintain and improve. For example, `webview_flutter` 3.0 was released recently to address many top feature requests, and we are continuing to invest in addressing the top-voted issues in that and other plugins.

Even as we ourselves continue to invest in [the](https://pub.dev/publishers/labs.dart.dev/packages) [hundreds](https://pub.dev/publishers/flutter.dev/packages) [of](https://pub.dev/publishers/dart.dev/packages) [packages](https://pub.dev/publishers/tools.dart.dev/packages) that the Flutter and Dart teams own, this is an area where the Flutter community can also play a key role. We all benefit when we all invest in package development!

## Text editing

Flutter provides built-in widgets like `TextField`, `TextFormField` (and their Cupertino counterparts), and various packages to allow you to add text editing functionality to your apps. This can become complicated quickly, when features like live filtering and formatting (such as number-only phone number or price input fields), or rich text editors (such as code or math equation editors) are required.

From this survey, we learned that about 86.7% of developers with intermediate or more experience tried adding text editing to their apps, and the satisfaction with the text editing functionality drop from 82.3% (single-line) and 82.2% (live filtering and formatting) to 69.6% (multi-line) and 66.6% (rich text editor).

<DashImage figure src="images/0J9YkkSqIT3dP1CzI.webp" alt="*Experts tended to have more experience adding text editing functionality to their apps*" caption="*Experts tended to have more experience adding text editing functionality to their apps*" />

Based on this feedback, the core framework team is planning to build solid basic rich text editing features and APIs to support packages. Also, the team is planning to better advertise existing features and build more examples. In the meantime, you can explore the [design doc](https://docs.google.com/document/d/1PXNd_LwJudiUTnCM2AXRxbd98_p4BlFf6qFhEhv3wvs/edit) on text editing deltas to find useful documentation, as well as [this Github issue](https://github.com/flutter/flutter/issues/87972), to stay up to date on progress. This effort is already well underway with a few low-level APIs now in the master channel.

We’ve also heard about challenges related to supporting different languages. For example, we heard loud and clear that RTL and bi-di text, such as Arabic, does not work acceptably well. Although there’s no written roadmap, we’re planning to make a big push to better support RTL and bi-di text editing soon.

## Mobile development

Because mobile platforms (iOS and Android) were the first ones to be officially supported by Flutter, the majority had experience working on iOS or Android apps in the last 6 months. The team wanted to better understand platform-specific issues, such as challenges related to debugging and releasing, so that the team can better prioritize their engineering effort.

<DashImage figure src="images/0TERDonM4zc_kafRm.webp" alt="*In the last 6 months, 72% and 91% had developed for iOS and Android, respectively*" caption="*In the last 6 months, 72% and 91% had developed for iOS and Android, respectively*" />

When it comes to debugging, in both platforms, users had to deal with platform specific issues while adding or upgrading packages or plugins most often. While debugging Android issues was less common in many situations, it was notable that debugging to optimize the performance was more common on Android than iOS.

<DashImage figure src="images/0AiW2zfqRgJcWNqKn.webp" alt="*Debugging platform issues happened more often while adding or upgrading packages or plugins*" caption="*Debugging platform issues happened more often while adding or upgrading packages or plugins*" />

We also learned that dealing with Xcode (iOS) and Gradle (Android) was the most common issue while releasing an app, which matched our hunch. We already made the Flutter CLI show user-friendly error messages for common Gradle errors, which was released in the latest update, [Flutter 2.10](https://medium.com/flutter/whats-new-in-flutter-2-10-5aafb0314b12).

We will continue to improve the way these build system errors are presented, so that it’s easier to understand and more actionable. For iOS, we will add features to `flutter build ipa` in an upcoming release ([related issue here](https://github.com/flutter/flutter/issues/97179)) that makes release easier. More Xcode settings will be automatically populated in new projects as well ([issue](https://github.com/flutter/flutter/issues/90020)). For Android, we are working on an auto-migration tool, which will be handy to find small discrepancies in Gradle config files.

<DashImage figure src="images/03MXILeNbFbIFagLu.webp" />

<DashImage figure src="images/0qtLcSyZO68tuY6Gk.webp" alt="*Over 36% of developers dealt with Xcode (iOS) and Gradle (Android) issues while releasing their apps*" caption="*Over 36% of developers dealt with Xcode (iOS) and Gradle (Android) issues while releasing their apps*" />

## What’s next?

Developers are increasingly using Flutter as part of their main job. The Flutter team will continue to listen and shape our technology using your feedback. If you have any urgent issues, please file an issue on [GitHub](https://github.com/flutter/flutter/issues).

<DashImage figure src="images/0Zw_zyVq5CfP7Y09o.webp" alt="*The proportion of devs using Flutter for main job has been increasing*" caption="*The proportion of devs using Flutter for main job has been increasing*" />

The Flutter quarterly user survey will continue seeking answers to important questions. You can also post your research ideas on [GitHub](https://github.com/flutter/uxr/discussions/categories/research-ideas). Please keep an eye out for the next survey. Also, consider participating in other research by [signing up for upcoming UX studies](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform).

Thanks again to everyone who provided feedback!
