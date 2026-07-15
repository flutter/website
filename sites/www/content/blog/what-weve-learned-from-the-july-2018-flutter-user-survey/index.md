---
title: "What We’ve Learned from the July 2018 Flutter User Survey"
description: "Flutter’s User Experience Research team recently conducted an online survey to measure user satisfaction and understand user needs."
publishDate: 2018-08-30
author: jayoung-lee
image: images/1gM8BhAAqil2B79RCarJ5-A.jpeg
category: announcements
layout: blog
---

*Written by [Ja Young Lee](https://medium.com/@jayoung.lee) & [Tao Dong](https://twitter.com/taodong)*

<DashImage figure src="images/1gM8BhAAqil2B79RCarJ5-A.jpeg" alt="Photo by [Jess Watters](https://unsplash.com/@designedbyjess) on [Unsplash](https://unsplash.com/)" caption="Photo by [Jess Watters](https://unsplash.com/@designedbyjess) on [Unsplash](https://unsplash.com/)" />


Flutter’s User Experience Research team recently conducted an online survey to measure user satisfaction and understand user needs. The survey was open to the public for two weeks in July of 2018 and received responses from 1,016 users. Thank you so much for giving us your valuable feedback! In this post, we would like to share what we learned from the survey and what we plan to do to address your feedback.

## Who’s using Flutter?

As you may expect, Flutter users come from all kinds of backgrounds. When we asked about their experience in different mobile platforms (a multiple choice question), Android was the most popular (67%), followed by Web (45%) and iOS (30%). We saw a sizable growth in the proportion of Flutter users coming from a Web background, given that it was 33% in the survey in April. While the ratio of Android developers and iOS developers largely reflects the [global user base imbalance of these two technologies](https://insights.stackoverflow.com/survey/2018/#technology-platforms), we are working on ways to attract more iOS developers to the Flutter community.

<DashImage figure src="images/1dYcTfPO6MS8RWpr9KB1cgg.webp" />


## More Flutter apps coming in the wild?

We also found that 15% of the respondents have already published a Flutter app, and more excitingly, 52% are working on an app to be released within the next 6 months! We are looking forward to seeing these beautiful apps roll out to millions of mobile users.

<DashImage figure src="images/11iG_hmhGXRwV4ZakI_cVjg.webp" />


## Are users satisfied with Flutter?

Our users were generally satisfied with Flutter. 92% of the respondents said that they are very satisfied or somewhat satisfied with Flutter. They were also willing to recommend Flutter to others; more than half (56%) of the respondents gave 9 or 10 to the likeliness of recommending Flutter to others, on a scale of 0 to 10.

When it comes to fast development and beautiful UIs that Flutter strives to support, 79% found Flutter extremely helpful or very helpful in both reaching their maximum engineering velocity and implementing an ideal UI. This is the first time we asked this question in our user survey. We will continue to monitor and strengthen our core value proposition — “build beautiful native apps in record time” — in future surveys and other types of research.

## How about Flutter’s documentation?

Documentation is a key aspect of great developer experience. We’ve seen users praise how well Flutter is documented, yet from a previous survey documentation is also the area that users wanted us to do more. So in this survey, we had a section of questions devoted to better understanding documentation needs and pain points from our users.

The results show that the quality of Flutter’s existing documentation is highly regarded by users (93% of respondents consider the quality good, very good, or excellent). However, there is clearly room for adding more sample code, making it easier to find samples, and improving the ability to learn how to use widgets from API references.

In addition, hundreds of users took the time to leave comments in this section of the survey. Thank you so much! We held a workshop to read through these comments and discuss what we can do to make Flutter better. In this workshop, we organized comments into high-level topics and sub-topics. From this exercise, it’s clear that having example snippets in each widget’s API doc is important. We’re making progress, and we welcome community contributions to our docs. Adding a missing snippet to a widget’s API doc is one of the simplest yet impactful contributions you can make to the Flutter ecosystem. If you’re interested in contributing, refer to the [Flutter repo style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo#provide-sample-code) and get started with pages listed in [this bug](https://github.com/flutter/flutter/issues/21136).

The results also reinforced what we found earlier in our UX studies — having visual illustrations in documentation helps developers learn Flutter more effectively. Finally, we’ve received many comments requesting better guidance on state management. We’re actively working on more samples and articles on this very topic.

We took all this feedback to heart. We were also heartened by some compliments users wrote in the survey. For example:
> *“Flutter is amazing, it’s made my job as a programmer infinitely more enjoyable. Please keep up the great work!”*
> *“This framework is absolutely awesome!!! I have built very complicated UI in no time, the load time is fantastic! especially in comparison to nativescript, also the layout is extremely flexible and easy to use. I am so happy!!!”*
> *“I’m incredibly satisfied with flutter and the community. I’m looking forward to a desktop solution as well.”*

<DashImage figure src="images/1g2MLIDuEz3HdUy1_JkjbVA.jpeg" />


## And are there more Cupertino widgets?

This short answer is Yes! In this survey, we asked users who had experience using Cupertino widgets to tell us what we can do to improve the ability to build UIs in the iOS style. The top request was for more Cupertino widgets. We’re happy to report that we have made significant improvements over the past few months. For example, we recently added [CupertinoApp](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/cupertino/app.dart), a convenience widget that wraps a number of widgets that are commonly required for an iOS-themed application. We’ll continue improving the Cupertino library based on community feedback.

## What’s up next?

We thank everyone who filled out the survey. The Flutter team has learned a lot, both quantitatively and qualitatively. We plan to run a user survey regularly to learn from you as we improve and grow.

The announcement of the survey was made on [Twitter](https://twitter.com/flutterio), [Reddit](https://www.reddit.com/r/FlutterDev/), [Google Groups](https://groups.google.com/d/forum/flutter-dev), [Flutter documentation website](https://flutter.io/docs/), and the [Gitter chat room](https://gitter.im/flutter/flutter). Join our community, and keep your eye out for the next one! You can also [sign up](https://flutter.io/research-signup) for future user experience studies.