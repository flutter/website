---
title: Clip Behavior
description: Flutter unifies clipBehavior and defaults to not clip in most cases.
---

## Summary

Flutter now defaults to not clip except for a few specialized widgets (e.g., ClipRect). To override the default no-clip, one shall explicitly set `clipBehavior` in widgets constructions.

## Context
Flutter used to be slow because of clips. For example, the Flutter gallery app benchmark has an average frame rasterization time of about 35ms back in May 2018 whereas the budget for smooth 60fps rendering is 16ms. By removing unnecessary clips and their related operations, we see almost 2x speedup from 35ms/frame to 17.5ms/frame.

![](https://lh5.googleusercontent.com/Pn8FxuW2W3Cgvw9kIUvLLenrwXti7WRm_zPif3VJILa325d1Njm8aP47DXfK1r2Du-FwLKhI9umw5nMG6eNqn5fLnQBIt6VIPZ7Q2ETiCuXgQPD1cUYOeA-2Ph_DpvL27fK7m_Af)


Here’s a comparison of transition with and without clips.

![](https://lh5.googleusercontent.com/gSFKigrEoekji0juxTVjj29PlIizjuxJsetHsIegLt85zCHknRIUOeICjMdEBjBhPZDZXcEzFh1WCOrdmZa9KZ5vghgS7Uo9IDAKyBtEJ7h3tKfIHXf6A4vxrHfj1a_0kuT6f4r2)

The biggest cost associated with clip at that time is that Flutter used to add a `saveLayer` after each clip (unless it’s a simple axis-aligned rectangle clip) to avoid the bleeding edge artifacts as described in [https://github.com/flutter/flutter/issues/18057](https://github.com/flutter/flutter/issues/18057). Such behaviors were universal to material apps through widgets like `Card`, `Chip`, `Button`, etc., which will result in `PhysicalShape` and `PhysicalModel` that clip their content.

A `saveLayer` is especially expensive in older devices because it creates an offscreen render target, and a render target switch can sometimes cost about 1ms.

Even without a `saveLayer`, a clip is still expensive because it applies to all subsequent draws until it’s restored. Thus a single clip may slow down the performance on hundreds of draw operations.

In addition to performance issues, Flutter also suffered from some correctness issues as the clip was not managed and implemented in a single place. In several places, the `saveLayer` was inserted to the wrong place and thus it only increased the performance cost without fixing any bleeding edge artifacts.

Therefore, we unified the `clipBehavior` control and its implementation in this breaking change. The default `clipBehavior` is `Clip.none` for most widgets to save performance except
-   `ClipPath` defaults to `Clip.antiAlias`
-   `ClipRRect` defaults to `Clip.antiAlias`
-   `ClipRect` defaults to `Clip.hardEdge`
-   `Stack` defaults to `Clip.hardEdge`
-   `EditableText` defaults to `Clip.hardEdge`
-   `ListWheelScrollView` defaults to `Clip.hardEdge`
-   `SingleChildScrollView` defaults to `Clip.hardEdge`
-   `NestedScrollView` defaults to `Clip.hardEdge`
-   `ShrinkWrappingViewport` defaults to `Clip.hardEdge`

## Migration guide

To migrate the code, you have 4 choices:

1.  Leave your code as is if your content does not need to be clipped (i.e., none of the widgets’ children expand outside their parent’s boundary). This will probably have a positive impact on your overall performance.
2.  Add `clipBehavior: Clip.hardEdge` if you need clipping, and clipping without anti-alias is good enough for your (and your clients’) eyes. This will be the common case when you clip rectangles or shapes with very small curved areas (such as the corners of rounded rectangles).
3.  Add `clipBehavior: Clip.antiAlias` if you need anti-aliased clipping. This will give you smoother edges at a slightly higher cost. This will be the common case when dealing with circles and arcs.
4.  Add `clip.antiAliasWithSaveLayer` if you want the exact same behavior as before (May 2018). Be aware that it’s very costly in performance. This will be only rarely needed. One case where you might need this is if you have an image overlaid on a very different background color. In these cases, consider whether you can avoid overlapping multiple colors in one spot (e.g. by having the background color only present where the image is absent).

For Stack widget specifically, if you previously used `overflow: Overflow.visible`, you shall replace it with `clipBehavior: Clip.none`.

For `ListWheelViewport` widget, if you previously specified `clipToSize`, replace it with the corresponding `clipBehavior`: `Clip.none` for `clipToSize = false` and `Clip.hardEdge` for `clipToSize = true`.

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

Not landed yet.

## References

{% include master-api.md %}

API documentation:
* [`Clip`][]

Relevant issues:
* [Issue 13736][]
* [Issue 18057][]
* [Issue 21830][]

Relevant PRs:
-   Remove unnecessary saveLayer #[5420](https://github.com/flutter/engine/pull/5420)
-   Add Clip enum to Material and related widgets #[18576](https://github.com/flutter/flutter/pull/18576)
-   Remove saveLayer after clip from dart #[18616](https://github.com/flutter/flutter/pull/18616)
-   Add ClipMode to ClipPath/ClipRRect and PhysicalShape layers #[5647](https://github.com/flutter/engine/pull/5647)
-   Add anti-alias switch to canvas clip calls #[5670](https://github.com/flutter/engine/pull/5670)
-   Rename clip mode to clip behavior #[5853](https://github.com/flutter/engine/pull/5853)
-   Rename clip to clipBehavior in compositing.dart #[5868](https://github.com/flutter/engine/pull/5868)
-   Call drawPaint instead of drawPath if there's clip #[5937](https://github.com/flutter/engine/pull/5937)
-   Call drawPath without clip if possible #[5952](https://github.com/flutter/engine/pull/5952)
-   Set default clipBehavior to Clip.none and update tests #[20205](https://github.com/flutter/flutter/pull/20205)
-   Expose clipBehavior to more Material Buttons #[20538](https://github.com/flutter/flutter/pull/20538)
-   Add customBorder to InkWell so it can clip ShapeBorder #[20751](https://github.com/flutter/flutter/pull/20751)
-   Set the default clip to Clip.none again. #[20752](https://github.com/flutter/flutter/pull/20752)
-   Add default-no-clip tests to more buttons #[21012](https://github.com/flutter/flutter/pull/21012)
-   Default clipBehavior of ClipRect to hardEdge. #[21703](https://github.com/flutter/flutter/pull/21703)
-   Missing default hardEdge clip for ClipRectLayer #[21826](https://github.com/flutter/flutter/pull/21826)

[`Clip`]: https://master-api.flutter.dev/flutter/dart-ui/Clip-class.html
[Issue 13736]: {{site.github}}/flutter/flutter/issues/13736
[Issue 18057]: {{site.github}}/flutter/flutter/issues/18057
[Issue 21830]: {{site.github}}/flutter/flutter/issues/21830