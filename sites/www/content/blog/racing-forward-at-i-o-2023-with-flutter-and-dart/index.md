---
title: "Racing Forward at I/O 2023 with Flutter and Dart"
description: "Major updates to graphics performance, web integration, developer productivity and security in Flutter 3.10"
publishDate: 2023-05-10
author: timsneath
image: images/1bzC0ul7jBVhOJiastVGKlw.png
category: events
layout: blog
---

<DashImage figure src="images/1bzC0ul7jBVhOJiastVGKlw.png" />


We’re *delighted* to be back for this year’s Google I/O, streaming live around the world from near our headquarters in Mountain View, California!

Just over three months ago, we introduced a bold new roadmap for Flutter and Dart at Flutter Forward in Nairobi, Kenya. At I/O, we’re sharing our progress against that vision with updates across the four themes that we shared: breakthrough graphics experiences, seamless integration with web and platforms, support for new and emerging architectures, and a focus on developer experience.

<DashImage figure src="images/1Zd93zNHQec6C55G3pEJuvA.png" />


As you probably know, Flutter is a UI toolkit that enables app developers to build for mobile, web, desktop, and embedded devices from a single codebase. Flutter enables you to build **beautiful** apps, giving you complete control over every pixel on the screen. It’s **fast**, taking advantage of your device’s capabilities with support for hardware-accelerated graphics and natively-compiled machine code. It’s **productive**, with technologies like stateful hot reload that allow you to immediately see code changes in your app. Its **portability** enables you to deploy to a wide variety of platforms with the same source code and without surprises. And it’s fully **open source**, with no cost to license it or need to pay for tools to develop for it.

## Ongoing Flutter momentum

Use of Flutter continues to grow both at Google and across the broader industry. Here at Google, teams have deployed Flutter apps across mobile, web and desktop platforms, with examples including:

