---
title: "Announcing Adobe XD support for Flutter"
description: >-
  Create in XD and export to working Flutter code
publishDate: 2020-05-13
author: timsneath
image: images/0N-K68XqE0DBUV0EK.webp
category: announcement
layout: blog
---

Our goal with Flutter is to provide a rich canvas for creative expression. With native performance on iOS and Android, full control over every pixel rendered on the screen, and the ability to iterate rapidly with stateful hot reload, we want to unleash the potential of designers and developers to build beautiful experiences that aren’t limited by artificial technical boundaries.

Last year at our [Flutter Interact event](https://www.youtube.com/watch?v=HjZxyTJzvYg&feature=emb_logo), we turned the spotlight on creators who are using Flutter to explore and experiment. We heard from digital artists like [Robert Felker](https://www.youtube.com/watch?v=DEppSs_ko48), who uses Flutter to build ethereal forms with generative algorithms. We presented [the work of creative agencies like gskinner](https://flutter.gskinner.com/), who created a series of innovative vignettes to demonstrate the potential of Flutter. And we saw a demonstration from Adobe of an [early prototype of a plugin for Adobe XD](https://www.youtube.com/watch?v=ukLBCRBlIkk&feature=youtu.be&t=3652) that exports Flutter code directly from their tool.

<DashImage figure src="images/0llO5f0NhDCAp5Y7j.webp" alt="Flutter is a rich canvas for creative expression: a toolkit for beautiful, native experiences that aren’t limited by traditional technical boundaries. (Generative artwork built with Flutter, courtesy of Robert Felker.)" caption="Flutter is a rich canvas for creative expression: a toolkit for beautiful, native experiences that aren’t limited by traditional technical boundaries. (Generative artwork built with Flutter, courtesy of Robert Felker.)" />

Today, **we’re delighted to join Adobe in announcing that their XD to Flutter plugin is [now available as early access](https://adobe.com/go/xd_plugins_discover_plugin?pluginId=6eaf77ea)** for broader public testing. [Adobe XD](https://www.adobe.com/products/xd.html) is a UI/UX design and collaboration tool that helps teams create and share designs for websites, apps, voice interfaces, games, and more. Part of Adobe’s class-leading [Creative Cloud](https://www.adobe.com/creativecloud.html), XD allows designers to turn vector art, text, images, microinteractions, and animations into interactive prototypes that behave like working software products. The ability to export designs to Flutter further reduces the latency between creative ideas and product development, as an XD prototype can now become working Flutter code within minutes. Adobe XD supports design on Windows or macOS, and includes a [free starter plan](https://www.adobe.com/products/xd/compare-plans.html) to get you up and running.

<DashImage figure src="images/0Vjx2GfxTsr8Imvew.webp" alt="Exporting from Adobe XD to Flutter is now just a plugin away." caption="Exporting from Adobe XD to Flutter is now just a plugin away." />

## Exporting Flutter code from Adobe XD

Using the Flutter plugin in XD is straightforward. You can either export an individual drawing or component, or an artboard. Here’s how.

Start by installing the [Flutter exporter plugin](https://adobe.com/go/xd_plugins_discover_plugin?pluginId=6eaf77ea). From Adobe XD, choose *Plugins > Discover Plugins*, and search for Flutter. Once you’ve installed it, you can display the UI Panel shown in the screenshot above by choosing *Plugins > Flutter > UI Panel*.

Now add the [adobe_xd](https://pub.dev/packages/adobe_xd) package to your Flutter project by including it in your `pubspec.yaml` app manifest. This package provides helper functions to minimize boilerplate in the generated XD code.

To export a single element, simply select the individual widget you’d like to export to Flutter, and choose the *Copy Selected* button from the UI panel. This copies the relevant Dart code to your clipboard, which you can use as the basis for a stateless or stateful widget:

<DashImage figure src="images/0ADItKKHZGWwawDHa.webp" alt="Exported code can be integrated into your existing project and updated without reworking other files." caption="Exported code can be integrated into your existing project and updated without reworking other files." />

Another approach is to export the entire project. Assuming you’ve already got a Flutter app that you want to load the content into (including the `adobe_xd` package reference in `pubspec.yaml`), you can simply choose *Plugins > Flutter > Export All Widgets* from the UI panel, and set any additional configuration options you want.

This creates a series of classes in the `lib/` subdirectory of your project, which you can then use directly. You can continue to tweak the XD prototype and export again with ⇧⌘F (Ctrl+Shift+F on Windows) and, if you have enabled the Dart [*Hot Reload on Save Watcher* setting](https://dartcode.org/docs/settings/#dartpreviewhotreloadonsavewatcher) in Visual Studio Code, your app automatically reloads with any updates when you re-export the widgets.

<DashImage figure src="images/0N-K68XqE0DBUV0EK.webp" alt="Having a fast turnaround from XD to code gives you a new way to turn prototypes into apps." caption="Having a fast turnaround from XD to code gives you a new way to turn prototypes into apps." />

As an early access preview, there are of course some limitations, which are described in the [release notes](https://github.com/AdobeXD/xd-to-flutter-plugin/blob/master/README.md). One notable limitation is that responsive layout is not yet available, pending completion of a new XD API. But you’ll automatically get updates to the plugin as new features like this become available.

It’s been great working with Adobe on this. We’re thrilled to have them supporting Flutter, and the [new JavaScript-based APIs](https://adobexdplatform.com/plugin-docs/) make extending Adobe XD easy for everyone. Here’s what they have to say about this new plugin:
> *“At Adobe, we’re always looking to simplify the designer-to-developer workflow that pains so many teams designing and building apps. Today, we’re excited to release an early access preview of the work that’s come out of our partnership with Flutter to remove guesswork, accelerate decision making, and help teams bring new experiences to market faster.”*
> - Vijay Vachani, Senior Director of Creative Cloud Platform & Ecosystem, Adobe

For more information, visit [Adobe’s page for the XD to Flutter plugin](https://github.com/AdobeXD/xd-to-flutter-plugin). We’re looking forward to seeing what you create with it!
