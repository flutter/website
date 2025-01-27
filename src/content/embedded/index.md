---
title: Embedded support for Flutter
description: >
  Details of how Flutter supports the creation of embedded experiences.
---

If you would like to embed Flutter engine into a car,
a refrigerator, a thermostat... you CAN! For example,
you might embed Flutter in the following situations:

* Using Flutter on an "embedded device",
  typically a low-powered hardware device
  such as a smart-display, a thermostat, or similar.
* Embedding Flutter into a new operating system or
  environment, for example a new mobile platform
  or a new operating system.

The ability to embed Flutter, while stable,
uses low-level API and is _not_ for beginners. 
In addition to the resources listed below, you
might consider joining [Discord][], where Flutter
developers (including Google engineers) discuss
various aspects of Flutter. The Flutter
[community][] page has info on more community
resources.

* [Custom Flutter Engine Embedders][], on the Flutter wiki.
* The doc comments in the
  [Flutter engine `embedder.h` file][] on GitHub.
* The [Flutter architectural overview][] on docs.flutter.dev.
* A small, self-contained [Flutter Embedder Engine GLFW example][]
  in the Flutter engine GitHub repo.
* An exploration into [embedding Flutter in a terminal][] by
  implementing Flutter's custom embedder API.
* [Issue 31043][]: _Questions for porting flutter engine to
  a new os_ might also be helpful.


[community]: {{site.main-url}}/community
[Discord]: https://discord.com/invite/N7Yshp4
[Custom Flutter Engine Embedders]: {{site.repo.flutter}}/blob/main/engine/src/flutter/docs/Custom-Flutter-Engine-Embedders.md
[Flutter architectural overview]: /resources/architectural-overview
[Flutter engine `embedder.h` file]: {{site.repo.flutter}}/blob/main/engine/src/flutter/shell/platform/embedder/embedder.h
[Flutter Embedder Engine GLFW example]: {{site.repo.flutter}}/tree/main/engine/src/flutter/examples/glfw#flutter-embedder-engine-glfw-example
[embedding Flutter in a terminal]: https://github.com/jiahaog/flt
[Issue 31043]: {{site.repo.flutter}}/issues/31043


