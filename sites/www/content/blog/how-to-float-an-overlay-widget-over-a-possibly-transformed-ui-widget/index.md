---
title: "How to float an overlay widget over a (possibly transformed) UI widget"
description: "Say you have a widget in your app’s UI and you want to overlay a floating widget on top of that widget. Maybe that widget is rotated or…"
publishDate: 2020-03-02
author: josealba
image: images/0FB5HpEeEvZ6NjJXl.webp
category: tutorial
layout: blog
---

*About the author: Jose recently graduated from university and now works on [Material](https://material.io), a design system that helps teams build high-quality digital experiences. Jose’s team maintains the Flutter [material library](https://api.flutter.dev/flutter/material/material-library.html).*

Say you have a widget in your app’s UI and you want to overlay a floating widget on top of that widget. Maybe that widget is rotated or has other transforms applied. How do you convey the position and transform information of the UI widget to the corresponding widget in the overlay?

You can do this using the CompositedTransformTarget, CompositedTransformWidget, LayerLink, Overlay, and OverlayEntry widgets.

In Flutter, the overlay lets you print visual elements on top of other widgets by inserting them into the overlay’s stack. You insert a widget into the overlay using an OverlayEntry and you use Positioned and AnimatedPositioned to choose where the entry is positioned within the overlay. This is useful when you need an item to appear on top of another widget (similar to the Stack widget) but you can use this widget anywhere without having to modify your entire codebase.

As described in this [article](https://medium.com/saugo360/https-medium-com-saugo360-flutter-using-overlay-to-display-floating-widgets-2e6d0e8decb9), a programmer needs to implement an autosuggestion feature to a text field widget to an existing page. They could implement this feature using a stack but, as mentioned in the article, this approach can be: intrusive, rigorous, error-prone, and just feels wrong. Instead of redesigning your whole screen into a stack, you can use the overlay widget to add this effect. This scenario can happen any time a developer has to implement a new feature on an existing route.

Using an Overlay might seem intuitive but can be challenging to implement in Flutter. The overlay entry must be inserted using a callback method. Plus you need to keep a reference to the overlay entry since you remove the entry using the reference and not the context of the overlay. Also, if you need the overlay entry’s position and transformation to be dependent on another widget that is *not* in the overlay, it can get confusing. This is because the context of the overlay’s MediaQuery is different from the regular context. You may have seen this when using padding or margin in a Widget before making a call to the Overlay. Luckily, Flutter already takes care of these details for you.

If an overlay entry needs to follow a ‘target’ that is not on the overlay stack you can use CompositedTransformTarget, CompositedTransformFollower, and LayerLink to “glue” the widgets together To do this you need to:

* Wrap the widget on the overlay with a CompositedTransformFollower.

* The follower has to be a descendant of CompositedTransformTarget.

* The target Widget must be wrapped with a CompositedTransformTarget.

* A LayerLink instance glues the follower and target together.

In the following GIF, the blue container is not on the overlay but the green container is. The blue container is a child of CompositedTransformTarget and the green container is the child of CompostedTransformFollower. They are linked together using the same LayerLink instance. Note how the green overlay widget is aware of the bounds of the blue UI widget, even though the blue widget is not in the overlay:

<DashImage figure src="images/178wqXwvzHdc-vJ9lxtazkQ.webp" />

Try it yourself using this [DartPad](https://dartpad.dev/8fd3ae34c3e5f1932dc687208be6f434) instance. The example code is as follows:

Code by Hans Muller

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Slide()));
}

class Indicator extends StatelessWidget {
  Indicator({ Key key, this.link, this.offset }) : super(key: key);

  final LayerLink link;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      offset: offset,
      link: link,
      child: Container(
        color: Colors.green,
      ),
    );
  }
}

class Slide extends StatefulWidget {
  Slide({ Key key }) : super(key: key);

  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  final double indicatorWidth = 24.0;
  final double indicatorHeight = 300.0;
  final double slideHeight = 200.0;
  final double slideWidth = 400.0;

  final LayerLink layerLink = LayerLink();
  OverlayEntry overlayEntry;
  Offset indicatorOffset;

  Offset getIndicatorOffset(Offset dragOffset) {
    final double x = (dragOffset.dx - (indicatorWidth / 2.0)).clamp(0.0, slideWidth - indicatorWidth);
    final double y = (slideHeight - indicatorHeight) / 2.0;
    return Offset(x, y);
  }

