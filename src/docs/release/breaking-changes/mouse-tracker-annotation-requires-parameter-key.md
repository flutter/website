---
title: MouseTrackerAnnotation requires parameter "key"
description: MouseTrackerAnnotation now requires a new parameter "key", and several methods of MouseTracker are changed to take this key as the argument.
---

# MouseTrackerAnnotation requires parameter "key"


## Context

Mouse events, such as when a mouse pointer has entered a region, exited, or
is hovering a region, are detected with the help of
`MouseTrackerAnnotation`s that are placed on interested regions during the
render phase. Upon each update (a new frame or a new event), `MouseTracker`
compares the annotations hovered by the mouse pointer before and after the
update, then dispatches callbacks accordingly. `MouseTracker` also tracks
which annotations are on the screen by requring the annotation's owners to
attach or detach the annotation promptly.

`MouseTracker` used to compare annotations based on identity, i.e. by
checking if the _exact_ annotation is hovered before and after the update.
Since the `MouseTrackerAnnotation` is a constant class, this means you
couldn't change an annotation's properties without replacing the annotation
as a whole, which would trigger the exit and enter callback.

This issue blocked the support for mouse cursor, since it’s very likely that
the cursor assigned to a region needs to be changed.

In order to fix this issue, we had to introduce this breaking change, which
added a key to `MouseTrackerAnnotation`, allowing the `MouseTracker` to
compare based on this key.

## Description of change

The `MouseTrackerAnnotation` class now has a new property `LocalKey key`,
which is a required parameter in the constructor:

```diff
 class MouseTrackerAnnotation extends Diagnosticable {
   const MouseTrackerAnnotation({
     this.onEnter,
     this.onHover,
     this.onExit,
-  });
+    @required this.key,
+  }) : assert(key != null);

+  final LocalKey key;

   ...
 }
```

Three of `MouseTracker`'s methods, `attachAnnotation`, `detachAnnotation`,
and `isAnnotationAttached`, which used to take a single parameter
`MouseTrackerAnnotation annotation`, will now take a single parameter
`LocalKey annotationKey`:

```diff
 class MouseTracker extends ChangeNotifier {
   ...

   @visibleForTesting
-  bool isAnnotationAttached(MouseTrackerAnnotation annotation);
+  bool isAnnotationAttached(LocalKey annotationKey);

-  void attachAnnotation(MouseTrackerAnnotation annotation);
+  void attachAnnotation(LocalKey annotationKey);

-  void detachAnnotation(MouseTrackerAnnotation annotation);
+  void detachAnnotation(LocalKey annotationKey);
 }
```

## Migration guide

There are 2 ways of migrating affected code. The first way requires less
work to migrate existing code, while the second is simpler to implement when the
annotation's properties might change.

### The straightforward way
The most straightforward way is by providing
`MouseTrackerAnnotation`'s constructor with `key: UniqueKey()`, which is
sufficient because the annotation only needs to be equal to itself, since the
annotation was not designed to be mutable. Then change the calls to the
affected methods to using the annotation's key. For example:

```diff
 class MyRenderObject extends RenderObject {
   final MouseHoverAnnotation _hoverAnnotation = MouseTrackerAnnotation(
+    key: UniqueKey(),
     onEnter: _handleEnter,
     onExit: _handleExit,
   );

   @override
   void attach(PipelineOwner owner) {
     super.attach(owner);
-    RendererBinding.instance.mouseTracker.attachAnnotation(_hoverAnnotation);
+    RendererBinding.instance.mouseTracker.attachAnnotation(_hoverAnnotation.key);
   }

   @override
   void detach() {
-    RendererBinding.instance.mouseTracker.detachAnnotation(_hoverAnnotation);
+    RendererBinding.instance.mouseTracker.detachAnnotation(_hoverAnnotation.key);
     super.detach();
   }

   @override
   void paint(PaintingContext context, Offset offset) {
     final Layer layer = AnnotatedRegionLayer<MouseTrackerAnnotation>(
       _hoverAnnotation,
       size: size,
       offset: offset,
       opaque: opaque,
     );
     context.pushLayer(layer, super.paint, offset);
   }
 }
```

### The key-based way

Another way is to think that the annotation is now completely based on the
key: store the key instead of the annotation, and generate the annotation on
the fly. For example,

```diff
 class MyRenderObject extends RenderObject {
-  final MouseHoverAnnotation _hoverAnnotation = MouseTrackerAnnotation(
-    onEnter: _handleEnter,
-    onExit: _handleExit,
-  );
+  final LocalKey _hoverAnnotationKey = UniqueKey();

   @override
   void attach(PipelineOwner owner) {
     super.attach(owner);
-    RendererBinding.instance.mouseTracker.attachAnnotation(_hoverAnnotation);
+    RendererBinding.instance.mouseTracker.attachAnnotation(_hoverAnnotationKey);
   }

   @override
   void detach() {
-    RendererBinding.instance.mouseTracker.detachAnnotation(_hoverAnnotation);
+    RendererBinding.instance.mouseTracker.detachAnnotation(_hoverAnnotationKey);
     super.detach();
   }

   @override
   void paint(PaintingContext context, Offset offset) {
     final Layer layer = AnnotatedRegionLayer<MouseTrackerAnnotation>(
-      _hoverAnnotation,
+      MouseTrackerAnnotation(
+        onEnter: _handleEnter,
+        onExit: _handleExit,
+        key: _annotationKey,
+      ),
       size: size,
       offset: offset,
       opaque: opaque,
     );
     context.pushLayer(layer, super.paint, offset);
   }
 }
```

## Timeline

This change was made at v1.13.6.

The API related to `MouseTrackerAnnotation` was not stable at the time of
writing, since a large change was in plan. It's recommended to refer to
later migration guides for up-to-date information.

## References

API documentation:
* [MouseTracker class](https://api.flutter.dev/flutter/gestures/MouseTracker-class.html)
* [MouseTrackerAnnotation class](https://api.flutter.dev/flutter/gestures/MouseTrackerAnnotation-class.html)

Relevant issues:
* [Add the ability to programmatically change pointer cursors](https://github.com/flutter/flutter/issues/31952)

Relevant PRs:
* [Add key to mouse annotations](https://github.com/flutter/flutter/pull/46034)
