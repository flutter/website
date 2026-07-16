---
title: "We hear you — learnings from Q3 2019 Flutter user survey"
description: "On performance, add-to-app, plugins, and more"
publishDate: 2019-11-19
author: jayoung-lee
image: images/0UMfWbaBispXV0tMD.webp
category: announcement
layout: blog
---

## We hear you — learnings from Q3 2019 Flutter user survey

<DashImage figure src="images/1kC6Z0A82B9Yk4mV88fo9CQ.webp" />

Flutter’s User Experience team runs a survey every quarter to understand what we can do to help you be successful with Flutter. Over 7,500 users participated in the Q3 survey, and we’re here to share what we learned, [as always](https://medium.com/flutter/search?q=survey).

Overall, 92% of the users were either *somewhat satisfied* or *very satisfied* with Flutter. This is the first question we ask in every survey, because it is important for us to build a product that you love. We are excited to see the same level of satisfaction as [last quarter](https://medium.com/flutter/what-do-flutter-package-users-need-6ecba57ed1d6).

## Performance

Flutter continues to polish its foundation, and that includes improving the experience around Flutter’s performance. To better understand how we’re doing on this topic, we covered the performance of Flutter as one of the main topics in this survey.

While 78% of the users had experience with release or profile mode (performance should only be assessed in release or profile mode), 85% of them were positively satisfied (either *somewhat satisfied* or *very satisfied*) with Flutter’s performance. In addition, we asked about sub-categories of performance: rendering performance, memory performance, power usage performance, and binary size. We learned that 10% to 20% of users don’t know how to assess these aspects of performance, and the least satisfying aspect was the binary size (54% positively satisfied). For those who need more information about how to assess and optimize different aspects of performance, we will soon publish how-to guides, in addition to [the existing documentation on performance](https://flutter.dev/docs/perf). The survey was an opportunity for us to understand that some performance metrics, such as power usage or memory performance, are harder to assess than others.

<DashImage figure src="images/0UMfWbaBispXV0tMD.webp" alt="*10% to 20% of users don’t know how to assess these performances*" caption="*10% to 20% of users don’t know how to assess these performances*" />

We also learned that only about half of the users (47%) are using [Dart DevTools](https://flutter.dev/docs/development/tools/devtools/overview) to measure the performance of their Flutter app, which is a suite of performance tools for Dart and Flutter. Half of those who haven’t used Dart DevTools said that they didn’t know they exist (48%) and a fifth of them didn’t know how to use them (21%). We will put more effort on increasing the awareness of the DevTools. We will also more tightly integrate DevTools with the IDEs, making it easier to launch specific DevTools functionality, potentially without requiring opening a separate web browser.

<DashImage figure src="images/0jKeTRjxJ0q0gFu2H.webp" alt="*Performance profiling tool preference*" caption="*Performance profiling tool preference*" />

## Add-to-app

Add-to-app is the incremental adoption of Flutter by adding a Flutter-rendered screen into an existing Android or iOS app, rather than creating a from-scratch Flutter-only project. This is a great way to adopt Flutter when there are constraints that prevent you from writing an app from scratch, and the team is investing into supporting such a journey.

From the survey, we learned that 56% of respondents are interested in add-to-app, and 36% of them have already attempted implementing add-to-app in their existing apps, while 40% were not aware that it’s currently possible with Flutter. Experimental add-to-app instructions are described in the [wiki page](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps). Although many users wanted to try add-to-app rather than building a full Flutter app, 64% of the interested users said that they would attempt to transition to a full Flutter app in a year, instead of remaining in a hybrid app.

The survey also helped the team identify future plans, such as which UI pattern to prioritize (i.e., full screen vs. partial screen), which tooling to improve first, and so on. It was also news to us that the lack of coverage in middleware (such as platform ⇄ Flutter interoperability) was the biggest challenge to those who tried add-to-app already, even more than the lack of capability/APIs or documentation. The team is working towards a better add-to-app experience. You can watch their progress in the [Add to App 2019 GitHub project](https://github.com/flutter/flutter/projects/51).

## Plugins

Ecosystem is another crucial part of Flutter; this enables developers to extend the capabilities of Flutter with packages and plugins when the core framework doesn’t support a particular feature. In the Q2 survey, we covered a number of [ecosystem-related questions](https://medium.com/flutter/what-do-flutter-package-users-need-6ecba57ed1d6) to understand your pain points. In Q3, we added two open-ended questions to better understand which plugins (or lack of plugins) are impeding the development and release of your apps.

16% of all respondents answered these questions, and we identified over 70 common themes. Some of the frequently-mentioned themes are listed below. The main takeaway for us is that the listed plugins already exist on pub.dev. This tells us that raising the quality of existing plugins should be one of the most important goals in the coming quarters.

1. Geo (e.g., Google Maps)

1. Media (e.g., audio/video player, audio/video recording)

1. Webview

1. Ads (e.g., Admob, native ads)

1. Payment

1. Data management

1. Image support (e.g. Lottie, SVG)

1. Camera

1. Notifications

1. Background services

We will focus on improving your experience around Flutter’s ecosystem and also make it easier for you to find quality plugins. As a starting point, Dart has recently released a “[verified publishers](https://medium.com/dartlang/verified-publishers-98f05466558a)” feature for [pub.dev](https://pub.dev) (on Dart’s 8th birthday!) to make it easy for users to identify trustworthy publishers. This was one of the planned improvements mentioned in the recap of the [previous survey](https://medium.com/flutter/what-do-flutter-package-users-need-6ecba57ed1d6). Please keep your eye out for further improvements.

<DashImage figure src="images/0rHPbdMZoe86uwe1H.webp" alt="*First page of dart.dev features some verified Flutter packages*" caption="*First page of dart.dev features some verified Flutter packages*" />

## Frustrating experiences

We also asked another open-ended question about recurring annoyances. Although [GitHub issues](https://github.com/flutter/flutter/issues) are open to anyone who wants to file, comment, or upvote, on this survey we wanted to capture frictions that users might not have reported on Github.

We collected over 1,600 comments from this one question, and several team members dedicated many hours to reading and sorting them into categories. We were able to capture some minor but frequent failures that may potentially lead to annoyance and frustration, such as issues related to hot reload and debugging, issues with upgrades and migration, and so on. The sub-teams of Flutter were notified of issues relevant to their work, and it led to many productive discussions. For example, we are working on [better reporting](https://github.com/flutter/flutter/issues/42549) to understand hot reload issues. If you have recurring annoyances, do not hesitate to file an issue. We are tracking those with the “a: annoyance” [label](https://github.com/flutter/flutter/labels/a%3A%20annoyance).

<DashImage figure src="images/0c_10W3HCaw0k6u_h.webp" alt="*Track the progress on Github*" caption="*Track the progress on Github*" />

Thank you again for participating in the survey! Please continue to provide valuable feedback to the Flutter team and help us plan for the coming quarters. Flutter’s UX research team also performs a variety of user experience studies so that we can learn how to make your experience with Flutter more pleasant. If you are interested in participating, please [sign up](https://flutter.dev/research-signup) for future studies.
