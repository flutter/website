---
title: Web support for Flutter
description: "Announcing the tech preview release of Flutter for web."
---

Web support is a code-compatible implementation of Flutter that is
rendered using standards-based web technologies: HTML, CSS and JavaScript.
With web support, you can compile existing Flutter code written in
Dart into a client experience that can be embedded in the browser and
deployed to any web server. You can use all the features of Flutter,
and you don’t need a browser plug-in.

{{site.alert.warning}}
  **As of 1.9, web support is available as a tech preview.**
  As web support hasn't yet reached alpha,
  you can expect to experience crashes and missing features.
  If you experience a problem that hasn't yet been reported, please
  [file an issue][] and make sure that "web" appears in the title.
{{site.alert.end}}

<img src="/images/Dart-framework-v-browser-framework.png"
     alt="showing Flutter architecture for C++ vs Flutter for web"
     width="100%">

Adding web support to Flutter involved implementing Flutter's
core drawing layer on top of standard browser APIs.
Using a combination of DOM, Canvas, and CSS,
web support aims to provide a portable, high-quality,
and performant user experience across modern browsers.
We implemented this core drawing layer completely in Dart
and used Dart's optimized JavaScript compiler to compile the
Flutter core and framework along with your application
into a single, minified source file that can be deployed to
any web server.

In this early stage of development,
we envision the web version of Flutter
being valuable in many scenarios. For example:

**A connected [Progressive Web Application][] built with Flutter**
: Web support for Flutter enables existing mobile-based applications
  to be packaged as a PWA for reach to a broader variety of devices,
  or to provide a companion web experience to an existing app.

**Embedded interactive content**
: Flutter provides a powerful environment for creating rich,
  data-centric components that can be easily hosted within
  an existing web page. Whether for data visualization, an online
  tool like a car configurator, or an embedded chart,
  Flutter can provide a productive development approach for
  embedded web content.

**Embedding dynamic content in a Flutter mobile app**
: An established way to provide dynamic content updates within
  an existing mobile application is the use of a web view control,
  which can load and display information dynamically.
  The support Flutter now offers for a unified environment for
  web and mobile content enables you to deploy content online
  or embedded in an app without rewriting.

<a name="web"></a>
## Notes on web support in 1.9

This preview version of web support is your opportunity to
try it out. Before you get started, here are a few notes:

{{site.alert.note}}
  * This release is missing features and has known performance
    issues, so we don't recommend it for production.

  * You can update existing Flutter code to work on the web,
    but there are some caveats as web support hasn't
    yet reached beta. For more information, see the
    [web FAQ][].
{{site.alert.end}}

The following resources can help you get started:

* To add web support to an existing app, or to create a
  new app that includes web support, see
  [Building a web application with Flutter][].
* To learn how to create a responsive Flutter
  app, see [Creating responsive apps][].
* To view commonly asked questions and answers, see the
  [web FAQ][].
* To see code examples,
  check out the [web samples for Flutter][].
* To learn about deploying a web app, see
  [Preparing an app for web release][].
* [File an issue][] on the main Flutter repo.
* You can chat and ask web-related questions on the
  **#news** discussion board on the [Discord group][].



[Progressive Web Application]: https://developers.google.com/web/progressive-web-apps/
[main Flutter repo]: {{site.github}}/flutter/flutter
[web FAQ]: /docs/development/platform-integration/web
[Building a web application with Flutter]: /docs/get-started/web
[Creating responsive apps]: /docs/development/ui/layout/responsive
[web samples for Flutter]: https://flutter.github.io/samples/
[Preparing an app for web release]: /docs/deployment/web
[File an issue]: https://goo.gle/flutter_web_issue
[Discord group]: https://discordapp.com/invite/yeZ6s7k
[file an issue]: https://goo.gle/flutter_web_issue
