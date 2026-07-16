---
title: "Announcing Flutter 3.3 at Flutter Vikings"
description: "A new Flutter release, a beautiful new app, work on improving rendering performance, and a note of farewell"
publishDate: 2022-08-30
author: timsneath
image: images/0bDz2chibrm3B6QZE.webp
category: release
layout: blog
---

### Flutter 3.3, a beautiful new app, work on improving performance, and a note of farewell

Greetings from the beautiful Norwegian capital of Oslo, where members of the Flutter community are gathering for the [Flutter Vikings conference](https://fluttervikings.com/). Flutter Vikings is a two day community-driven developer event with three tracks of content from experts who have traveled from across the world. Over five thousand developers have registered so far, and while the in-person event is sold out, you can [watch all the sessions online for free](https://www.youtube.com/playlist?list=PL4dBIh1xps-EWXK28Qn9kiLK9-eXyqKLX).

Flutter continues to grow, both in usage and in the size of the ecosystem. **Every day, more than 1,000 new mobile apps using Flutter are published** to the Apple and Google Play stores, along with more usage on web and desktop. And the Flutter package ecosystem [now comprises over 25,000 packages](https://pub.dev/packages?q=sdk%3Aflutter), providing further evidence of maturity and breadth.

<DashImage figure src="images/0bDz2chibrm3B6QZE.webp" />


**Today we’re announcing Flutter 3.3.** This release is focused on refinements and performance improvements that reinforce the features shipped in Flutter 3. It expands support for the evolving Material 3 specification with several new components and a number of bug fixes, and it includes new features aimed at tablet and desktop developers including Scribble handwriting support on iPad, selectable text grouping, and trackpad support. This release also includes Dart 2.18, which introduces FFI support for libraries and code written in Swift or Objective-C. Apps that are built against this release will experience improved performance across desktop, web, and mobile, so we encourage you to run flutter upgrade to get the latest on all your developer workstations!

For more on all the new features and improvements, check out the detailed [Flutter 3.3 release notes](https://medium.com/flutter/whats-new-in-flutter-3-3-893c7b9af1ff) and the [Dart 2.18 announcement blog post](https://medium.com/dartlang/dart-2-18-f4b3101f146c).

## Wonderous: a new reference app

In partnership with the design team at [gskinner](https://gskinner.com/), **today we’re launching Wonderous**, an app built to showcase Flutter’s capacity to deliver high-end, beautiful experiences without caveats. Even as it shows off the power of Flutter, we built Wonderous together to be a beautiful app in its own right. From the stunning Taj Mahal in the Indian city of Agra to the Mayan ruins of Chichén Itzá on the Yucatán peninsula of Mexico, Wonderous brings some of the most remarkable places in the world to your phone, using video and imagery to explore the intersection of art, history, and culture.

<DashImage figure src="images/0La9LUctqdub-CvsS.jpg" />


Wonderous is an app we hope you’ll share with your family and friends, but is also an open source project that you can explore as a developer. As a real-world app, it provides a comprehensive example of a wide variety of visual techniques and best practices that we think will inspire intermediate to advanced developers. Over the coming weeks, the gskinner.com team will be sharing more detailed technical articles on the making of the app, including its support for accessibility, animation techniques that are generalizable, and tips and tricks for performance.

For more about our motivations for building Wonderous and links to its associated website, the Android and iPhone apps, and the source code, check out the [separate article](https://medium.com/flutter/wonderous-explore-the-world-with-flutter-f43cce052e1) here on the Flutter blog.

## Impeller: our new graphics engine

Aside from the improvements in 3.3 itself, the team has been hard at work on **[Impeller](https://github.com/flutter/engine/tree/main/impeller), our next-generation rendering layer**.

Impeller is a significant rewrite of a core part of the Flutter engine, replacing the previous Skia code with a custom runtime that takes full advantage of modern hardware-accelerated graphics APIs such as [Metal](https://developer.apple.com/metal/) on iOS and [Vulkan](https://developer.android.com/ndk/guides/graphics) on Android. It delivers silky-smooth animations, considerably raising the bar for what applications can expect from a multiplatform UI toolkit. The difference is visceral, and apps that use Impeller can expect to be able to push boundaries further than before while staying locked to 60Hz or faster refresh rates. Most notably, Impeller totally eradicates the need for runtime shader compilation, which is a common source of frame rate ‘jank’ for apps today.

While it is not feature complete and we are still optimizing performance, we are now testing it internally on Google-class applications. And if you download [Wonderous for iPhone](https://apps.apple.com/us/app/wonderous/id1612491897) from the Apple App Store, you’ll see Impeller in action on a production-quality app.

**We’re thrilled to now make Impeller available as an early adopter preview on iOS.** Impeller doesn’t require changes to your code, other than [enabling a flag](https://github.com/flutter/flutter/wiki/Impeller). More information on the architecture of Impeller and how to enable it [can be found on our wiki](https://github.com/flutter/flutter/wiki/Impeller). While it’s under active development, early adopters of Impeller should switch to the `master` channel of Flutter to ensure you’re working with the latest code.

We look forward to seeing apps and demos that take advantage of the performance and quality improvements in Impeller. We’d also appreciate [reproducible issue reports](https://github.com/flutter/flutter/issues/new?assignees=&labels=created+via+performance+template&labels=impeller&template=4_performance_others.md&title=[Impeller]) that demonstrate performance or fidelity regressions in current builds.

## Goodbye to Eric

We close with an affectionate farewell to [Eric Seidel](https://twitter.com/_eseidel?lang=en), one of the co-founders of Flutter who is leaving Google this month for new adventures. Eric was the very first person to introduce Flutter to the world, before it had a name or a mascot, at the [Dart Developer Summit back in 2015](https://www.youtube.com/watch?v=PnIWl33YMwA); he has managed the Flutter engineering team for most of its existence, and quite simply, without Eric there would be no Flutter as we know it.

But Eric has an entrepreneur’s heart, and his “superpower” (to use one of his favorite words) is as a creator and initiator. So it didn’t come as a huge surprise when he shared his plan to start something new. And so we send him our encouragement and appreciation as he flies the nest and begins his next adventure.

It’s fitting to close this post with an extract from the [Flutter 1.0 launch event](https://developers.google.com/events/flutter-live), in which Eric shares our vision for Flutter: **a long-term bet that we can radically improve the experience of building beautiful user experiences**. This *remains* our vision, and we’re not done. With millions of developers from around the world relying on it, an ecosystem of thousands of contributors to the project, and a team here at Google that is flourishing and growing, we hope you’ll continue to join us on our journey!

<YoutubeEmbed id="5SZZfpkVhwk" title="" fullwidth="true"/>
