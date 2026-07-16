---
title: "Improving Flutter with your opinion — Q4 2019 survey results"
description: "Written by JaYoung Lee and Tao Dong"
publishDate: 2020-02-11
author: jayoung-lee
image: images/0W4ladsI7F9pgXph1.webp
category: announcement
layout: blog
---

## Improving Flutter with your opinion — Q4 2019 survey results

<DashImage figure src="images/0W4ladsI7F9pgXph1.webp" />


The Flutter UX research team ran the 7th quarterly survey in November of 2019 and received 6,343 responses. Thank you for participating — each and every response matters. As always, we are back to share our findings.

First and foremost, we found that 93% of respondents are positively satisfied with Flutter, meeting our 2019 goal of maintaining 90% or higher satisfaction rate! We’re delighted that even as Flutter’s active developer base grows, we’ve continued to make developers happy.

Here are the top 5 issues mentioned in the responses. For more information, please read the detailed report below.

1. **Cupertino widgets:** About 20% of all developers are (1) considering or using Cupertino widgets (Flutter’s iOS-styled widgets) for production apps and (2) think that it is *very* or *extremely* important to replicate the iOS look and feel with the Cupertino widgets.

1. **GitHub issues:** Only 15% of the survey respondents have filed at least one issue on the flutter/flutter repo GitHub, and only 23% have voted on existing issues.

1. **CI/CD:** 20% of respondents have used Continuous Integration and Delivery (CI/CD) services for their Flutter projects, and the top three preferred services were: Codemagic, GitLab CI/CD, and Jenkins. 60% to 74% of developers were positively satisfied with these services.

1. **Hot reload:** 70% of respondents think that hot reload is working as expected more than 90% of the time. When hot reload doesn’t work, 23% of developers *seldom* or *never* know why.

1. **Dart String API:** 17% of developers have either heard about or encountered an issue with unicode characters that require two bytes to express, such as emojis, diacriticals, etc. About 10% of those who experienced the issue could not release their app, because of it.

Findings from each topic were shared with the Flutter/Dart team for future planning. Please see the sections below for further details.

## Cupertino widgets

In previous surveys, the Cupertino widget library (which enables the iOS design language in Flutter) have scored lower for satisfaction compared to other subsystems. Only around 70% of developers were *very satisfied* or *somewhat satisfied* with Cupertino widgets, while over 80% of developers are positively satisfied with other subsystems, such as Material widgets or the core framework. Note that the satisfaction rate was calculated after excluding respondents who selected “I have no experience with this.”

<DashImage figure src="images/09ldHbXX7XFfWu-op.webp" alt="*Cupertino widgets have lower satisfaction rate than other Flutter subsystems*" caption="*Cupertino widgets have lower satisfaction rate than other Flutter subsystems*" />


We also noticed that many respondents were indifferent about Cupertino widgets (20% were neither satisfied nor dissatisfied), even when excluding 41% of all respondents who selected “I have no experience with Cupertino widgets.”

<DashImage figure src="images/0j9j0D-2k7v2_NhAX.webp" alt="*20% of developers are neither satisfied nor dissatisfied with Cupertino widgets*" caption="*20% of developers are neither satisfied nor dissatisfied with Cupertino widgets*" />


We wanted to learn why the Cupertino widget set has a comparatively low satisfaction score. From follow-up questions, we learned that only 53% of respondents use Cupertino widgets seriously, either in their production apps, or in evaluating them for potential production use. Others said that they use Cupertino widgets just for fun, for experimenting, or don’t use them at all. This was an important data point, because we wanted to understand the specific pain points when using Cupertino widgets in production, and how big an impediment this was for Flutter developers.

We learned that about 70% of those who use Cupertino widgets *seriously* think that it is *very* or *extremely important* to replicate the appearance and behavior of native iOS design. If we take all developers into account (including those who selected “I have no experience with Cupertino widgets”), this is about 20% of all developers. It tells us that, while Cupertino widgets is a weak area, the benefit of prioritizing this area applies to only a small group of developers.

