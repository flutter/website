---
title: "Flutter 2023 Q1 survey — API breaking changes, deep linking, and more"
description: "The Flutter team has been running a quarterly user survey program since its 1.0 release in 2018. The 19th survey was announced in the…"
publishDate: 2023-06-30
author: jayoung-lee
image: images/0BujM3j2SMg1qp3hi.webp
category: announcement
layout: blog
---

## Flutter 2023 Q1 survey — API breaking changes, deep linking, and more

The Flutter team has been running a quarterly user survey program since its 1.0 release in 2018. The 19th survey [was announced](https://twitter.com/FlutterDev/status/1630674202297610240) in the first quarter of 2023, collecting 13,378 responses over the 14-day window. The survey intended to collect timely feedback from Flutter developers, and included questions about the following subjects:

* Perceived growth of Flutter

* API breaking changes

* Deep linking

Overall, 93% of respondents were positively satisfied (somewhat + very satisfied), with 55% being very satisfied. This number has been consistent since August 2022. It’s also notable that developers continued to be highly satisfied with Flutter, because the number of users increased by 24% over this period.

## Perceived growth of Flutter

In this section, we asked how respondents feel about Flutter’s recent growth. We believe that developers’ perception of Flutter’s growth influences their decision to continue using it, and we wanted to know if our perception matches that of our users.

When we asked the respondents to rate the recent growth, 80% said that Flutter’s growth in popularity is fast, as shown in the following graph. This matches our data, which shows that the number of monthly active users has increased by 24% over the last 3 quarters, as previously mentioned.

<DashImage figure src="images/0EvfHfmRcMbEyHcAh.webp" alt="*42% said that Flutter’s growth is very fast and 38% said that it is somewhat fast*" caption="*42% said that Flutter’s growth is very fast and 38% said that it is somewhat fast*" />


The Flutter team’s improvements are a major factor (63%) in the perceived rapid growth of Flutter, according to 80% of respondents who selected “fast” in the previous question (N=2877). Other notable factors include learning resources (57%), tools and services that work with Flutter (51%), and global online communities (50%). It was reassuring to learn that the areas where the Flutter team can improve also contribute to the perceived growth. We will continue introducing new videos, collaborating with other teams to improve tools, and supporting healthy communities.

Of those who said that the growth of the technology is slow (4%, or 137 people), the most common reasons given were a lack of job postings (66%) and adoption by well-known companies (55%). Flutter’s Developer Relations team found that some hiring managers are having trouble finding qualified candidates, and job seekers are having trouble improving their skills to meet the requirements of hiring companies. To bridge this gap, the Flutter team is planning to work on more resources to help Flutter developers improve their skills while working towards a job. We will also continue to share [developer stories](https://youtu.be/bHg6TzuP9bc), so you can see how others are using Flutter for their production apps.

<DashImage figure src="images/0zeJT-J_oHhKYFcem.webp" alt="*Reasons to think the Flutter’s recent growth is fast or slow*" caption="*Reasons to think the Flutter’s recent growth is fast or slow*" />


## API breaking changes

Breaking changes refer to changes that introduce new behavior incompatible with previous versions of the API. Breaking changes help us keep the API clean and consistent, but developers need to update their previously written code to work with the new behavior, whether the change is major like the introduction of null-safety in Dart, or minor like the deprecation of `GestureRecognizer.kind()`.

To reduce the pain associated with the process, Flutter has been announcing breaking changes in various places (such as [the Flutter website](https://docs.flutter.dev/release/breaking-changes), and the [Flutter Announce](https://groups.google.com/forum/#!forum/flutter-announce) or [Dart Announce](https://groups.google.com/a/dartlang.org/g/announce) Google groups). In each stable release, tooling is updated to display warning messages when appropriate and migration tools are provided where possible (Flutter Fix, `dart fix` command). A Flutter developer 2019 survey questioned developers how they felt about breaking changes in order to ensure a cleaner API. Overall, developers liked the idea, but we were asked to keep the following in mind:

* Change slowly

* Offer a good migration tool

* Provide documentation, examples, tutorials, change logs

* Clearly explain the benefit

* Broadly announce it

Because Flutter has experienced significant growth since then (both in number of developers and size of API), we wanted to survey you again and decide whether an update to our policy was necessary.

Overall, the proportion of developers who have been affected by breaking changes in the last 12 months increased from 30% to 51%, over the last 4 years.

<DashImage figure src="images/0BujM3j2SMg1qp3hi.webp" alt="*51% of the developers have experienced breaking changes in the last 12 months*" caption="*51% of the developers have experienced breaking changes in the last 12 months*" />


44% of respondents affected by breaking changes find it frustrating that they have to keep updating their code, which was also higher than 2019 (32%). However, the majority of you agree that the changes made the code cleaner (67%), compared to 2019 (47%). Also, the majority of respondents agree that the changes were valuable (63%), which increased from 49% in 2019.

This suggests that the complexity of the changes we introduced appears to have increased, but we were successful in having the changes deliver value to developers. Given that overall 60% of the respondents think that breaking changes have more benefits than annoyances (whereas 11% hold the opposite view), we learned that the changes have been largely beneficial to the Flutter developers.

<DashImage figure src="images/0YjPyKLHdN6xW-4-3.webp" alt="*Perception around breaking changes*" caption="*Perception around breaking changes*" />


We also asked how satisfied you are with how breaking changes are handled. We learned that satisfaction rates were consistent across the various aspects of our efforts.

<DashImage figure src="images/0LreVRDXghbLuzKDR.webp" alt="*Ratings on the Flutter team’s handling of breaking changes*" caption="*Ratings on the Flutter team’s handling of breaking changes*" />


In light of this, we have decided to double down on our current policy. We plan to find more ways to automate migrations, improve the discoverability of our documentation, and more broadly communicate the value and reasoning behind the changes we do make.

We expect to revisit this again in a few years. As Flutter matures, we believe it’s likely that developers will shift from valuing the improvements introduced in breaking changes to valuing the stability of an API that never breaks. We want to make best use of the time where our community understands the value of breaking changes but not frustrate the Flutter developer base if this attitude changes.

## Deep linking

Deep links send users directly to an in-app location instead of a website or an app store location. Since this is a useful feature for developers, we wanted to measure the awareness of this feature, understand how developers are implementing the feature, and assess how easy it is to set up deep links, so that we can support this feature better.

First of all, we learned that deep links are known to about half of the respondents (55%). Among these, about 50% tried implementing deep links in their Android app, and about 39% tried implementing them in their iOS app, as displayed in the following graph. In both platforms, less than 5% reported that they had trouble implementing the feature.

<DashImage figure src="images/0dQYszaV1ZKzV_b-y.webp" alt="*Percentage of developers who implemented deep links in Android and iOS apps*" caption="*Percentage of developers who implemented deep links in Android and iOS apps*" />


To implement deep links for your app, you need to configure a web portion and an app portion. The web portion directs users to the app, and the app portion then directs users to the correct page.

When it comes to the technology that developers chose to set up their web, about half of respondents said that they use Firebase Dynamic Links. However, we recently learned from the Firebase team that Firebase Dynamic Links is no longer recommended for new projects. The Dynamic Links service will be discontinued in favor of native files (App Links for Android and Universal Links for iOS). You will have at least 12 months to migrate from the date Firebase announces the shutdown. For more information, check out the [Dynamic Links FAQ](https://firebase.google.com/support/dynamic-links-faq).

<DashImage figure src="images/0GfXUuto3tB79I47F.webp" />


<DashImage figure src="images/0q-OVlB4QmxOfjfOM.webp" alt="What developers use to guide users from their websites to an iOS or Android app" caption="What developers use to guide users from their websites to an iOS or Android app" />


For app setup, users have adopted various approaches. Named routes, which is the simplest solution, was the most popular choice (31%). It was followed by the `go_router` package, which is a better solution if you want the features that named routes don’t support, such as route stack management. These features can be particularly useful when you need more control over your deep links.

<DashImage figure src="images/06ZkWSeMzkU_vy8uJ.webp" alt="What developers use to route users within an app" caption="What developers use to route users within an app" />


From the survey, we learned that we should put more effort into explaining the value of the feature so that more developers can benefit from it, and make it easier to implement. We are planning to launch a validation tool in the coming quarters to streamline the implementation process.

## What’s next?

The Flutter team is always eager to hear from you and incorporate your feedback into the engineering roadmap. This quarter’s survey was particularly valuable because it gave us the confidence to continue our breaking change policy and helped us identify blind spots around deep linking. We will continue to listen to you and incorporate your feedback into our work.

The Flutter team is committed to providing the best possible experience for developers. We believe that with your input, we can create a framework that is both powerful and developer-friendly. We appreciate your continued support and look forward to hearing from you in the future. See you in the next survey!
