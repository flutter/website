---
title: How Flutter works
description: >-
  Dive deeper into how Flutter works through a six-part video series.
layout: tutorial
---

<Stepper level="2">

## Flutter's architecture {:#architecture}


<div class="video-wrapper">
  <YouTubeEmbed id="0Xn1QhNtPkQ" title="How Flutter Works" fullWidth />
</div>

Welcome to the first episode of "How Flutter Works,"
a six-part series designed to explore what happens to
your Dart code after you hand it off to the Flutter framework.
This episode takes a high-level look at Flutter's architecture,
covering declarative code, multi-platform frameworks, and
the role of Dart.
This video is perfect for anyone beginning to
research Flutter who wants to understand the big picture.

## Widgets and the three trees {:#three-trees}

<div class="video-wrapper">
  <YouTubeEmbed id="xiW3ahr4CRU" title="The three trees" fullWidth />
</div>

Dive into Flutter's architecture by exploring its
three primary trees: `Widget`, `Element`, and `RenderObject`.
Discover how widgets provide the declarative API for Flutter developers and
see how elements glue widgets to the rendering layer.
You'll also learn about the role of render objects in
translating widget values into painting calls.

## State objects and their lifecycle {:#state}

<div class="video-wrapper">
  <YouTubeEmbed id="FP737UMx7ss" title="The state class" fullWidth />
</div>

Episode 3 of "How Flutter Works" dives deep into the `State` class,
a critical piece behind every `StatefulWidget`.
Follow the full lifecycle of a `State` object—from `initState`,
where you initialize resources, to `dispose`, where you clean up.
Along the way, explore important methods including `didChangeDependencies`,
`didUpdateWidget`, and the all-important `build` method.
By the end of the episode, you'll understand how `State` objects
track, respond to, and manage changes in your Flutter apps—and
how the `State` lifecycle enables efficient UI updates.

This episode also peels back the curtain on how Flutter
recurses down the widget tree after a `setState` call,
building out only the parts of your app that need to change.
You'll learn why `const` constructors matter for performance,
why `setState` closures must be synchronous, and how
elements (not widgets themselves) manage the actual rebuild process.
If you're curious how Flutter keeps apps fast and responsive, or
you just want to really understand what happens behind the scenes,
this episode is packed with the essential foundations.

## The widgets that actually render {:#render-object-widgets}

<div class="video-wrapper">
  <YouTubeEmbed id="zcJlHVVM84I" title="The RenderObjectWidget" fullWidth />
</div>

Ever wonder how your Flutter app actually renders to the screen?
This video dives into `RenderObjectWidget`—the only type of
widget in Flutter that creates something visual.
While stateless and stateful widgets help structure your app,
it's render object widgets that turn your UI code into real pixels.

You'll learn how Flutter builds the
`Widget`, `Element`, and `RenderObject` trees,
why many common widgets don't directly render anything, and
how Flutter uses `RenderObjectWidget` to create and
update render objects that power your UI.

## A day in the life of a render object {:#render-objects}

<div class="video-wrapper">
  <YouTubeEmbed id="EuG12bebwac" title="A day in the life of a RenderObject" fullWidth />
</div>

In Episode 5 of "How Flutter Works," Craig walks through
a full day in the life of a `RenderObject`.
Building on the concepts from Episode 4,
this video explains the core responsibilities of render objects:
layout, painting, hit testing, and accessibility. Craig demystifies how
constraints flow down the render tree, how sizes come back up, and
how parent render objects set their children's positions.
He also breaks down key methods like
`layout`, `paint`, and `describeSemanticsConfiguration`,
showing how they fit together to keep your UI responsive and accurate.

## The Flutter engine and embedders {:#engine}

<div class="video-wrapper">
  <YouTubeEmbed id="Y2aBMjWVv2Y" title="The Flutter Engine and Embedders" fullWidth />
</div>

In Episode 6 of "How Flutter Works," Craig takes us
beneath the Dart code to explore the Flutter engine and embedders.
This episode explains how Flutter mobile apps rely on
native Android and iOS code to launch and operate,
how the Flutter engine connects your Dart code to the host platform, and
how embedders facilitate communication between the two.
Craig also highlights the structure of a newly generated Flutter project,
dives into how threads are managed in a Flutter app, and
explains the roles of platform channels and the [Pigeon][] package.

You'll also learn why the Flutter engine is
written in C++ rather than Dart,
how it evolved from a fork of Chrome, and
how it uses Skia or Impeller to render each frame.
The episode wraps up by looking ahead to
Flutter's future architecture improvements,
which aim to simplify native interop even further.
If you want a clear mental model of how Flutter apps work under the hood,
this is the perfect way to connect all the layers together.

[Pigeon]: {{site.pub-pkg}}/pigeon

</Stepper>
