---
title: "How can we improve the Flutter experience for desktop?"
description: "Insights and priorities based on 2022 Flutter desktop user research by Mindy Hoover and Chris Bracken"
publishDate: 2022-12-12
author: melyndahoover
image: images/1VbmSF-liAOyeParju2Y4kw.webp
category: announcement
layout: blog
---

In February, Flutter launched official [support for developing Windows](https://medium.com/flutter/announcing-flutter-for-windows-6979d0d01fed) apps, extending its cross-platform capabilities to desktop. With the release of [Flutter 3](https://medium.com/flutter/introducing-flutter-3-5eb69151622f) in May 2022, Flutter announced stable support for macOS and Linux, completing the trifecta of desktop support! Now that Flutter users have had a few months to experiment with these new capabilities, we wanted to know: *how can Flutter better support desktop developers?*

To answer that question, we collected data from 1,901 Flutter desktop developers in the Q3 Flutter survey. If you attended Flutter Vikings in August, you might have seen UX researchers chatting with developers during focus group sessions as well. Here’s what we found and how we’ll use it to improve Flutter.

## How satisfied are you with Flutter on desktop?

On average 78% of Flutter desktop developers across Windows, macOS, and Linux reported that they were *very* or *somewhat satisfied* with their development experience. This rating is on par with satisfaction for iOS (78%) and in between Android (92%) and web (63%). That’s great news for Flutter desktop! But it also begs the question, where is the experience falling short for the other 22%?

<DashImage figure src="images/13nXqiZ_vAvOXBU4yeRTOHA.webp" alt="Satisfaction by target platform" caption="Satisfaction by target platform" />

## What parts of the desktop developer workflow are most challenging?

Next, we asked developers to gauge their satisfaction at various stages of the software development workflow. The results showed that satisfaction tended to decrease over the course of the desktop app development process. This resulted in the lowest user satisfaction while *debugging performance issues* and *deploying the app*. Additionally, finding Flutter packages that work for desktop is challenging, according to qualitative feedback from the survey and focus groups.

<DashImage figure src="images/1VbmSF-liAOyeParju2Y4kw.webp" alt="Flutter for desktop satisfaction by development workflow stage" caption="Flutter for desktop satisfaction by development workflow stage" />

The Flutter ecosystem needs more desktop-enabled packages to better support desktop. (The most requested packages are listed later in this article.) We are hard at work on new desktop-enabled APIs (more on that below), but we can’t do it all. We hope that the community will also step up and help fill those gaps by creating new packages and adding desktop support to existing ones using [federated plugins](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#federated-plugins), for example.

We know that troubleshooting performance issues isn’t a fun task, but it should at least be a satisfying experience. Our team is working hard to improve the functionality of Flutter DevTools, especially the memory analysis features, to make troubleshooting performance easier. For example, now you can use Flutter’s DevTools to [compare memory snapshots](https://docs.flutter.dev/development/tools/devtools/release-notes/release-notes-2.20.0)! Also, see the completely rewritten [memory view page](https://docs.flutter.dev/development/tools/devtools/memory).

Flutter desktop developers told us that deploying desktop apps requires too many steps. The desktop team will be conducting a task analysis on desktop app deployment to determine where we can improve app deployment processes and documentation.

## What would help you make better desktop user interfaces?

72% of users agreed that “Flutter’s built-in widgets can create UIs that are suitable for desktop.” When we asked developers what would help them improve the UI design of their desktop apps, they overwhelmingly replied that they wanted better support for:

1. Adaptive layouts (44%)

1. Drag and drop (31%)

1. Keyboard shortcuts (27%)

<DashImage figure src="images/1kfqE355iFMpjF2r52wVviA.webp" alt="Which of the following could be improved to help you reach your design goals when using flutter to develop desktop apps?" caption="Which of the following could be improved to help you reach your design goals when using flutter to develop desktop apps?" />

We strive to make Flutter the best *cross-platform* app development framework, so this is always top of mind. However, improving “*adaptive layouts*” is an ambiguous problem space that affects every target platform, not just desktop. There are also many factors at play including screen size, operating system, input devices (to name a few), so designing a useful solution isn’t a trivial task. But our engineers are on the job, working on improvements to the [flutter_adapative_scaffold](https://pub.dev/packages/flutter_adaptive_scaffold) package and creating codelabs to walk you through how to efficiently build adaptive apps. In the meantime, stay tuned for [Flutter Forward](https://flutter.dev/events/flutter-forward) in January, where Greg Spencer and Justin McCandless will be discussing how to architect adaptive apps using existing Flutter tools.

As for drag and drop and keyboard shortcuts, they have both been on our radar for a while now. In fact, the [Shortcuts Widget](https://api.flutter.dev/flutter/widgets/Shortcuts-class.html) was recently released. You can see it in action in this recent “[Widget of the Week” episode](https://www.youtube.com/watch?v=6ZcQmdoz9N8). Finally, support for drag and drop is one of our top priorities in 2023!

## What packages would make Flutter desktop development simpler?

Package support for desktop is still catching up to that of mobile and web. The most requested packages from desktop developers were:

1. multi-window (35%)

1. native controls (32%)

1. local storage (24%)

1. web views (23%)

<DashImage figure src="images/1tleEgMs6XOSPDo4smD7Zvg.webp" alt="Which APIs or features do you wish were better supported by Flutter?" caption="Which APIs or features do you wish were better supported by Flutter?" />

This feedback was closely aligned with Flutter’s current list of priorities with APIs for multi-window, native menus, and web views in the pipeline. Once those are released we can begin to prioritize solutions to local data storage and database access. Some additional package requests that are currently lower on the priority list, but also warrant consideration, are audio/video players and audio/video devices. A need for packages that support clipboard management and complex input devices (3D mouse, gamepad controllers, for example) came up during focus groups at Flutter Vikings, but wasn’t included in the quarterly survey.

If you are interested in contributing to Flutter packages for desktop, consider helping grow the Flutter ecosystem by creating packages to fill these gaps or submitting PRs to existing packages. By working together, we are confident the Flutter package ecosystem will grow and adapt to better support desktop developers.

## What additional desktop documentation is needed?

The last category surveyed covered Flutter’s desktop documentation. Satisfaction with Flutter’s desktop docs was 13% lower than satisfaction with the rest of Flutter’s documentation in Q3. Next, we asked what documentation would help streamline the desktop development process. The most requested documentation topics were:

1. Publishing apps (43%)

1. Automatic updating (42%)

1. Foreign Function Interface (FFI) (42%)

This feedback has been very helpful for prioritizing documentation work in Q4 2022 and 2023. As a result, our team is currently drafting documentation to help desktop developers publish their apps and including a helpful [codelab](https://github.com/flutter/codelabs/tree/main/ffigen_codelab) that is nearly complete! Although automatic updating is not a feature we maintain for Flutter, there are a number of [community](https://pub.dev/packages/auto_updater) [packages](https://pub.dev/packages/squirrel) in the Flutter ecosystem that provide this capability. Therefore, it’s not high on our priority list to provide an additional package. Please see [pub.dev](https://pub.dev) for automatic updating packages and their associated documentation.

<DashImage figure src="images/1Ku1PCFW0lYew-Dh7pIGDvQ.webp" alt="Which of the following desktop-specific topics do you wish was better documented?" caption="Which of the following desktop-specific topics do you wish was better documented?" />

## What’s next?

In 2023, the Flutter team is prioritizing work based on your feedback. We are actively working on solutions for multi-window and native menu bars. Drag and drop is also high on our priority list. A task analysis is in the works to determine how to make app deployment more efficient; additional documentation on this topic is forthcoming. We are also hard at work making improvements to Flutter DevTools so you can better monitor app performance and fix memory leaks. Lastly, we are creating codelabs and investigating improvements to the flutter_adaptive_scaffold package to help developers build adaptive, cross-platform apps with Flutter.

Now that we’ve set the bar, we’ll be enacting these improvements, and checking in with Flutter developers to measure our success. So keep an eye out for future Flutter surveys!

Thank you to everyone who contributed their desktop feedback during the Q3 Flutter survey and to those who took the time to talk to us at Flutter Vikings! The value of your feedback is immeasurable. If you would like to participate in future studies beyond the quarterly surveys, you can [sign up for upcoming UX studies](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform).
