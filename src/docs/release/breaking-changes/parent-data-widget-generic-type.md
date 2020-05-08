---
title: The generic type of ParentDataWidget changed to ParentData
description: The ParentDataWidget is now bound to the ParentData type.
---

## Summary

The generic type of `ParentDataWidget` has changed from
`RenderObjectWidget` to `ParentData`.

## Context

Prior to this change, a `ParentDataWidget` was bound
to a specific `RenderObjectWidget` type as ancestor.
For example, a `Positioned` widget could only be used
within a `Stack` widget. With this change,
a `ParentDataWidget` can be used with any
`RenderObjectWidget` type as ancestor as long as
the `RenderObject` of said `RenderObjectWidget`
sets up the correct `ParentData` type. In this new world,
the `Positioned` widget can be reused with a hypothetical
new `SuperStack` widget.

## Description of change

The generic type argument of `ParentDataWidget`
has changed from `RenderObjectWidget` to `ParentData`,
and a new debug property, `debugTypicalAncestorWidgetClass`,
is added to `ParentDataWidget`.
The latter is used for error messages to give users a
better idea of the context a given `ParentDataWidget`
is supposed to be used in.

## Migration guide

You must migrate your code as described in this section
if you're subclassing or implementing `ParentDataWidget`.
If you do, the analyzer shows the following warnings when you
upgrade to the Flutter version that includes this change:

```none
  error • Missing concrete implementation of 'getter ParentDataWidget.debugTypicalAncestorWidgetClass' • lib/main.dart:114:7 • non_abstract_class_inherits_abstract_member
  error • 'FrogJar' doesn't extend 'ParentData' • lib/main.dart:114:41 • type_argument_not_matching_bounds
```

Code before migration:

<!-- skip -->
```dart
class FrogSize extends ParentDataWidget<FrogJar> {
  FrogSize({
    Key key,
    @required this.size,
    @required Widget child,
  }) : assert(child != null),
        assert(size != null),
        super(key: key, child: child);

  final Size size;

  @override
  void applyParentData(RenderObject renderObject) {
    final FrogJarParentData parentData = renderObject.parentData;
    if (parentData.size != size) {
      parentData.size = size;
      final RenderFrogJar targetParent = renderObject.parent;
      targetParent.markNeedsLayout();
    }
  }
}

class FrogJarParentData extends ParentData {
  Size size;
}

class FrogJar extends RenderObjectWidget {
  // ...
}
```

Code after migration:

<!-- skip -->
```dart
class FrogSize extends ParentDataWidget<FrogJarParentData> { // FrogJar changed to FrogJarParentData
  FrogSize({
    Key key,
    @required this.size,
    @required Widget child,
  }) : assert(child != null),
        assert(size != null),
        super(key: key, child: child);

  final Size size;

  @override
  void applyParentData(RenderObject renderObject) {
    final FrogJarParentData parentData = renderObject.parentData;
    if (parentData.size != size) {
      parentData.size = size;
      final RenderFrogJar targetParent = renderObject.parent;
      targetParent.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => FrogJar; // Newly added
}
```

The generic type of the `ParentDataWidget` superclass
changes from `FrogJar` (a `RenderObjectWidget`) to
`FrogJarParentData` (the `ParentData` type that
`FrogSize.applyParentData` wants to operate on).
Additionally, the new `debugTypicalAncestorWidgetClass`
is implemented for this `ParentDataWidget` subclass.
It returns the type of a typical ancestor `RenderObjectWidget`
for this `ParentDataWidget`. Most of the time,
you just want to return the old generic type here
(`FrogJar` in this example).

## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

## References

API documentation:
* [`ParentDataWidget`][]

Relevant PR:
* [Make ParentDataWidget usable with different ancestor RenderObjectWidget types][]


[Make ParentDataWidget usable with different ancestor RenderObjectWidget types]: {{site.github}}/flutter/flutter/pull/48541
[`ParentDataWidget`]: {{site.api}}/flutter/widgets/ParentDataWidget-class.html
