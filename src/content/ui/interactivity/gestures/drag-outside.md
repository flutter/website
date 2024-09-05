---
title: Drag outside an app
description: How to drag from an app to another app or the operating system.
---

You might want to implement
drag and drop somewhere in your app.

You have a couple potential approaches
that you can take. One directly uses
Flutter widgets and the other uses a package
([super_drag_and_drop][]), available on [pub.dev][].

[pub.dev]: {{site.pub}}
[super_drag_and_drop]: {{site.pub-pkg}}/super_drag_and_drop

## Create draggable widgets within your app

If you want to implement drag and drop within
your application, you can use the [`Draggable`][]
widget. For insight into this approach, see
the [Drag a UI element within an app][] recipe.

An advantage of using `Draggable` and `DragTarget` is
that you can supply Dart code to decide whether to accept a drop.

For more information, check out the
[`Draggable` widget of the week][video] video.

[Drag a UI element within an app]: /cookbook/effects/drag-a-widget
[`Draggable`]:  {{site.api}}/flutter/widgets/Draggable-class.html
[`DragTarget`]: {{site.api}}/flutter/widgets/DragTarget-class.html
[local data]: {{site.pub-api}}/super_drag_and_drop/latest/super_drag_and_drop/DragItem/localData.html
[video]: https://youtu.be/q4x2G_9-Mu0?si=T4679e90U2yrloCs

## Implement drag and drop between apps

If you want to implement drag and drop within
your application and _also_ between your
application and another (possibly non-Flutter) app,
check out the [super_drag_and_drop][] package.

To avoid implementing two styles of drag and drop,
one for drags outside of the app and another for
dragging inside the app,
you can supply [local data][] to the package to
perform drags within your app.

Another difference between this approach and
using `Draggable` directly,
is that you must tell the package up front
what data your app accepts because the platform
APIs need a synchronous response, which doesn't
allow an asynchronous response from the framework.

An advantage of using this approach is that it
works across desktop, mobile, _and_ web.
