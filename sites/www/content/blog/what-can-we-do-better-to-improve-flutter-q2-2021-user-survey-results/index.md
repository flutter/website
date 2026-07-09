---
title: "What can we do better to improve Flutter? — Q2 2021 user survey results"
description: "Written by JaYoung & Mariam"
publishDate: 2021-08-13
author: jayoung-lee
image: images/0m2ihVMc99emY4hQY.webp
category: announcements
layout: blog
---

## What can we do better to improve Flutter? — Q2 2021 user survey results

The Flutter team runs a user survey every quarter to hear from Flutter users and to make plans for the future. The most recent survey in May was our 13th user survey, which collected over 7,000 responses. We asked Flutter developers to rate their satisfaction with various parts of Flutter, and for those who were not fully satisfied, to comment as to why. The team not only summarized multiple choice survey responses, but also read open-ended comments that were left in the survey. There were 3,403 comments. And we’re back to share what we learned from you.

## Satisfaction

Overall, 92% of respondents said that they are positively satisfied with Flutter (39% somewhat satisfied and 53% very satisfied). Subsystems of Flutter scored different levels of satisfaction, ranging from 72% to 93%, as shown in the following graph. While we’re happy to share that we’re maintaining a high level of satisfaction, we’re also paying attention to specific areas where we can improve.

<DashImage figure src="images/0m2ihVMc99emY4hQY.webp" />


## Open-ended questions

The survey had two open-ended questions:

*“Why are you dissatisfied with Flutter? Please share your reasons:”*

*“Is there anything else you’d like to tell the Flutter team?”*

We collected 847 comments from the first question and 2,556 comments from the second question. The comments were first divided into various topics (such as documentation, ecosystem, web support, and so on) using a machine learning algorithm. Then, each topic was assigned to the teams working in each area for their analysis.

Obviously, the teams cannot take on everything and solve all the issues at once. However, each team tried to extract insights from the comments and prioritize the ideas, carefully assessing the effect and effort needed. In the next sections, we’ll share some examples of our takeaways.

### Example 1: About the general developer experience

At a high level, reading through the written feedback was useful in three ways:

1. Confirm existing issues

1. Find new areas of concern and ideas

1. Notice a need for additional information and evidence

First, we confirmed that there are pain points frequently observed in many other sources, such as the GitHub Issues tab, Reddit, and Stack Overflow. The examples include, but aren’t limited to memory consumption and examples for skill-up. We’re well aware of these challenges and set priorities for them within each subteam. In the meantime, we’d like to re-promote existing resources like [Using the Memory View](https://flutter.dev/docs/development/tools/devtools/memory) or the [Learning Center](https://events.flutter.dev/engage/learn/beginner).

Second, some topics were surprising for us to discover. For example, there were several comments that expressed concern about expanding to desktop and web. These comments asked us to concentrate on making iOS and Android better and to not stretch our focus. We understand the concern and will pay attention. We will also better communicate how we strive to be a strong technology for mobile as well as extend our support for additional platforms over time.

Last, we wanted to have more information about some of the issues reported in the survey, especially those related to performance and documentation. If you want to have conversations with Flutter contributors and add more details to your issues, then consider posting them on the GitHub Issues tab. This tab is regularly triaged by the team. When you post, follow the rules in [File bugs for everything](https://github.com/flutter/flutter/wiki/Issue-hygiene#file-bugs-for-everything). (Of course, “how to” questions will be answered better in a support forum like Stack Overflow or Discord! See the [Community](https://flutter.dev/community) page for more info.)

### Example 2: About Flutter’s web support

The team found that the dissatisfaction feedback that was centered around lack of a stable version for web support was alleviated after the [stable release of web support ](https://medium.com/flutter/flutter-web-support-hits-the-stable-milestone-d6b84e83b425)with Flutter 2.0 in March. Many of the features that we added for the stable release of the web support for Flutter were based on last year’s [survey](https://medium.com/flutter/flutter-on-the-web-slivers-and-platform-specific-issues-user-survey-results-from-q3-2020-f8034236b2a8), where we asked about the features that you might need for your web apps.

The web-specific questions in the [Q3 2020 survey](https://medium.com/flutter/flutter-on-the-web-slivers-and-platform-specific-issues-user-survey-results-from-q3-2020-f8034236b2a8) were based on the open-ended feedback we received in our Q2 survey from last year. Your comments helped us determine which areas we should prioritize for the initial stable release for Flutter’s web support.

In 2020, 15% of the comments were about performance and jank, so we prioritized improving our HTML renderer’s performance as well as stabilizing the CanvasKit renderer. Another 15% of the comments were about our plugin gaps and requests for GoogleMaps, Firestore, and so on, so we ensured that the majority of the Google-owned plugins, including GoogleMaps, Firebase_analytics, cloud_firestore and more, were supported in the web stable release. There were several comments regarding scrolling and text rendering. While there is still more work for us to do in these areas, we were able to build a solid foundation for supporting [scrolling on desktop form factors ](https://github.com/flutter/flutter/issues/70866)as well as supporting [rich text functionality](https://github.com/flutter/flutter/issues/33523), such as multiline text selection in a text field.

This quarter, we hear that users believe Flutter’s web support still needs improvement. The “look and feel” of web apps is the most commonly mentioned reason for dissatisfaction with Flutter’s web support. We were also asked to provide more web-specific widgets, intuitive responsive widgets, and so on. Asks for search engine optimization (SEO) were also noted. Other reasons for dissatisfaction were right-to-left (RTL) text support, code size, routing, and debugging.

We’re planning to ask about some of these areas in the next user survey, as we plan our next release. For others, we are already making progress, such as adding [RTL text support](https://github.com/flutter/flutter/projects/159), understanding issues with routing through our current [UXR study](https://github.com/flutter/uxr/tree/master/nav2-usability), and investigating ways to decrease our code size.

## What’s next?

The quarterly survey program is a structured way for us to better understand your needs, but it isn’t the only channel to use for us to hear from Flutter developers. If you have urgent issues that need follow-up, please file them on [GitHub](https://github.com/flutter/flutter/issues).

The Flutter UXR team will continue to run surveys every quarter through an announcement on flutter.dev, in the Flutter IDE plugin, or on Twitter @FlutterDev. Please continue contributing your thoughts as the team seeks answers to important questions. You can also participate in other research by [signing up for upcoming UX studies](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform).

Again, thank you to everyone who participated in this survey and provided valuable feedback. Our goal is to build a product that you love, and we appreciate your time and effort helping us.