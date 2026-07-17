---
title: "Are you happy with Flutter? — Q4 2020 user survey results"
description: >-
  The Flutter team at Google has been running a quarterly survey program to
  collect your feedback since 2018. The survey for the last…
publishDate: 2021-02-11
author: jayoung-lee
image: images/0hs9oiR_zpBhkzT9u.webp
category: announcement
layout: blog
---

## Are you happy with Flutter? — Q4 2020 user survey results

The Flutter team at Google has been running a quarterly survey program to collect your feedback [since 2018](https://medium.com/flutter/search?q=survey). The survey for the last quarter launched on November 23, 2020 and remained open for 8 days. The team collected 8,285 responses, and we want to share the results with you! Even though this survey was half the length of our usual surveys, we learned a lot from your answers, as always. We truly appreciate those of you who took the time to provide valuable feedback.

## User satisfaction

Overall, 92% of respondents were *somewhat satisfied* or *very satisfied* with Flutter. We’re glad that we continue to maintain a high level of satisfaction.

<DashImage figure src="images/0vY8rm_jNlGOmZ8eJ.webp" alt="*92% of the users were satisfied with Flutter, and 51% were very satisfied.*" caption="*92% of the users were satisfied with Flutter, and 51% were very satisfied.*" />

As you can see from the graph, we learned the following as well:

* 91% said that Flutter works well for their projects.

* 90% are committed and want to use Flutter for their next project.

* 58% said that Flutter is critical to their company’s success.

These results show that Flutter continues to flourish and is a vital part of the developer toolkit.

<DashImage figure src="images/0hs9oiR_zpBhkzT9u.webp" alt="*90% of users would prefer to use Flutter for their next project.*" caption="*90% of users would prefer to use Flutter for their next project.*" />

But, we noticed that the overall satisfaction decreased a bit since last quarter’s survey, from 94% to 92%. To understand why you aren’t completely satisfied with various aspects of Flutter, the team closely reviewed the open-ended comments. Thanks to the feedback, the team is aware of major issues and will invest in high priority items. For instance, we are planning to [improve code completion](https://github.com/dart-lang/sdk/projects/24) because we found that it was the most common source of frustration among IDE-related issues.

## Pain points

This time, we took a different approach to understanding Flutter’s pain points. We wanted to learn what blocks you from using Flutter more than you do. When we asked, “if not for the following reasons, I would use Flutter more”, 26% of respondents selected *lacking critical libraries* as the reason. In response, we’re partnering with [Baseflow](https://baseflow.com/), [Invertase](https://invertase.io/), and [Codemagic](https://codemagic.io/) to improve the quality of our first-party packages and plugins. While the team is working hard to improve critical libraries identified from previous research, we are also monitoring specific needs from our issue tracker with the tag [would be a good package](https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22would+be+a+good+package%22+sort%3Areactions-%2B1-desc) so that anyone can find what’s missing from the ecosystem and contribute to it.

As the number of Flutter-compatible packages grows beyond 15,000 and because there’s no way to scale the Flutter team to take on dozens or even hundreds of packages that might be considered critical, we provide a variety of mechanisms for the community to [grade packages](https://pub.dev/help/scoring). We provide these mechanisms so that searches produce high quality results, including likes, static analysis, and the [Flutter Favorite](https://flutter.dev/docs/development/packages-and-plugins/favorites) designation, which is awarded by a group of Flutter community volunteers. Doing this not only encourages you to contribute more packages to cover the critical bases, but the quality of the packages will improve over time because package authors are rewarded for their work with better scores and recognition. We will continue to invest in this area so that the ecosystem becomes self-sustaining and continues to naturally increase in quality.

<DashImage figure src="images/04kA8p14vcnIS5cOG.webp" alt="*26% of users need more libraries. This result excludes 19% of users who said I am using Flutter enough.*" caption="*26% of users need more libraries. This result excludes 19% of users who said I am using Flutter enough.*" />

To make it easier for those of you working on projects other than Flutter (19%), we will continue to invest in [add-to-app](https://flutter.dev/docs/development/add-to-app), which helps you integrate Flutter modules into existing Android or iOS apps. You can follow the progress of the related features on [GitHub issue 72009](https://github.com/flutter/flutter/issues/72009).

*Lacking features in the core framework* was selected by 18% of respondents. After we took a closer look at the open-ended comments, the feedback was centered on the boundary between the functionality included in the Flutter framework and the functionality provided by packages. While it’s understandable that some of you want the framework to include more features beyond user-interface APIs, our focus is on what we do best — provide an excellent UI framework. But, we want to provide you with the functionality you need, so we partner with community contributors to supply the domain-specific and platform-specific capabilities through packages and plugins. As previously mentioned, we invested in tools and programs to recognize high quality packages and help you discover them in the ecosystem. We welcome your feedback and ideas to further strengthen our package ecosystem.

## Online communities

In this survey, the team wanted to know where you exchange information or ideas with other Flutter developers. While 21% of respondents said that they aren’t active on any online communities, we found that Stack Overflow was the most popular community for Flutter devs to connect with each other. Stack Overflow was chosen by 38% of respondents as the online community where they are most active.

<DashImage figure src="images/0jjBvOh6G9e9TwLQ1.webp" alt="*Stack Overflow was the main online community for 38% of respondents. This graph omits the 21% who aren’t active on any online communities.*" caption="*Stack Overflow was the main online community for 38% of respondents. This graph omits the 21% who aren’t active on any online communities.*" />

Depending on where the respondent is most active, the rating on the community’s usefulness differed. For example, we asked, “To what degree do you agree or disagree with the following statements about the online community you selected in the previous question?” For the response, *I was able to get answers when I asked other Flutter users in the community questions*, 75% of respondents who are active on Stack Overflow agreed that they can get answers when they asked questions there. Also, 61% of respondents who are mostly active on instant messaging services said that they also got answers.

<DashImage figure src="images/08JtwdBejYL_ez5rJ.webp" alt="*Respondents were asked to rate how much they agreed with the statement, “I was able to get answers when I asked …” questions, and the results differed by the community they are active in.*" caption="*Respondents were asked to rate how much they agreed with the statement, “I was able to get answers when I asked …” questions, and the results differed by the community they are active in.*" />

This was our first time assessing user distribution online, and your perception about various online communities. Growing a helpful and thriving community is critical to Flutter’s success. We share the results with you in the hope that both the help givers and the help seekers can better use these online communication channels. The Flutter team will monitor this data to guide our support and educational effort, and make sure that you are able to find help and stay connected.

## Flutter events

Every year, a number of in-person and online events for the Flutter community are organized by local meetup groups and Flutter contributors, and about 90% of respondents who attend learn something new about Flutter and find that information to be helpful. While these events are effective learning opportunities, through our research, we now know that the majority of respondents (61%) weren’t aware of these events in 2020. Even though we didn’t host a large event in 2020 like we did in 2019 with [Flutter Interact, where we would have publicized these events](https://www.youtube.com/playlist?list=PLjxrf2q8roU0o0wKRJTjyN0pSUA6TI8lg), this percentage was still higher than what we expected. So, going forward, as we plan our [Flutter Engage event](https://events.flutter.dev) on March 3, 2021, we are partnering with regional Google teams to help spread the word. We’re also working closely with local Flutter groups to ensure that our event content reaches a larger percentage of the Flutter community. Everyone is invited to this free online event.

<DashImage figure src="images/0AkXrQy4YPsBUoYLA.webp" alt="*61% of users who didn’t attend any events in 2020 (both online and offline) were not aware of the events.*" caption="*61% of users who didn’t attend any events in 2020 (both online and offline) were not aware of the events.*" />

<DashImage figure src="images/0Z0mRRjjnEDQWqAsl.webp" alt="*85% or more users learned something new from various Flutter events.*" caption="*85% or more users learned something new from various Flutter events.*" />

## What’s next?

The next survey will be announced around late February on [flutter.dev](https://flutter.dev/), [@FlutteDev](https://twitter.com/FlutterDev) (And in the [Flutter IDE plugins](https://flutter.dev/docs/get-started/editor?tab=androidstudio). You can also participate in other research by [signing up](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform) for upcoming UX studies.

Please continue contributing your thoughts as the team seeks answers to important questions.

Again, thank you to everyone who participated in this survey and provided valuable feedback. We appreciate your time and effort!

See you at [Flutter Engage](https://events.flutter.dev/)!
