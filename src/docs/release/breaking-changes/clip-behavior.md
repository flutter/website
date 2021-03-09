---
title: Clip Behavior
description: Flutter unifies clipBehavior and defaults to not clip in most cases.
---

## Summary

Flutter now defaults to _not_ clip except for a few specialized widgets
(such as `ClipRect`). To override the no-clip default,
explicitly set `clipBehavior` in widgets constructions.

## Context

Flutter used to be slow because of clips. For example,
the Flutter gallery app benchmark had an average frame
rasterization time of about 35ms in May 2018,
where the budget for smooth 60fps rendering is 16ms.
By removing unnecessary clips and their related operations,
we saw an almost 2x speedup from 35ms/frame to 17.5ms/frame.

{% comment %}
The following two images are not visible.
![](https://lh5.googleusercontent.com/Pn8FxuW2W3Cgvw9kIUvLLenrwXti7WRm_zPif3VJILa325d1Njm8aP47DXfK1r2Du-FwLKhI9umw5nMG6eNqn5fLnQBIt6VIPZ7Q2ETiCuXgQPD1cUYOeA-2Ph_DpvL27fK7m_Af)

Here’s a comparison of transition with and without clips.

![](https://lh5.googleusercontent.com/gSFKigrEoekji0juxTVjj29PlIizjuxJsetHsIegLt85zCHknRIUOeICjMdEBjBhPZDZXcEzFh1WCOrdmZa9KZ5vghgS7Uo9IDAKyBtEJ7h3tKfIHXf6A4vxrHfj1a_0kuT6f4r2)
{% endcomment %}

The biggest cost associated with clipping at that time is that Flutter
used to add a `saveLayer` call after each clip (unless it was a simple
axis-aligned rectangle clip) to avoid the bleeding edge artifacts
as described in [Issue 18057][]. Such behaviors were universal to
material apps through widgets like `Card`, `Chip`, `Button`, and so on,
which resulted in `PhysicalShape` and `PhysicalModel` clipping their content.


A `saveLayer` call is especially expensive in older devices because
it creates an offscreen render target, and a render target switch
can sometimes cost about 1ms.

Even without `saveLayer` call, a clip is still expensive
because it applies to all subsequent draws until it’s restored.
Therefore a single clip may slow down the performance on
hundreds of draw operations.

In addition to performance issues, Flutter also suffered from
some correctness issues as the clip was not managed and implemented
in a single place. In several places, `saveLayer` was inserted
in the wrong place and it therefore only increased the performance
cost without fixing any bleeding edge artifacts.

So, we unified the `clipBehavior` control and its implementation in
this breaking change. The default `clipBehavior` is `Clip.none`
for most widgets to save performance, except the following:

* `ClipPath` defaults to `Clip.antiAlias`
* `ClipRRect` defaults to `Clip.antiAlias`
* `ClipRect` defaults to `Clip.hardEdge`
* `Stack` defaults to `Clip.hardEdge`
* `EditableText` defaults to `Clip.hardEdge`
* `ListWheelScrollView` defaults to `Clip.hardEdge`
* `SingleChildScrollView` defaults to `Clip.hardEdge`
* `NestedScrollView` defaults to `Clip.hardEdge`
* `ShrinkWrappingViewport` defaults to `Clip.hardEdge`

## Migration guide

You have 4 choices for migrating your code:

1. Leave your code as is if your content does not need
   to be clipped (for example, none of the widgets’ children
   expand outside their parent’s boundary).
   This will likely have a positive impact on your app's
   overall performance.
2. Add `clipBehavior: Clip.hardEdge` if you need clipping,
   and clipping without anti-alias is good enough for your
   (and your clients’) eyes. This is the common case
   when you clip rectangles or shapes with very small curved areas
   (such as the corners of rounded rectangles).
3. Add `clipBehavior: Clip.antiAlias` if you need
   anti-aliased clipping. This gives you smoother edges
   at a slightly higher cost. This is the common case when
   dealing with circles and arcs.
4. Add `clip.antiAliasWithSaveLayer` if you want the exact
   same behavior as before (May 2018). Be aware that it’s
   very costly in performance. This is likely to be only
   rarely needed. One case where you might need this is if
   you have an image overlaid on a very different background color.
   In these cases, consider whether you can avoid overlapping
   multiple colors in one spot (for example, by having the
   background color only present where the image is absent).

For the `Stack` widget specifically, if you previously used
`overflow: Overflow.visible`, replace it with `clipBehavior: Clip.none`.

For the `ListWheelViewport` widget, if you previously specified
`clipToSize`, replace it with the corresponding `clipBehavior`:
`Clip.none` for `clipToSize = false` and
`Clip.hardEdge` for `clipToSize = true`.

Code before migration:

<!-- skip -->
```dart
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: const <Widget>[
              SizedBox(
                width: 100.0,
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
```

Code after migration:

<!-- skip -->
```dart
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: const <Widget>[
              SizedBox(
                width: 100.0,
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
```

## Timeline

Landed in version: _various_<br>
In stable release: 2.0.0

## References

API documentation:
* [`Clip`][]

Relevant issues:
* [Issue 13736][]
* [Issue 18057][]
* [Issue 21830][]

Relevant PRs:

* [PR 5420][]: Remove unnecessary saveLayer
* [PR 18576][]: Add Clip enum to Material and related widgets
* [PR 18616][]: Remove saveLayer after clip from dart
* [PR 5647][]: Add ClipMode to ClipPath/ClipRRect and PhysicalShape layers
* [PR 5670][]: Add anti-alias switch to canvas clip calls
* [PR 5853][]: Rename clip mode to clip behavior
* [PR 5868][]: Rename clip to clipBehavior in compositing.dart
* [PR 5973][]: Call drawPaint instead of drawPath if there's clip
* [PR 5952][]: Call drawPath without clip if possible
* [PR 20205][]: Set default clipBehavior to Clip.none and update tests
* [PR 20538][]: Expose clipBehavior to more Material Buttons
* [PR 20751][]: Add customBorder to InkWell so it can clip ShapeBorder
* [PR 20752][]: Set the default clip to Clip.none again
* [PR 21012][]: Add default-no-clip tests to more buttons
* [PR 21703][]: Default clipBehavior of ClipRect to hardEdge
* [PR 21826][]: Missing default hardEdge clip for ClipRectLayer

[PR 5420]:  {{site.github}}/flutter/engine/pull/5420
[PR 5647]:  {{site.github}}/flutter/engine/pull/5647
[PR 5670]:  {{site.github}}/flutter/engine/pull/5670
[PR 5853]:  {{site.github}}/flutter/engine/pull/5853
[PR 5868]:  {{site.github}}/flutter/engine/pull/5868
[PR 5952]:  {{site.github}}/flutter/engine/pull/5952
[PR 5973]:  {{site.github}}/flutter/engine/pull/5937
[PR 18576]: {{site.github}}/flutter/flutter/pull/18576
[PR 18616]: {{site.github}}/flutter/flutter/pull/18616
[PR 20205]: {{site.github}}/flutter/flutter/pull/20205
[PR 20538]: {{site.github}}/flutter/flutter/pull/20538
[PR 20751]: {{site.github}}/flutter/flutter/pull/20751
[PR 20752]: {{site.github}}/flutter/flutter/pull/20752
[PR 21012]: {{site.github}}/flutter/flutter/pull/21012
[PR 21703]: {{site.github}}/flutter/flutter/pull/21703
[PR 21826]: {{site.github}}/flutter/flutter/pull/21826

[`Clip`]: {{site.api}}/flutter/dart-ui/Clip-class.html
[Issue 13736]: {{site.github}}/flutter/flutter/issues/13736
[Issue 18057]: {{site.github}}/flutter/flutter/issues/18057
[Issue 21830]: {{site.github}}/flutter/flutter/issues/21830
[Issue 18057]: {{site.github}}/flutter/flutter/issues/18057
