---
title: Flutter for web
description: "Announcing the preview release of Flutter for web."
---

Flutter for web is a code-compatible implementation of Flutter that is
rendered using standards-based web technologies: HTML, CSS and JavaScript.
With Flutter for web, you can compile existing Flutter code written in
Dart into a client experience that can be embedded in the browser and
deployed to any web server. You can use all the features of Flutter,
and you don’t need a browser plug-in.

Flutter for web is currently available as a technical preview.

Check out the [repository](https://github.com/flutter/flutter_web)
for instructions on how to get started.

<img src="/images/Dart-framework-v-browser-framework.png"
     alt="showing Flutter architecture for C++ vs Flutter for web"
     width="100%">

Adding web support involves implementing Flutter's core drawing layer on
top of standard browser APIs. Using a combination of DOM, Canvas,
and CSS, we're able to provide a portable, high-quality, and performant
user experience across modern browsers. We implemented this core drawing
layer completely in Dart and used Dart's optimized JavaScript compiler
to compile the Flutter core and framework along with your application
into a single, minified source file that can be deployed to any web server.

In this early stage of development, we envision Flutter for web being
valuable in many scenarios. For example:

* **A connected [Progressive Web
  Application](https://developers.google.com/web/progressive-web-apps/)
  built with Flutter.** Web support for Flutter enables existing mobile-based
  applications to be packaged as a PWA for reach to a broader variety of
  devices, or to provide a companion web experience to an existing app.

* **Embedded interactive content.** Flutter provides a powerful environment
  for creating rich, data-centric components that can be easily hosted
  within an existing web page. Whether for data visualization, an online
  tool like a car configurator, or an embedded chart, Flutter can provide
  a productive development approach for embedded web content. 

* **Embedding dynamic content in a Flutter mobile app.** An established way
  to provide dynamic content updates within an existing mobile application
  is the use of a web view control, which can load and display
  information dynamically. The support Flutter now offers for a
  unified environment for web and mobile content enables you to deploy
  content online or embedded in an app without rewriting.

## Notes on the technical preview

The Flutter for web technical preview is your opportunity to try out our work.
Before you get started, here are a few notes:

* We are developing Flutter for web in a fork of the Flutter repo. This enables
  fast iterations while keeping the core Flutter repo stable.

* We have already started work to merge the web code into the core
  repository. Eventually, we'll have a singke SDK/Framework with one set
  of widgets that works across all platforms.

* The Flutter widget APIs are identical to the mobile widget APIs, but
  are temporarily packaged separately.

* You can repackage existing Flutter code to work on the web preview, but
  there are some caveats while we're still in preview. Check out the 
  [instructions](https://github.com/flutter/flutter_web#) for more details.

Go to the [flutter web](https://github.com/flutter/flutter_web)
repository to get started. Thank you for
[filing any issues](https://goo.gle/flutter_web_issue) you find.
You can also chat and ask questions on our
[Gitter channel](https://gitter.im/flutter/flutter_web).
