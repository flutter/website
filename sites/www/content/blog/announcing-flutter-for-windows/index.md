---
title: "Announcing Flutter for Windows"
description: >-
  Build high-quality Windows apps that also run on mobile and web
publishDate: 2022-02-03
author: timsneath
image: images/0LtCDFBQudFeDS_f6.jpg
category: release
layout: blog
---

Since we launched Flutter, we’ve focused on delivering a cross-platform solution for beautiful, tailored apps that are compiled to machine code and take full advantage of the underlying graphics hardware of your device. Today marks a significant expansion of this vision with the first production release of support for Windows as an app target, enabling Windows developers to benefit from the same productivity and power that mobile developers have been enjoying.

<DashImage figure src="images/0LtCDFBQudFeDS_f6.jpg" />

Our goal with Flutter is to give you the tools you need to build a great experience, regardless of which operating system you’re building for. And so we want to bring the same core framework and tools to every place you might want to paint pixels. Flutter allows you to handcraft **beautiful** experiences where your brand and design come to the forefront. Flutter is **fast**, compiling directly to machine code; with support for stateful hot reload, you get the **productivity** of an interactive environment that allows you to make changes while your app is running and see the results immediately. And Flutter is **open**, with thousands of contributors adding to the core framework and extending it with an ecosystem of packages.
> # Nearly half a million apps use Flutter…

