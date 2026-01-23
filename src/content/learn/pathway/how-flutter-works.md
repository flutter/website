---
title: How Flutter Works
breadcrumb: How Flutter Works
description: This pages walks you through the quick install process for Flutter.
layout: tutorial
---

<Stepper level="2">

## Flutter's architecture

<YouTubeEmbed id="0Xn1QhNtPkQ" title="How Flutter Works" fullWidth />

<br> Welcome to the first episode of "How Flutter Works," a six-part
series designed to explore what happens to your Dart code after you
release it into Flutter. In this episode, we're taking a high-level
look at Flutter's architecture. Learn about declarative code,
multi-platform frameworks, and the role of Dart in Flutter's
architecture. This video is perfect for those beginning to research
Flutter and who want to understand the big picture.

## The three trees

<YouTubeEmbed id="xiW3ahr4CRU" title="The three trees" fullWidth />

<br> Dive into Flutter's architecture by exploring its three primary
trees: Widget, Element, and RenderObject. Discover how widgets provide
the declarative API for Flutter developers and see how Elements glue
widgets to the rendering layer. Follow along as we also cover the role
of RenderObjects in translating widget values into painting calls.


## The state class

<YouTubeEmbed id="FP737UMx7ss" title="The state class" fullWidth />

<br> In Episode 3 of How Flutter Works, we dive deep into the State
class, a critical piece behind every StatefulWidget. We walk through
the full life cycle of a State object—from initState, where you
initialize resources, to dispose, where you clean up. Along the way,
we explore important methods like didChangeDependencies (triggered by
inherited widgets like MediaQuery), didUpdateWidget (for reacting to
ancestor-driven changes), and the all-important build method. By the
end of the episode, you'll understand how State objects track, respond
to, and manage changes in your Flutter apps—and how the State life
cycle enables efficient UI updates.

We also peel back the curtain on how Flutter recurses down the widget
tree after a setState call, building out only the parts of your app
that need to change. You'll learn why const constructors matter for
performance, why setState closures must be synchronous, and how
Elements (not Widgets themselves) manage the actual rebuild process.
If you're curious how Flutter keeps apps fast and responsive, or you
just want to really understand what happens behind the scenes, this
episode is packed with the essential foundations.


## The RenderObjectWidget

<YouTubeEmbed id="zcJlHVVM84I" title="The RenderObjectWidget" fullWidth />

<br> Ever wonder how your Flutter app actually renders to the screen?
In this video, we dive into RenderObjectWidgets—the only type of
widget in Flutter that creates something visual. While
StatelessWidgets and StatefulWidgets help structure your app, it’s
RenderObjectWidgets that turn your UI code into real pixels.

You'll learn how Flutter builds the Widget, Element, and RenderObject
trees, why many common widgets don’t directly render anything, and how
RenderObjectWidgets create and update RenderObjects that power your
UI.

## The RenderObject

<YouTubeEmbed id="EuG12bebwac" title="The RenderObject" fullWidth />

<br> In Episode 5 of "How Flutter Works," Craig walks through a full
day in the life of a RenderObject. Building on the concepts from
Episode 4, this video explains the core responsibilities of
RenderObjects: layout, painting, hit testing, and accessibility. Craig
demystifies how constraints flow down the render tree, how sizes come
back up, and how parent RenderObjects set their children's positions.
He also breaks down key methods like layout, paint, and
describeSemanticsConfiguration, showing how they fit together to keep
your UI responsive and accurate.


## The Flutter Engine and Embedders

<YouTubeEmbed id="Y2aBMjWVv2Y" title="The Flutter Engine and Embedders" fullWidth />

<br> In Episode 6 of "How Flutter Works," Craig takes us beneath the
Dart code to explore the Flutter engine and embedders. This episode
explains how Flutter mobile apps rely on native Android and iOS code
to launch and operate, how the Flutter engine connects your Dart code
to the host platform, and how embedders facilitate communication
between the two. Craig also highlights the structure of a newly
generated Flutter project, dives into how threads are managed in a
Flutter app, and explains the roles of PlatformChannels and the Pigeon
package. 

You’ll also learn why the Flutter engine is written in C++ rather than
Dart, how it evolved from a fork of Chrome, and how it uses Skia or
Impeller to render each frame. The episode wraps up by looking ahead
to Flutter's future architecture improvements, which aim to simplify
native interop even further. If you want a clear mental model of how
Flutter apps work under the hood, this is the perfect way to connect
all the layers together.

</Stepper>