We appreciate receiving detailed bug reports where you identify fidelity differences, as well as pull requests that fix reported issues, so that we can focus our effort. Recent work includes iOS 13 dark mode. As we make more improvements around Cupertino widgets, you can track progress in our [changelog](https://github.com/flutter/flutter/wiki/Changelog).

<DashImage figure src="images/1BobyRIQmaCBwnw3bYBTe6w.webp" alt="*About 70% of developers who use Cupertino widgets seriously think that it is very or extremely important to replicate native iOS look & feel*" caption="*About 70% of developers who use Cupertino widgets seriously think that it is very or extremely important to replicate native iOS look & feel*" />


## GitHub issues

In addition to quarterly surveys, we use [GitHub issues](https://github.com/flutter/flutter/issues) to solicit feedback and track issues with Flutter in real time. Although many developers file issues and converse with the team on GitHub, we wondered how many of the survey respondents overlap with these GitHub users.

It turns out that only 15% of the survey respondents have filed at least one issue on GitHub, and only 23% have voted on existing issues. Almost a third (29%) of respondents have never filed or voted on an issue.

<DashImage figure src="images/0SKqIROqsnOclxsM2.webp" alt="*Only 15% of respondents had experience filing GitHub issues, and 23% have upvoted for existing issues*" caption="*Only 15% of respondents had experience filing GitHub issues, and 23% have upvoted for existing issues*" />


This confirms that, for many developers, the quarterly user survey might be the only avenue to give direct feedback to the team. Thus, the team will continue to field surveys and monitor both sources to understand developer needs.

## CI/CD

There are several CI/CD (continuous integration and delivery) service options for Flutter. We want to make them more friendly for Flutter developers, but we do not know which pain points are most critical. We asked whether respondents have used CI/CD with Flutter in the past. Of the 20% of developers who have used CI/CD, we asked which service they used, and how satisfied they are.

<DashImage figure src="images/0k2lkGMPnru3RgKI6.webp" alt="*20% of the developers have implemented CI/CD with Flutter*" caption="*20% of the developers have implemented CI/CD with Flutter*" />


As you can see in the graph below, Flutter developers use various CI/CD services, of which the top three are: Codemagic, GitLab CI/CD, and Jenkins. All three had less than 74% satisfaction level, which is not bad, but lower than what we see in other measures of Flutter satisfaction.

<DashImage figure src="images/19im6A1aef_HaADS0nvMkUg.webp" alt="*Satisfaction with various CI/CD services were between 60% and 74% (Note: the services with less than 150 developers are greyed out*" caption="*Satisfaction with various CI/CD services were between 60% and 74% (Note: the services with less than 150 developers are greyed out*" />


From the open-ended question “What is your current CI/CD setup for your Flutter app, and what are the pain points?”, we collected 462 comments. After manually categorizing them, we found 6 common themes that cause pain: missing functionality, difficult set up, configuring the iOS build, speed, stability, and ease of publishing.

<DashImage figure src="images/0PSy8K56xJKtZ_7AX.webp" alt="*More than 60 respondents commented about missing functionality and difficulty in setup as their pain points when using CI/CD services with Flutter*" caption="*More than 60 respondents commented about missing functionality and difficulty in setup as their pain points when using CI/CD services with Flutter*" />


Based on the data, we are brainstorming on ways to address these issues. The first proposal suggests officially maintaining several CI/CD integration configurations. The second proposal suggests providing tools to simplify iOS building, managing certificates, and so on. The third proposal suggests collaborating with Firebase to provide better integration with the Firebase test lab. Although the decision has not been finalized, the team will use feedback from the survey to ensure that we offer what is actually wanted and needed.

## Hot reload

Feedback from previous surveys and user studies have shown that developers had some difficulty understanding hot reload’s limitations — when *doesn’t* hot reload update the UI?

The Flutter team has plans to make hot reload easier to understand and more trustworthy. In this survey, we wanted to establish a baseline against which the effectiveness of future improvements can be measured.

According to the survey, 70% of respondents think that hot reload is working as expected more than 90% of the time. When it doesn’t work, 23% of developers *seldom* or *never* know why. Even 20% of those who have used Flutter for over a year seldom or never know why it doesn’t work.

<DashImage figure src="images/05DO-hJz2NO5xPsMT.webp" alt="*About 70% of respondents think that hot reload work as expected in &gt;90% of the cases*" caption="*About 70% of respondents think that hot reload work as expected in &gt;90% of the cases*" />


<DashImage figure src="images/0nA3zAVD8v8ArX5ai.webp" alt="*20% to 27% of developers seldom or never know why hot reload doesn’t work (23% overall)*" caption="*20% to 27% of developers seldom or never know why hot reload doesn’t work (23% overall)*" />


Because hot reload touches almost every aspect of Flutter, from the IDE to the Dart VM, we held a cross-team workshop to analyze open-ended comments survey respondents submitted; we identified both known and unexpected hot reload limitations that developers ran into in the wild.

We will take the following actions in the next few months:

* Remove the StatelessWidget to StatefulWidget hot reload restriction
[https://github.com/flutter/flutter/pull/48932](https://github.com/flutter/flutter/pull/48932)

* Verify the problem that hot reload doesn’t reflect asset changes (for example, fonts or images)
[https://github.com/flutter/flutter/issues/49230](https://github.com/flutter/flutter/issues/49230)

* Look into the issue about doing a hot reload while using the debugger
[https://github.com/flutter/flutter-intellij/issues/2241](https://github.com/flutter/flutter-intellij/issues/2241)

* Take a look at state management packages and how using them affects hot reload behavior
[https://github.com/flutter/website/issues/3566](https://github.com/flutter/website/issues/3566)
[https://github.com/flutter/flutter-intellij/issues/4310](https://github.com/flutter/flutter-intellij/issues/4310)

* Document hot reload limitations with regard to native code changes, routing, and package changes
[https://github.com/flutter/website/issues/2920](https://github.com/flutter/website/issues/2920)

* Surface VM connection status in the IDE
[https://github.com/flutter/flutter-intellij/issues/4309](https://github.com/flutter/flutter-intellij/issues/4309)

We also have plans to allow the IDE to suggest hot restart after non-reloadable code changes have been made. However, more investigations are needed to minimize false positives and ensure an unobtrusive developer experience.

## String API

Dart’s String API doesn’t support manipulating [extended grapheme clusters](https://github.com/dart-lang/language/issues/34) such as 👍 😀 and 🇩🇰, out of the box. To address this limitation, the Dart team recently published an experimental package called [characters](https://pub.dev/packages/characters). However, it’s unclear whether this solution is sufficient and, in this survey, we wanted to find out.

17% of developers have heard about or experienced the extended grapheme clusters issue. About 10% of those who experienced the issue could not release their app because of it.

<DashImage figure src="images/0BqpEt11-35wDedUr.webp" alt="*17% of developers have heard about or ran into the extended grapheme clusters issue*" caption="*17% of developers have heard about or ran into the extended grapheme clusters issue*" />


When we asked whether developers prefer built-in grapheme support in the String API, which would require breaking changes, or the current package-based solution, the opinions came to a nearly even split. Nonetheless, we are surprised by the number of developers who are willing to consider breaking the String API in exchange for first-class support of extended grapheme clusters, as you can see below.

<DashImage figure src="images/0_Eo60HUKPSvvx_p_.webp" alt="*The opinion was almost an even split. To our surprise, many developers preferred the breaking change option (option 1) over the package option (option 2).*" caption="*The opinion was almost an even split. To our surprise, many developers preferred the breaking change option (option 1) over the package option (option 2).*" />


The results from this survey will help the team evaluate the options and tradeoffs further this quarter. We’ll continue taking feedback from the community through discussions on related bugs and with more targeted user studies.

## And finally..

Flutter’s quarterly user survey is an invaluable way for us to understand your experience with Flutter. Your feedback directly affects where we focus our efforts. Please continue to support the surveys, and also consider [signing up](https://flutter.dev/research-signup) for future UX studies.

Thank you!