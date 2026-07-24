---
title: "Flutter on the web, slivers, and platform-specific issues: user survey results from Q3 2020"
description: >-
  Explore Q3 2020 survey findings about
  Flutter web usage, slivers, and platform-specific development challenges.
publishDate: 2020-10-20
author: jayoung-lee
image: images/0_CopRAy_n9COQGqR.webp
category: announcement
layout: blog
---

In August 2020, the Flutter team launched its 10ᵗʰ quarterly user survey. Over 10 days, 7,668 users responded to the survey globally. Each user spent about 7.4 minutes to complete the survey, which equals 39.4 days of developer time. We deeply appreciate the time everyone took to provide feedback to us, and we want to share the results with you.

Like we always do, we asked about your level of satisfaction with various parts of Flutter. This quarter, we also focused on getting feedback about additional topics, such as Flutter on the web, slivers (widgets for rich scrolling effects), and debugging platform-specific issues. We cover each of the topics in more detail in this article. If you’re interested, read on!

**Summary**

* 94% of the respondents were positively satisfied (PSAT) with Flutter overall, and 58% were very satisfied (VSAT). While PSAT is stable, VSAT is increasing continuously.

* The percentage of users working for enterprise companies increased from 26% to 31%. The proportion of advanced users is increasing as well.

* 59% of those who worked with Flutter on the web in the last 3 months were positively satisfied with the performance of it. 71% were positively satisfied with Flutter’s ability to create a UI that feels natural on the web.

* 79% of the users who wanted to implement rich scrolling effects with slivers tried using them. The biggest issue (36%) was difficulty finding the widget that met their needs.

* 71% of the users have experience debugging platform-specific issues. The common issues were with tooling (32%), visual differences (28%), and dependency management issues (28%).

## Satisfaction and changes in user base

The percentage of users that were *very satisfied* with Flutter hit a record high at 58% this quarter. Overall, Flutter users continued to be satisfied with the product (94%), even with the exponential growth of the community. The following graph shows how the level of satisfaction with Flutter has progressed over time.

<DashImage figure src="images/0k_YiDB0OZTd8WQI2.webp" alt="*58% of the users selected “Very satisfied” for the question asking, “Overall, how satisfied are you with Flutter?”*" caption="*58% of the users selected “Very satisfied” for the question asking, “Overall, how satisfied are you with Flutter?”*" />

There were some notable changes to our user base. First, the percentage of users working for enterprise companies increased significantly to 31%, from 26% in Q1 and Q2, while the percentage of users working for start-ups remained stable at around 35% during this period.

<DashImage figure src="images/0mTLE89U4VUtGDnEI.webp" alt="*While most of the Flutter users are working for start-ups, the percentage of developers working for enterprises increased significantly from 26% to 31%.*" caption="*While most of the Flutter users are working for start-ups, the percentage of developers working for enterprises increased significantly from 26% to 31%.*" />

