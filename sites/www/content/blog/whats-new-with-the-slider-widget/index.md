---
title: "What’s new with the Slider widget?"
description: "Flutter lets you create beautiful, natively compiled applications. The reason Flutter can do this is because Flutter loves Material…"
publishDate: 2020-06-18
author: josealba
image: images/10vbyZT-NITTvqljO8HtU4w.webp
category: announcements
layout: blog
---

<DashImage figure src="images/10vbyZT-NITTvqljO8HtU4w.webp" />


Flutter lets you create beautiful, natively compiled applications. The reason Flutter can do this is because Flutter loves Material. [Material](https://material.io) is a design system that helps build high-quality, digital experiences. As UI design continues to evolve, Material continues to update its components, motion, and design system.

Flutter recently updated the [`Slider`](https://api.flutter.dev/flutter/material/Slider-class.html) and [`RangeSlider`](https://api.flutter.dev/flutter/material/RangeSlider-class.html) widgets to the latest the Material guidelines. The new sliders were designed with better accessibility in mind: The tracks are taller, the thumbs have shadows, and the value indicators have a new shape and improved text scaling support.

This article describes the changes to the `Slider` and `RangeSlider` widgets.

<DashImage figure src="images/0neQ_0e28CgjA00W_.webp" />


## What’s new?

`Slider` and `RangeSlider` were updated, to have a smoother experience when you work with these widgets. This diagram demonstrates the five different components that go into making the slider widgets.

<DashImage figure src="images/0elEXE_pM0iEDuv_t.webp" />


Both `Slider` and `RangeSlider` consist of five parts:

1. Value indicators that show labels for thumb values

1. A track that the thumbs slide across

1. Thumbs that indicate the position of the value

1. Overlays that display when the thumbs are pressed

1. Tick marks on the track when the slider is discrete

Note: This article refers to two different types of overlays:

* The `OverlaySlider` component represents the component mentioned in the preceding image.

* Flutter’s `Overlay` class is used to ‘float’ widgets over all the other widgets shown on the following screen.

## New default value indicator shape

The biggest visual difference between the old slider and the new slider widgets is the default value indicators: [`RectangularSliderValueIndicatorShape`](https://master-api.flutter.dev/flutter/material/RectangularSliderValueIndicatorShape-class.html) for `Slider` and [`RectangularRangeSliderValueIndicatorShape`](https://master-api.flutter.dev/flutter/material/RectangularRangeSliderValueIndicatorShape-class.html) for `RangeSlider`. The indicators reflect the latest design changes from Material. The old indicator shape was an upside-down pear, and the new shape is more rectangular and looks like a speech bubble. The value indicator was updated for both `Slider` and `RangeSlider`.

<DashImage figure src="images/0i3IWhVNFBB5OJEze.webp" />


## Value indicator paints on the overlay

The updated value indicator is now painted on the overlay. This means that the indicator is no longer restricted to the scope of the slider’s `MediaQuery` and can be displayed over other widgets. This is expected because the indicator is only activated when dealing with the gesture detector, which means that it’s only shown when the user interacts with the slider. By integrating the [`Overlay`](https://api.flutter.dev/flutter/widgets/Overlay-class.html) with the [`CompositedTransformTarget`](https://api.flutter.dev/flutter/widgets/CompositedTransformTarget-class.html), [`CompositedTransformFollower`](https://api.flutter.dev/flutter/widgets/CompositedTransformFollower-class.html), and [`Layerlink`](https://api.flutter.dev/flutter/rendering/LayerLink-class.html) widgets, the value indicator can display over other widgets. To learn more about this mechanism, see [How to float an overlay widget over a (possibly transformed) UI widget](https://medium.com/flutter/how-to-float-an-overlay-widget-over-a-possibly-transformed-ui-widget-1d15ca7667b6).

The following diagram shows how the `Slider` and `RangeSlider` widgets are made:

<DashImage figure src="images/0DEYZqsMMIdQWZ8mF.webp" />


You may notice that we use a separate `LeafRenderObjectWidget` to paint the indicators on the overlay. This is because we need to paint on both the `Overlay` class and the screen, which you can’t do from the same `LeafRenderObjectWidget` widget.

Because we’re now painting the value indicator on the overlay, it’s no longer restricted to the scope of the `MediaQuery` that contains the slider. The indicator is no longer clipped to that box, which means that the entire value indicator is displayed always.

<DashImage figure src="images/0HviG9DqaeW84PJi5.webp" />


Note: This example was made with the `textScaleFactor` set to 4 for better demonstration.

The value indicator rectangle is shifted so that part of the indicator doesn’t go off screen. This improvement allows you to increase the number of digits within the indicator and increase the text scale factor of your application without worrying if the text exceeds the screen size. In the following image, the value indicator text scale is 4 and contains a 3-digit value, but the slider handles it with no problem.

```
double getHorizontalShift({

  RenderBox parentBox,

  Offset center,

  TextPainter labelPainter,

  double textScaleFactor,

  Size sizeWithOverflow,

  double scale,

}) {

  assert(!sizeWithOverflow.isEmpty);

  const double edgePadding = 8.0;

  final double rectangleWidth = _upperRectangleWidth(labelPainter, scale, textScaleFactor);

  /// Value indicator draws on the overlay, and by using the global Offset,

  /// we are making sure that we use the bounds of the Overlay instead of the Slider.

  final Offset globalCenter = parentBox.localToGlobal(center);

  // The rectangle must be shifted toward the center so that it minimizes the

  // chance of it rendering outside the bounds of the render box. If the shift

  // is negative, then the lobe is shifted from right to left. If the shift is

  // positive, then the lobe is shifted from left to right.

  final double overflowLeft = math.max(0, rectangleWidth / 2 —     globalCenter.dx + edgePadding);

  final double overflowRight = math.max(0, rectangleWidth / 2 — (sizeWithOverflow.width — globalCenter.dx — edgePadding));

  if (rectangleWidth < sizeWithOverflow.width) {

    return overflowLeft — overflowRight;

  } else if (overflowLeft — overflowRight > 0) {

    return overflowLeft — (edgePadding * textScaleFactor);

  } else {

    return -overflowRight + (edgePadding * textScaleFactor);

  }

}
```


<DashImage figure src="images/0f7ar1ek7C7pUx5cF.webp" />


Note: This example was made with the `textScaleFactor` set to 4 for better demonstration.

## Activated value indicator takes precedence

The `RangeSlider` value indicator was also updated so that the currently active indicator takes precedence over the resting indicator. This means that if the indicators overlap, then the active indicator ‘floats’ over the other one.

<DashImage figure src="images/0dUrIA4k2wFu48rDe.webp" />


Note: This example was made with the `textScaleFactor` set to 4 for better demonstration.

## Old value indicator updated

We kept the `PaddleValueIndicator` widget, and updated it to have better scalability and accessibility. The `PaddleValueIndicator` widget is also printed on the `Overlay` like the `RectangularSliderValueIndicatorShape`. In the following example, you can see that both `Slider` and `RangeSlider` are using the old value indicator.

<iframe src="https://codepen.io/JoseAlba/embed/qBOXGYx" width="800" height="600" frameborder="0" allowfullscreen></iframe>


If you want to continue using the old value indicator, then just wrap your `Slider` widget with `SliderTheme`, and set the `valueIndicatorShape` property in `SliderThemeData` to `PaddleSliderValueIndicatorShape`. The process is identical for `RangeSlider`. Wrap your `RangeSlider` widget with `SliderTheme`, and set the `rangeValueIndicatorShape` property in `SliderThemeData` to `PaddleRangeSliderValueIndicatorShape`.

<DashImage figure src="images/0LNKN4lwqpBxQZ60A.webp" />


## The active track is bigger than the inactive track

The other component shapes in `Slider` were also updated. The track shape was changed so that the active part of the track is bigger than the inactive part of the track. This means that if your application uses a left-to-right language, then the left part of the track is bigger than the right. If your application uses a right-to-left language, then the right part of the track is bigger than the left. For `RangeSlider`, the active track is the portion of the track between the two thumbs.

<DashImage figure src="images/0q81pqrMZMWkCmRLF.webp" />


<DashImage figure src="images/0qIoICKw6wo7NcwOW.webp" />


## Tick mark component

The tick mark size and positioning changed. The tick marks are now part of the track component instead of extending the end of the track. There is also padding on the tick mark, so it appears within the track component. The size of the tick mark now has a radius of 1.

<DashImage figure src="images/0PLNNQjK0_zOXok1A.webp" />


## Thumb component has a shadow

When the thumb slider component is activated, there is now a `Shadow` that appears on the `Overlay`.

<DashImage figure src="images/0j7DxUmBmRK7Ztd5A.webp" />


## Closing remarks

You can try these changes by switching to Flutter version 1.18.0–9.0. This version is available only on the master branch during the release of this article. You can switch to the master branch by running `flutter channel master` and then `flutter upgrade`.

Learn more about the development of the `RangeSlider` in [Material RangeSlider in Flutter](https://medium.com/flutter/material-range-slider-in-flutter-a285c6e3447d).

*About the author: Jose recently graduated from university and now works on [Material](https://material.io/), a design system that helps teams build high-quality digital experiences. Jose’s team maintains the Flutter [material library](https://api.flutter.dev/flutter/material/material-library.html). To learn more, visit his Jose’s pages on [GitHub](https://github.com/JoseAlba), [LinkedIn](https://www.linkedin.com/in/josealba1996/), [YouTube](https://www.youtube.com/channel/UCOdKA_On0oPe1tz02z1QfxA?view_as=subscriber), and [Instagram](https://www.instagram.com/jose.alba/).*