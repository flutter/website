---
title: "Going deeper with Flutter’s web support"
description: "Harnessing the full power of the web platform for app-centric experiences"
publishDate: 2020-07-29
author: mariam_hasnany
image: images/1dbcXXNRiMmMXxA1YsZYwcQ.webp
category: announcements
layout: blog
---

Today we want to give an update on our progress towards bringing Flutter to the web, with a particular focus on work we’re doing to integrate deeply and natively with the web platform.

<DashImage figure src="images/1dbcXXNRiMmMXxA1YsZYwcQ.webp" />


Our vision for Flutter is to provide a portable toolkit for building beautiful experiences wherever you might want to paint pixels on the screen. As [we’ve noted previously](https://medium.com/flutter/flutter-web-support-updates-8b14bfe6a908), we are deliberately app-centric with our framework and API choices, building a layered architecture that can scale across mobile, desktop, and embedded devices without compromising performance or quality.

The web is at the core of our work. Flutter was originally born out of explorations from the Chrome team. It draws inspiration from the productivity and iterative development model of the web, and many of our engineers have years of experience building browser engines and web standards. We target the web browser because it is the beating heart of the internet: the most pervasive, flexible, and extensive app model that has existed in computing history.

For years, the web platform and the HTML DOM were essentially the same thing. But recently, the web platform has expanded with ever-richer APIs and capabilities that expose the underlying operating system and hardware. From [hardware-accelerated graphics](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API) to [shell integration](https://w3c.github.io/manifest/) and [PWAs](https://web.dev/progressive-web-apps/), from [service workers](https://developers.google.com/web/fundamentals/primers/service-workers) to new [layout and paint APIs](https://developer.mozilla.org/en-US/docs/Web/Houdini), the web is an ever more potent target for complex apps and even frameworks that layer on top of this foundation.

Flutter’s web support is not simply a transpiler to the DOM: it takes full advantage of this emerging set of APIs to offer an experience that is both true to the web and a no-compromise expression of Flutter.

In this post, we provide a deeper insight into this story, sharing how Flutter uses the web to enable rich interactive experiences without having to rewrite existing Flutter code. We also address areas like accessibility and backend compilation choices that may not be immediately obvious to a casual experimenter.

## More than a canvas painting

What does it actually mean to paint Flutter widgets as pixels on the web?

Let’s start with a recap of Flutter’s web architecture. Flutter is a [multilayer system](https://flutter.dev/docs/resources/technical-overview#layer-cakes-are-delicious) with:

* a *framework* that provides abstractions for common idioms like widgets, animation and gestures.

* an *engine* that renders to the target device using the system APIs it exposes.

The framework code is written in Dart. We combine that with your own code and at compile time apply [tree-shaking algorithms](https://medium.com/flutter/optimizing-performance-in-flutter-web-apps-with-tree-shaking-and-deferred-loading-535fbe3cd674) so that only the code used by your application is downloaded to the browser. Flutter adopts a reactive model, rendering the user interface in response to state changes. Within each frame Flutter builds widgets, performs layout, and lastly paints changes to the UI using the underlying browser APIs.

<DashImage figure src="images/0RAaqRbmWskcjj6j2.webp" alt="Flutter’s architecture for the web is multilayer system with a Framework on top of a browser engine." caption="Flutter’s architecture for the web is multilayer system with a Framework on top of a browser engine." />


By default, the web mode uses standard HTML DOM and Canvas technologies. In this mode, the engine translates each generated Flutter scene into HTML, CSS or Canvas, and renders a frame onto the page as a tree of HTML elements.

We call this approach the DomCanvas backend. It gives us the most compatibility across browsers with a compact code size and is well suited for apps with short lived sessions that require fast startup.

While we continue to make good progress on DomCanvas performance and fidelity, we’re also working in parallel on a [CanvasKit](https://skia.org/user/modules/canvaskit)-based backend that enables rendering Skia paint commands in the browser using [WebAssembly](https://webassembly.org/) and [WebGL](https://www.khronos.org/webgl/). We started experimenting with CanvasKit because Skia is the same graphics engine used by Flutter mobile and desktop and, unlike HTML DOM, it allows direct access to the low-level graphics stack enabling full parity with native Flutter.

While DomCanvas offers broader browser support, smaller code size, fast initial page load, CanvasKit allows Flutter developers to embrace new technologies for building graphically-intensive web apps. In the future, the advantages of one approach may become overwhelming, but for now Flutter gives you [the option to choose](https://github.com/flutter/flutter/wiki/Experimental-flags-for-web-support#canvaskit-backend) which backend best fits your desired use case.

## Feeling at home in the browser

For a web application to feel at home in the browser, it must support a wide variety of browser idioms, including natural text interaction and scrolling behavior, back/forward navigation, and accessibility, all with good performance across a wide variety of devices and form factors.

### **Text rendering**

One of the biggest challenges we faced when building Flutter’s web support was developing a layout system specifically for text layout. In order to lay out a paragraph of text, Flutter creates a [`paragraph`](https://api.flutter.dev/flutter/dart-ui/Paragraph-class.html) object and calls its [`layout()`](https://api.flutter.dev/flutter/dart-ui/Paragraph/layout.html) method. Since the web currently lacks a direct text layout API, we use the DOM to perform various measurements on the paragraph by triggering `layout()` and observing side-effects of layout properties for other elements in the frame.

As you can imagine, these measurements can become quite expensive, so we recently started experimenting with using a [canvas API for measuring text](https://github.com/flutter/flutter/issues/33523) to improve both backend approaches. We’ve found that it improves text layout performance by up to 6x and also resolves several issues with multi-line text fields and text overflow. You can enable these canvas text improvements with a [release mode flag](https://github.com/flutter/flutter/wiki/Experimental-flags-for-web-support#text-rendering-performance-improvements). *(Update as of 7/30/2020: canvas text measurement is now on by default in the `master` channel and will gradually roll out to other channels.)*

While rendering the text quickly and correctly is important to the end-user experience, being able to interact with the text on the browser is just as important. Today you can make text selectable on a Flutter web app by using either the `SelectableText` or `EditableText` widgets. Soon you will also be able to copy/paste the selected text as well as have better text editing interactions with text field focus handling, form editing and more.

### **Scrolling**

There are two ways scrolling can make a Flutter web app feel more natural: scrolling performance and scrolling affordance.

Whether a mobile or web app, scrolling performance can dictate whether an app is considered “janky” or not. For our rendering system, scrolling is defining a particular usage pattern on how and when we load content. We’ve specifically focused on improving the performance of scrolling this past quarter by [optimizing static content scrolling](https://github.com/flutter/engine/pull/17621) and adding [performance benchmarks](https://docs.google.com/spreadsheets/d/10AXb-4ulJipM6ZtiieFEBXhmybB6-_gTV6HDQlgcQdA/edit#gid=2047450737) to ensure we don’t regress in the future.

Since Flutter’s framework was initially designed for native mobile apps, Flutter web apps already have excellent support for gestures and scrolling physics for mobile browsers. Scrolling behaviors for desktop browsers are contingent on the work we do for Flutter desktop on a framework level. So far, we are able to process drag scrolling with a mouse and other mouse/wheel events, but we still need to add keyboard scrolling support.

### **Navigation**

Unlike native apps, web apps come with a built-in back button in the browser. Today the browser’s back button behaves like `Navigator.pop()` in any Flutter app. This means that when a user opens a link to a Flutter web app in the browser, the framework splits the initial route into parts and pushes each one.

As an example of Flutter’s navigation support today, you can try going from [google.com](https://google.com) to [gallery.flutter.dev/#/demo/banner](https://gallery.flutter.dev/#/demo/banner), and then clicking the browser back button.

<DashImage figure src="images/1cDlTCoUW0SRMVUl4B1sDPw.webp" alt="Today the browser back button tries to match the Flutter app’s back button routing history." caption="Today the browser back button tries to match the Flutter app’s back button routing history." />


You’ll notice it doesn’t take you back to google.com, as you might expect, but instead the home page of the site: gallery.flutter.dev. Flutter splits the initial gallery app path, pushing both gallery.flutter.dev and the /demo/banner page, so when the browser back button triggers `Navigator.pop()` it goes back to gallery.flutter.dev because that’s how the app’s internal history was set up.

There’s an ongoing effort to improve navigation/routing in Flutter for all platforms with [Navigator 2.0](http://flutter.dev/go/navigator-with-router) and a new [Router widget](http://flutter.dev/go/router-and-widgetsapp-integration). This will not only make navigation more declarative and flexible, but also improve how routing history works for Flutter web apps.

## Being accessible

By design, Flutter implements accessibility by building a `SemanticsNode` tree separate from the `RenderObject` tree. Flutter’s accessibility system is currently opt-in, meaning an end-user has to choose whether to enable assistive technology. When enabled, the `SemanticsNode` tree is produced by scanning the render tree and merging semantic nodes that represent a single logical interactive element on the screen.

To do this on the web, we generate a second DOM tree parallel to the DOM tree used as the `RenderObject` tree and translate the flags, actions, labels, and other semantic properties into ARIA.

Every Flutter web app can be made [accessible](https://flutter.dev/docs/development/accessibility-and-localization/accessibility). For example, the [Flutter Gallery app](https://gallery.flutter.dev/#/) is accessible once you have first enabled a screen reader assistive technology like [VoiceOver](https://www.apple.com/accessibility/mac/vision/), which works for web apps on both iOS and macOS. When you follow the screen reader instructions to explicitly enable accessibility for the app, you’ll see a semantic tree is produced.

<DashImage figure src="images/0Qvklox5veq6mDZhF.webp" alt="Every Flutter web app exposes a semantic tree to accessibility tools like VoiceOver." caption="Every Flutter web app exposes a semantic tree to accessibility tools like VoiceOver." />


Flutter’s web semantic features have reached parity with what exists for Flutter’s semantic system today, but we need to add automated testing to ensure that we don’t have regressions. There are complex features that we still need to support such as [tables](https://github.com/flutter/flutter/issues/45205) and [relationships between elements](https://developers.google.com/web/fundamentals/accessibility/semantics-aria/aria-labels-and-relationships).

## Rive: A showcase example of Flutter on the web

A prime example of a rich interactive application that demonstrates the capabilities of Flutter’s web support is Rive, who are today launching a rewrite of their design collaboration tool that is built entirely with Flutter.

Rive is an animation design application that allows designers and developers to create high-quality assets to be easily integrated to any platform. In order to combine user interface with glitch-free animations in real-time, Rive requires heavy rendering of graphics and performant experiences across modern browsers as well as other platforms.

[Rive 2 beta](https://blog.rive.app/announcing-rive-2/) is completely rewritten in Flutter, and as a result, offers both web and desktop versions from the same codebase. Their web experience uses the CanvasKit backend to deliver a consistent experience with Skia across both platforms. Stay tuned for upcoming technical blog posts from Rive describing how they rebuilt their tool using Flutter. For now, you can [sign up](https://beta.rive.app) for one of their limited slots to try out their beta web app.

<YoutubeEmbed id="rJZFaeCVuqE" title="" fullwidth="true"/>


## Conclusion

We hope this gives you a deeper understanding of how we are making full use of the power of the web platform to build out Flutter support for the web. Just a few years ago, it would not have been possible for us to deliver Flutter on the web with an acceptable level of quality and performance, but the introduction of new web technologies and continued advances in the platform have let us harness much more of the potential of the underlying device. As the web continues to evolve, we will evolve with it and improve our support for text interactions, scrolling, navigation, and accessibility as we continue to work towards to a stable release.

Check out our documentation on [getting started with building Flutter web apps](https://flutter.dev/docs/get-started/web). If you’ve already built something, we’d love to see it! Share what you’re working on, either as a [CodePen](https://codepen.io/pen/editor/flutter) or with a URL. You can find us at [@flutterdev](https://twitter.com/FlutterDev) on Twitter — we can’t wait to see what you create!