---
title: Web support for Flutter
shortTitle: Web
description: >-
  Details of how Flutter supports the creation of web experiences.
---

Flutter delivers the same experiences on the web as on mobile.

Building on the portability of Dart, the power of the web platform,
the flexibility of the Flutter framework, and the performance of WebAssembly,
you can build apps for iOS, Android, and the browser from the same codebase.
The web is just another device target for your app.

To get started, visit [Building a web application with Flutter][].

## Powered by WebAssembly

Dart and Flutter can compile to WebAssembly,
a binary instruction format that enables fast apps on all major browsers.

For a glimpse into the benefits of using WebAssembly,
check out the following video.

<YouTubeEmbed id="lpnKWK-KEYs?start=1712"
  title="What's new in Flutter - WebAssembly"></YouTubeEmbed>

## How it works

Flutter on the web compiles your Dart application and the Flutter framework to
either JavaScript (using `dartdevc` during development and `dart2js` for
production) or [WebAssembly][] (`dart2wasm` when building with `--wasm`),
instead of the ARM or x64 machine code used on mobile and desktop platforms.
Flutter renders your UI using hardware-accelerated browser graphics APIs
(WebGL and WebGPU) through its CanvasKit and Skwasm renderers, delivering a
portable, consistent, and high-performance experience across modern browsers.

<img src="/assets/images/docs/arch-overview/web-framework-diagram.png"
  alt="Flutter architecture for web" >

## What types of apps can I build?

While you can do a lot on the web,
Flutter's web support is most valuable in the
following scenarios:

**Single Page Application**
: Flutter's web support enables complex standalone web apps that are rich with
  graphics and interactive content to reach end users on a wide variety of
  devices.

**Existing mobile applications**
: Web support for Flutter provides a browser-based delivery model for existing
  Flutter mobile apps.

Not every HTML scenario is ideally suited for Flutter at this time.
For example, text-rich, flow-based, static content such as blog articles
benefit from the document-centric model that the web is built around,
rather than the app-centric services that a UI framework like Flutter
can deliver. However, you _can_ use Flutter to embed interactive
experiences into these websites.

However, if you want to use Dart and wish to implement a traditional
DOM-based website, a community-released Dart package,
[Jaspr][], supports static websites; in fact,
the [Dart documentation][] and [Flutter documentation][]
and [marketing][] websites were migrated to use the Jaspr package.
Note that Jaspr uses Dart (but not Flutter), and makes SEO work in the same
way a traditional website would.

[Dart documentation]: {{site.dart-site}}
[Flutter documentation]: {{site.main-url}}
[Jaspr]: https://jaspr.site/
[marketing]: {{site.main-url}}

## Get started

The following resources can help you get started:

* To add web support to an existing app, or to create a
  new app that includes web support,
  visit [Building a web application with Flutter][].
* To configure web development server settings in a centralized file,
  check out [Set up a web development configuration file][].
* To learn how to create a responsive Flutter
  app, check out [Creating responsive apps][].
* To view commonly asked questions and answers,
  visit the [web FAQ][].
* For code examples,
  check out the [web samples for Flutter][].
* For a Flutter web app demo, check out the [Wonderous app][].
* To learn about deploying a web app,
  visit [Preparing an app for web release][].
* [File an issue][] on the main Flutter repo.
* You can chat and ask web-related questions on the
  **#help** channel on [Discord][].

[Building a web application with Flutter]: /platform-integration/web/building
[Set up a web development configuration file]: /platform-integration/web/web-dev-config-file
[Creating responsive apps]: /ui/adaptive-responsive
[Discord]: https://discordapp.com/invite/yeZ6s7k
[file an issue]: https://goo.gle/flutter_web_issue
[Wonderous app]: {{site.wonderous}}/web
[Preparing an app for web release]: /deployment/web
[Progressive Web Application]: https://web.dev/progressive-web-apps/
[web FAQ]: /platform-integration/web/faq
[web samples for Flutter]: https://github.com/flutter/samples/#?platform=web
[WebAssembly]: /platform-integration/web/wasm
