---
title: "Which factors affected users’ decisions to adopt Flutter? — Q1 2021 user survey results"
description: "The Flutter team is here to share the results from this quarter’s user survey! This quarter, we collected over 8,000 responses over 7 days, between March 5th and 11th. The goal of this quarterly survey program is to hear from you, in a structured format, so that the Flutter team can focus on things that matter most to our users. Results from the previous surveys are published on Medium too."
publishDate: 2021-05-13
author: jayoung-lee
image: images/0_m-0usdhsHPmeZ8U.webp
category: announcements
layout: blog
---

## Which factors affected users’ decisions to adopt Flutter? — Q1 2021 user survey results

## User satisfaction

In this quarter’s survey, 92% of the 8,652 respondents said that they are positively satisfied with Flutter (55% very satisfied, 37% somewhat satisfied), similar to the last quarter’s results.

What’s notable this quarter is that 89% of the respondents were also positively satisfied with the Dart language, which is an all-time high score. This was very encouraging news to the team, because the percentage started at 80 in 2019. The Dart team did tremendous work to improve the developers’ experience with the Dart language to achieve this satisfaction rate, including [sound null safety](https://dart.dev/null-safety). We’re very happy to share this survey result, and we thank those who acknowledged the unique strengths of the language.

<DashImage figure src="images/09CO8AmwyqIudhgK6.webp" alt="*The percentage of users who are positively satisfied with Dart increased 9%, from 80% in Q3 2019 to 89% in Q1 2021.*" caption="*The percentage of users who are positively satisfied with Dart increased 9%, from 80% in Q3 2019 to 89% in Q1 2021.*" />


## Which factors affected users’ decisions to adopt Flutter?

The Flutter team wanted to understand how different factors affect users’ decisions to adopt Flutter for their new projects. The goal was to find areas that the team should invest in to alleviate users’ concerns and delight our users. In addition, by sharing the results, we hope that you can also use the information to find ways to contribute to the Flutter community or to advocate for Flutter in your organization or community.

Because this survey targeted existing Flutter users, we asked about the users’ recent experience with evaluating Flutter for their next new project. We learned that 75% of the respondents evaluated Flutter against other technologies in the last 3 months and that 67% of them were for business reasons, followed by learning (17%) and hobby (14%).

First, we asked what made users lean toward adopting Flutter. As shown in the following chart, users leaned toward adopting Flutter mainly because Flutter supports the following features, listed by importance:

1. A single codebase.

1. Ready-made UI widgets.

1. Hot reload.

<DashImage figure src="images/0lmC1UJVINDIXumGt.webp" alt="*Factors that made developers lean toward adopting Flutter for their next project*" caption="*Factors that made developers lean toward adopting Flutter for their next project*" />


Next, we asked what made users lean against adopting Flutter. The users were most concerned about the following, listed in order of importance:

1. Google’s commitment to Flutter.

1. Maturity of Flutter for the scale of the app they’re building.

1. Packages and plugins available in Flutter’s ecosystem.

<DashImage figure src="images/00d3CyUdb9K75qjt2.webp" alt="*Factors that made developers lean against adopting Flutter for their next project*" caption="*Factors that made developers lean against adopting Flutter for their next project*" />


From these results, the team learned that users fear whether Flutter will be around for the long term. It’s a reasonable concern, because you’re tying your career or apps to our framework. So, we want to mention the scale of internal adoption again. At Flutter Engage, we shared that there are more than 30 teams at Google who are building mission-critical apps with Flutter. These are teams like [Google Pay, Google Ads, Nest Hub, and Stadia](https://youtu.be/IdrCyS7EF8M?t=67) who have thousands of developers committed to Flutter development. Flutter will be prominently featured at [Google I/O](https://events.google.com/io/) again this year. Stay tuned for our latest announcements, and sign up for the Flutter sessions listed on the[ I/O website](https://events.google.com/io/program/content?4=topic_flutter&lng=en), starting May 5th.

We also want to point out that Flutter isn’t only growing because of support from Google — there are more contributors outside of Google than inside. A vibrant, open source community of developers around the world is contributing to our shared success! Take a look at the other large and small contributors like [Toyota](https://youtu.be/IdrCyS7EF8M?t=237) or Ubuntu.

The next concern was about the maturity of Flutter, including the ecosystem around it. We’re investing in developing the packages and plugin ecosystem and working on the stability and quality of the core framework. We see the sentiment improving here with the release of Flutter 2 and an ever-growing ecosystem supporting it. Now that the web support is stable and the desktop support is in beta, our main themes in upcoming releases will be around polishing the framework and improving the productivity that you can achieve with Flutter. In the meantime, you can check out the [showcase section](https://flutter.dev/showcase) of the Flutter website and see how major brands like BMW, eBay, Nubank, Tencent, Square, and Sonos are building with Flutter.

We also collected thousands of raw comments about various topics in response to open-ended questions. We had at least three different workshops where engineers in the Flutter subteams gathered to read and digest comments about various topics, including ecosystem, developer tools, and so on. The ideas generated during the workshop will be used as input for the team’s goals for the coming quarters.

<DashImage figure src="images/0_m-0usdhsHPmeZ8U.webp" alt="*Online post-it notes that the Flutter team used to generate and organize ideas about developer tools, based on the comments from the survey*" caption="*Online post-it notes that the Flutter team used to generate and organize ideas about developer tools, based on the comments from the survey*" />


There are things that community contributors can do too. We learned from the user comments that many Flutter developers still want to have higher-quality packages with better maintenance, even though they acknowledge that Flutter’s ecosystem has matured over time. There were a lot of mentions of multimedia packages (like audio and video players) and Bluetooth packages that need better support. We welcome you to contribute to those areas and expand the coverage, by, for example, submitting PRs to existing packages, as the Flutter team strives to provide high-quality, [first-party packages](https://pub.dev/publishers/flutter.dev/packages).

## Cloud-based services and products

The Flutter team knows that there is an interest for cloud services among some Flutter users, but the team didn’t have a good understanding of what types of cloud solutions users are looking for. Thanks to the survey, we learned that 40% of the developers use cloud-based services, and 27% plan to use one for their Flutter projects.

For those who are already using cloud-based services, the most popular cloud solution was Firebase (82%), followed by Google Cloud Platform (GCP) (34%), and Amazon Web Services (AWS) (25%).

<DashImage figure src="images/0VLupMT920gd2acrw.webp" />


Users said that they chose Firebase and GCP, because they were easy to use with Flutter. Many users who chose AWS and Azure said that it was because of existing familiarity.

<DashImage figure src="images/0d0IHqqnl0KoeLuT8.webp" />


The Flutter team is working closely with Firebase and GCP. We will continue to support [FlutterFire plugins](https://firebase.flutter.dev/), and the team is also working with the GCP team to make it easier to use with Flutter.

## What’s next?

The Flutter UXR team will be running surveys every quarter. You’ll be able to find the announcement on [flutter.dev](https://flutter.dev/), in the Flutter IDE plugin, or on Twitter @FlutterDev. You can also participate in other research by signing up for upcoming UX studies. Please continue contributing your thoughts as the team seeks answers to important questions.

Again, thank you to everyone who participated in this survey and provided valuable feedback. We read every piece of feedback and take it to heart. Our goal is to build a product that you love, and we appreciate your time and effort helping us!