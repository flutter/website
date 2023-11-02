---
title: Drag outside an app
description: How to drag from an app to another app or the operating system.
---

You will likely want to implement
drag and drop somewhere in your app.

You have a couple potential approaches
that you can take. One directly uses
Flutter widgets and the other uses a package
([super_drag_and_drop][]), available on pub.dev.

[super_drag_and_drop]: {{site.pub}}/packages/super_drag_and_drop

## Draggable and DragTarget

If you want to implement drag and drop within
your application, you can use the <code>Draggable</code>
widget. For insight into this approach, see
the [Drag a UI element within an app][] recipe.

An advantage of using <code>Draggable</code>
and <code>DragTarget</code> is that you can supply
Dart code to decide whether to accept a drop.

[Drag a UI element within an app]: {{site.url}}/cookbook/effects/drag-a-widget
[local data]: {{site.pub-api}}/super_drag_and_drop/latest/super_drag_and_drop/DragItem/localData.html

## super_drag_and_drop package

If you want to implement drag and drop within
your application and <i>also</i> between your
application and another (possibly non-Flutter) app,
check out the [super_drag_and_drop][] package.

To avoid implementing two styles of drag and drop,
you can supply [local data][] to the package to be
dragged within your app.

Another difference between this approach and
using <code>Draggable</code> directly,
is that you must tell the package up front
what data your app accepts because the platform
APIs need to be responded to synchronously,
which doesn't allow an asynchronous response
from the framework.

An advantage of using this approach is that it
works across desktop, mobile, <i>and</i> web.
