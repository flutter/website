---
title: Web support for Flutter
description: "Details of how Flutter supports the creation of web experiences."
---

In addition to mobile apps, Flutter supports the generation of web content 
rendered using standards-based web technologies: HTML, CSS and JavaScript.
With web support, you can compile existing Flutter code written in
Dart into a client experience that can be embedded in the browser and
deployed to any web server. You can use all the features of Flutter,
and you don’t need a browser plug-in.

{{site.alert.warning}}
  **While in development, web support is available in the beta channel.**
  If you experience a problem that hasn't yet been reported, please
  [file an issue][] and make sure that "web" appears in the title.
{{site.alert.end}}

<img src="/images/Dart-framework-v-browser-framework.png"
     alt="showing Flutter architecture for C++ vs Flutter for web"
     width="100%">

Adding web support to Flutter involved implementing Flutter's
core drawing layer on top of standard browser APIs, in addition
to compiling Dart to JavaScript, instead of the ARM machine code that
is used for mobile applications. Using a combination of DOM, Canvas, 
and CSS, Flutter can provide a portable, high-quality,
and performant user experience across modern browsers.
We implemented the core drawing layer completely in Dart
and used Dart's optimized JavaScript compiler to compile the
Flutter core and framework along with your application
into a single, minified source file that can be deployed to
any web server.

While traditional web approaches remain a great choice, we envision
the web support available in Flutter being valuable in many scenarios. 
For example:

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
  
Not every HTML scenario is ideally suited for Flutter at this time. 
For example, text-rich flow-based content such as blog articles
benefit from the document-centric model that the web is built around,
rather than the app-centric services that a UI framework like Flutter
can deliver.

<a name="web"></a>
## Notes on web support

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
  **#help** channel on [Discord][].



[Building a web application with Flutter]: /docs/get-started/web
[Creating responsive apps]: /docs/development/ui/layout/responsive
[Discord]: https://discordapp.com/invite/yeZ6s7k
[file an issue]: https://goo.gle/flutter_web_issue
[main Flutter repo]: {{site.github}}/flutter/flutter
[Preparing an app for web release]: /docs/deployment/web
[Progressive Web Application]: https://developers.google.com/web/progressive-web-apps/
[web FAQ]: /docs/development/platform-integration/web
[web samples for Flutter]: https://flutter.github.io/samples/
