---
title: "Flutter web support updates"
description: "PWAs, better debugging, and CanvasKit-based rendering"
publishDate: 2020-04-29
author: mariam_hasnany
image: images/1w9xtjSXgRDPcCtNJLYhzpQ.webp
category: announcements
layout: blog
---

Almost a year ago, we shared our first technical preview of Flutter’s support for targeting the web. Our vision for Flutter is to provide a portable toolkit for building beautiful experiences wherever you might want to paint pixels on the screen. Given the pervasiveness of the web, it’s a natural place to experiment with Flutter, but its characteristics are different from a mobile platform like Android and iOS.

Having Flutter code run in a web browser opens up an array of intriguing possibilities, including:

* Providing an easy path for developers to take their existing mobile apps to the web, whether as a fully-fledged app, PWA, or as a low-friction preview of the installed experience.

* Enabling desktop app developers to build once and make a late-bound decision about whether to ship as a high-performance installed desktop app and/or a friction-free ephemeral web app.

* Tools like [DartPad](https://dartpad.dev/b3ccb26497ac84895540185935ed5825) and [CodePen](https://codepen.io/topic/flutter/templates) that let you quickly experiment with Dart code, seeing the results in real time without needing to install anything locally on your machine.

* Sharing code between mobile and web applications with minimal compromise.

Flutter was built to be unapologetically app-centric in its framework and API choices. We believe it is a distinct offering that contributes to the broad tapestry of web development. If we are successful at our goals, Flutter’s web support will provide a framework that takes full advantage of all that the web platform offers, allowing developers to build beautiful rich interactive applications that feel completely at home in a browser.

<DashImage figure src="images/1w9xtjSXgRDPcCtNJLYhzpQ.webp" alt="[Ampstor](https://ampstor.app/): a no-code tool for building better storytelling web pages, built with Flutter’s web support." caption="[Ampstor](https://ampstor.app/): a no-code tool for building better storytelling web pages, built with Flutter’s web support." />


[Ampstor](https://ampstor.app/) is a powerful example. The team set out to build an editing tool for building [AMP Stories](https://amp.dev/about/stories/), a new format that helps content providers create visual narratives for mobile devices. Here’s what they had to say about using Flutter on the web:
> “As a startup that helps customers build highly-branded experiences, it’s critical that we can get to market quickly and iterate based on customer feedback. We chose Flutter because it gave us the freedom to focus on the product, not the platform itself. We’re delighted with our experiences so far and our customers love the app we’ve built.”

Our early goal with web support was to prove the basic hypothesis that the Flutter framework could be ported to the web. Last summer, we unforked the web code back into the main framework, leading to a single codebase that supports mobile and web (as well as desktop!). Our focus has since shifted to delivering fast, jank-free performance using the latest web platform advances, improving behavioral consistency across Flutter target platforms, and rooting out and fixing scenarios that don’t yet feel natural on the web.

With that in mind, here is an update on what the team has been working on since web support landed in the beta channel last December.

## What’s new?

### PWA Support

Fans of [Progressive Web Apps](https://web.dev/what-are-pwas/) will be delighted to know that the default Flutter template for web apps now includes support for the core features needed for an installable, offline-capable PWA app:

<DashImage figure src="images/0qu7hcAYfSXorb3jx.webp" alt="The Flutter “counter” template app, running as a PWA on macOS." caption="The Flutter “counter” template app, running as a PWA on macOS." />


Notice that this looks like a normal desktop app, but it’s really a Flutter web app that’s been installed into the browser as a PWA. You can see the difference with the added icon buttons in the title bar, which exposes Chrome functionality. Flutter-based PWAs can be [installed in the same way as any other web-based PWA](https://web.dev/install-criteria/); the settings signaling that your Flutter app is a PWA are provided by `manifest.json`, which is produced by `flutter create` in the `web/` subfolder.

PWAs are supported on major mobile and desktop browsers and are just one of the ways we are investing in [bridging the gap](https://www.youtube.com/watch?v=JKVZMqpiY7w) between the capabilities of the native platform and the web.

This remains a work in progress, so please give us feedback if you see something that doesn’t look right.

### Plugins

When we launched beta, only a few plugins supported the web. Since then, we’re seeing [more plugins](https://pub.dev/flutter/packages?platform=web) add support for the web platform, thanks to some great contributions from the community, such as:

* [audioplayers](https://pub.dev/packages/audioplayers): play multiple audio files simultaneously

* [connectivity](https://pub.dev/packages/experimental_connectivity_web): allows apps to discover network connectivity and configure accordingly

* [cloud_firestore](https://pub.dev/packages/cloud_firestore): NoSQL cloud database, accessed through the Cloud Firestore API

* [cloud_functions](https://pub.dev/packages/cloud_functions): access serverless cloud functions, hosted by Firebase

While we plan on extending a few more popular Google-authored plugins for the web ourselves, we largely depend on the community to help bring web support to existing packages. To help you get started, we have published a couple of articles explaining [how to write a web plugin](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-5e26c689ea1).

### Web Debugging with Expression Evaluation

Debugging is a crucial step in the development process, and is one of the areas of active development for creating a richer Flutter web experience. If you use VS Code to develop Flutter applications, you’re probably expecting the full set of debug capabilities to be available to you, including evaluating expressions in the debug window, using the watch functionality, or hovering over variables to see their value.

Until recently, this was only available for debugging mobile Flutter apps. In the last couple of months, we have been working on connecting expression evaluation to Flutter on the web and now have experimental support ready to try out in VSCode. Support for other IDEs, such as [IntelliJ](https://github.com/flutter/flutter-intellij/issues/4519), is still in progress.

This feature is available on the Flutter dev or master channel. Use the following instructions to set it up for VS Code:

Configure your project to [run on the web](https://flutter.dev/docs/get-started/web). Within VS Code, enable expression evaluation for web in `launch.json`:

<DashImage figure src="images/0K0gsPz3gj7SVvjr1.webp" />


Set a breakpoint and start debugging. Try expression evaluation in the debug console using the expression evaluation box as shown below. Additionally, you can use the watch window or hover over variables to evaluate your code using expressions.

<DashImage figure src="images/0Zg-bAhzitlDDVU9e.webp" />


You can also try setting conditional breakpoints using expressions:

<DashImage figure src="images/0hWsTPLh33YwdFhYG.webp" />


### Testing

The latest builds of Flutter now support running automated Flutter driver UI tests against your Flutter web apps in just the same way that they work for mobile apps. To enable support for this experimental feature, you can [read the directions on the Flutter wiki](https://github.com/flutter/flutter/wiki/Running-Flutter-Driver-tests-with-Web).

## Current priorities: testing, quality and performance

Over the past few months, our focus has been spent on improving the infrastructure, quality and rendering for Flutter’s web support. While we still have a lot to do, we have made significant progress in all three areas.

### Test infrastructure and benchmarks

Building test infrastructure is one of those improvements that isn’t always visible to those developing with Flutter but is nonetheless important to building a stable version of Flutter on the web.

This past quarter we have added automated testing to ensure correctness of the web engine and framework. We added screenshot tests on Chrome to make sure we are rendering consistently and correctly as we make changes to the code. We now run unit and integration testing on Chrome, Firefox and Safari. Running these tests on mobile browsers and Internet Explorer/Edge will be coming online soon. Additionally, we have added performance benchmark tests, enabling us to iterate quickly without introducing regressions.

### Quality

Speaking of issues, we’ve been busy burning down issues to incrementally improve our quality through optimizations and correctness fixes.

Recently we landed an optimization in Flutter for web that improves scrolling for static content, meaning content that is not lazily loaded but is rendered all in the same frame. This should bring scrolling performance more in line with traditional web experiences.

We’ve also fixed several text rendering issues such as text disappearing behind the canvas or cursor problems with multiline text. These text correctness fixes are currently enabled behind the `FLUTTER_WEB_USE_EXPERIMENTAL_CANVAS_TEXT` flag; our plan is to make this the platform default soon.

At [Flutter Interact](http://g.co/FlutterInteract) last year, we announced that our new Gallery sample app runs on the web using Flutter. Since then we’ve made significant performance optimizations in web support as well as the app, so that it runs even faster and smoother. As a result of these changes, initial load time is now three times faster, and the code size has been reduced by 2.7x.

<DashImage figure src="images/19FIv19QYzuwBQ-4Hx3EkGA.webp" alt="The Flutter Gallery app, running as a PWA on Windows." caption="The Flutter Gallery app, running as a PWA on Windows." />


Stay tuned for an upcoming blog series that will share more about what we’ve learned, as well as best practices for optimizing your Flutter app for performance. Until then, check out the updated [Flutter Gallery app](https://gallery.flutter.dev) for yourself.

### Rendering improvements with CanvasKit

When we started our exploration into the web, we considered a variety of approaches for rendering UI, knowing that our choice would dictate how well we could build, layout, and paint Flutter widgets on the web.

We originally opted for an HTML DOM-based model that combines HTML, CSS, and the [Canvas API](https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API) to express output produced by the Flutter framework. We call this implementation our DomCanvas rendering system.

Over the last year, we have gained a better understanding of the performance and correctness characteristics of the various rendering technologies available on the web, and have been experimenting with a second approach that uses [CanvasKit](https://skia.org/user/modules/canvaskit). CanvasKit brings [Skia](https://skia.org/) to the web using [WebAssembly](https://webassembly.org/) and [WebGL](https://get.webgl.org/), enabling a hardware-accelerated drawing surface that improves our ability to render complex and intensive graphics efficiently.

We believe that both DomCanvas and CanvasKit offer advantages in different scenarios, and so we’re supporting both rendering models.

* DomCanvas offers the greatest compatibility with a wide variety of browsers, with a compact code size. However, repaint performance is poorer, which makes it less suitable for more graphically-intensive applications.

* The CanvasKit backend offers superior performance, fidelity, and correctness, but it has poor initial startup time due to a larger code size.

By default, Flutter’s web support uses DomCanvas, but you can enable the CanvasKit rendering engine with this command:

```bash
flutter run -d chrome --release 
            --dart-define=FLUTTER_WEB_USE_SKIA=true
```


One word of caution: the CanvasKit engine still has a few rough edges; for early adopters who are putting Flutter into production, the DomCanvas engine offers the greatest stability.

## Known issues on our radar

While we believe we’re making good progress at building a solid foundation, there are a few other areas we are planning to work on to fill out our web support.

* **Desktop-class UX.** Supporting Flutter on desktop web browsers requires more than web support: there are typically significant UI differences between mobile and desktop experiences. We’re therefore adding features to support desktop-class experiences, such as [responsive widgets](https://material.io/components/navigation-rail/) and scrolling physics, that still need to be implemented.

* **Autofill** is a feature supported in most platforms, and in terms of the web, it means enabling the browser to store data and fill it in where appropriate. We [recently added initial autofill support](https://github.com/flutter/flutter/pull/52126) to the core framework, and now we are working on [adding this feature to Flutter on the web](https://github.com/flutter/engine/pull/17986). This effort includes addressing browser differences, [saving fill information for future autofills,](https://github.com/flutter/flutter/issues/55613) and passing auto-fillable elements as a group to the engine.

* **URL Routing.** It’s a small issue, perhaps, but today Flutter web apps include a [hash marker for routing](https://github.com/flutter/flutter/issues/33245) even on the home page. We’re working to eradicate this and provide more control over URL routing, with [contributions from the community](https://github.com/flutter/engine/pull/17829) under review at present.

* **Code size** remains an area of active investigation. Today every Flutter web app downloads the engine code that it needs; we’re looking into possibilities to cache some of this logic to reduce startup time and download size.

## Call to action

We hope there are some fun surprises in this article: we’ve made a lot of progress since the December update. However, you should be aware that Flutter’s web support is still in beta, and you should be cautious about deploying it into production environments, since performance and browser compatibility work is still in progress.

If you are new to developing with Flutter on the web, check out [flutter.dev/web](https://flutter.dev/web) to learn more and try out your code on [dartpad.dev](https://dartpad.dev/) or [codepen.io/flutter](https://codepen.io/flutter).

For those that are currently developing Flutter web apps, thank you for your support and contributions, we hope you continue experimenting, [filing issues](https://github.com/flutter/flutter/issues/new?title=[web]:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version) and [updating plugins](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6) to support the web!