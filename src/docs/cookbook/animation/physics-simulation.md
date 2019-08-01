---
title: Animate a widget using a physics simulation
prev:
  title: Animate a page route transition
  path: /docs/cookbook/animation/page-route-animation
next:
  title: Animate the properties of a container
  path: /docs/cookbook/animation/animated-container
---

Physics simulations can make app interactions feel realistic and interactive.
For example, you might want to animate a widget to act as if it were attached to
a spring or falling with gravity.

This recipe demonstrates how to move a widget from a dragged point back to the
center using a spring simulation.

This recipe uses these steps:

1. Set up an animation controller
2. Move the widget using gestures
3. Animate the widget
4. Calculate the velocity to simulate a springing motion


## Step 1: Set up an animation controller

Start with a stateful widget called `DraggableCard`:

```dart
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(home: PhysicsCardDragDemo()));
}

class PhysicsCardDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DraggableCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;
  DraggableCard({this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Card(
        child: widget.child,
      ),
    );
  }
}
```

Make the `_DraggableCardState` class extend from
[SingleTickerProviderStateMixin][].  Then construct an [AnimationController][] in
`initState` and set `vsync` to `this`.

{{site.alert.note}}
  Extending `SingleTickerProviderStateMixin` allows the state object to be a
  `TickerProvider` for the `AnimationController`. For more information, see the
  documentation for [TickerProvider][].
{{site.alert.end}}

```dart
class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

```

## Step 2: Move the widget using gestures

Make the widget move when it's dragged, and add an [Alignment][] field to the
`_DraggableCardState` class:

```dart
Alignment _dragAlignment = Alignment.center;
```

Add a [GestureDetector][] that handles the `onPanDown`, `onPanUpdate`, and
`onPanEnd` callbacks. To adjust the alignment, use a [MediaQuery][] to get the
size of the widget, and divide by 2. (This converts units of "pixels dragged" to
coordinates that [Align][] uses.) Then, set the `Align` widget's `alignment` to
`_dragAlignment`:

```dart
@override
Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onPanDown: (details) {},
    onPanUpdate: (details) {
      setState(() {
        _dragAlignment += Alignment(
          details.delta.dx / (size.width / 2),
          details.delta.dy / (size.height / 2),
        );
      });
    },
    onPanEnd: (details) {},
    child: Align(
      child: Card(
        child: widget.child,
      ),
    ),
  );
}
```

## Step 3: Animate the widget

When the widget is released, it should spring back to the center.

Add an `Animation<Alignment>` field and an `_updateAnimation()` method. This
method defines a `Tween` that interpolates between the point the widget was
dragged to, to the point in the center.

```dart
Animation<Alignment> _animation;

void _updateAnimation() {
 _animation = _controller.drive(
   AlignmentTween(
     begin: _dragAlignment,
     end: Alignment.center,
   ),
 );
}
```

Call `_updateAnimation` in `initState`. This gives `_animation` an initial
value. Then update `_dragAlignment` when the `AnimationController` produces a
value:

```dart
@override
void initState() {
  _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
  _controller.addListener(() {
    setState(() {
      _dragAlignment = _animation.value;
    });
  });

  _updateAnimation();
  super.initState();
}

```

Next, make the `Align` widget use the `_dragAlignment` field:

```dart
child: Align(
  alignment: _dragAlignment,
  child: Card(
    child: widget.child,
  ),
),
```


Finally, update the `GestureDetector` to manage the animation controller:


```dart
onPanDown: (details) {
 _controller.stop();
},
onPanUpdate: (details) {
 setState(() {
   _dragAlignment += Alignment(
     details.delta.dx / (size.width / 2),
     details.delta.dy / (size.height / 2),
   );
 });
},
onPanEnd: (details) {
 _updateAnimation();
 _controller.reset();
 _controller.forward();
},
```

## Step 4: Calculate the velocity to simulate a springing motion

The last step is to do a little math, to calculate the velocity of the widget
after it's finished being dragged. This is so that the widget realistically
continues at that speed before being snapped back. (The `_updateAnimation()`
method already sets the direction  by setting the animation's start and end
alignment.)

The `onPanEnd` callback provides a [DragEndDetails][] object. This object
provides the velocity of the pointer when it stopped contacting the screen. The
velocity is in pixels per second, but the `Align` widget doesn't use pixels. It
uses coordinate values between [-1.0, -1.0] and [1.0, 1.0], where [0.0, 0.0]
represents the center. The `size` calculated in step 2 is used to convert pixels
to coordinate values in this range.

Finally, `AnimationController` has an `animateWith()` method that can be given a
[SpringSimulation][]:

```dart
onPanEnd: (details) {
  _updateAnimation();
  // Calculate the velocity relative to the unit interval, [0,1],
  // used by the animation controller.
  var pxPerSecond = details.velocity.pixelsPerSecond;
  var unitsPerSecondX = pxPerSecond.dx / size.width;
  var unitsPerSecondY = pxPerSecond.dy / size.height;
  var unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
  var unitVelocity = unitsPerSecond.distance;

  var spring = SpringDescription(
    mass: 30,
    stiffness: 1,
    damping: 1,
  );
  var simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

  _controller.animateWith(simulation);
},
```

{{site.alert.note}}
  Now that the animation controller uses a simulation it's `duration` argument
  is no longer required.
{{site.alert.end}}

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

main() {
  runApp(MaterialApp(home: PhysicsCardDragDemo()));
}

class PhysicsCardDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DraggableCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

/// A draggable card that moves back to [Alignment.center] when it's
/// released.
class DraggableCard extends StatefulWidget {
  final Widget child;
  DraggableCard({this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

/// Holds the state for the [DraggableCard] widget
class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  /// The position the user has dragged the card to. Represented as an
  /// [Alignment].
  Alignment _dragAlignment = Alignment.center;

  Animation<Alignment> _animation;

  /// Update the animation so that it runs from the dragged point back to the
  /// center.
  void _updateAnimation() {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
    _updateAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _updateAnimation();
        // Calculate the velocity relative to the unit interval, [0,1],
        // used by the animation controller.
        var pxPerSecond = details.velocity.pixelsPerSecond;
        var unitsPerSecondX = pxPerSecond.dx / size.width;
        var unitsPerSecondY = pxPerSecond.dy / size.height;
        var unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
        var unitVelocity = unitsPerSecond.distance;

        var spring = SpringDescription(
          mass: 30,
          stiffness: 1,
          damping: 1,
        );
        var simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

        _controller.animateWith(simulation);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}

```

![Demo showing a widget being dragged and snapped back to the center](/images/cookbook/animation-physics-card-drag.gif){:.site-mobile-screenshot}

[Align]: {{site.api}}/flutter/widgets/Align-class.html
[Alignment]: {{site.api}}/flutter/painting/Alignment-class.html
[AnimationController]: {{site.api}}/flutter/animation/AnimationController-class.html
[GestureDetector]: {{site.api}}/flutter/widgets/GestureDetector-class.html
[SingleTickerProviderStateMixin]: {{site.api}}/flutter/widgets/SingleTickerProviderStateMixin-mixin.html
[TickerProvider]: {{site.api}}/flutter/scheduler/TickerProvider-class.html
[MediaQuery]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[DragEndDetails]: {{site.api}}/flutter/gestures/DragEndDetails-class.html
[SpringSimulation]: {{site.api}}/flutter/physics/SpringSimulation-class.html