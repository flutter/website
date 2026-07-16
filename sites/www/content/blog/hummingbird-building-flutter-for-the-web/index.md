---
title: "Hummingbird: Building Flutter for the Web"
description: "At Flutter Live today, we announced that we are experimenting with running Flutter on the Web. In this post, we describe how we are…"
publishDate: 2018-12-04
author: yegorj
image: images/0gD64Y8ECWBBuSZrx.webp
category: engineering
layout: blog
---

At Flutter Live today, we announced that we are experimenting with running Flutter on the Web. In this post, we describe how we are approaching the challenge, and the current state of the technology. At the end of the post you will find answers to questions about interop and embedding.

<DashImage figure src="images/0gD64Y8ECWBBuSZrx.webp" />


Let’s begin with a quick refresher of Flutter’s architecture. Flutter is a multi-layered system, such that higher layers are easier to use and allow you to express a lot with little code, and the lower layers give you more control at the expense of having to deal with some complexity. When a higher layer does not do what a developer wants, they can drop to a lower layer. Developers have access to all the layers above the Flutter Engine.

<DashImage figure src="images/1pUNwEsIf3HKaarmNVRwP7Q.webp" alt="Flutter for Mobile Architecture" caption="Flutter for Mobile Architecture" />


Flutter Engine is exposed as the lowest-level library in Flutter, *dart:ui*. It knows nothing about widgets, physics, animation, or layout (except text layout). All it knows is how to compose [pictures](https://docs.flutter.io/flutter/dart-ui/Picture-class.html) onto the screen and turn them into pixels. It would be hard to write applications directly on top of dart:ui. This is why the higher layers were created.

Everything above dart:ui is what we like to call “the framework”. Everything below it is “the engine”. The framework is written entirely using the Dart programming language. Most of the engine is written in C++, with Android-specific parts written in Java, and iOS-specific parts written in Objective-C. Some basic classes and functions in dart:ui are written in Dart and mostly serve as bridges between Dart and C++.

Flutter also offers a plugin system. Plugins are code written in a language that has direct access to the OEM libraries and third-party libraries that the mobile ecosystems have accumulated over time. To create a plugin for Android you would write Java or Kotlin. An iOS plugin is written using Objective-C or Swift.

## Hello, The Web

The Web platform has been evolving for decades and includes numerous technologies and specifications. There are a few umbrella terms used to describe large collections of related features: HTML, CSS, SVG, JavaScript, WebGL. In order to run Flutter on the Web we need to:

* **Compile Dart code:** Flutter is written in Dart and we need to run Dart on the Web.

* **Choose a subset of Flutter to run on the Web**: it is not practical or useful to run all Flutter code on the Web. Some of it is platform specific, such as the Android and iOS bits.

* **Choose a sufficient subset of Web features**: over time the Web Platform accumulated features that overlap in functionality. For example, you can draw graphics using HTML+CSS, SVG, Canvas, and WebGL.

Dart has been compiling to JavaScript for as long as the language has existed. Many important applications compile from Dart to JavaScript and run in production today. Flutter’s compilation strategy relies on this same infrastructure.

When we began our exploration we were faced with several choices for UI rendering. We quickly realized that the specific Flutter layers we want to support dictate the Web technologies we would use for implementation. We built three **prototypes**:

1. **Just widgets**: This prototype implemented Flutter’s widget framework and offered a set of core layout widgets as a foundation for building custom widgets. For layout and positioning it relied on the Web’s built-in capabilities, such as flexbox, grid layout, browser scrolling via `overflow:scroll`, etc.

1. **Widgets + custom layout**: This prototype included Flutter’s layout system (provided by `RenderObject`), but mapped render objects directly to HTML elements.

1. **Flutter Web Engine**: This prototype retained all layers above dart:ui and provided a dart:ui implementation that runs in the browser.

One of the most valuable features of Flutter is that it is *portable* across platforms. While you can (and sometimes are encouraged to) write custom platform-specific code, the code that does not need to be different across platforms can be shared. This allows writing applications targeting multiple platforms with a single codebase.

After attempting to port several sample applications to the Web we realized that prototypes #1 and #2 would not provide the level of portability that Flutter developers have come to enjoy. We therefore decided to go with prototype #3, the Flutter Web Engine design, since this would allow the highest framework-level code reuse between platforms:

<DashImage figure src="images/1M0ik7rqmkK1Cf0xB4iwbxg.webp" alt="*Flutter for the Web Architecture (Hummingbird)*" caption="*Flutter for the Web Architecture (Hummingbird)*" />


Now that we know we want to implement the entire dart:ui API we need to pick a set of Web technologies to build on top of. Flutter renders UI one frame at a time. Within each frame Flutter ***builds*** widgets, performs ***layout***, and finally ***paints*** them on the screen.

## Building widgets

The widget building mechanism does not depend on the environment the app is running in. The process simply instantiates in-memory objects, tracks their state, and when the state changes computes the minimal updates necessary for the lower levels of the system, layout and painting. Porting this part to the Web was straight-forward. After the Dart team implemented super-mixin support in dart2js, the compiler compiled all of the widgets and the widget framework to JavaScript with almost no issues.

## Layout

The layout system is a little trickier. The biggest challenge was text layout. Everything else — Center, Row, Column, Stack, Scrollable, Padding, Wrap, and so on — is laid out by the framework and therefore compiles to the Web with no modifications.

In Flutter you lay out a paragraph of text by creating a [Paragraph](https://docs.flutter.io/flutter/dart-ui/Paragraph-class.html) object and calling its [layout()](https://docs.flutter.io/flutter/dart-ui/Paragraph/layout.html) method. Unfortunately, the Web lacks a direct text layout API. The trick we used to measure text’s layout properties was to cause the browser to lay it out, then read back the relevant properties from the DOM elements.

When laying out a paragraph of text Flutter measures the paragraph’s height, width, maximum intrinsic width, minimum intrinsic width, and alphabetic and ideographic baselines. These properties are illustrated below.

<DashImage figure src="images/1KpntaDMPfVygd3iTCUgI1A.webp" alt="*Paragraph layout attributes*" caption="*Paragraph layout attributes*" />


You can find more details in Flutter’s [Paragraph documentation](https://docs.flutter.io/flutter/dart-ui/Paragraph-class.html).

To measure these properties we first put a paragraph in an HTML DOM element, then we read the dimensions of the element. This causes the browser to lay it out. For example, to get the element’s width and height we call [offsetWidth](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetWidth) and its sibling, [offsetHeight](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetHeight). To measure the baseline we place the paragraph in an element configured to lay itself out using flex row. Next to the paragraph we place another element called “probe”. Because the probe is aligned with the text’s baseline calling [getBoundingClientRect](https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect) on it gives us the baseline. We use similar tricks to measure minimum and maximum intrinsic widths.

## Painting

Last but not least, we need to paint the widgets. This area has seen the most churn during our exploration, and it still is one of the most active areas of research for us. By the end of the frame all our widgets need to be turned into pixels on the screen. In the browser, this means they have to be boiled down to some combination of HTML/CSS, Canvas, SVG, and WebGL.

We have not looked at WebGL yet, mostly because it is low level and requires that we reimplement things that browsers can already do, such as text layout and rasterizing 2D graphics, but also because we have not yet figured out how accessibility, text selection, and composition with non-Flutter components can work with WebGL.

One of our early prototypes produced an HTML element for every RenderObject. We did get promising results, however that turned out to be too much of a breaking API change. We would have to maintain a massive code delta with Flutter, so we shelved the idea.

We are currently simultaneously exploring two approaches:

* HTML+CSS+Canvas

* CSS Paint API

### HTML+CSS+Canvas

With this approach we categorize pictures produced by the framework into those expressible using HTML+CSS, and those expressible using Canvas 2D. We then output HTML DOM that combines HTML, CSS, and 2D canvases.

We prefer HTML+CSS because it is backed by the browser’s [display list](https://en.wikipedia.org/wiki/Display_list). This means we can leave optimizing the rasterization of pictures to the browser’s rendering engine. This also means we can apply arbitrary transforms, particularly rotations and scaling, without worrying about pixelation. We call this canvas implementation *DomCanvas*.

If we are unable to express a picture using HTML+CSS, we fall back to canvas. Canvas 2D allows us to paint nearly all of Flutter drawing commands. If you compare Flutter’s [Canvas](https://docs.flutter.io/flutter/dart-ui/Canvas-class.html) to the Web’s [CanvasRenderingContext2D](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D) you find many similarities. Painting on the canvas is efficient because it does not create a mutable tree of nodes that needs to be maintained over time, like HTML DOM or SVG do.

One challenge with the 2D canvas is that browsers represent it as a bitmap, a buffer of memory that stores *Width* x *Height* pixels. As a result scaling a canvas results in pixelation. If scaling results in resizing the picture we need to resize the canvas. We found that allocating canvases is fairly expensive, and so is resizing them. On top of that, when compositing multiple canvases onto the same page the browser has to perform raster composition, which also shows up in our profiles. Compositing rasters works differently from display lists. You can paint multiple display lists onto the same memory buffer. We call Canvas 2D-backed canvas implementation *BitmapCanvas*. We are researching ways to make bitmap canvases more efficient.

To express Flutter’s opacity, transform, offset, clip rect, and other [layers](https://docs.flutter.io/flutter/rendering/Layer-class.html) we use plain HTML elements. For example, an opacity layer becomes an `<flt-opacity>` element with the `opacity` CSS attribute on it, a transform layer becomes an `<flt-transform>` element with the `transform` CSS attribute, and clip rect becomes an `<flt-clip-rect>` with `overflow: hidden`.

When all is said and done, a frame is rendered onto the page as a tree of HTML elements with DomCanvas and BitmapCanvas as leaf nodes. For example:

<DashImage figure src="images/1srIZflrlT4IhxER1nnOtJw.webp" alt="*Sample HTML DOM structure of a frame*" caption="*Sample HTML DOM structure of a frame*" />


An equivalent Flutter layer tree (called [*flow layer*](https://github.com/flutter/engine/tree/master/flow/layers)) in the Flutter Engine would look like this:

<DashImage figure src="images/1yjnmm_UQ6wrQD5AssXxqLg.webp" alt="*Sample Flutter Engine layer structure*" caption="*Sample Flutter Engine layer structure*" />


Structurally they are very similar. The biggest difference is that on the Web we have to pick different implementations for pictures based on their contents.

HTML+CSS+Canvas works in all modern browsers. However, we are already looking into the future:

### CSS Paint API

[CSS Paint](https://developers.google.com/web/updates/2018/01/paintapi) is a new Web API and part of a bigger effort, [Houdini](https://developers.google.com/web/updates/2016/05/houdini). Houdini is a collaboration between many browser vendors to expose certain parts of the CSS engine to developers. In particular, the CSS Paint API allows developers paint custom graphics into HTML elements when those elements request painting. For example, you may assign the painting of an element’s `background` to a custom CSS painter. It is very similar to canvas but with the following important differences:

* The painting is not done by the main JavaScript isolate, but by something called a *paint worklet*. It is a bit like a web worker in that it has its own memory space. A paint worklet executes during the browser’s paint phase, after the DOM changes are committed.

* CSS paint is backed by a display list, not a bitmap. This gives us the best of both worlds — the 2D canvas-like painting efficiency *and* no pixelation.

* Currently CSS paint does not support painting text.

As of this writing, Chrome and Opera are the only browsers to support CSS Paint in production. However, other browsers [are in various stages of shipping](https://ishoudinireadyyet.com/) their implementations.

We have experimental support for the CSS Paint API in Flutter for Web and it shows good results already, particularly in performance. Our implementation simply serializes paint commands into a custom CSS property. The paint worklet reads those commands and executes them. We render text using the normal `<p>` and `<span>` HTML elements.

Our current serialization mechanism isn’t particularly efficient — it’s a tree of nested lists converted to JSON — but part of the Houdini project is to add support for [typed array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays). When it becomes available we will encode paint commands as typed arrays instead of JSON strings. Typed arrays are [transferable](https://developer.mozilla.org/en-US/docs/Web/API/Transferable), which means they can be passed from the main isolate to the paint worklet by reference. No copying of memory involved.

## Interop and embedding

### Calling Dart libraries from Flutter

Flutter web apps have full access to all existing Dart libraries that run on the Web today.

### Calling JavaScript libraries from Flutter

Flutter web apps fully support Dart’s JS-interop packages: `package:js` and `dart:js`.

### Using CSS in Flutter web apps

Currently Flutter assumes full control over the web page for correctness and performance. For example, we only use a small subset of CSS that follows certain performance guidelines, such as [https://csstriggers.com/](https://csstriggers.com/). Putting arbitrary CSS on the page may cause Flutter behave unpredictably.

Another reason to avoid CSS in a Flutter for Web app is because, by design, Flutter needs to know all the layout properties as it renders the frame. CSS acts as a blackbox. For example, if you want to display a scrollable list of widgets you have to instantiate and generate HTML for all of them and apply the necessary CSS properties (e.g. flex-direction row and overflow: scroll). Then the browser lays everything out and renders it to screen. Application code does not participate in the layout process.

Finally, in the spirit of keeping Flutter code portable across platforms, we avoid CSS so we can run the same code natively on Android and iOS.

### Embedding Flutter in existing web-apps

We have not yet added proper support for this, but we intend to explore it in the future. A couple of approaches we are considering are `<iframe>` and shadow DOM.

### Embedding non-Flutter components in Flutter

We have not yet added support for embedding non-Flutter components — Custom Elements, React components, Angular components — in a Flutter web app, but we intend to explore this in the future. One possible avenue is to use the [platform view](https://master-docs-flutter-io.firebaseapp.com/flutter/dart-ui/SceneBuilder/addPlatformView.html) for dropping foreign content into a Flutter web app. One important aspect to consider is what kind of effect foreign content may have on the performance and correctness of apps. Because non-Flutter components are likely to contain arbitrary CSS in them, as mentioned above, it can be problematic. More research is required.

## Portability

Our goal is to make as much of the framework portable to the Web as possible. However, that does not mean that an arbitrary Flutter app will run on the Web with no code changes. A Flutter web app is still a web app; it is sandboxed in the browser and can only do what the web browser allows. For example, if your Flutter app uses a native plugin that does not have a Web implementation, such as ARCore, you won’t be able to run the app on the Web. Similarly, there is no direct access to the file system or low-level network.

## Current status

We built enough of the Web Engine to render most of the Flutter Gallery. We have not ported Cupertino widgets, but all of the Material widgets, Material Theming, as well as the Shrine and Contact Profile demo apps run on the Web.

<YoutubeEmbed id="5IrPi2Eo-xM" title="hummingbird screen recording" fullwidth="true"/>


## Where is the source code?

We plan to open source this project soon, and are excited about sharing it with the open source community. This project started as an exploration inside Google’s internal source tree. We intend to move development to GitHub as soon as our code stabilizes and we’ve had a chance to disentangle it from our internal infrastructure. In the meantime, do not be surprised if you see Web-related pull requests under the github.com/flutter organization!

## Conclusion

I hope this post gives you an idea of the challenges we are solving to make Flutter run well on the Web. We welcome your thoughts and ideas.

Stay tuned for Google I/O 2019!