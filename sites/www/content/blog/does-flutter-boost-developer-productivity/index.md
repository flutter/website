---
title: "Does Flutter boost developer productivity?"
description: "The Flutter team continues to run a quarterly user survey to hear from you, our Flutter developers. The first survey in 2022 ran between…"
publishDate: 2022-05-05
author: jayoung-lee
image: images/0hjsh42RwSy9QAK1S.webp
category: announcement
layout: blog
---

The Flutter team continues to run a quarterly user survey to hear from you, our Flutter developers. The first survey in 2022 ran between February 22nd and March 3rd, and was accessed through Flutter IDE plugins, the docs.flutter.dev website, and Twitter — and over eight thousand of you responded.

Flutter continues to be loved by most developers (93% positively satisfied), and even scored the highest percentage of “very satisfied” (60%) in its history! This is noteworthy because the number of Flutter developers grew by over 10% since the last quarterly survey (from November 2021 to February 2022). We’re happy to see that Flutter is maintaining a high level of satisfaction even as the community grows.

<DashImage figure src="images/0hjsh42RwSy9QAK1S.webp" alt="Satisfaction with Flutter over time" caption="Satisfaction with Flutter over time" />


We focused on the following four topics in this survey:

* **IDE plugin:** What can we do to improve Flutter’s IDE plugin support?

* **Dart scalability:** Do Dart tools grow slow or unresponsive as a Flutter project grows larger?

* **Game development:** Are you interested in game development? *— (More about this in an upcoming blog post.)*

* **Flutter’s value to developers:** Is Flutter delivering the values promised to developers?

We don’t take your support for granted and we’re keeping an eye out for signals that show where we can further improve. We recognize that there is always room for improvement, and in this article we’ll tell you more about what we’ve learned and how that info drives our roadmap.

## IDE plugins

According to this survey, 63.5% of all developers were “very” satisfied with Flutter’s IDE plugins. What about the rest of the population? Why are they not fully satisfied?

As shown in the following figure, there was no one item that stood out from others as the reason for not being fully satisfied with the IDE plugins. Missing features (35%) was the biggest reason for both Android Studio/IntelliJ and VS Code users, but slow plugin (29%), memory consumption (28%), buggy plugin (26%), all received a fair number of votes, too. (The IDE type is logged when a respondent clicks on the survey link within their IDE.)

<DashImage figure src="images/0EMCuq3u9Ou_ALwgz.webp" alt="Reasons for not being fully satisfied with Flutter’s IDE plugins" caption="Reasons for not being fully satisfied with Flutter’s IDE plugins" />


“IntelliJ” label includes Android Studio users as well.

When we asked what features are missing or inadequately supported, refactoring and quick fixes were chosen as the top two that need better support. This was somewhat surprising, because we didn’t expect that refactoring would be the highest ranked. Also, we were surprised to learn that Android Studio/IntelliJ users are very concerned about navigation, though we do understand that Android Studio/IntelliJ users care more about Android integration than VS Code users. There’s also great interest from developers for a UI builder.

<DashImage figure src="images/0JMOa0ZRVpHAy7prt.webp" alt="Missing or inadequately supported features in the IDE" caption="Missing or inadequately supported features in the IDE" />


In summary, we now feel better aligned with Flutter developers. Still, we will continue to learn more about what’s needed to improve areas of concern through various studies.

## Dart tools

Dart tools, such as Dart analyzer, compiler, DevTools, and IDE plugins, make it easy to use the language. We heard from a few developers that Dart tools can become slow or even unresponsive when the Flutter project is large. We want to assess how widespread and severe this problem is in our next survey.

From this survey we found that about a quarter of the developers have experienced this symptom (24.5%), and almost a half of them said that it has had an extremely negative (16.7%) or moderately negative (29.6%) impact on development.

<DashImage figure src="images/0Jv2irMQ8bSqUxGTW.webp" alt="Developers encountered a Dart tool growing slow or unresponsive as their Flutter project grew larger" caption="Developers encountered a Dart tool growing slow or unresponsive as their Flutter project grew larger" />


<DashImage figure src="images/0EHUt9u95L4cLrRBk.webp" alt="Impact of a slow or unresponsive Dart tool on productivity" caption="Impact of a slow or unresponsive Dart tool on productivity" />


We expected these numbers to be lower and we’re eager to improve in this area, so we’re planning to reach out to some developers who expressed interest in a follow-up conversation to reproduce the problem and eventually improve the performance of the tools.

## Flutter’s value to developers

Flutter promises to provide a framework for building beautiful, fast, multi-platform applications from a single codebase. In this survey, we explored whether Flutter developers feel that we’ve met these values.

We asked different questions to those who have converted existing apps to Flutter and to those who created a new Flutter app from scratch. With multiple answers allowed, 59.2% have created a new app from scratch, and 26.5% either converted an existing app or added Flutter components to an existing app.

<DashImage figure src="images/0CmgeijL3JkkAQA1_.webp" alt="Developers’ experience developing and publishing Flutter apps" caption="Developers’ experience developing and publishing Flutter apps" />


To those who created a new app with Flutter, we asked to what extent they agree with three statements about integration with other Google services, development productivity, and target platforms. We found that over 90% of them agreed to “Flutter reduced time to build and publish new apps, compared to other technologies that I have used” (92.1%) and to “Flutter enabled my app to target more platforms”. (92.2%)

<DashImage figure src="images/0F-sHYKccRgOOQ85L.webp" alt="The impact of creating a new app with Flutter" caption="The impact of creating a new app with Flutter" />


Similar questions were asked of those who adopted Flutter for existing apps. 90.7% agreed that “Flutter enabled my app to be developed more quickly than before” and 85.3% agreed that “Flutter enabled my app to be available on more platforms than before”. We also found that 84.8% of the developers agreed that “Flutter made my app look more beautiful than before”.

<DashImage figure src="images/0PihM7mrr3InFiCOZ.webp" alt="The impact of adopting Flutter for an existing app" caption="The impact of adopting Flutter for an existing app" />


Of course we heard what Flutter can do better, such as providing more plugins for all supported platforms, adding more documentation, improving perceived performance, integrating better with other tools, and so on. Some comments also mentioned that certain problem areas haven’t changed after years of surveys. While we strive to address the issues and improve the product, we appreciate your patience! Nevertheless, we are pleased to learn and report that our developers are targeting more platforms in a more productive way.

## Wrapping up

Special thanks go to everyone who participated in our survey! The Flutter team members dedicate time every quarter to analyze and digest the feedback and make decisions for the next quarter and beyond. We’ll continue to reach out to hear what we can do to make your experience with Flutter more enjoyable and more productive.

Flutter’s UX research team is also running a variety of user experience studies. If you are interested in participating, please [sign up](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform) to be considered for a future study.

And please continue to participate and share your thoughts. See you in the next survey!