So far, we’ve seen momentum that has exceeded our expectations, with nearly half a million apps now released that use Flutter, including big apps from companies like [Betterment](https://verygood.ventures/success-stories/betterment), BMW, and ByteDance, and apps from thirty teams at Google. In 2021, Flutter became the most popular cross-platform UI toolkit, as measured by analysts like [Statista](https://www.statista.com/) and [SlashData](https://www.slashdata.co/):

<DashImage figure src="images/0w2gBpEJcFceqjIRv.webp" />

Our own data backs this up, with a consistent [92% of Flutter developers expressing positive satisfaction](https://medium.com/flutter/about-web-community-and-code-samples-q3-2021-survey-results-b67f5b997dca) with our tools in all four quarterly surveys in 2021. (And to the other 8% of you, we’re listening to your feedback and want you to be happy as well!)

One common request has been for Windows support.
> # Today, we’re thrilled to announce the full availability of support for Windows apps for Flutter in stable builds.

## Windows and Flutter

A couple of years ago, we laid out an ambitious vision for Flutter to expand from mobile apps on iOS and Android to other platforms including web and the *desktop*.

The core of Flutter carries across platforms: from the portable, hardware-accelerated Skia graphics engine, to the Flutter rendering system; core primitives like animation, theming, text input, and internationalization; and the hundreds of widgets that Flutter offers.

But desktop apps aren’t just mobile apps running on a bigger screen. They’re designed for different input devices, such as a keyboard and mouse. They have resizable windows that often run on a widescreen monitor. There are different conventions for critical things like accessibility, input method editors, and visual styling. And they integrate with different APIs in the underlying operating system: desktop apps support everything from file system pickers to device hardware to data stores like the Windows registry.

So while we’ve brought Flutter *to* Windows, we’ve also tailored it *for* Windows.

Just as with our support for Android and iOS, the Windows implementation of Flutter combines a Dart framework and C++ engine. Windows and Flutter communicate through an embedding layer that hosts the Flutter engine and is responsible for translating and dispatching Windows messages. Flutter coordinates with Windows to paint your UI to the screen, handles events like window resizing and DPI changes, and works with existing Windows modalities for internationalization, such as input method editors.

<DashImage figure src="images/0nmWy9ouW6nL5vrlB.webp" alt="On Windows, Flutter uses exactly the same Dart code, but takes advantage of native Windows APIs." caption="On Windows, Flutter uses exactly the same Dart code, but takes advantage of native Windows APIs." />

Your app can use every part of the Flutter framework, and on Windows, it can also talk to the Win32, COM, and Windows Runtime APIs either directly through Dart’s C interop layer, or using a platform plugin written in C++. We’ve also adapted a number of common plugins to include Windows support, including `camera`, `file_picker`, and `shared_preferences`. More importantly, the community has already added Windows support for a broad array of other packages, covering everything from Windows taskbar integration to serial port access.

<DashImage figure src="images/0EgO7uhhHTZ5M5RWX.webp" alt="There are already hundreds of packages that have been adapted to support Flutter apps built for Windows." caption="There are already hundreds of packages that have been adapted to support Flutter apps built for Windows." />

For a fully tailored Windows UI, you can also use packages like [`fluent_ui`](https://pub.dev/packages/fluent_ui) and [`flutter_acrylic`](https://pub.dev/packages/flutter_acrylic) to create an app that expresses the Microsoft Fluent design system beautifully. And using the [`msix`](https://pub.dev/packages/msix) tool you can wrap your app in an installer that can be uploaded to the Microsoft Store on Windows.

Together, this fosters creation of apps that look great on Windows, run fast on Windows, and still transfer to other desktop or mobile devices, as well as the web. Here are a few early examples that we’ve seen so far:

<DashImage figure src="images/1UuEJrQgjNUXhxgDJgjhQLg.jpeg" />

<DashImage figure src="images/0CV_R70NqCzCoGxuI.webp" />

<DashImage figure src="images/0EokU2CUDhjr6nDpW.webp" />

<DashImage figure src="images/02FlTNeXvMtnATYfw.webp" />

<DashImage figure src="images/0QZlDI5SemNqlOuX1.webp" />

<DashImage figure src="images/0EqTtZLTkDhGrNAZj.webp" alt="Some early community examples of Windows apps built with Flutter, including [Harmonoid](https://github.com/harmonoid/harmonoid) and [Rows](https://rows.com/)." caption="Some early community examples of Windows apps built with Flutter, including [Harmonoid](https://github.com/harmonoid/harmonoid) and [Rows](https://rows.com/)." />

## Microsoft and Flutter

We asked the Windows team if they’d be willing to share a few words about Flutter’s support. Here’s what Kevin Gallo, Corporate Vice President for Windows Developer Platform at Microsoft, has to say:
> “We’re delighted to see Flutter adding support for creating Windows apps. Windows is an open platform, and we welcome all developers. We’re excited to see Flutter developers bring their experiences to Windows and also publish to the Microsoft Store. Flutter support for Windows is a big step for the community, and we can’t wait to see what you’ll bring to Windows!”

Indeed, several teams from Microsoft have contributed to today’s announcement. In particular, we’d like to express our gratitude to the Fluent design team for their contribution of iconography for Flutter apps on Windows. Their [`fluentui_system_icons`](https://pub.dev/packages/fluentui_system_icons) package has been awarded Flutter Favorite status to signify its quality.

We’ve also been impressed with the investments Microsoft has made around accessibility for Windows, and we’re grateful for that team’s assistance to ensure Flutter has support for screen readers from day one. It’s a mistake to dismiss accessibility as a niche requirement. As this diagram from the [Microsoft inclusive design toolkit](https://www.microsoft.com/design/inclusive/) illustrates, we all have reason to care about delivering experiences that adapt for different permanent, temporary, or situational needs.

<DashImage figure src="images/1kZRGSKMDQQhbINmZRw6z4w.webp" />

The video below demonstrates how Flutter integrates with Windows Narrator. For the purposes of this video, we’ve deliberately blurred the screen to give you a sense of how valuable this feature is to users who need it.

<YoutubeEmbed id="YVSlpqSXV0c" title="Flutter Windows Narrator Demo" fullwidth="true"/>

## An ecosystem of tools for Windows development

Our tooling partners are also adding support for Windows. To highlight a few:

* [FlutterFlow](https://flutterflow.io/), the low-code Flutter app design tool, is [announcing support today for Windows](https://www.youtube.com/watch?v=6jnXHgSQ-Q0), along with features to help Flutter developers build apps tailored for desktop usage.

* [Realm](https://docs.mongodb.com/realm/sdk/flutter/) is a super-fast local data store. [The latest version, shipping today](https://www.mongodb.com/developer/article/introducing-realm-flutter-sdk/), now supports building Windows apps with Flutter, with fast access to the underlying database using [Dart FFI](https://dart.dev/guides/libraries/c-interop), adding to their existing support for mobile platforms like iOS and Android.

* Nevercode has updated their [Codemagic CI/CD tool](https://flutterci.com/) to support Windows, enabling you to test and build your Windows apps in the cloud and automate deployment of your app to the Microsoft Store.

* [Syncfusion](https://www.syncfusion.com/flutter-widgets) have updated their suite of widgets to take full advantage of Windows. If you subscribe to their toolkit, you’ll find data visualization components like treemaps and charting, a rich data grid widget, calendars and even support for PDF creation and Excel spreadsheets.

* Lastly, [Rive](https://rive.app/) announced today an upcoming Windows version of their popular graphics tooling suite, allowing designers and developers to create interactive vector animations that can respond to code in real time using a state machine. The upcoming Windows edition of their app offers screaming fast performance and a lower memory footprint, and will be available soon in the Microsoft Store for download.

<DashImage figure src="images/1IDu8nsxUNLecfET3nuSdDg.webp" alt="[Rive](https://rive.app), coming soon to the Microsoft Store on Windows." caption="[Rive](https://rive.app), coming soon to the Microsoft Store on Windows." />

It’s very exciting for us to see a mature ecosystem built around Flutter, and we’d encourage you to check out each of these partners as you start building Windows apps with Flutter.

## Windows support arrives in Flutter 2.10

Stable, production-quality support for building Windows apps is available as part of [Flutter 2.10, which releases today](https://docs.flutter.dev/get-started/install). Flutter 2.10 also includes many other features, performance improvements and bug fixes, which are covered in more detail [in a separate blog post](https://medium.com/flutter/whats-new-in-flutter-2-10-5aafb0314b12).

In the coming months, you’ll hear more from us on completing stable support for macOS and Linux, making the full set of desktop, web, and mobile platforms available for your production Flutter apps.

In the meantime, thank you for your support of Flutter. We’re excited to see what you build for Windows!

<DashImage figure src="images/0vowtRZE_wvyVA7CB.webp" />
