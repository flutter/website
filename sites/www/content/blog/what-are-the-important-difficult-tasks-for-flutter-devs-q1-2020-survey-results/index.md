---
title: "What are the important & difficult tasks for Flutter devs? — Q1 2020 survey results"
description: >-
  Written by JaYoung Lee and Youyang Hou
publishDate: 2020-05-15
author: jayoung-lee
image: images/0OfKgvG4OS6Jt7Wum.webp
category: announcement
layout: blog
---

## What are the important & difficult tasks for Flutter devs? — Q1 2020 survey results

Every quarter, we survey Flutter developers to better understand how you’re using Flutter and what we can improve. Today we’re posting the results of the eighth quarterly survey, which took place in February 2020. We received about 6,000 responses over 8 days and were happy to learn that an all-time high of 94.5% of developers report positive satisfaction with Flutter. While we ask some questions every quarter to understand longitudinal trends, this quarter’s survey had a specific focus on identifying key tasks that are important and difficult to the users. Before we jump into the results, here are some other interesting findings.

## About Flutter users

First, we learned that users are more satisfied with Flutter’s core framework (+2%) and ecosystem (+4%) than last quarter. But user satisfaction with the animation framework dropped slightly (-3%). To learn more about why this happened, we’ll ask a few more questions about your experience with the animation framework in the next survey. In the meantime, check out the “[Making Animations in Flutter](https://www.youtube.com/watch?v=GXIJJkq_H8g&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua)” playlist from our YouTube channel. All of these videos were recently released.

Next, about half of the respondents said that they’ve published apps with Flutter (51%). This number has been continuously growing — about a year ago, it was 34%. Those who published an app had a higher satisfaction rate with Flutter than those who haven’t.

<DashImage figure src="images/0cqbZUVzw4XSlZyJR.webp" alt="*Satisfaction with Flutter by the stage of app development. Developers who have published a Flutter app were more satisfied with Flutter than those who haven’t.*" caption="*Satisfaction with Flutter by the stage of app development. Developers who have published a Flutter app were more satisfied with Flutter than those who haven’t.*" />

Similarly, when we asked about their primary purpose for using Flutter, 48% of the respondents said that they are using Flutter for their main job. This number is also growing. A year ago, it was 30%. The number of users evaluating Flutter for potential production use has been decreasing, from 36% in 2019 to 25% in 2020. This implies that many of the users have completed evaluation and adopted Flutter for more serious purposes.

Finally, we found that 69% of the developers who have published a complete production app are building both iOS and Android apps. 16% said that they are trying Web, in addition to the two mobile platforms. Currently, there are approximately 50,000 Flutter apps published in the Play Store. This number has been growing exponentially, and we hope to see this trend continue in the coming months.

For more stats, insights, and future plans, see the “[Flutter Spring 2020 Update](https://medium.com/flutter/flutter-spring-2020-update-f723d898d7af)” article.

## About tasks

Some of the survey respondents were invited to take a longer survey. As a result, 43% of the respondents (N = 2,598) answered a set of questions where we asked for their thoughts on 29 Flutter-related tasks. The tasks covered UI development, framework and tooling, ecosystem, performance and troubleshooting, and testing and optimization. All 29 tasks in these areas were deemed to be critical to Flutter users. Yet, we hypothesized that some of the tasks are more important and difficult than others and thus require more attention from the team.

We structured the survey so that a random half of the selected respondents were asked which of the tasks are important to them, and another half of the respondents were asked which of the tasks are difficult to accomplish. By dividing the respondents into two groups (aka “between-subject design”), we were able to reduce the total number of questions asked to each person. Also, by asking users to rate the importance and difficulty of the tasks, we are able to identify top priority tasks that are both important and difficult to Flutter developers. Below is the quadrant that the team used to decide what to do with each of the tasks.

<DashImage figure src="images/0vABPU2mLHiRog8Vw.webp" alt="*Importance-difficulty quadrant supports decision making.*" caption="*Importance-difficulty quadrant supports decision making.*" />

The following tasks were ranked to be the top 6 most important tasks. It is notable that the important tasks were widely spread across different stages of app development, from performance and testing to UI development.

* Debug errors and crashes in my Flutter app

* Test my app to ensure it works on the range of platforms

* Choose a state management approach for my Flutter app

* Understand and resolve layout issues (such as text overflow)

* Create UI based on design spec provided by a UX UI designer

* Troubleshoot platform-specific issues with my Flutter app

<DashImage figure src="images/0OfKgvG4OS6Jt7Wum.webp" alt="*Relative importance of tasks. Blue dots are estimated importance scores for individuals, red dots are averages.*" caption="*Relative importance of tasks. Blue dots are estimated importance scores for individuals, red dots are averages.*" />

The tasks below were ranked to be the top 6 most difficult tasks. We found several tasks related to troubleshooting and performance are difficult for Flutter professional developers. Most of the UI-related tasks were rated to be not very difficult.

* Troubleshoot platform-specific issues with my Flutter app

* Diagnose and fix memory issues in my Flutter app

* Diagnose and fix CPU usage issues in my Flutter app

* Add an existing platform-specific native API to my Flutter app

* Diagnose and fix UI jank in my Flutter app

* Develop a Flutter plugin (with a platform-specific implementation)

<DashImage figure src="images/0nPtVnwI_F22HmC_F.webp" alt="*Relative difficulty of tasks. Blue dots are estimated importance scores for individuals, red dots are averages.*" caption="*Relative difficulty of tasks. Blue dots are estimated importance scores for individuals, red dots are averages.*" />

As you can see, some tasks appeared in the list of both highly important and difficult tasks (such as “troubleshooting platform-specific issues with my Flutter app”). This knowledge is valuable to the Flutter team, because they can prioritize these areas based on user input, and not by guesswork.

In addition, because Flutter usage is growing fast among enterprise customers (26% of the survey respondents work for an enterprise), we ran an additional analysis to find unique challenges that are specific to developers from larger companies. For this group of developers, we found that reducing app size, adding Flutter to an existing app (i.e. add-to-app), choosing state management techniques, understanding and resolving layout issues were more important and difficult than for other users.

The Flutter team is now better aware of tasks that you consider both important *and* difficult and will use this input to guide development focus. In addition, the team is going to keep track of improvements over time, and will re-grade the tasks to ensure that each step of development is healthy and well-supported.

## What’s next?

One of the joys of working on an open source project like Flutter is having a community that is willing to offer insights and provide suggestions to improve the product, whether in surveys or by other forms of feedback such as GitHub issues. And so, we want to say a particular thank you to those of you who filled out the survey. Several of us read through every comment that was submitted.

We hope that these reports demonstrate that we’re deeply interested in understanding your feedback. For the next quarterly survey, we plan to follow up on some of the insights from this survey, in particular we seek a better understanding of the tasks that were highlighted above as important yet difficult. Please look out for the next survey, which will be available soon.

Flutter’s UX research team is also running a wide variety of user experience studies to make your experience with Flutter more pleasant. If you are interested in participating in future studies, please [sign up](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform).
