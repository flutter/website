---
title: "Flutter: What’s next on the Web?"
description: "Our priorities for upcoming releases, focusing on performance, developer experience and web integration"
publishDate: 2021-09-14
author: mariam_hasnany
image: images/17iBUzC4UvwNi8agIsCrZ7w.webp
category: announcement
layout: blog
---

<DashImage figure src="images/17iBUzC4UvwNi8agIsCrZ7w.webp" />

Flutter’s web support [hit the stable milestone](https://medium.com/flutter/flutter-web-support-hits-the-stable-milestone-d6b84e83b425) in March 2021. So what’s next?

According to our user research, the web is the target for over 10% of Flutter projects. So our focus is now on improving the quality of the initial stable release and enabling more of you to ship your Flutter web apps to production.

We established these priorities based on the findings from Flutter’s quarterly surveys and what we heard from you in issues, face-to-face discussions, and on social media. We just received the results for the Q3 survey and are pleased to see that this plan is in line with your feedback.

This article provides more detail into our roadmap and the work planned for each priority. Some features may span several quarters, and others require investigation (🔍) before we can commit to a solution.

## WEB LOOK AND FEEL

It’s important that Flutter web apps feel natural on the web. This includes features such as scrolling behavior, text functionality, splash screens, hyperlinks, SEO, and other web-specific UI features.

### RTL text

Previously, Flutter offered incomplete web support for right-to-left (RTL) languages such as Arabic and Hebrew. While the framework itself supported RTL text, the web engine produced undefined behavior because it ignored the distinction between LTR and RTL.

The recent stable release (2.5) added basic support for RTL so that all major use cases for RTL languages are supported and usable on Flutter web apps. Most of the issues related to basic support have been addressed and we plan to fix the remaining issue.

* [Implement RTL support for text editing](https://github.com/flutter/flutter/issues/32239) (fixed)

* [RTL text rendering glitch on web](https://github.com/flutter/flutter/issues/69396) (fixed)

* [TextField with `TextDirection.rtl` has misplaced cursor on web](https://github.com/flutter/flutter/issues/78550) (planned)

* [InlineSpans in RichText overlaps in RTL application](https://github.com/flutter/flutter/issues/82136) (fixed)

### Scrolling Behavior

While Flutter 2 included [several improvements](https://github.com/flutter/flutter/pulls?q=is%3Apr+is%3Aclosed+is%3Amerged+label%3A%22f%3A+scrolling%22) to support scrolling behavior on desktop browsers (such as scroll bar support), scrolling behavior is still an area that at times doesn’t look or feel right on the browser or on the OS that the web app is running on.

While some of these behaviors depend on the work for Flutter desktop support, there are some issues (listed below) that we plan to address in this roadmap specific to scrolling physics and scrollbars. We also plan to investigate trackpad support.

* [PageScrollPhysics has weird behavior](https://github.com/flutter/flutter/issues/35687)

* [No scrollbar in (infinite) list widget](https://github.com/flutter/flutter/issues/41434)

* [Mac desktop scroll physics should be range maintaining](https://github.com/flutter/flutter/issues/85579)

* [Let scrollbars avoid obstructing slivers and media query paddings](https://github.com/flutter/flutter/issues/13253)

* [MaterialScrollBehavior.buildScrollbar needs update](https://github.com/flutter/flutter/issues/87739)

🔍 Research for [trackpad support](https://github.com/flutter/flutter/issues/23604)

### App loading API

Some web apps prefer to show a splash screen, loading indicator, or landing page when an app is loading or to offer a custom experience. Currently, there is no easy way to implement a custom experience or indicate that a Flutter web app is loading; this became more critical when rendering with the CanvasKit’s larger bundle size.

Our work here focuses on providing you with an explicit API for the application start up cycle that can be used to preload the app, control the app’s loading cycle, and build splash screens or loading indicators.

* [Add support for splash screen on the web](https://github.com/flutter/flutter/issues/48468)

## ACCESSIBILITY

Accessibility is one of our top priorities; we aim to provide you with the tools necessary to build accessible web apps that work well on the most common screen readers.

Flutter 2.2 made significant improvements to accessibility support. Since then, we’ve heard concerns from end users trying to traverse their web apps with screen readers, such as [JAWS](https://www.freedomscientific.com/products/software/jaws/).

In this roadmap, we are focusing on the issues with [supported screen readers](https://flutter.dev/docs/development/accessibility-and-localization/accessibility#screen-readers) for desktop browsers, such as snackbar announcements. We will also continue to investigate ways to improve our overall accessibility support.

* [Fail to announce button press when using enter key](https://github.com/flutter/flutter/issues/83812)

* [Arrow and B key do not update the screen reader focus](https://github.com/flutter/flutter/issues/83809)

## PERFORMANCE

Performance is an area we will always prioritize to improve the user experience with Flutter web apps. Currently, our main focus will improve scrolling jank, and speed up the initial load of web apps.

### Scrolling jank

Based on our recent quarterly survey, scrolling jank was one of the top performance issues reported. Our goal is to ensure that Flutter web apps scroll smoothly using gestures on mobile and mouse/keyboard on desktop, but that also depends on the type and quantity of content a web app expects a user to scroll through.

In the coming months we will primarily focus on improving jank due to image decoding, and we will continue investigating scrolling performance issues to find other use cases we can improve.

* [Move image decoding to web workers](https://github.com/flutter/flutter/issues/63397)

* [Make platform views less expensive in the CanvasKit renderer](https://github.com/flutter/flutter/issues/71884)

### Bundling CanvasKit (offline support)

Currently, Flutter web apps rendered in CanvasKit require extra manual steps to work offline as a Progressive Web App (PWA). In order to work fully as a PWA in offline mode out of the box, and ensure that the app meets strict content security policies, we need to bundle CanvasKit and font fallbacks.

We will start by bundling CanvasKit first, then bundle fonts, and add the tooling necessary to enable offline mode.

* [CanvasKit backend should not depend on volatile Google Fonts](https://github.com/flutter/flutter/issues/85793)

* [Support bundling CanvasKit instead of CDN](https://github.com/flutter/flutter/issues/70101)

### CanvasKit download size

CanvasKit offers better performance than DOM-based approaches, and is therefore our default renderer on desktop browsers. However, the time needed to download an app impacts initial load performance (and the Lighthouse score for Flutter apps running on the web).

In this roadmap, we will investigate ways to reduce the download size of CanvasKit in an effort to improve initial load performance. We want to ensure that the end user’s devices or browser isn’t dealing with a massive payload.

🔍 [Improve CanvasKit download size](https://github.com/flutter/flutter/issues/89616)

🔍 [Find a reasonable sized emoji font fallback](https://github.com/flutter/flutter/issues/76248)

## INTEGRATION WITH HTML CONTENT

The ability to integrate with browser code is important for leveraging the strength of the web platform. There are two ways for Flutter web apps to integrate with HTML: 1) using HTML platform views within Flutter web apps, or 2) embedding Flutter as a content island into an existing web app (sort of an add to app for web). While the former exists today and may need improvement, the latter will be a new feature that needs further design and development.

### Embedding with custom element (Add to app)

Today, the only way to embed a Flutter web app into an existing website/web app is through an iframe. While that works for some use cases, it is not always an ideal solution for those slowly migrating their web app to use Flutter.

In this roadmap, we will investigate and design a custom solution that enables you to embed your Flutter web apps, similar to the add-to-app mobile scenario.

🔍 [Render app inside custom element](https://github.com/flutter/flutter/issues/32329)

## DEVELOPER EXPERIENCE

Flutter’s ecosystem includes features that you use for development but currently lack web support, such as plugins, debugging, hot reload, and so on. In order for you to have a great developer experience on the web, we will continue to bridge the parity gap between mobile and web.

### Camera plugin

A camera plugin has been one of the most requested plugins since our initial stable release; many of you find the parity gap to be a blocker when bringing Flutter mobile apps to the web.

In the Flutter 2.5 stable release, we delivered an early version of a [plugin](https://pub.dev/packages/camera_web) that initializes the camera, shows a camera preview, and takes a picture. We will make improvements to this plugin as we receive feedback.

* [Add camera support for web](https://github.com/flutter/flutter/issues/45297) (fixed with some PRs pending)

## Thank you!

While this is an overview of our current roadmap for the web, our [GitHub issue list](https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3Aplatform-web+) remains the source of truth for what we’re working on. We may add, prolong, or defer features based on what we learn and what you tell us.

As always, we greatly value your feedback and appreciate your support!
