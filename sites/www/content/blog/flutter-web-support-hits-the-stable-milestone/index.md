---
title: "Flutter web support hits the stable milestone"
description: "Publish to web and mobile from the same codebase"
publishDate: 2021-03-03
author: mariam_hasnany
image: images/1bbkcrsggiQLxNDRAgHiSBQ.webp
category: announcement
layout: blog
---

<DashImage figure src="images/1bbkcrsggiQLxNDRAgHiSBQ.webp" />


Our vision for Flutter is to be a portable UI framework for building beautiful app experiences on any platform. Today, as part of [Flutter 2](https://medium.com/flutter/whats-new-in-flutter-2-0-fe8e95ecc65), we’re announcing that Flutter’s web support has hit the stable milestone.

The first Flutter release supported iOS and Android, and has been used to bring over 150,000 apps to mobile app stores. Now, adding web support means that those same apps can reach an even broader audience, as well as opening up new ways to build interactive experiences on the web.

In this initial release of web support, we’re focusing on three app scenarios:

* **Progressive web apps (PWAs)** that combine the web’s reach with the capabilities of a desktop app.

* **Single page apps (SPAs)** that load once and transmit data to and from internet services.

* **Expanding existing Flutter mobile apps to the web**, enabling shared code for both experiences.

This article describes what we’ve built so far, and explores examples of how you can take advantage of Flutter’s web support in your own apps.

<DashImage figure src="images/0yDQInopKQv6QR0Hb.webp" alt="[iRobot Education](https://edu.irobot.com/the-latest/building-a-coding-experience-for-all) developed the [iRobot Coding app](https://code.irobot.com/) using Flutter to offer their learn-to code experience to everyone anywhere by making it available on the web." caption="[iRobot Education](https://edu.irobot.com/the-latest/building-a-coding-experience-for-all) developed the [iRobot Coding app](https://code.irobot.com/) using Flutter to offer their learn-to code experience to everyone anywhere by making it available on the web." />


## Our journey to the web

Today’s web platform is richer than ever, with [hardware-accelerated 2D and 3D graphics](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API), [offline and installation support](https://web.dev/progressive-web-apps/), and [access to the underlying operating system and hardware](https://web.dev/fugu-status/). The web has allowed a [broad](https://vuejs.org/) [array](https://angular.io/) [of](https://flask.palletsprojects.com/) [frameworks](https://reactjs.org/) that build on this underlying platform to offer developers great flexibility in how they create apps for the web.

Since Flutter is written in [Dart](https://dart.dev/), a language that offers JavaScript compilation, it was a natural next step to explore the web as a target. This also builds towards our vision of providing a portable framework for building beautiful UI wherever you want to paint pixels.

Our approach is to build a consistent toolkit that works across all platforms (rather than have two separate frameworks that have subtle deviations of behavior), to ensure that your own code runs without surprises.

<DashImage figure src="images/0ai8xTn_dMUTB6af6.webp" />


At an architectural level, Flutter is a [multilayer system](https://flutter.dev/docs/resources/technical-overview#layer-cakes-are-delicious) with:

* A **framework** that provides abstractions for common idioms like widgets, animation, and gestures.

* An **engine** that renders to the target device using the system APIs it exposes.

The framework itself is written in Dart, and the roughly 700,000 lines of core Flutter framework code are the same across all platforms: mobile, desktop, and now web. The same is true for your code; we use either the Dart development compiler ([`dartdevc`](https://dart.dev/tools/dartdevc)) or the Dart deployment compiler ([`dart2js`](https://dart.dev/tools/dart2js)) to compile your code into JavaScript, which can then be hosted on a server.

With Dart’s ability to compile the Flutter framework (as well as your app code) into JavaScript, our work to support the web involved replacing the low-level C++ rendering engine used by mobile apps with code that maps to web platform APIs. Flutter doesn’t merely transpile to HTML equivalents of its widgets. Instead, Flutter’s web engine offers a choice of two renderers: an HTML renderer that is optimized for size and broad compatibility, and a CanvasKit renderer that uses WebAssembly and WebGL to render Skia paint commands to the browser canvas.

Our goal for Flutter is to offer a new way to target the web platform, build on existing foundations, and provide new insights that improve the web for everyone.

## Delivering a production-quality stable release

Since our [beta release of web support](https://medium.com/flutter/web-support-for-flutter-goes-beta-35b64a1217c0) a year ago, we’ve learned a lot about how early adopters are using it, and we’ve worked with a few customers who have now shipped their Flutter web apps to production.

Over this period, we have made major architectural improvements and added features that extend and optimize Flutter for the web, focusing on four areas: **performance**, **web-specific features**, **desktop form factors,** and **plugins.**

<DashImage figure src="images/1eq4uks7XD1mMWrTQVTUY6w.webp" />


### Performance

The biggest area of improvement since our early releases is performance. During development, we’ve gained a better understanding of the performance and correctness characteristics of the various rendering technologies available on the web.

We originally started with an HTML, DOM-based model. In this model, Flutter’s web engine translates each generated Flutter scene into HTML, CSS, or Canvas, and renders a frame onto the page as a tree of HTML elements. Even though the HTML renderer offered the greatest compatibility with a wide variety of browsers and had a smaller code size, the HTML renderer’s repaint performance was less suitable for more graphic-intensive applications like [Rive](https://rive.app/), a collaborative tool built with Flutter to create motion graphics.

<DashImage figure src="images/0kS0WlZkECsmnqaY7.webp" alt="[Rive](https://rive.app/), a tool for creating custom animations, rebuilt their app using Flutter on the web and it is now available in beta." caption="[Rive](https://rive.app/), a tool for creating custom animations, rebuilt their app using Flutter on the web and it is now available in beta." />


To handle the fidelity required to render intensive graphics efficiently, we started experimenting with [CanvasKit](https://skia.org/user/modules/canvaskit), which enables rendering Skia paint commands in the browser using [WebAssembly](https://webassembly.org/) and [WebGL](https://www.khronos.org/webgl/). We discovered that CanvasKit can deliver superior performance, fidelity, and correctness, enabling the level of graphical horsepower expressed in this [demo](https://flutterplasma.dev/) by [Felix Blaschke](https://github.com/felixblaschke), a talented member of the Flutter community.

<DashImage figure src="images/0PHaTJqBxdvTDycOh.webp" alt="[Flutter Plasma](https://flutterplasma.dev/), a demo created by Felix Blaschke, running on Safari, Firefox, Edge and Chrome." caption="[Flutter Plasma](https://flutterplasma.dev/), a demo created by Felix Blaschke, running on Safari, Firefox, Edge and Chrome." />


Each renderer offers advantages in different scenarios, so Flutter is supporting both rendering modes:

* **HTML renderer:** Uses a combination of HTML elements, CSS, Canvas elements, and SVG elements. This renderer has a smaller download size.

* **CanvasKit renderer:** This renderer is fully consistent with Flutter mobile and desktop, has faster performance with higher widget density, but adds about 2MB in download size.

To optimize your Flutter web app for the characteristics of each device, the rendering mode is set by default to auto. This means that your app runs with the HTML renderer on mobile browsers and with CanvasKit on desktop browsers.

You can also use `--web-renderer html` or `--web-renderer canvaskit` to explicitly choose which renderer your app uses. For more information, see [Web renderers](https://flutter.dev/docs/development/tools/web-renderers).

### Web-specific features

A Flutter app running in the browser should feel like a web app. So we added features to Flutter that help you use the best of the web.

The web has many strengths, especially its global reach. One of the many reasons to bring your existing Flutter app to the web is to reach users outside of app stores. To do that, we added support for [custom URL strategies](https://flutter.dev/docs/development/ui/navigation/url-strategies), to ensure that it’s possible for your users to reach your app anywhere with just a click of a URL. With this feature, you have control over the URLs shown in the address bar as well as the routing of your app on the web.

<DashImage figure src="images/0bf3e0LQ8MVQb0ETI.webp" alt="[Flutter Plasma demo](https://flutterplasma.dev/)’s showroom page is an example of the [url_strategy plugin](https://pub.dev/packages/url_strategy), based on Flutter’s custom URL strategies, in action." caption="[Flutter Plasma demo](https://flutterplasma.dev/)’s showroom page is an example of the [url_strategy plugin](https://pub.dev/packages/url_strategy), based on Flutter’s custom URL strategies, in action." />


Hyperlinks are also critical to how users navigate the web. A new [`link widget`](https://pub.dev/documentation/url_launcher/latest/link/Link-class.html) in the `url_launcher` package enables users to deep link to anchors within your app or to external websites. You can use `link` on relevant widgets, including buttons, inline text, images, and specify whether the link opens in the same tab or in a new tab.

Another integral part of any app is text rendering. Developing a layout system for text was one of the biggest challenges to support Flutter on the web. Since the web lacks a direct-text layout API, Flutter must perform various measurements on the [`paragraph`](https://api.flutter.dev/flutter/dart-ui/Paragraph-class.html) by triggering a [`layout()`](https://api.flutter.dev/flutter/dart-ui/Paragraph/layout.html). These measurements can become quite expensive, so a new [canvas-based text measurement](https://github.com/flutter/flutter/issues/33523) adds supports for both plain and rich text. Now, Flutter can do detailed measurements efficiently on the web, enabling things like painting highlight boxes accurately on selected text.

Interacting with text is just as important as being able to render text quickly and accurately. Text can now be selected, copied, *and* pasted by using `SelectableText` and `EditableText` widgets. Also, form text fields support [autofill](https://api.flutter.dev/flutter/widgets/AutofillGroup-class.html) by enabling the browser to store data and handle cases for future autofills.

Flutter 2 is particularly suitable for implementing Progressive Web Apps, or PWAs. PWAs are a good fit for bridging the gap between mobile and web apps in a safe and trusted manner through the efforts of Chrome’s [Project Fugu](https://web.dev/fugu-status/).

<DashImage figure src="images/0W5BGuCaX7v9rvtjh.webp" alt="[Invoice Ninja](https://www.invoiceninja.com/), an invoice management app, launched the PWA app using the same codebase as their existing Flutter mobile apps." caption="[Invoice Ninja](https://www.invoiceninja.com/), an invoice management app, launched the PWA app using the same codebase as their existing Flutter mobile apps." />


When you create a Flutter web app, we include a PWA web manifest file, as well as code to setup service workers. The [manifest file](https://developer.mozilla.org/en-US/docs/Web/Manifest) provides metadata about how your app should run, including information like icons and an app title. [Service workers](https://developers.google.com/web/ilt/pwa/introduction-to-service-worker) enable caching of resources and running your app offline. When running a Flutter app in the browser as a PWA, you’ll see the opportunity to install it to your device, whether as a mobile or desktop app.

### Support for desktop form factors

We want to make Flutter web experiences feel right, regardless of the shape and size of your browser window. On mobile browsers, Flutter apps already have excellent support for gestures and scrolling physics inherited from mobile app support. But desktop browsers offer different UI affordances, and so we’ve updated Flutter accordingly.

For instance, there is an expectation for content on the desktop to display scrollbars that can be controlled by a mouse or keyboard. So the new [customizable interactive scrollbars](https://flutter.dev/go/update-scrollbars) support a [theme](https://api.flutter.dev/flutter/material/ScrollbarTheme-class.html), a track, and the ability to scroll by dragging a thumb. The [`PrimaryScrollController`](https://api.flutter.dev/flutter/widgets/PrimaryScrollController-class.html) has been expanded so that you can use [keyboard shortcuts to scroll](https://flutter.dev/go/default-scroll-action) without having to wire up your own scroll views.

<DashImage figure src="images/06XtFgsx4cz1OY88N.jpg" alt="Property management solution for [Zurich Insurance](https://www.zurich.com/), built by [Spica Technologies](https://spicatech.co.uk/), is a great example of the business apps Flutter’s web support can enable on desktop browsers." caption="Property management solution for [Zurich Insurance](https://www.zurich.com/), built by [Spica Technologies](https://spicatech.co.uk/), is a great example of the business apps Flutter’s web support can enable on desktop browsers." />


We also increased the [default content density](https://github.com/flutter/flutter/issues/43350), because mouse pointers support a tighter density than touch devices. And we added a superset of [system mouse cursors](https://github.com/flutter/flutter/issues/60641) in the framework to support all platforms.

Finally, to support *all* users, Flutter’s web semantic features are expanded to support accessibility for Windows, macOS, and ChromeOS. On the web, a second DOM tree called the [`SemanticsNode`](https://api.flutter.dev/flutter/semantics/SemanticsNode-class.html) tree is generated in parallel to the [`RenderObject`](https://api.flutter.dev/flutter/rendering/RenderObject-class.html) DOM tree. The `SemanticsNode` tree translates the flags, actions, labels, and other semantic properties into [ARIA attributes](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA). Now you can use [Narrator](https://support.microsoft.com/en-us/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1), [VoiceOver](https://www.apple.com/accessibility/vision/), [TalkBack](https://support.google.com/accessibility/android/answer/6007100?hl=en), or [ChromeVox](https://support.google.com/chromebook/answer/7031755?hl=en#:~:text=You%20can%20turn%20ChromeVox%20on,then%20ChromeVox%20will%20start%20speaking.) screen readers to navigate a Flutter web app.

### Plugin ecosystem

Finally, web support was added to some of the most-used plugins, making it possible to bring your existing Flutter apps to the web. [Flutter plugins](https://pub.dev/) allow your code to interact with native libraries for the platform you are running on. When you run your Flutter app on the web, you can access existing JavaScript libraries through plugins.

Since the beta release and with help from the community, support for the following plugins was added:

* [image_picker](https://pub.dev/packages/image_picker_for_web)

* [google_maps](https://pub.dev/packages/google_maps)

* [firebase_analytics](https://pub.dev/packages/firebase_analytics)

* [firebase_storage](https://pub.dev/packages/firebase_storage)

* [connectivity](https://pub.dev/packages/experimental_connectivity_web)

* [cloud_firestore](https://pub.dev/packages/cloud_firestore)

* [cloud_functions](https://pub.dev/packages/cloud_functions)

* [cross_file](https://pub.dev/packages/cross_file)

## Looking forward

A few years ago, it wouldn’t have been possible to deliver Flutter on the web with an acceptable level of quality and performance. However, the introduction of new web technologies and continued advances in the platform allowed us to harness much more of the potential of the underlying device. With support for the web, Flutter encompasses every device on the internet with a consistent experience across all modern browsers and devices.

Much of this release was defined by the feedback shared by early web adopters, and by issues filed by the community. And for that, we thank you! Going forward, our primary goal is to address your feedback and resolve issues quickly so that you can stay focused on shipping a high-quality, Flutter app across *all* of your target platforms.

<DashImage figure src="images/0eLfOUS1mLRtcDr4j.webp" alt="[Moi Mobiili](https://www.moi.fi/), a modern Mobile Virtual Network Operator, recently launched their web app using Flutter." caption="[Moi Mobiili](https://www.moi.fi/), a modern Mobile Virtual Network Operator, recently launched their web app using Flutter." />


Performance will likely always be an area of investment. Our goal is to reduce code size and increase frames per second (fps). Today, every Flutter web app downloads the engine code that it needs. We’re looking into possibilities to cache some of this logic, reducing startup time and download size. We recently did work in the Flutter Gallery demo app to reduce code size using deferred libraries and plan to share what we learned soon.

We’re also continuing to refine a few areas over the coming months:

* While CanvasKit is stable, there are a couple of edge cases that aren’t covered, such as [font fallbacks](https://github.com/flutter/flutter/issues/74741) for special characters or properly supporting [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) images.

* PWAs currently [cache a subset of resources](https://github.com/flutter/flutter/issues/75861), so our full offline support still requires [extra manual steps to work for CanvasKit](https://github.com/flutter/flutter/issues/70101).

* Text rendering and functionality, like selecting heavily styled text, is still one of the most complex features we will continue to work on.

* Our plugin ecosystem is something we will also continue to invest in so that Google-published packages have greater parity across mobile and web.

<DashImage figure src="images/0O9LlG-FDFRIFAsX0.webp" alt="[Simplebet](https://simplebet.io/) used Flutter’s web support to build highly interactive embeddable NFL & NBA betting experiences within Fanduel’s existing suite of mobile apps." caption="[Simplebet](https://simplebet.io/) used Flutter’s web support to build highly interactive embeddable NFL & NBA betting experiences within Fanduel’s existing suite of mobile apps." />


## Getting started with Flutter on the web

With the portability of Dart, the power of the web platform, and the flexibility of the Flutter framework, you can now build apps for iOS, Android, and the browser from the same codebase.

For those of you who already have an existing Flutter web app, you can now build your app in the [stable channel](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels#stable). If you are new to building Flutter web apps, check out [flutter.dev/web](https://flutter.dev/web), our [get started codelab](https://flutter.dev/docs/get-started/codelab-web), and the Flutter Engage [web breakout session](https://youtu.be/HAstl_NkXl0). And, as you’re building your web app, be sure to file any issues on [GitHub](https://goo.gle/flutter_web_issue).

We can’t wait to see what you build with Flutter’s new web support!
