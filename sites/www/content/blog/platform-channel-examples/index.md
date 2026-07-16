---
title: "Platform channel examples"
description: "Google Summer of Code (GSoC) ‘20"
publishDate: 2020-08-29
author: ayushbherwani1998
image: images/15PoXySK4-tAKWAY1zCzfHg.webp
category: story
layout: blog
---

Google Summer of Code (GSoC) 2020

<DashImage figure src="images/15PoXySK4-tAKWAY1zCzfHg.webp" />

Google Summer of Code is an initiative by Google to promote open source among student developers, where students pair with a mentor and work with an open source organization for three months.

This year marks the 16th year of Google Summer of Code, and the first year of the Dart organization taking part in GSoC. Many students might be thinking, that’s great, but where is Flutter?

<iframe src="https://giphy.com/gifs/3ogwFTfjbRk2iz89Mc/html5" width="435" height="244" frameborder="0" allowfullscreen></iframe>

The good news is, the projects listed include both Flutter and Dart projects. (And to be clear, all Flutter projects are written in the Dart language, but not all Dart projects use the Flutter framework.) Check out all of the project ideas on the [Dart wiki](https://github.com/dart-lang/sdk/wiki/Dart-GSoC-2020-Project-Ideas).

This post showcases the final project, which demonstrates 3 different kinds of platform channels, and was written during the 3-month coding period, as well as an example of a federated plugin.

The completed Platform Channel sample demonstrates how to use different kinds of named channels to communicate with the host application, specifically:

* How to use `MethodChannel` to invoke platform methods.

* How to use `EventChannel` to listen to continuous value changes from the platform.

* How to use `BasicMessageChannel` and `MessageCodec` to send messages of different types across the platform.

You can find the complete [platform channel sample](https://github.com/flutter/samples/tree/master/platform_channels) on GitHub.

## PlatformChannel sample

I was selected to create the `PlatformChannel` sample app, which aims to demonstrate how to send data back and forth in messages between Dart and native code using platform channels.

Flutter is a UI framework that allows you to paint beautiful pixels on the screen using the same Dart code across platforms, but what if you want to work with native APIs to access sensor events, hardware information, or access hardware like a camera, or biometrics? *Platform channels* are here to help. It’s a mechanism that allows you to communicate with your native host application and access the platform-specific APIs.

### MethodChannel **demo**

The MethodChannel demo demonstrates how to implement a [`MethodChannel`](https://api.flutter.dev/flutter/services/MethodChannel-class.html) and invoke platform methods to increment and decrement the value of a counter.

Related PR: [#453](https://github.com/flutter/samples/pull/453)

<DashImage figure src="images/1raON7YDig_i1Lt88IsfjFA.gif" alt="MethodChannel demo in action" caption="MethodChannel demo in action" />

### EventChannel demo

The EventChannel demo demonstrates how to implement an [`EventChannel`](https://api.flutter.dev/flutter/services/EventChannel-class.html) to listen to continuous values from the device’s `Accelerometer` sensor. It also shows how to test the `EventChannel` implementation, which gives you a deeper understanding of how `EventChannel` works.

Related PR: [#462](https://github.com/flutter/samples/pull/462)

<DashImage figure src="images/1LSMSOh-0dz8TCaKP2Z-CoQ.webp" alt="EventChannel Demo in action" caption="EventChannel Demo in action" />

### Platform Image demo

The Platform Image demo demonstrates how to use [`BasicMessageChannel`](https://api.flutter.dev/flutter/services/BasicMessageChannel-class.html) with [`StandardMessageCodec`](https://api.flutter.dev/flutter/services/StandardMessageCodec-class.html) to load an image from native assets. It also solves [issue #20879: Would like an example of sending an image across `PlatformChannels`](https://medium.com/r?url=https%3A%2F%2Fgithub.com%2Fflutter%2Fflutter%2Fissues%2F20879).

Related PR: [475](https://github.com/flutter/samples/pull/475)

<DashImage figure src="images/1mc9V6dDcmV0qT6UpzX1AQg.webp" alt="Platform Image demo in action" caption="Platform Image demo in action" />

### BasicMessageChannel & different MessageCodec demo

The BasicMessageChannel demo demonstrates how to use `BasicMessageChannel` and [`MessageCodec`](https://api.flutter.dev/flutter/services/MessageCodec-class.html) to move structured data across platforms. In the demo, it uses a variety of `MessageCodecs` to send and receive data about pets.

Related PRs: [#484](https://github.com/flutter/samples/pull/484), [#496](https://github.com/flutter/samples/pull/496)

<DashImage figure src="images/1oXELli8oLVJuWFW6BtdXjw.webp" alt="BasicMessageChannel Demo in action" caption="BasicMessageChannel Demo in action" />

## Federated plugin sample

During my first video conference with my mentor, Andrew, he told me about an often-used quote at Google, to “always keep your wheels in the dirt”; in other words, “make sure that you aren’t stuck, but can make progress and move forward”. So, to keep my wheels in the dirt during GSoC, we decided that I would *also* work on a federated plugin sample. The sample aims to demonstrate how to build a *federated plugin* (a plugin divided into a different package for each platform implementation) to retrieve the current battery level of the device on different platforms. The sample also demonstrates how to work with platform channels to communicate with different platforms, including web and desktop. Currently, the plugin only supports Android and web. Support for Windows and Linux will be added soon.

Check out the [federated_plugin sample on GitHub](https://github.com/flutter/samples/tree/master/experimental/federated_plugin).

Related PRs: [#497](https://github.com/flutter/samples/pull/497), [#503](https://github.com/flutter/samples/pull/503), [#507](https://github.com/flutter/samples/pull/507), [#526](https://github.com/flutter/samples/pull/526)

Check out all of [my PRs for flutter/samples](https://github.com/flutter/samples/pulls?q=+is%3Apr+author%3AAyushBherwani1998+).

### Other Contributions

Apart from working on the main project and contributing to the [flutter/samples](https://github.com/flutter/samples) repository, I also contributed to the [flutter/flutter](https://github.com/flutter/flutter) repository, and it has been a fabulous learning journey for me. During the GSoC period, I opened 20 pull requests, of which 16 got merged and three are still in review. Check out [my PRs to flutter/flutter](https://github.com/flutter/flutter/pulls?q=is%3Apr+author%3AAyushBherwani1998+).

Taking the first step and contributing to any open source project is often challenging. We all have encountered this situation, therefore to help the first time contributors and share my experience, I penned a blog, [Contributing to Flutter: Getting Started](https://medium.com/flutter-community/contributing-to-flutter-getting-started-a0db68cbcd5b).

## Experience

It has been a great journey to work and learn under the mentorship of the Flutter team. For me, the best thing about GSoC is not the stipend but the mentorship and learning experience that I can cherish my whole life.

### Mentorship

[Andrew](https://twitter.com/redbrogdon) has not only been a great guide but also a friend who has helped me to improve my technical skills and with my career-related questions. He always trusted my abilities and allowed me to explore and experiment with the samples. Whenever I was stuck on a problem, he proactively helped me to find a way around, or introduced me to someone from the Flutter team who could help me. The same goes for [Brett](https://twitter.com/DomesticMouse). Though not my primary mentor, he helped me whenever I reached out to him.

### Learning

I am glad Andrew and I decided to follow the [Test Driven Development](https://en.wikipedia.org/wiki/Test-driven_development) process, which has helped me to understand a different type of software development and get a better understanding of how platform channels work internally. Working on a federated plugin sample also gave me a chance to explore win32 development.

### Challenges

Challenges are what makes GSoC a great learning journey. One of the hurdles we faced was designing the WinRT/C++ API for the federated plugin sample. Though we were not able to overcome it due to some constraints, doing research about the topic helped me to explore the other paths and find an alternate solution.
> # That’s it for this article, I would like to thanks Andrew, Brett, and the Flutter team, who helped me to complete the samples and contribute to the Flutter SDK 🎉

*About the author: Ayush is an Undergraduate student who is passionate about developing efficient Mobile apps in both Flutter and Android. Apart from Mobile Development, his interest lies in developing Mobile DApps. You can connect with him on [Twitter](https://twitter.com/ayushbherwani), [LinkedIn](https://linkedin.com/in/ayushbherwani), and [GitHub](https://github.com/AyushBherwani1998).*