Another notable change was in the perceived level of experience with Flutter. As you can see in the following graph, the proportion of novice users decreased over time, while the proportion of advanced users increased over time. This means that we have more experienced users in our community who can help share their knowledge with novice users. If you’re interested in gaining or sharing knowledge, you can participate in online conversations with other Flutter developers. Visit the [Community tab](https://flutter.dev/community) on flutter.dev.

<DashImage figure src="images/0_CopRAy_n9COQGqR.webp" alt="*The proportion of advanced users is increasing continuously.*" caption="*The proportion of advanced users is increasing continuously.*" />

## Flutter on the web

Flutter supports web development in beta, in addition to supporting mobile in the stable channel. In this survey, we asked about specific issues early adopters had regarding performance, web-like experience, workflows, and documentation, so that we can prioritize important issues.

Survey respondents were actively using Flutter to build web apps. About 33% said they have either evaluated Flutter on the web for potential production use (15%), have built a demo (11%), or published a production app (7%), as shown in the third row of the following graph.

<DashImage figure src="images/0R7aSejQwaxUY2W9L.webp" alt="*33% of the users (1,468 out of 4,449) reported that they have either evaluated Flutter on the web for production (15%), have built a demo* (11%), *or published a production app (7%).*" caption="*33% of the users (1,468 out of 4,449) reported that they have either evaluated Flutter on the web for production (15%), have built a demo* (11%), *or published a production app (7%).*" />

More specifically, 29.5% of the users who had both mobile and web experience used Flutter on the web more seriously (for potential production) in the last 3 months. The percentage varied depending on the developers’ prior experience with the platforms. It appears that the respondents with web-only backgrounds were trying Flutter as an alternative web framework (22% tried Flutter on the web for potential production), and the respondents with mobile-only backgrounds were actively trying Flutter on the web as a gateway to web development (16% tried Flutter on the web).

<DashImage figure src="images/0C0d4X2FddTe0fC6A.webp" alt="*The percentage of users who tried Flutter on the web for production in the last 3 months varied depending on their prior experience with mobile and web platforms.*" caption="*The percentage of users who tried Flutter on the web for production in the last 3 months varied depending on their prior experience with mobile and web platforms.*" />

The Flutter web team also collected feedback regarding various issues around creating a web-like experience. First, we learned that the respondents found browser navigation and routing history (55%), copying/pasting selected text (34%), scrolling physics (33%), and selecting text (32%) as the most critical in creating a web-like experience. Respondents also asked for better documentation for routing and adapting mobile layouts to the web.

<DashImage figure src="images/08WXtO7Mx_n5Gs0m_.webp" alt="*Users selected “browser navigation and routing history” as the most critical feature in creating a web-like experience using Flutter.*" caption="*Users selected “browser navigation and routing history” as the most critical feature in creating a web-like experience using Flutter.*" />

The Flutter team is actively making improvements based on the feedback we receive. To address the top user issues around navigation and routing, the team recently released [Navigator 2](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade). We also added support for [copying/pasting selectable text](https://github.com/flutter/flutter/issues/47234), and have plans to improve the [selectable text](https://github.com/flutter/flutter/projects/173#card-43620465) functionality (especially for rich text). We are continuing our efforts to enhance scrolling physics and performance based on issues reported by the community.

Finally, the team received feedback around workflows, performance, and third-party APIs. Within basic workflows, respondents found debugging the most difficult. Page loading speed and scrolling were the most common performance issues respondents ran into. Respondents wanted Flutter on the web to have better support for local storage (for example, SQLite), Firebase storage, and Google Maps. These areas will shape up as the team makes progress in Flutter on the web.

## Slivers

Sliver widgets (widgets that start with “Sliver” such as SliverAppBar and SliverList) are used to create rich scrolling effects. While many scrolling effects can be achieved with widgets like ListView, GridView, PageView, or AnimatedList, sliver widgets help customize the scroll view and achieve a more beautiful UI.

<DashImage figure src="images/0a-qk7SfiAnHAq2vU.webp" alt="*You can achieve rich scrolling effects like this with sliver widgets.*" caption="*You can achieve rich scrolling effects like this with sliver widgets.*" />

The Flutter team has heard different stories about users’ experience with slivers. Some said that they don’t use slivers in their apps, and some said that they need more slivers to implement various effects. So, the team decided to add questions to this quarter’s survey, to better understand how Flutter users work with slivers.

The first thing we learned was that more users design their UIs with simple scrolling effects (49%) than with rich scrolling effects (39%). (An example of a simple scrolling effect and an example of a rich scrolling effect were presented in the survey.) For those who need rich scrolling effects, 78% said that they need slivers to implement the effects they want.

<DashImage figure src="images/0YNnoQE06DVStrvWV.webp" alt="*More users design their UIs with simple scrolling effects (49%) than with rich scrolling effects (39%).*" caption="*More users design their UIs with simple scrolling effects (49%) than with rich scrolling effects (39%).*" />

Out of those who needed slivers, 20% said that they haven’t tried slivers. What’s more interesting to us is that 35% of the users who said that they tried to use slivers had issues with slivers. When we asked about the biggest issues for them, as shown in the following graph, the discovery issue was the biggest (36%), followed by the learning issue (30%), and then the usability issue (19%).

<DashImage figure src="images/0-P_8Vyu4EMCZ4ji0.webp" alt="*Discovery was the biggest issue for sliver users, followed by the learning issue, and the usability issue.*" caption="*Discovery was the biggest issue for sliver users, followed by the learning issue, and the usability issue.*" />

Because we do not want you to compromise your UI as a consequence of these issues, we plan to update [flutter.dev](https://flutter.dev/), so that the sliver widgets and relevant information about slivers are easier to find and easier to learn. If you’re looking for new slivers that aren’t in the Flutter framework, consider using community packages, such as [sliver_tools](https://pub.dev/packages/sliver_tools) or [sticky_headers](https://pub.dev/packages/sticky_headers). The Flutter community always welcomes your contribution to this area as well.

In the meantime, if you’re new to slivers and want to learn more, visit the following resources:

* [Slivers, demystified](https://medium.com/flutter/slivers-demystified-6ff68ab0296f) (Medium article)

* [Slivers explained — making dynamic layouts](https://www.youtube.com/watch?v=Mz3kHQxBjGg) (The Boring Flutter Development Show on YouTube, Ep. 12)

## Debugging platform-specific issues

In the [previous survey](https://medium.com/flutter/what-are-the-important-difficult-tasks-for-flutter-devs-q1-2020-survey-results-a5ef2305429b), we found that *troubleshooting platform specific issues* and *testing apps across platforms* are the most difficult tasks for Flutter developers. Although we saw some bugs related to platform-specific issues, we didn’t know the relative priorities of the issues and if they’re bundled in themes or spread out. To find the true reasons why troubleshooting and testing are difficult to perform, we added questions that ask what specific issues users encountered.

First, we asked which platform-specific issues users debugged. We found the most *common* platform-specific issues are tooling issues (32%), visual differences in different platforms (28%), dependency management issues (28%), behavioral differences in different platforms (27%), plugin behavior differences in different platforms (26%), and missing native features (25%).

<DashImage figure src="images/0YB3J0hC7A6F7NdXE.webp" alt="*The most common platform-specific issues are tooling issues, visual differences, and dependency management issues.*" caption="*The most common platform-specific issues are tooling issues, visual differences, and dependency management issues.*" />

Survey respondents also rated the importance and difficulty of each of the issues they debugged. The most *important* issues to debug are missing native features, performance discrepancies, behavioral differences, plugin behavior differences, and release issues. The most *difficult* issues to debug are missing native features, device-specific issues, performance discrepancies, dependency management, and tooling issues.

<DashImage figure src="images/0WdHGeM6kI6hqtQGw.webp" alt="*The importance and difficulty of platform-specific issues. (The error bar represents the 95% confidence interval.)*" caption="*The importance and difficulty of platform-specific issues. (The error bar represents the 95% confidence interval.)*" />

Regarding testing apps across multiple platforms, 85% of the respondents said that it’s very or extremely *important*. Yet, it was very or extremely *difficult* for 27% of the respondents. So, testing apps across multiple platforms is important, but most developers don’t feel it’s a big blocker for them. From the open-ended comments, we learned that the most common testing issues included difficulty testing for iOS (especially for Windows developers), testing for multiple screen sizes, and testing on multiple physical devices.

Our team will invest more time in the next quarter to aggressively reduce our bug queue and address major issues around tooling, dependency management, and release. We will also keep improving documentation around those areas. For example, we will improve documentation about how to use such as CI tools such as (for example, GitHub Actions and Bitrise) that help users to better test their to test apps on iOS.

## What’s next?

Your input influences our decision-making every day. We will continue this tradition of basing our decisions on what you tell us in these surveys. So, please, continue to participate and share your thoughts. Flutter’s UX research team is also running a wide variety of user experience (UX) studies, to make your experience with Flutter more pleasant. If you are interested in participating in a study, [sign up](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform) to be considered for a future study.