* Android’s new [Nearby Share app for Windows](https://www.android.com/better-together/nearby-share-app/), built with Flutter, which allows wireless sharing of photos and documents between Windows and Android devices.

* The [new Play Console app](https://play.google.com/store/apps/details?id=com.google.android.apps.playconsole), currently in open beta, which lets developers view app statistics and reply to reviews.

* The [Google Cloud mobile app](https://cloud.google.com/blog/products/management-tools/google-cloud-mobile-app-with-uptime-checks), which lets you monitor your services with a new Flutter-powered experience.

* [Google Classroom practice sets](https://workspaceupdates.googleblog.com/2023/04/practice-sets-for-google-classroom.html), a new web-based tool for creating and distributing interactive assignments that deliver real-time feedback and help to students.

On the subject of Classroom, [we announced at Flutter Forward](https://www.youtube.com/watch?v=JVJF_M9bgj4) that the team was building a new version of the mobile app using Flutter. The new version is starting to roll out on iOS now, with new features in an updated version of the Android app coming soon. This version of Classroom uses the latest Flutter technologies, including our new Impeller graphics rendering engine, which enables fast, jank-free UI.

Rewriting Classroom in Flutter has even improved performance. The new version of the app has faster cold startup time than the old version, as this side-by-side video demonstrates:

<YoutubeEmbed id="_5CIATSDSPI" title="Comparison of the previous Google Classroom with the new Flutter-powered version" fullwidth="true"/>


We are continuing to invest in packages to connect your Flutter app with the rest of the Google developer ecosystem. This includes major updates to our [Google Ads support](https://medium.com/flutter/2023-google-mobile-ads-updates-for-flutter-16b603df9ec9) for native ads; [new Windows and better web support for Firebase](https://github.com/firebase/flutterfire); and new experimental support for [deeper Android interoperability](https://io.google/2023/program/2f02692d-9a41-49c0-8786-1a22b7155628/).

With Flutter support on six platforms (Android, iOS, web, Windows, macOS, and Linux), **over one million published apps now use Flutter**. They come from all over the world: from [SNCF Connect](https://play.google.com/store/apps/details?id=com.vsct.vsc.mobile.horaireetresa.android&hl=en_US&gl=US), the train travel app for the French railway; to Apple App of the Day winner [SO VEGAN](https://apps.apple.com/us/app/so-vegan/id1572826611); from [Rive’s blazing-fast desktop apps](https://rive.app/downloads) for creating animated graphics to the relationship-empowering [Agapé](https://www.getdailyagape.com/) mobile and tablet app; from the beautiful, [newly-redesigned Global Citizen app](https://www.globalcitizen.org/en/content/new-global-citizen-app-impact-activism-every-day/) to the [new Ubuntu Linux installer](https://9to5linux.com/first-look-at-ubuntu-23-04s-brand-new-desktop-installer-written-in-flutter). We’re so glad to see proof of Flutter’s value!

## Breakthrough graphics performance with Impeller

We aspire for Flutter to offer developers and designers immense power for delivering amazing graphical experiences. Over the last few years, we’ve been rebuilding our graphics rendering architecture for speed and power. We call this new engine *Impeller*.
> # “We aspire for Flutter to offer developers and designers immense power for delivering amazing graphical experiences.”

Since we introduced Impeller on iOS, we’ve expanded testing and our work with early adopters to validate production quality and further tune performance. With today’s Flutter 3.10 release, we’re delighted to announce that [Impeller is now turned on by default for iOS](https://github.com/flutter/flutter/issues/122223), giving apps a big performance boost simply by migrating to the latest version of Flutter.

With Impeller now enabled for production iOS use, we turn our attention to adding preview support for Android. Just as Impeller on iOS uses the underlying Metal APIs, Android’s implementation of Impeller builds on [Vulkan](https://www.vulkan.org/), which provides low-level APIs for speedy rendering on the underlying graphics hardware. While the vast majority of [modern Android devices](https://developer.android.com/about/dashboards#Vulkan) support Vulkan, we will support a backward-compatible mode for older devices. We’ll be sharing an early preview of Impeller for Android, along with more details about the technical underpinnings of Impeller, in an upcoming blog post.

## Seamless integration with the web

As we described at Flutter Forward, we have a different goal than most existing web frameworks. The implementation of Flutter we’re building for the web is explicitly *not* designed to be a general purpose web framework. There are plenty of existing web frameworks, like Angular and React, that fill that space very well. Instead, Flutter is the first framework designed architecturally around new and emerging web technologies like [CanvasKit](https://skia.org/docs/user/modules/canvaskit/) and [WebAssembly](https://webassembly.org/), which particularly suit complex app experiences.
> # “Flutter is the first framework designed architecturally around new and emerging web technologies like CanvasKit and WebAssembly.”

Since our early releases of Flutter’s web support, we’ve been working hard to improve performance, accessibility and interoperability.

A major contributor to perceived performance is *load time*, the interval between a page being requested and becoming interactive. In this release, we’ve taken a leap forward, thanks to reductions in the size of CanvasKit on all browsers, and additional optimizations for Chromium-based browsers. In Flutter 3.10, CanvasKit shrank to 1.5MB (from 2.7MB in our previous version). Icon fonts have also been trimmed of unused glyphs, resulting in a 100× reduction in size in most cases. Thanks to these optimizations, we reduced the load time for our default counter app by 42% using a simulated cable connection.

As previewed at Flutter Forward, we now [support embedding Flutter content in an existing HTML web page](https://flutter-forward-demos.web.app/#/), rather than Flutter occupying the entire page or needing to use inline frames. With Flutter 3.10, we introduced *element embedding*, which allows you to integrate Flutter content just like any other CSS element on the page — for instance, applying complex CSS transitions and transformations. To get started, try one of these samples that use [JavaScript](https://github.com/flutter/samples/tree/main/web_embedding/element_embedding_demo) or wrap Flutter in an [Angular component](https://github.com/flutter/samples/tree/main/web_embedding/ng-flutter).

Continuing our focus on breakthrough graphics performance, Flutter 3.10 also gains support for [fragment shaders](https://docs.flutter.dev/development/ui/advanced/shaders) on the web. Custom shaders can be used to provide rich graphical effects beyond those that the Flutter SDK provides. A shader is a program authored in a small, Dart-like language, known as [GLSL](https://www.khronos.org/opengl/wiki/Core_Language_(GLSL)), and executed on the user’s GPU. If you want to learn more, check out [our documentation on shaders](https://docs.flutter.dev/ui/advanced/shaders), as well as our [new codelab](https://codelabs.developers.google.com/codelabs/flutter-next-gen-uis#0).

## Early to new architectures with WebAssembly

[WebAssembly](https://webassembly.org/) (often abbreviated to Wasm) has been growing in maturity as a platform-neutral binary instruction format for [modern browsers](https://caniuse.com/wasm). On the web, Flutter has been using Wasm to distribute the CanvasKit runtime, while the Dart framework and application code has historically been compiled to JavaScript. We’ve been interested in targeting Wasm, instead of JavaScript, for a while. Until recently, however, Wasm lacked native support for garbage-collected languages like Dart.

Over the past year we’ve therefore collaborated with several teams across the WebAssembly ecosystem to introduce garbage collection to the standard. This has been achieved via a new extension called [WasmGC](https://github.com/WebAssembly/gc/blob/main/proposals/gc/Overview.md), which now has near-stable implementations in Chromium-based and Firefox browsers.

WebAssembly excites us with its potential to bring the performance of native code to the web. Dart’s JavaScript compiler, used across millions of lines of code at Google, already generates fast, well-tuned JavaScript. However, switching to Wasm will give us the efficiency of native code with the portability of JavaScript, which will further improve our performance on the web. In some early benchmarks, we’ve seen a boost of 3× for execution speeds, which translates into yet richer web-based experiences. And Wasm couples this with easier integration with code written in other languages like Kotlin and C++.
> # “WebAssembly excites us with its potential to bring the performance of native code to the web.”

As we wait for browser support to become more pervasive, we have introduced preview support for compiling Flutter apps to WebAssembly in pre-release channels. We’d love you to try it for your own apps and give us early feedback. To learn more, check out [flutter.dev/wasm](https://flutter.dev/wasm).

## Continued focus on developer experience

While we hope to delight many with the breakthrough graphics performance and richer web support listed earlier, we also introduce many improvements to developer velocity and productivity in this release. And [our detailed technical blog captures hundreds of improvements to Flutter itself](https://medium.com/flutter/whats-new-in-flutter-3-10-b21db2c38c73), which will be of great interest to existing Flutter developers.

But perhaps the most significant improvement in this release to the core developer experience is **the release of [Dart 3](https://dart.dev), which is included in Flutter 3.10**.

Dart 3 completes a long journey to bring sound null safety to the Dart ecosystem. Writing null-safe code protects against a whole class of programming bugs that come from uninitialized values being used without checks. While we’ve supported null safe code since Dart 2.0, we’ve now turned off the legacy “unsafe” mode. As an ecosystem, we’ve been preparing for this for some time, and with 99% of the top 1,000 packages supporting null safety, we believe now is the right time to make the transition.
> # “Dart 3 completes a long journey to bring sound null safety to the Dart ecosystem.”

Dart 3 introduces many other new features, including records, patterns, and class modifiers, which will improve the readability and fluidity of Dart code. Head to the [main Dart 3 blog](https://medium.com/dartlang/announcing-dart-3-53f065a10635) for more information and examples. Flutter itself is already taking advantage of these new Dart 3 features, so you’ll see improvements to our own codebase as these roll in. And we think you’ll enjoy using them in your own code.

## SLSA and software supply chain security

In the modern age, protecting against threats to critical software infrastructure is unfortunately a necessity. So in addition to the headline features listed earlier, our engineering team has [made a priority this year](https://medium.com/flutter/flutter-in-2023-strategy-and-roadmap-60efc8d8b0c7) of investing in security. This investment spans security testing, automation, and supply chain security.
> # “Our team has prioritized investments in security”

By undertaking the following work, we aim to give businesses further confidence in adopting Flutter:

* The Open Source Security Foundation [Best Practices Program](https://bestpractices.coreinfrastructure.org/en) serves as a useful benchmark for helping projects adhere to best practices for security and vulnerability management. We are delighted to announce that we have completed [100% of the passing requirements](https://bestpractices.coreinfrastructure.org/en/projects/5631) for this program [passing level](https://bestpractices.coreinfrastructure.org/en/projects/5631). We continue to advance towards demonstrating adherence to [silver](https://bestpractices.coreinfrastructure.org/en/projects/5631?criteria_level=1) and [gold](https://bestpractices.coreinfrastructure.org/en/projects/5631?criteria_level=2) criteria.

* Flutter has also enabled [OpenSSF Scorecards](https://securityscorecards.dev/) and [Dependabot](https://github.com/dependabot/dependabot-core) on all Flutter critical repositories. OpenSSF Scorecards is a static analysis tool that checks how well your repository adheres to best practices, and creates issues when those practices aren’t being met. Dependabot monitors vulnerabilities in project dependencies and creates pull requests to update them as necessary. Using these tools, the Flutter team has identified and resolved over 300 vulnerabilities across our sites and codelabs.

* The Flutter and Dart SDKs, along with the release workflows for these SDKs, have recently reached the [SLSA L1](https://slsa.dev/spec/v1.0/levels#build-l1) level. The SLSA (Supply-chain Levels for Software Artifacts) framework helps open source projects maintain strong supply chain security. Reaching SLSA L1 is a great step towards protecting the tools Flutter developers use daily.

* Lastly, we made many security improvements to our infrastructure. This includes migrating to more secure build and test environments while limiting access to these environments. In addition, we have improved our logging and auditing capabilities for Flutter framework and engine artifacts, providing exceptional protection of our artifacts. These improvements provide the Flutter team far greater insight into how the artifacts we generated are handled during the build process.

## An open-source project, a work of thousands

There are thousands of other changes in this release that we hope will delight existing Flutter developers. But it’s worth noting how many of those contributions come from developers outside Google. They include new features; documentation improvements; packages that extend Flutter to horizons we never could have anticipated; and reproducible issue reports and feature requests that give us fresh perspectives on how we can improve.

Flutter is not a *Google* project, it’s an *all of us* project. We’re so grateful for the diversity and enthusiasm of the community that makes Flutter the product it is. It’s a joy to join you on this mission; the future for Flutter is brighter than ever!

<YoutubeEmbed id="1J3B-xaoXgw" title="FL020 v9 YT" fullwidth="true"/>
