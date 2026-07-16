---
title: "Material Range Slider in Flutter"
description: "What is it? Why might you use it? How do you theme it?"
publishDate: 2019-07-11
author: clocksmith
image: images/0wtmSldtwjSvtRtuI.webp
category: tutorial
layout: blog
---

## Material RangeSlider in Flutter

The range slider, a highly customizable component for selecting a range of values, has been released in Flutter 1.7. This article explains what a range slider is, why you might use it, and how you can use Material Theming to customize the behavior and appearance of the Flutter `RangeSlider`.e
> Note: To learn about updates to the `Slider` and `RangeSlider` widgets, see [What’s new with the Slider widget?](https://medium.com/flutter/whats-new-with-the-slider-widget-ce48a22611a3)

### Why Range Slider?

A slider component can offer a single selection or multiple selections on either a discrete or continuous track. Unlike single selection sliders that predetermine either a minimum or maximum value with the ability to adjust the selection in one direction, range sliders have two selection points that allow for a flexible adjustment of minimum and maximum value points. This flexibility makes it a useful component for instances when a user prefers to control a specific range, such as indicating price points or a length of time.

<DashImage figure src="images/0Mu435B7sBkJHMuY4.webp" />


### Structure & Implementation

<DashImage figure src="images/0wtmSldtwjSvtRtuI.webp" />


The `RangeSlider` consists of 5 parts:

1. A track that the thumbs slide across.

1. Tick marks on the track when the `RangeSlider` is discrete.

1. 2 thumbs (or knobs) that indicate the min and max value of the range.

1. Value indicators that show the labels for the thumb values when labels are defined and `showValueIndicator` matches the type of slider.

1. Overlays that display on the thumbs when they are pressed.

We needed the `RangeSlider` to have rich animations. This includes the interaction-driven animations for the positions of the thumb, as well as the built-in animations for the overlay and value indicators. In Flutter, we do this by making the `RangeSlider` component a `StatefulWidget`, which stores the animation controllers as state.

The actual range slider values are stored as state in the parent widget. The values are updated by calling `setState()` within the `RangeSlider`’s `onChange()` callback. In other words, in order to have an interactive range slider, the `RangeSlider` widget itself must be created within a `StatefulWidget`.

```dart
RangeValues _values = RangeValues(0.3, 0.7);

RangeSlider(
  values: _values,
  onChanged: (RangeValues values) {
    setState(() {
      _values = values;
    });
  },
);
```

<DashImage figure src="images/0B0bu8hC9PtI5xXBL.webp" />


The `RangeSlider`’s `State` object builds a `LeafRenderObjectWidget`. Everything is painted in its inner `RenderBox`, which also handles touch input.

### Handling Touch Input

If you are curious about how `RangeSlider` implements touch input, read on! One interesting aspect of `RangeSlider` is that it’s one of the only out-of-the-box Flutter widgets that uses a `GestureArenaTeam`. The next section covers how to customize touch input.

If you have no interest in peeking under the hood, feel free to skip this section.

To ensure that `RangeSlider` can handle both taps and drags while functioning properly within scroll views, tab bar views, and other widgets that handle gestures, a `GestureArenaTeam` is used. A `GestureArenaTeam` allows for a gesture within a group of gestures to be properly chosen by “winning.”

First, the drag recognizer is added to the team, followed by the tap recognizer. There is no team captain, so the drag recognizer wins, since it was the first recognizer added to the team, as soon as any other recognizers are out of the arena. On the other hand, if the tap can win outright, such as when the slider is within a vertically scrolling list and the user taps then immediately lifts, then the tap recognizer wins.

The drag and tap events resolve to 1 of 3 possible interactions:

* Drag `onStart` or Tap `onTapDown` →`_startInteraction`

* Drag `onUpdate` →`_handleDragUpdate`

* Drag `onEnd` or `onCancel` and Tap `onEnd` or `onCancel` → `_endInteraction`

At the start of interaction, one of the very first things that must be determined is which thumb should be selected for movement. The `RangeSlider` does this by using a themable function that takes in properties like the tap value and drag displacement, and returns a thumb choice: `Thumb.start`, `Thumb.end`, or `null` for no selection.

The default thumb selector first attempts to find the closest thumb in `_startInteraction`. If a thumb is selected, then the thumb’s position is immediately updated to the tap value. But if the tap value is between the thumbs, but not in either touch target, there is no selection. Also, if the thumbs are close enough together, and the tap is in both touch targets, no thumb is selected. In this case, a thumb is only selected once there is a non-zero movement (drag displacement). Then the left thumb is selected for negative movement, and the right thumb is selected for positive movement. This is the only scenario where the interaction actually begins in the first `_handleDragUpdate` step. In either case, a special callback, `onChangeStart()`, emits the start values of this interaction.

When the thumbs are further apart, touching the inner track does not select a thumb:

<DashImage figure src="images/0mlCfCFNzbUsT6P5l.webp" />


When the thumbs are closer together, the drag displacement is used to determine the thumb selection:

<DashImage figure src="images/0vcWwbYKPKh0Q-Cbc.webp" />


Implementation of the default thumb selector with the behavior described above:

```dart
 static final RangeThumbSelector _defaultRangeThumbSelector = (
      TextDirection textDirection,
      RangeValues values,
      double tapValue,
      Size thumbSize,
      Size trackSize,
      double dx, // drag displacement
    ) {
    final double touchRadius = math.max(thumbSize.width, RangeSlider._minTouchTargetWidth) / 2;

    final bool inStartTouchTarget = (tapValue - values.start).abs() * trackSize.width < touchRadius;

    final bool inEndTouchTarget = (tapValue - values.end).abs() * trackSize.width < touchRadius;


    if (inStartTouchTarget && inEndTouchTarget) {
      bool towardsStart;
      bool towardsEnd;
      switch (textDirection) {
        case TextDirection.ltr:
          towardsStart = dx < 0;
          towardsEnd = dx > 0;
          break;
        case TextDirection.rtl:
          towardsStart = dx > 0;
          towardsEnd = dx < 0;
          break;
      }
      if (towardsStart)
        return Thumb.start;
      if (towardsEnd)
        return Thumb.end;
    } else {
      if (tapValue < values.start || inStartTouchTarget)
        return Thumb.start;
      if (tapValue > values.end || inEndTouchTarget)
        return Thumb.end;
    }
    return null;
  };
```

After a thumb is selected, all future drag updates are used to determine the new positions of the thumb. The overlay animation starts on the selected thumb, and the value indicator animations start on both thumbs. As the user drags the selected thumb, the range slider emits a new set of values with the updated position, and the values are then passed back to the range slider to update its corresponding position.

The last step is `_endInteraction`. Once the tap or drag gesture is lifted, the overlay and value indicator animations that were started in the first step are reversed. A special callback, `onChangeEnd()`, also emits the end values.

### Custom Touch Input Selection

In the previous section, you saw the code for Material’s default thumb selection behavior. **But what if you wanted something different?** The following code shows how to write a thumb selector that always selects the closest thumb, regardless of what part of the track is touched.

<DashImage figure src="images/0HLlGFubMmDajfdYU.webp" />


Implementation of a custom thumb selector that always finds the closest thumb:

```dart
 static final RangeThumbSelector _customRangeThumbSelector = (
    TextDirection textDirection,
    RangeValues values,
    double tapValue,
    Size thumbSize,
    Size trackSize,
    double dx,
  ) {
    final double start = (tapValue - values.start).abs();
    final double end = (tapValue - values.end).abs();
    return start < end ? Thumb.start : Thumb.end;
  };
```

Once you have this custom thumb, you can set it in the global app theme:

```dart
theme: ThemeData(
  sliderTheme: SliderThemeData(
    thumbSelector: _customRangeThumbSelector,
  ),
  // ...
),
```

Or it can be set on a specific slider instance using the SliderTheme:

```dart
SliderTheme(
  data: SliderThemeData(
    thumbSelector: _customRangeThumbSelector,
    // ...
  ),
  child: RangeSlider(
    // ...
  ),
),
```

### Controlling Allowed Thumb Positions

Above, you saw how to use the SliderThemeData to customize how the thumbs are selected. This section shows how to limit the positions that the thumbs can be dragged, or set, to. There are 2 ways to control the allowed positions of thumbs. It can be done by **value**, or it can be done by **space.** By value can be useful, for example, if you have a price selector. Let’s say the allowed prices can be within $0 and $100, but you want the range to be at least $20 apart. So the range [$30, $50] would be allowed but the range [$33, $34] would not be allowed. Simply adjust the onChanged function as follows:

<DashImage figure src="images/0tqIVrQZCHKLeLZCV.webp" />


```dart
RangeSlider(
  values: _values,
  min: 0,
  max: 100,
  onChanged: (RangeValues values) {
    setState(() {
      if (values.end - values.start >= 20) {
        _values = values;
      } else {
        if (_values.start == values.start) {
          _values = RangeValues(_values.start, _values.start + 20);
        } else {
          _values = RangeValues(_values.end - 20, _values.end);
        }
      }
    });
  }
);

```

If it is only necessary to restrict the thumbs for the sake of appearances, then the minThumbSeparation property can be used to limit the number of logical pixels that separate the 2 thumbs. The default top thumb will draw a white outline around itself for better contrast between the thumbs. Here is a side by side comparison showing the default value of 8 vs a custom value of 24

<DashImage figure src="images/0kChVA0QLDWygcEn0.webp" />


### Painting Shapes

In addition to handling touch input, the `RenderBox` is also responsible for painting the `RangeSlider`. It paints the `RangeSlider`’s components in this order:

1. Track

1. Overlays

1. Tick Marks (if discrete)

1. Value Indicators (if visible)

1. Thumbs

This can be important to know when painting custom shapes. All shape implementations are abstracted away from the `RenderBox.paint()` method through 5 separate abstract classes, which makes the painting or rendering of the `RangeSlider` fully customizable and themable since the classes exist on the `SliderThemeData` object.

In the next section, we will show how to override the default shapes with custom shapes.

### Using Custom Shapes

Just like the single Slider, all of the shapes that make up a slider can be customized for the RangeSlider. See [this clip](https://www.youtube.com/watch?v=YSULAJf6R6M&t=410s) for an example of how a Material Slider was customized.

This is done by passing custom implementations of the abstract shape classes into the SliderThemeData. This takes advantage of the RangeSliderThumbShape class to provide custom thumbs that have different appearances depending on what side they are on.

The custom range thumb shape can be implemented as follows:

```dart
class _CustomRangeThumbShape extends RangeSliderThumbShape {
  static const double _thumbSize = 4.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => _thumbSize;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    @required Animation<double> activationAnimation,
    @required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop,
    @required SliderThemeData sliderTheme,
    TextDirection textDirection,
    Thumb thumb,
  }) {
    final Canvas canvas = context.canvas;

    Path thumbPath;
    switch (textDirection) {
      case TextDirection.rtl:
        switch (thumb) {
          case Thumb.start:
            thumbPath = _rightTriangle(_thumbSize, center);
            break;
          case Thumb.end:
            thumbPath = _leftTriangle(_thumbSize, center);
            break;
        }
        break;
      case TextDirection.ltr:
        switch (thumb) {
          case Thumb.start:
            thumbPath = _leftTriangle(_thumbSize, center);
            break;
          case Thumb.end:
            thumbPath = _rightTriangle(_thumbSize, center);
            break;
        }
        break;
    }
    canvas.drawPath(thumbPath, Paint()..color = sliderTheme.thumbColor);
  }
}

Path _rightTriangle(double size, Offset thumbCenter, {bool invert = false}) {
  final Path thumbPath = Path();
  final double halfSize = size / 2.0;
  final double sign = invert ? -1.0 : 1.0;
  thumbPath.moveTo(thumbCenter.dx + halfSize * sign, thumbCenter.dy);
  thumbPath.lineTo(thumbCenter.dx - halfSize * sign, thumbCenter.dy - size);
  thumbPath.lineTo(thumbCenter.dx - halfSize * sign, thumbCenter.dy + size);
  thumbPath.close();
  return thumbPath;
}

Path _leftTriangle(double size, Offset thumbCenter) => _rightTriangle(size, thumbCenter, invert: true);
```

Then the custom range thumb shape can be set on a `SliderThemeData`:

```dart
SliderTheme(
  data: SliderThemeData(
    rangeThumbShape: _CustomRangeThumbShape(),
    // ...
  ),
  child: RangeSlider(
    // ...
  ),
),
```

<DashImage figure src="images/0w97BioIrNzfHqQ43.webp" />


### Closing Remarks

The Material range slider is a component that was requested by the community. It works out-of-the-box, and is also customizable to suit the needs of your app. The behavior and visual appearance can be changed in the theme at the global level, or on an instance by instance basis.

The complete code for all code included in this article, along with more examples, can be found in the [Material gallery on github](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery/lib/demo/material) and in the [Material library on github](https://github.com/flutter/flutter/tree/master/packages/flutter/lib/src/material).

Special thanks to Shams Zakhour, Liam Spradlin, Barbara Eldredge, Cortney Cassidy, and Will Larche.
