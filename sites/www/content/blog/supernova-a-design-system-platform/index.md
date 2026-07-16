---
title: "Supernova: a design system platform"
description: "Experience of an early adopter building a Flutter web app"
publishDate: 2021-09-30
author: mariam_hasnany
image: images/1GOSImwOIA3oqItUMRmq5Kw.webp
category: story
layout: blog
---

Two years ago, Flutter announced an [early adopter program](https://medium.com/flutter/flutter-for-web-early-adopter-program-now-open-9f1fb146e4c4) for companies that were ready to build with Flutter’s web support. Today one of those early adopters, [Supernova](https://www.supernova.io/), is launching their design system platform, which is both built with Flutter and exports code for Flutter.

We think Supernova is a good example of the kind of experience Flutter enables on the web. I sat down with Supernova’s CEO [Jiří Třečák](https://twitter.com/JiriTrecak) and CTO [Artem Ufimtcev](https://twitter.com/ArtemUfimtcev) to learn more about what they have built with Flutter’s web support.

### How would you describe Supernova to someone who has never heard of it?

Usually design and developer teams are compartmentalized and never truly work together; this is because tooling is built with only one or the other discipline in mind. So we decided to build a platform where designers and developers can come together and work as a team.

<DashImage figure src="images/1GOSImwOIA3oqItUMRmq5Kw.webp" />


### Tell me more about what sparked the idea for Supernova.

The idea stemmed from the need for a certain amount of automation in the design process to make the iterative workflow less cumbersome. What we’re launching today is a tool that automates the process of turning the design system built by designers into something developers can directly consume in the form of code.

<DashImage figure src="images/1oqPmxo8kmisR_7oiZn06vQ.webp" alt="Supernova, a platform that automates the design process" caption="Supernova, a platform that automates the design process" />


### Can you go into more detail about the features users can expect in this launch?

For this launch you can bring your Figma designs to Supernova, manage style, assets, or other components and then export them into code. We’ve built a documentation editor that lets you create documents based on your design system, and finally, an automation engine that updates your documents and code automatically when design changes are made.

<DashImage figure src="images/1YaZp-vdLHW17_b9ktY_4mQ.webp" alt="Supernova’s documentation editor" caption="Supernova’s documentation editor" />


*Everything* in our platform is built with Flutter and Dart. There is a lot of sophisticated logic, so our application is more Dart-heavy than most, and Flutter is used for the visualization layer. Alongside Flutter’s CanvasKit renderer, we also have our own Skia engine to parse and render the components from a data model in Figma.

### Why did you choose Flutter and Dart to be an integral part of what you’ve built?
> # Our main consideration for Flutter was that we would be able to bend the platform to our will.

Originally Supernova was written as a native macOS app, but we saw lots of interest in a web-based solution. Flutter’s promise of deploying to other platforms with one codebase made it an appealing choice. We knew we would eventually want a desktop app as well, as our tool is very compute-heavy and has more demanding performance needs than typical websites.

Our main consideration for Flutter was that we would be able to bend the platform to our will. We knew we would have a lot of visual operations that are not very common, and instead of building it from scratch using WebGL, Flutter gave us a way to access the lower-layer rendering engine so we can build it in our own way, using a framework that is well tested.

Despite some early struggles, we feel we made the right decision because of the flexibility that Flutter provided.

<DashImage figure src="images/10vWG-4VTlJkHX_9z0nGNWg.webp" alt="Supernova is not only built with Flutter but also exports Flutter code" caption="Supernova is not only built with Flutter but also exports Flutter code" />


### So it wasn’t always smooth sailing. Can you describe some of those struggles and what you learned along the way?

One of the very first technical challenges we encountered while working on our Flutter web app was with routing. When the Router API was released, we reworked our routing system to adopt it right away, which proved to be better for web apps. While it offered better integration into browser history, it was far too complicated for nested routing. So instead we made it possible to share state controllers (MobX stores in our case) between pages to simulate nested routing. This approach makes maintenance and implementation much simpler.

The main thing we learned is the importance of interoperability between Dart and JavaScript specifically for web apps. Using web-specific libraries has limitations if you are also targeting other platforms supported by Flutter, but if your main focus is web apps, it can save a tremendous amount of time. We learned that using JavaScript libraries and embedding HTML can compensate for plugins that lack web support. As an example, we use this approach for a code preview widget, which we embed as HTML and use with a JavaScript library for syntax highlighting. I would say that familiarity with JavaScript helps a great deal when building a Flutter web app, along with understanding the strengths and limitations of Dart/JavaScript interoperability and HTML embedding.

<DashImage figure src="images/1Zo9xfW_VtnLJmaTYq5ZJyg.webp" alt="Code preview widget built using Dart/JavaScript interoperability" caption="Code preview widget built using Dart/JavaScript interoperability" />


We also learned that tuning performance for web apps with Flutter is not very different to other platforms supported by Flutter. In most cases issues can be resolved in one of two ways:

1. Localizing widget rebuilds to the smallest possible part of the widget tree. Using MobX as our primary state management system means that rebuilds only affect necessary parts of the UI.

1. Using lists with on-demand child builders. We try to use `ListView` builders and slivers whenever possible so that we build only what is currently visible on the screen.

### Despite the struggles, were there specific technical challenges you experienced that Flutter helped you overcome?

Using the CanvasKit renderer through Flutter was a much more pleasant experience than writing shaders from scratch using WebGL. CanvasKit provided us with more higher level tools for rendering, letting us focus on nuances of converting Figma’s non-standard vector models to work with our Skia rendering engine.

<DashImage figure src="images/1J7beI4HVjgoaD4JHk-JUyw.webp" />


Developers often underestimate the challenges of font management. In our case, we have to support any font the designers might be using. Flutter helps a great deal here, thanks to the [google_fonts package](https://pub.dev/packages/google_fonts) that automatically downloads fonts directly from Google.

Lastly, Flutter also allows us to share the codebase that powers both the Supernova platform and a separate plugin we built to run in Figma. While there are completely different front ends, they share the same data model and logic.

### I’m curious, how did you find using Flutter on the web compared with more traditional frameworks?

In general, there are a lot of similarities. Concepts from Flutter, such as its reactive approach to UI, widgets, flexbox layout, and even state management, can be found in many modern web frameworks.

However, there are a few things that make Flutter different. Unlike other web frameworks, Flutter doesn’t rely on HTML or CSS to write UI components. Instead, you have to learn what widgets exist and how to compose them together to achieve the same UI as what you would’ve otherwise done with CSS. That said, Flutter comes with out-of-box support for Material, so if you’re comfortable with that look and feel, it gets you a long way.
> # I find the philosophy behind Dart quite different.

The other important difference is the language. While at its core, Dart is similar to JavaScript, I find the philosophy behind Dart quite different. After spending some time writing Dart, you can tell that it’s built for safety and predictability. Language features like sound null safety are uncommon in the world of JavaScript and JavaScript–compatible languages, and we found them crucial for making complex apps stable and maintainable. Another pleasant surprise for us was the annotation processing and code generation capabilities of Dart.

### Since you were early adopters, how do you feel Flutter’s web support has improved?

We have been using Flutter on the web ever since the first technical preview. Back then, the web target didn’t have support for navigation with browser history, performance was poor, lots of widgets and plugins were missing, and the tooling and debugger were just not there.

Now with the stable release, we’ve seen progress in all these areas and feel confident in our decision to use Flutter on the web. If you were to compare the technical preview to the Flutter 2.5 release, there are substantial improvements in performance, especially around rendering sophisticated layouts.

That said, there are still opportunities to improve! In particular, we’re looking forward to seeing better tooling for inspecting CanvasKit rendered widgets, since today’s browser tooling doesn’t support it.

### One last question, how can someone get started with Supernova?

With today’s launch, Supernova is now available to everyone! To get started, visit [supernova.io](https://www.supernova.io/) to register and provide a link to your Figma design file. Then, basically, the entire world is open to you from there. You can immediately start exporting code for Flutter (or any other framework) or get the assets for icons to start writing documentation.

<DashImage figure src="images/1mtTv0oMcbsbStL_T9RSsZw.webp" alt="Supernova’s component manager integrated with Figma" caption="Supernova’s component manager integrated with Figma" />


We’re so happy to see one of Flutter’s early adopters launch on the web. Be sure to check it out for yourself! And if you are building with Flutter on the web, please tell us about it. As ever, you can find us on Twitter as [@flutterdev](https://twitter.com/FlutterDev). We can’t wait to see what you’ve created!