---
title: "GSoC ’21: Creating a desktop sample for Flutter"
description: "by Abdullah Deshmukh"
publishDate: 2021-08-22
author: abd99
image: images/1aRiqWvnUYD-cSbGhxTnUsw.jpeg
category: events
layout: blog
---

<DashImage figure src="images/1aRiqWvnUYD-cSbGhxTnUsw.jpeg" />


[Google Summer of Code](https://summerofcode.withgoogle.com/) (GSoC) is an open source, summer program sponsored by Google. During this program, students work on a project under the guidance of an open source organization.

This was the second time that the Dart team participated as a mentoring organization in GSoC. Unfortunately, due to the unavailability of mentors, there weren’t any Flutter projects on the [ideas list](https://docs.google.com/document/d/1KfaTPPt6rqvgPD4kkZcsaehXC9FijcJ20V4J3FDLsRk/edit#) this year. Because it was my second time participating in GSoC, I contacted my mentor from last year, Brett, to see if working on a project would be possible. After a discussion with him and the org admin, I found a project to work on.

This blog shows the work I did for my project. [Check out all the projects under Dart this year](https://summerofcode.withgoogle.com/organizations/4658845562961920/#projects). All of the resulting source code is in GitHub repositories, and you can see how the work progressed by looking at individual pull requests (PRs).

## Project details: Flutter desktop tool

This year, at Flutter Engage, a beta snapshot of Flutter’s desktop support was included in the stable channel. This caused a need for a desktop sample for the [samples](https://github.com/flutter/samples) repo that could, later on, be released on the desktop app stores like the [macOS App Store](https://developer.apple.com/macos/distribution/), the [Microsoft Store](https://docs.microsoft.com/en-us/windows/uwp/publish/), and the [Linux Snap Store](https://snapcraft.io/docs/snapcraft-overview). After a discussion with Brett and the team, we decided to build a desktop sample that would also be a tool to help developers manage lint rules for their projects. Check out the [linting_tool on GitHub](https://github.com/flutter/samples/tree/master/experimental/linting_tool).

<DashImage figure src="images/0Lh2I-A4Aak5UZXze.png" alt="A screenshot of the app" caption="A screenshot of the app" />


The app uses the lint rules that are hosted by the Dart team from the [dart-lang/linter](https://github.com/dart-lang/linter) repo, and the app can do the following:

**Show a list of available lint rules for Dart.**

You can fetch a list of lint rules from an API. The app uses the [`flutter_markdown`](https://pub.dev/packages/flutter_markdown) package to format the details and the code snippets.

Related PR: [#856](https://github.com/flutter/samples/pull/856)

**Save the rules to different profiles.**

You can create different rule profiles for different types of projects. The app uses the [`hive`](https://pub.dev/packages/hive) database to maintain persistent storage.

<DashImage figure src="images/0FwXcFHhXjCuOEaFw.png" alt="A list of saved profiles" caption="A list of saved profiles" />


Related PR: [#860](https://github.com/flutter/samples/pull/860)

**Modify and export profiles.**

The profiles can be modified to your liking and then exported to Flutter projects as analysis_options.yaml files. The packages [`yaml`](https://pub.dev/packages/yaml), [`json2yaml`](https://pub.dev/packages/json2yaml), and [`file_selector`](https://pub.dev/packages/file_selector) are used to accomplish this.

Related PRs: [#874](https://github.com/flutter/samples/pull/874), [#869](https://github.com/flutter/samples/pull/869)

**Show default profiles.**

You can view a list of default profiles that [`effective_dart`](https://pub.dev/packages/effective_dart), [`pedantic`](https://pub.dev/packages/pedantic), [`lints`](https://pub.dev/packages/lints), and [`flutter_lints`](https://pub.dev/packages/flutter_lints) use.

Related PR: **[**#871](https://github.com/flutter/samples/pull/871)

To see how the project progressed during the GSoC period, see [this set of PRs](https://github.com/flutter/samples/pulls?q=author%3Aabd99+created%3A2021-06-07..2021-08-31+).

There are a few more things that I’d like to add to the project. The two main things are the ability to load profiles from existing analysis_options.yaml files and the ability to search for a specific rule in the rules list. I also have a new video series that I’m working on that will cover how to deploy Flutter desktop apps. I’ll update this blog when it’s out and will also share it on my [Twitter account](https://twitter.com/abdullahzakir99).

## Experience

My experience with Google Summer of Code (GSoC) this time was even better than last year. (Check out [Learn testing with the new Flutter sample](https://medium.com/flutter/learn-testing-with-the-new-flutter-sample-gsoc20-work-product-e872c7f6492a) to read more about the project I worked on last year.) I think this year was better because the project was more technical, covered more concepts, and was related to something that I never worked on before. I also knew a lot more people on the team this time. I think GSoC will be a part of my life that I won’t ever forget.

### Mentorship

[Brett](https://github.com/domesticmouse) was always there to help me with all my questions and blockers. He was very understanding when I had to give more time to my other commitments like school, other gigs, and family-related things. I think the best thing was that he gave me complete freedom to explore things and tweak the project’s scope if I thought that something would be a valuable addition to the project. One cool thing I did this time was I asked him general software engineering-related questions that were not directly related to the project at the end of every weekly meeting, questions like “How does Google handle estimates?” and “What do you think about remote work?”. This helped me learn things about the software industry that aren’t related to programming. I highly recommend that you try this during your internships or GSoC-like projects. And, yes, he’s still the coolest person I have ever worked with.

### Learning

Learning is the best part about open source software. A lot of things that I did this time couldn’t be Googled. I read a lot of code, finding how different packages do the same things and the general patterns in which they differ. I also learned how to find a great package for a project from a huge list of available ones. Because this category was new to me, this experience helped me learn a lot in a short amount of time.

### Challenges

There were a few challenges that I got to learn from this time. The first one was related to the timeline. This year, the timeline of GSoC was reduced in half which made us reprioritize and skip a lot of features that might have been valuable additions to the project. The other challenges were working on a completely new category and finding good resources on how to do things in a category that isn’t too popular.

## Final thoughts

I had an amazing experience over the past year working with Flutter and the samples repo. And, I would like to thank Brett, the Flutter team, and the GSoC team for that.

*About the author: Abdullah is a fresh computer engineering graduate based in Pune, India. He has been building mobile apps over the past 4 years and enjoys working with things built around it. You can connect with him on [Twitter](https://twitter.com/abdullahzakir99), [LinkedIn](https://www.linkedin.com/in/abdullahzakir99/), and [GitHub](https://github.com/abd99).*