---
title: Web support for Flutter
description: "Details of how Flutter supports the creation of web experiences."
---

Flutter’s web support delivers the same experiences on the web as on mobile.
Building on the portability of Dart, the power of the web platform and the
flexibility of the Flutter framework, you can now build apps for iOS, Android,
and the browser from the same codebase. You can compile existing Flutter code
written in Dart into a web experience because it is exactly the same Flutter
framework and **web** is just another device target for your app.

<img src="/images/arch-overview/web-arch.png"
     alt="Flutter architecture for web"
     width="100%">

Adding web support to Flutter involved implementing Flutter's
core drawing layer on top of standard browser APIs, in addition
to compiling Dart to JavaScript, instead of the ARM machine code that
is used for mobile applications. Using a combination of DOM, Canvas, 
and WebAssembly, Flutter can provide a portable, high-quality,
and performant user experience across modern browsers.
We implemented the core drawing layer completely in Dart
and used Dart's optimized JavaScript compiler to compile the
Flutter core and framework along with your application
into a single, minified source file that can be deployed to
any web server.

While you can do a lot on the web, Flutter’s web support is most valuable in the
following scenarios:

**A [Progressive Web Application][] built with Flutter**
: Flutter delivers high-quality PWAs that are integrated with a user’s
  environment, including installation, offline support, and tailored UX.

**Single Page Application**
: Flutter’s web support enables complex standalone web apps that are rich with
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

For a glimpse into how to migrate your mobile app to web, see
the following video:

<iframe width="560" height="315" src="{{site.youtube-site}}/embed/HAstl_NkXl0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<a name="web"></a>
## Resources

The following resources can help you get started:

* To add web support to an existing app, or to create a
  new app that includes web support, see
  [Building a web application with Flutter][].
* To learn about Flutter's different web renderers (HTML and CanvasKit), see 
  [Web  renderers][]
* To learn how to create a responsive Flutter
  app, see [Creating responsive apps][].
* To view commonly asked questions and answers, see the
  [web FAQ][].
* To see code examples,
  check out the [web samples for Flutter][].
* To see a Flutter web app demo, check out the [Flutter Gallery][].
* To learn about deploying a web app, see
  [Preparing an app for web release][].
* [File an issue][] on the main Flutter repo.
* You can chat and ask web-related questions on the
  **#help** channel on [Discord][].

---


[Building a web application with Flutter]: /docs/get-started/web
[Creating responsive apps]: /docs/development/ui/layout/responsive
[Discord]: https://discordapp.com/invite/yeZ6s7k
[file an issue]: https://goo.gle/flutter_web_issue
[Flutter Gallery]: https://gallery.flutter.dev/
[main Flutter repo]: {{site.github}}/flutter/flutter
[Preparing an app for web release]: /docs/deployment/web
[Progressive Web Application]: https://developers.google.com/web/progressive-web-apps/
[web FAQ]: /docs/development/platform-integration/web
[web samples for Flutter]: https://flutter.github.io/samples/
[Web renderers]: /docs/development/tools/web-renderers