  void showIndicator(DragStartDetails details) {
    indicatorOffset = getIndicatorOffset(details.localPosition);
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: 0.0,
          left: 0.0,
          child: SizedBox(
            width: indicatorWidth,
            height: indicatorHeight,
            child: Indicator(
                offset: indicatorOffset,
                link: layerLink
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(overlayEntry);
  }

  void updateIndicator(DragUpdateDetails details) {
    indicatorOffset = getIndicatorOffset(details.localPosition);
    overlayEntry.markNeedsBuild();
  }

  void hideIndicator(DragEndDetails details) {
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overlay Indicator')),
      body: Center(
        child: CompositedTransformTarget(
          link: layerLink,
          child: Container(
            width: slideWidth,
            height: slideHeight,
            color: Colors.blue.withOpacity(0.2),
            child: GestureDetector(
              onPanStart: showIndicator,
              onPanUpdate: updateIndicator,
              onPanEnd: hideIndicator,
            ),
          ),
        ),
      ),
    );
  }
}

```

This example shows how to use these widgets together. To see the true power of these widgets, apply a Transformation to the CompositedTransformTarget. You will notice that the green overlay widget is also impacted by this transformation, thanks to their shared LayerLink widget.

In the following GIF, the blue container is not on the overlay but the green container is. This time the CompositedTransformTarget has been rotated. As you can see, even though the CompositeTransformFollower is on the overlay stack, it still knows where the target is and any transformations that have been applied to it.

<DashImage figure src="images/0FB5HpEeEvZ6NjJXl.webp" />

Try it yourself using this [DartPad](https://dartpad.dev/58e5e12bb29370bbca75f19e2685387a) instance. The example code is as follows:

Code by Hans Muller

```dart
import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Slide()));
}

class Indicator extends StatelessWidget {
  Indicator({ Key key, this.link, this.offset }) : super(key: key);

  final LayerLink link;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      offset: offset,
      link: link,
      child: Container(
        color: Colors.green,
      ),
    );
  }
}

class Slide extends StatefulWidget {
  Slide({ Key key }) : super(key: key);

  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  final double indicatorWidth = 24.0;
  final double indicatorHeight = 300.0;
  final double slideHeight = 200.0;
  final double slideWidth = 400.0;

  final LayerLink layerLink = LayerLink();
  OverlayEntry overlayEntry;
  Offset indicatorOffset;

  Offset getIndicatorOffset(Offset dragOffset) {
    final double x = (dragOffset.dx - (indicatorWidth / 2.0)).clamp(0.0, slideWidth - indicatorWidth);
    final double y = (slideHeight - indicatorHeight) / 2.0;
    return Offset(x, y);
  }

  void showIndicator(DragStartDetails details) {
    indicatorOffset = getIndicatorOffset(details.localPosition);
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: 0.0,
          left: 0.0,
          child: SizedBox(
            width: indicatorWidth,
            height: indicatorHeight,
            child: Indicator(
                offset: indicatorOffset,
                link: layerLink
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(overlayEntry);
  }

  void updateIndicator(DragUpdateDetails details) {
    indicatorOffset = getIndicatorOffset(details.localPosition);
    overlayEntry.markNeedsBuild();
  }

  void hideIndicator(DragEndDetails details) {
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overlay Indicator')),
      body: Transform.rotate(
        angle: -math.pi / 12.0,
        child: Center(
          child: CompositedTransformTarget(
            link: layerLink,
            child: Container(
              width: slideWidth,
              height: slideHeight,
              color: Colors.blue.withOpacity(0.2),
              child: GestureDetector(
                onPanStart: showIndicator,
                onPanUpdate: updateIndicator,
                onPanEnd: hideIndicator,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```

## Conclusion

When implementing a UI that floats widgets on top of other widgets, using the overlay and linking the widgets together is a straightforward and powerful approach. In this article, you learned how to use a LayerLink to glue these widgets together. Now go forth and create your beautiful UI!

*To learn more about Jose, visit his pages on [GitHub](https://github.com/JoseAlba), [LinkedIn](https://www.linkedin.com/in/josealba1996/), [YouTube](https://www.youtube.com/channel/UCOdKA_On0oPe1tz02z1QfxA?view_as=subscriber), and [Instagram](https://www.instagram.com/jose.alba/).*
