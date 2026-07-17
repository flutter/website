---
title: "Learn testing with the new Flutter sample | GSoC’20 Work Product"
description: >-
  By Abdullah Deshmukh
publishDate: 2020-08-29
author: abd99
image: images/15PoXySK4-tAKWAY1zCzfHg.webp
category: tutorial
layout: blog
---

<DashImage figure src="images/15PoXySK4-tAKWAY1zCzfHg.webp" />

## A quick introduction to GSoC

[Google Summer of Code](https://summerofcode.withgoogle.com/)(GSoC) is a 3-month program sponsored by Google in which students work with an open source organization. With the help of mentors, the students complete a project during their summer break.

This year, the Dart team participated for the first time as a mentoring organization in GSoC. [Five Dart project proposals](https://summerofcode.withgoogle.com/organizations/6544944065413120/) were accepted by GSoC, of which two featured Flutter.

This blog shows the work I did for my GSoC project. [Check out a summary of the work done by all the students under Dart](https://link.medium.com/s1jpFEG3fab). All of the resulting source code is in GitHub repositories, and you can see how the work progressed by looking at individual pull requests (PRs).

## Project details: Testing sample app

Out of my two submitted proposals, the [Testing sample app](https://github.com/dart-lang/sdk/wiki/Dart-GSoC-2020-Project-Ideas#idea-flutter-testing-sample-app) was accepted. Testing is the most common thing skipped by students when learning any new technology. This project focuses on helping developers learn testing in Flutter in an easy, quick way. It also aims to help students see the best practices of testing in Flutter. [Check out the testing_app sample on GitHub](https://github.com/flutter/samples/tree/master/testing_app).

<DashImage figure src="images/0d_ULBZHcg78XQFJb.gif" alt="A screen-capture of the app in action" caption="A screen-capture of the app in action" />

We built an app that contains a list of items. The user can add items to, and remove items from, a favorites list. Then we used a tool named Flutter Driver to perform several types of testing. (Flutter Driver lets you create instrumented apps and drive those apps from a test suite.) We demonstrated the following types of testing:

### Widget testing

A type of testing where you can test each and every individual widget of your choice. It is important to know whether each individual widget is working as intended.

For more info on Flutter widget testing, see [An introduction to widget testing](https://flutter.dev/docs/cookbook/testing/widget/introduction).

Related PR: [#476](https://github.com/flutter/samples/pull/476)

### Integration testing (Flutter Driver)

Using Flutter Driver for integration testing is similar to using Selenium WebDriver (generic web), Protractor (Angular), Espresso (Android), or Earl Gray (iOS). Integration testing with Flutter Driver gives us a good idea of how different pieces of our app perform as a whole on a real device.

For more info on Flutter integration testing, see [An introduction to integration testing](https://flutter.dev/docs/cookbook/testing/integration/introduction).

Related PR: [#481](https://github.com/flutter/samples/pull/481)

### Performance testing

Flutter Driver lets us trace the performance of the app on real devices and store the entire timeline of the task.

For more info on Flutter performance testing, see [Performance profiling](https://flutter.dev/docs/cookbook/testing/integration/profiling).

Related PR: [#494](https://github.com/flutter/samples/pull/494)

### State management testing

Testing state is quite important, especially in complex apps where a lot of state data is present and a dedicated state management approach is used. This app manages state using the [provider package](https://pub.dev/packages/provider). The sample demonstrates how to test state using the Flutter Driver.

Related PRs: **[**#487](https://github.com/flutter/samples/pull/487), [#490](https://github.com/flutter/samples/pull/490)

To see how the testing sample progressed during the GSoC period, see [this set of PRs](https://github.com/flutter/samples/pulls?q=author%3Aabd99+created%3A2020-06-01..2020-08-31+).

As development of the sample was coming to end, I knew that I would have a lot of time left under the GSoC timeline with not much work. So, I reached out to my mentors, Brett and Andrew, asking for more to do. Thanks to Flutter being an open source project, I had a lot of things to choose from. Out of the projects suggested by my mentors, I felt that building a codelab on “Testing in Flutter” was the most interesting, and it was related to the topic of my project as well. So, I spent the rest of the time building the codelab. [Check it out](https://codelabs.developers.google.com/codelabs/flutter-app-testing).

## Experience

Google Summer of Code has been one of the best experiences of my entire life. I never thought my summer would be so amazing at the start of the year — full of learning and at the same time contributing to an amazing community.

### Mentorship

[Brett](https://github.com/domesticmouse), my primary mentor, was everything I could ask for in a mentor/co-worker. He replied to my emails within a few minutes. Yes, you read that right, minutes, even though we had a significant difference in our time zones. He answered my questions in a way that would help me find the answers to the questions myself. He showed me how building good resources for developers is supposed to be done in the best way. The most important point is the story — the way in which you plan to share the knowledge in the form of a sample, codelab, etc. He also helped with career-related questions and connected me to others when he wasn’t able to help with a specific problem. And yes, he is the coolest person I have ever worked with.

[Andrew](https://github.com/RedBrogdon), my secondary mentor, was also always there to help me with my questions, be they project related or career related. He helped me take an approach that would solve my problem in an easy and compelling way, always keeping in mind the perspectives of the community and myself.

### Learning

GSoC is primarily a learning-focused program and always will be. I personally learned a lot from the entire program. I learned how to build a sample intended to teach something while keeping everything else as simple as possible, how to build a codelab (which you can do too, using [these codelab authoring and tools](https://github.com/googlecodelabs/tools)), and much more.

### Challenges

It’s always said that there’s no growth/learning without challenges. The first challenge I faced was to keep the sample extremely simple, but at the same time as realistic as possible. The next challenge was when I tried to run Flutter Driver tests using Travis CI, as I had no prior experience with CI (continuous integration) systems. We were able to get CI running, but we decided to not include it in the sample because Flutter Driver tests are supposed to be run on a physical device and not on an emulator/simulator.

Lastly, I would like to thank Brett, Andrew, the Flutter team, and the GSoC team for the amazing experience I had during this summer.

Thanks for reading!
> About the author: Abdullah is a senior year undergrad student based in Pune, India. He has a keen interest in Mobile App Engineering and a lot of other things built around it. You can connect with him on [Twitter](https://twitter.com/abdullahzakir99), [LinkedIn](https://www.linkedin.com/in/abdullahzakir99/), and [GitHub](https://github.com/abd99).
