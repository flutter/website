---
title: Annotations return local position relative to object
description: Provide mouse events with reliable and meaningful local positions.
---

## Summary

The local position returned in an annotation search is now
relative to the region that contains the annotation object
instead of the layer. This majorly affects mouse events
(`onEnter`, `onExit`, and `onHover`).

## Context

Annotations are metadata that are assigned during the
rendering phase to regions on the screen.
Searching the annotations with a location gives the
contextual information that contains that location.
They are used to detect mouse events and the theme of app bars.

When `localPosition` was first added to the search result,
it was defined as relative to the layer that owned the annotation,
which turned out to be a design mistake.
The offset from the layer is meaningless and unreliable.
For example, a `Transform` widget draws on the same layer
with an offset if the transform matrix is a simple translation,
or push a dedicated `TransformLayer` if the matrix is non-trivial.
The former case keeps the previous coordinate origin
(for example, the top left corner of the app),
while the latter case moves the position origin since
it's on a new layer, and the difference of them might
just be an unnoticeable scale of 99%.

Moreover, the major (if not only) users of
`AnnotatedRegionLayer` are render objects and widgets,
which define regions out of themselves and expect to
know the location relative to the region.
How the search is implemented under the hood using
a layer is unrelated, and should be transparent.

This change was also the first step of a longer plan to
move the annotations from the layer tree into an
independent tree ([Issue #49568][]).
As a result, the annotations no longer have access to
their position relative to any layers.

## Description of change

The `localPosition` returned by an `AnnotatedRegionLayer`
is now the local position it received subtracted by `offset`,
where `offset` is the location of the clipping area relative
to the layer.

```dart
class AnnotatedRegionLayer<T> extends ContainerLayer {
  @override
  bool findAnnotations<S>(AnnotationResult<S> result, Offset localPosition, { @required bool onlyFirst }) {
    ...
    if (/* shouldAddAnnotation */) {
      result.add(AnnotationEntry<S>(
        annotation: typedValue,
        // Used to be:
        // localPosition: localPosition,
        localPosition: localPosition - offset,
      ));
    }
    ...
  }
}
```

Conceptually, this has changed how `AnnotatedRegionLayer.offset`
and `size` are defined. They used to mean
"the clipping rectangle that restricts the annotation search",
while they now jointly represent
"the region of the annotation object".

## Migration guide

This change shouldn't affect most people.
The `MouseRegion` couldn't output a valid `localPosition`
at the time of the change,
and the only other use case in the Flutter framework was
by `SystemUiOverlayStyle`, which didn't
depend on the local position.

If anyone relied on this property,
they would have found it to be unreliable,
in which case this change is a fix.
In the case that someone actually wants the relative
location to the layer, a case-by-case analysis is
needed to figure out a migration plan.

## Timeline

This change was introduced in 1.15.2.

## References

API documentation:
* [`AnnotatedRegionLayer`][]
* [`AnnotationEntry`][]

Relevant issues:
* [Issue #49568][]

Relevant PRs:
* [Make Annotation's localPosition relative to object][]

[`AnnotatedRegionLayer`]: {{site.api}}/flutter/rendering/AnnotatedRegionLayer-class.html
[`AnnotationEntry`]: {{site.api}}/flutter/rendering/AnnotationEntry-class.html
[Issue #49568]: {{site.github}}/flutter/flutter/issues/49568
[Make Annotation's localPosition relative to object]: {{site.github}}/flutter/flutter/pull/50157
