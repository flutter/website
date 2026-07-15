---
title: "What’s next for Flutter"
description: "Setting out our vision at the Flutter Forward event in Nairobi"
publishDate: 2023-01-25
author: timsneath
image: images/01m_CqCW7oMEoqPrl.webp
category: announcements
layout: blog
---

Today we’re excited to share our vision for Flutter at [Flutter Forward](https://flutter.dev/events/flutter-forward), our developer event streaming live from Nairobi, Kenya, as developers from around the world gather in-person and online to learn about future directions for Flutter.

Flutter is a UI toolkit that enables app developers to build for mobile, web, and desktop from a single codebase. Flutter enables you to build **beautiful** apps, giving you complete control over every pixel on the screen. It’s **fast**, taking advantage of your phone or computer’s hardware with support for hardware-accelerated graphics and natively-compiled machine code. It’s **productive**, with technologies like stateful hot reload that allow you to immediately see code changes in your app. Its **portability** enables you to deploy to a wide variety of platforms with the same source code and without surprises. And it’s fully **open source**, with no cost to license it or need to pay for tools to develop for it.

Flutter has proven popular, with over 700,000 published apps to date: from [small startups with big ideas](https://flutter.dev/showcase/so-vegan) to [enterprises with critical needs](https://flutter.dev/showcase/credit-agricole). At Google, too, we’re finding Flutter a valuable tool, enabling teams like [Google Classroom](https://edu.google.com/workspace-for-education/classroom/) to deliver high-quality solutions to mobile and web users; we’re also adding support for it in our other developer tools including [Google Ads](https://developers.google.com/admob/flutter/quick-start), [Google Maps](https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#0), [Google Pay](https://pub.dev/packages/pay), and of course [Firebase](https://firebase.google.com/docs/flutter/setup?platform=ios).

<YoutubeEmbed id="JVJF_M9bgj4" title="Google Classroom and Flutter" fullwidth="true"/>

> “With Flutter, we reduced the code size by 66% for the same functionality… this means less bugs for each platform and less tech debt in the future.” (Kenechi Ufondu, Software Engineer, Google Classroom)

The first release of Flutter provided a UI toolkit for building mobile apps on Android and iOS, but with Flutter 3, we expanded production support to include Windows, macOS, Linux, and the web, while also enabling embedded platforms to use Flutter. Building on that, [this week we shipped our latest stable release, Flutter 3.7](https://medium.com/flutter/whats-new-in-flutter-3-7-38cbea71133c), which adds a broad set of new features including a new rendering engine on iOS, enhanced support for Material 3 and iOS-style widgets, revamped support for internationalization, background processing improvements, and updates to developer tooling.

But at this event, we’re looking ***forward***, offering a preview of the next wave of investments we’re making in Flutter: breakthrough graphics performance, seamless integration for web and mobile, early support for new and emerging architectures, and a continued focus on developer experience. We’re showcasing work that will gradually be delivered over the coming months, and we hope that this leaves you excited about our vision for Flutter as a powerful toolkit for any developer who wants to build high-quality, beautiful user experiences that can go anywhere pixels are painted.

*A disclaimer: the features we’re previewing here are still under development and may change significantly over the coming months. Showing them at this early stage is designed to give early adopters a chance to contribute.*

<DashImage figure src="images/01m_CqCW7oMEoqPrl.webp" />


## Breakthrough graphics performance

Historically, cross-platform frameworks have required compromise on visuals, due to the challenges of creating an abstraction layer. Flutter has taken a different approach than most, with its own rendering layer that offers hardware-accelerated graphics and a consistent visual appearance on every device. Moving forward, we will invest in *breakthrough graphics performance* that extends Flutter’s existing strength in this area.

At Flutter Forward, we’re showing more progress on [**Impeller**](https://github.com/flutter/flutter/wiki/Impeller), Flutter’s next generation rendering engine. Impeller is optimized for Flutter, giving us even more flexibility and control over the graphics pipeline, and opening new opportunities for us. Impeller provides more predictable performance, using precompiled shaders that alleviate dropped frames at runtime caused by shader compilation. It takes advantage of primitives in Metal and Vulkan, the modern low-level APIs in iOS and Android. And it makes effective use of concurrency, distributing single-frame workloads across threads.

<DashImage figure src="images/1QrEupNb6Ebc5_4c0PW4fQw.jpeg" />


<DashImage figure src="images/1-DXiE7L987-q6zs8hczbOQ.jpeg" />


<DashImage figure src="images/1xoVH5v5x7znMLB6NTjcqCA.jpeg" alt="Impeller provides silky-smooth performance for demanding graphical apps like [Wonderous](https://wonderous.app), a beautiful app that takes you on a tour of the world’s wonders. Shown here: the latest version of Wonderous, which adapts its UI for different devices and form factors, available at [https://wonderous.app.](https://wonderous.app.)" caption="Impeller provides silky-smooth performance for demanding graphical apps like [Wonderous](https://wonderous.app), a beautiful app that takes you on a tour of the world’s wonders. Shown here: the latest version of Wonderous, which adapts its UI for different devices and form factors, available at [https://wonderous.app.](https://wonderous.app.)" />


In addition to offering a silky-smooth UI, Impeller can drastically improve performance in certain scenarios. One demo (shown below) demonstrates a best-case example of this. On the left is a kaleidoscope app using SVG clipping, built using the current default renderer. Scrolling down the page, performance drops with rendering taking longer than the per-frame budget, leading to a frame rate of 7–10 fps. The right side shows the same app running under Impeller, rendering at a glitch-free 60 fps.

<YoutubeEmbed id="Z7v-YRdHusM" title="Flutter Forward: Impeller side-by-side demo" fullwidth="true"/>


One advantage of building from the ground up is that the architecture can support brand new use cases. Newly introduced **support for custom shaders** is already leading to some [amazing new demos](https://twitter.com/reNotANumber/status/1599717360096620544) that show seamless integration with the Flutter widget hierarchy. Our work here isn’t limited to mobile devices, though: we now have early support for custom shaders on the web too, with the same code now powering hardware-accelerated experiences across iOS, Android, and the browser.

<DashImage figure src="images/0aS5btwRMIK-AkltC.webp" alt="Flutter now supports pixel shaders on the web, enabling various cool visual effects. (Credit: [Erick Ghaumez](https://twitter.com/rxlabz).)" caption="Flutter now supports pixel shaders on the web, enabling various cool visual effects. (Credit: [Erick Ghaumez](https://twitter.com/rxlabz).)" />


And now we’re starting early work on supporting **3D with Flutter**. During the keynote, we showed that you can import models created with [Blender](https://www.blender.org/), and even use hot reload to iterate with Blender in real-time and see the results in a running app. It’s early days, but we’re excited about the initial performance we’re getting, along with the potential of integrating 3D into other Flutter experiences.

<DashImage figure src="images/1ZaldnkdSaQZqWX5LKWB5Ig.webp" />


<DashImage figure src="images/1MdyKANeEPV0iIQTTwOBGog.webp" />


<DashImage figure src="images/1R-Lktrjfd8lLirhC_BBg5Q.webp" alt="Impeller enables Flutter to render 3D graphics, as shown in this fun demo of Dash." caption="Impeller enables Flutter to render 3D graphics, as shown in this fun demo of Dash." />


Adding 3D and custom shaders raises the bar for graphics performance in a portable UI toolkit to a new level. We’re very excited to see what you do with these new features as they become available.

## Seamless integration for web and mobile

While you can write an app entirely using Flutter and Dart, almost any non-trivial project needs to connect with other code. On the web, Flutter may be used as an embedded component within a larger app; on mobile, apps may need to call system APIs or other code written in another language. Our second major theme of investment is therefore *seamless integration for web and mobile.*

On the web, we’re previewing a new feature that we’re calling **element embedding**, which allows Flutter content to be added to any standard web `<div>`. When embedded in this way, Flutter just becomes a web component, integrating cleanly with the web DOM and even enabling the use of CSS selectors and transformations to style the parent Flutter object.

We’re also making some big changes to the [js](https://pub.dev/packages/js) package, to enable seamless **interoperability between JavaScript and Dart** code. With js, you can annotate any function in your Dart code with a `@JSExport` attribute, and then call it from your JavaScript code.

Combining these two new features opens up some exciting new scenarios for using Flutter on the web. In [a proof-of-concept demo](https://flutter-forward-demos.web.app/#/) that we showed at Flutter Forward, you can see a simple Flutter app embedded in a HTML-based webpage. Using CSS, we apply an animated rotation effect; even while rotating, the Flutter content remains interactive. The demo also shows that you can use an HTML button and JavaScript event handler to make changes to the Flutter state, and vice versa. When this work is complete, we think this will open up many new opportunities to use Flutter to add interactivity to an existing web app.

<DashImage figure src="images/1QjyV-g_N50iwOVNSGglxxA.webp" alt="With Element Embedding, you can embed Flutter into a &lt;div&gt; element and use CSS to style it." caption="With Element Embedding, you can embed Flutter into a &lt;div&gt; element and use CSS to style it." />


Turning to Android and iOS, Flutter has long supported integration with system APIs using platform channels, which offer a message-based approach for communicating with code written in a language like Kotlin or Swift. While this unlocks access to those libraries, it requires an app author to be conversant with multiple languages and requires a fair amount of boilerplate code.

We’re now starting work on **a new approach for system interoperability** that allows libraries to be called directly. On iOS, we’re building on our work on FFI for C interoperability, adding support for Swift and Objective-C libraries. On Android, we’re using JNI to bridge to Jetpack libraries written in Kotlin. With a new command, Dart automatically creates bindings for cross-language interoperation and converting data classes appropriately. When complete, we aspire that this work will enable a Flutter developer to call a new Jetpack or iOS library without needing to use a plugin or learn a different API syntax, as well as greatly easing the work for a plugin author. [Check out our sample](https://github.com/flutter/samples/tree/main/experimental/pedometer) to learn more!

## Early to new and emerging architectures

Thanks to Dart’s broad support for a wide range of processor architectures, as well as its highly-optimized JavaScript compiler, Flutter can already run on a broad variety of devices and form factors. But with some exciting new options on the horizon, our third theme is bringing *early support to new and emerging architectures*.

[WebAssembly](https://webassembly.org/) has been growing in maturity as a platform-neutral binary instruction format, with [growing support on modern browsers](https://caniuse.com/wasm). Excitingly, WebAssembly opens the web platform to other languages beyond JavaScript. Over recent months, we’ve been collaborating with the Chrome team and other WebAssembly partners to add [early support for garbage-collected languages](https://github.com/WebAssembly/gc) like Dart. This new extension to WebAssembly is now supported with a flag in the latest development builds of Chrome. At Flutter Forward, we’re unveiling early support for **Flutter compilation to WebAssembly**, which will enable further speed and size optimizations for our web support.

Another platform architecture that is generating growing interest is [RISC-V](https://en.wikipedia.org/wiki/RISC-V), an open standard instruction set architecture (ISA) designed for broad usage. The Android team recently gave a talk on [their work to support RISC-V](https://www.youtube.com/watch?v=70O_RmTWP58), and we’re happy to also announce that **Dart now supports RISC-V**, as part of our own journey to enable Flutter to run on RISC-V devices as they become available. Production RISC-V hardware is still in its infancy, but at Flutter Forward we demonstrated our progress to date on the [ClockworkPi DevTerm Kit R-01](https://www.clockworkpi.com/product-page/devterm-kit-r01), a self-assembly portable terminal running Linux. We believe RISC-V support will be of particular interest for embedded scenarios, where Flutter can provide a powerful UI toolkit for a diverse set of needs.

<DashImage figure src="images/1LfW_XnTVxV1dL1CLT7iAWQ.jpeg" alt="The ClockworkPi DevTerm R-01, an experimental RISC-V computer, running a Dart console app." caption="The ClockworkPi DevTerm R-01, an experimental RISC-V computer, running a Dart console app." />


## Continued focus on developer experience

Foundational to everything we’ve described above is developer productivity, which has been a hallmark of Flutter since its inception, with features like stateful hot reload. Our fourth and final area of investment for the future is a *continued focus on developer experience*, across both Flutter and Dart.

At Flutter Forward, we’re previewing some of our early work on some major new Dart language features that we hope demonstrate our commitment to tasteful evolution of the language. In our development channel, we now have early support for **records and patterns**, two new enhancements that work particularly well together.

<DashImage figure src="images/0uGTJ0p_XZE_yZ9NS.webp" alt="A simple example of records and patterns being used to return and receive multiple function parameters." caption="A simple example of records and patterns being used to return and receive multiple function parameters." />


We’re also **formally announcing Dart 3**, which is the culmination of our work to introduce sound null safety to the language. Dart 3 also removes other long-deprecated features to further modernize the language. We have started publishing alpha-quality builds of Dart 3, along with matching Flutter builds, enabling developers to test packages and apps. For more information on Dart 3, check out the [separate blog post on the Dart channel](https://medium.com/dart-lang/dart-3-alpha-f1458fb9d232).

We’re investing in the developer experience for Flutter as well, of course. Following on from the success of the casual game toolkit we [announced at I/O](https://medium.com/flutter/announcing-the-flutter-casual-games-toolkit-c22e401d8fee) last year, we’re sharing [the first version of our **news toolkit**](https://medium.com/flutter/announcing-the-flutter-news-toolkit-180a0d32c012), which accelerates mobile development for news publishers and other content providers who want to reach mobile users without having to design an app from scratch. It includes everything you need to build an article-centric app, with navigation and search, authentication, ad integrations, notifications, profiles and subscriptions, while incorporating best practices from Google News Initiative’s research. We’re today featuring three early adopters here in Africa who are building apps based on this toolkit, including [Hespress](https://www.hespress.com/), one of the largest news sites in Morocco, [Bold Sports](https://boldsportsng.com/), a popular the Nigerian sports site; and [The Standard](https://www.standardmedia.co.ke/), the oldest newspaper in Kenya.

<YoutubeEmbed id="YnJwjZ3jCTc" title="FOO041 v8" fullwidth="true"/>


## Moving forward together

We hope you share our excitement about where we’re taking Flutter moving forward. We’re continuing to invest heavily in the core developer experience, while making some foundational improvements that pave the way for ourselves and others to build even more powerful experiences with Flutter.

This image summarizes our direction:

<DashImage figure src="images/1iIgYbZq3WKnUBctIWBap_Q.webp" />


Beyond our own development themes, it’s gratifying to see how the Flutter ecosystem continues to expand, like [FlutterFlow](https://flutterflow.io/) is a low-code builder for developing native mobile applications, and [Widgetbook](https://widgetbook.io), which provides flexible tooling for designers and developers to collaborate on user interface development.

In closing, it has been wonderful to come to Kenya and see the entrepreneurship and talent of local developers. The vibrancy of the Flutter community here in Africa is special; the Flutter Kenya user group alone has over 1,000 developers. And we’re thrilled that Flutter can provide new opportunities for developers across Africa to participate in the fast-growing app economy. Klasha is a great example of this promise, using Flutter to quickly get to market and solve local problems. Here’s a video of their experience with Flutter:

<YoutubeEmbed id="o8NPZ2ofLbI" title="FL018 v4 Grade v2 YT" fullwidth="true"/>
