---
title: "Bringing Flutter to the Web"
description: "Flutter, our portable UI framework for building beautiful, tailored experiences, now supports the modern web! We’re pleased to release a…"
publishDate: 2019-05-07
author: kevmoo
image: images/1jQBkI-cZwOP_KAEnPhzDtg.webp
category: announcements
layout: blog
---

[Flutter](https://flutter.dev), our portable UI framework for building beautiful, tailored experiences, now supports the modern web! We’re pleased to release a technical preview of the SDK that lets you take Flutter UI code and business logic and run it directly in the browser.

## Our ambitions for Flutter on web browsers

Since its first beta last year, customers have been using Flutter to create mobile apps that run on iOS and Android. However, Flutter was always architected as a portable UI toolkit and, among other places, runs on Windows, Mac, Fuchsia, and even Raspberry Pi. Since Flutter is built using Dart, which includes production-quality compilers for both native machine code and JavaScript, we had a solid foundation. The remaining challenge was to replace the Skia-based graphics engine and text renderer with web-platform equivalents.

To do this right, we needed to deliver:

* Fast, jank-free 60 frames-per-second performance for interactive graphics.

* Consistent behavior and visuals with Flutter on other platforms.

* High-productivity developer tooling that integrates with existing development patterns.

* Support for core web features across all modern browsers.

While Flutter for the web is a work in progress — and there’s plenty of work to do in each of these areas — we’re ready to share a preview so you can try it out and give us feedback.

## Flutter web architecture

The overall architecture of Flutter on the web closely resembles Flutter on mobile:

<DashImage figure src="images/1D5HYFARy1U-T4E9OtK3LMA.webp" alt="Flutter for web architecture" caption="Flutter for web architecture" />


The Flutter framework (green in the diagram above) is shared between the mobile and web offerings. It provides high-level abstractions for the UI foundations of Flutter, including animation, gestures, base widget classes, as well as a Material-themed set of widgets for most common application needs. If you’re already building on Flutter, you will feel immediately at home with Flutter for the web.

The magic comes in translating these concepts to the browser. We’ve reimplemented the dart:ui library, replacing the bindings to the Skia engine used by mobile, with code that targets the DOM and Canvas. When you compile Flutter code for the web, your application, the Flutter framework, and the web-flavored dart:ui library — all written in Dart — are compiled to JavaScript that can run on any modern browser.

<DashImage figure src="images/1jQBkI-cZwOP_KAEnPhzDtg.webp" alt="Flutter for web demo running on Chrome, Firefox, and Safari" caption="Flutter for web demo running on Chrome, Firefox, and Safari" />


We are thoughtfully embracing core web features, like seamless integration of browser history with Flutter’s routing model. We are also coordinating with [Flutter’s desktop effort](https://github.com/flutter/flutter/wiki/Desktop-shells) to enable mouse scrolling, hover, and focus — features that not required in mobile experiences.

The Flutter web project is focusing on the core value provided by the framework: rich, interactive experiences. Web content focused on documents can still benefit by embedding Flutter web visualizations.

The preview framework exists as a temporary fork of the existing Flutter framework. This allowed our engineers to move quickly to implement web functionality while letting the core team continue to maintain and improve the production-ready toolset. We have already begun to merge browser support into the main repository. We plan to provide *one* Flutter toolkit, with one framework that will power mobile, web, and other platforms.

Our planned work includes:

* Support for text features such as selection and copy-paste.

* Support for plugins. For features like location, camera, and file access, we hope to bridge mobile and the web with a single API.

* Out-of-the-box support for technologies like Progressive Web Apps.

* Unifying web development tooling under the existing Flutter CLI and IDE integration.

* Debugging web applications using DevTools.

* Improved performance, browser support, and accessibility.

Go to [flutter.dev/web](https://flutter.dev/web) to find examples, documentation, and links to more resources. We’re excited to see what you build!