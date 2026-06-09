---
title: Supernova
description: Supernova, a design system platform, used Flutter to build their collaborative  web app for designers and developers.
logo: images/third_party/case_studies/supernova/logo.jpeg
headline: Supernova
summary: Supernova, a design system platform, used Flutter to build their collaborative  web app for designers and developers.
companyName: Supernova
card: images/third_party/case_studies/supernova/case_study_card.png
locations:
  - North America
platforms:
  - Web
industries:
  - Productivity
tags:
  - web
publishDate: 2021-11-05
---

**Goal**

In 2019, Flutter announced an [early adopter program](https://blog.flutter.dev/flutter-for-web-early-adopter-program-now-open-9f1fb146e4c4) for companies that were ready to build with Flutter’s web support. One of those early adopters, [Supernova](https://www.supernova.io/), was interested in using Flutter to build a collaborative design system platform for the web.

In most organizations, the design and development teams work independently because they rely on different sets of tools. Supernova’s goal was to solve that disconnect by creating a platform where designers and developers can work together as one team. They also wanted to automate the process of turning the design system that designers use into something developers can directly consume in the form of code.

**Why Flutter?**

Originally, Supernova was written as a native macOS app, but their users showed a lot of interest in a web-based solution. Flutter appealed to the team because it would allow them to launch their tool on other platforms with a single codebase — especially because they knew they would eventually want a desktop app as well, since the tool is very compute-heavy and has more demanding performance needs than most websites.

The tool also uses a lot of uncommon visual operations, and they liked that Flutter gave them a way to access the lower-layer rendering engine so they can build it their own way, instead of building it from scratch using WebGL.

**Their Solution**

The team found that using web-specific libraries with Dart saved them a huge amount of time. The few times they needed a plugin that lacked web support, such as with their code preview widget, they embedded it as HTML and used a JavaScript library for syntax highlighting.

The entire tool is built with Flutter and Dart. Because it relies on a lot of sophisticated logic, their application is especially Dart-heavy, with Flutter used for the visualization layer. The team liked Dart’s language features like sound null safety, which they found crucial for making complex apps stable and maintainable. They were also excited about the annotation processing and code generation capabilities of Dart.

They used Flutter’s CanvasKit renderer to parse and render the components from a data model in Figma. The team much preferred using the CanvasKit renderer through Flutter instead of writing shaders from scratch using WebGL. CanvasKit gave them more higher-level tools for rendering, letting them focus on the nuances of converting Figma’s non-standard vector models to work with their rendering engine.

Because font management is a major challenge for developers, Supernova can support any font a designer wants to use. To do this, they used Flutter and the [google_fonts package](https://pub.dev/packages/google_fonts), which automatically downloads fonts directly from Google.

Finally, Flutter allowed the team to share one codebase between the Supernova platform and a separate plugin that they built to run in Figma. Although there are completely different front-ends, they share the same data model and logic.

***“We feel confident in our decision to use Flutter on the web.”***

\- Jiří Třečák, CEO, or Artem Ufimtcev, CTO, Supernova

**Results**

Two years after joining the early access program, Supernova launched their innovative design system platform with Flutter. Anyone can now bring their Figma designs into Supernova and immediately start exporting code for Flutter (or any other framework). Supernova’s documentation editor lets you create documents based on your design system, and includes an automation engine that updates your documents and code automatically when design changes are made.
