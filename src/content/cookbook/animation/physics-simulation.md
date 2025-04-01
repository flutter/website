---
title: Animate a widget using a physics simulation
description: How to implement a physics animation.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/animation/physics_simulation/"?>

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

<?code-excerpt "lib/starter.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: PhysicsCardDragDemo()));
}

class PhysicsCardDragDemo extends StatelessWidget {
  const PhysicsCardDragDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const DraggableCard(child: FlutterLogo(size: 128)),
    );
  }
}

class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, super.key});

  final Widget child;

  @override
  State<DraggableCard> createState() => _DraggableCardState();
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
    return Align(child: Card(child: widget.child));
  }
}
```

Make the `_DraggableCardState` class extend from
[SingleTickerProviderStateMixin][].
Then construct an [AnimationController][] in
`initState` and set `vsync` to `this`.

:::note
Extending `SingleTickerProviderStateMixin` allows the state object to be a
`TickerProvider` for the `AnimationController`. For more information, see the
documentation for [TickerProvider][].
:::

```dart diff
- class _DraggableCardState extends State<DraggableCard> {
+ class _DraggableCardState extends State<DraggableCard>
+     with SingleTickerProviderStateMixin {
+   late AnimationController _controller;
+
    @override
    void initState() {
      super.initState();
+     _controller =
+         AnimationController(vsync: this, duration: const Duration(seconds: 1));
    }

    @override
    void dispose() {
+     _controller.dispose();
      super.dispose();
    }
```

## Step 2: Move the widget using gestures

Make the widget move when it's dragged, and add an [Alignment][] field to the
`_DraggableCardState` class:

```dart diff
  class _DraggableCardState extends State<DraggableCard>
      with SingleTickerProviderStateMixin {
    late AnimationController _controller;
+   Alignment _dragAlignment = Alignment.center;
```

Add a [GestureDetector][] that handles the `onPanDown`, `onPanUpdate`, and
`onPanEnd` callbacks. To adjust the alignment, use a [MediaQuery][] to get the
size of the widget, and divide by 2. (This converts units of "pixels dragged" to
coordinates that [Align][] uses.) Then, set the `Align` widget's `alignment` to
`_dragAlignment`:

```dart diff
  @override
  Widget build(BuildContext context) {
-   return Align(
-     child: Card(
-       child: widget.child,
+   var size = MediaQuery.of(context).size;
+   return GestureDetector(
+     onPanDown: (details) {},
+     onPanUpdate: (details) {
+       setState(() {
+         _dragAlignment += Alignment(
+           details.delta.dx / (size.width / 2),
+           details.delta.dy / (size.height / 2),
+         );
+       });
+     },
+     onPanEnd: (details) {},
+     child: Align(
+       alignment: _dragAlignment,
+       child: Card(
+         child: widget.child,
+       ),
      ),
    );
  }
```

## Step 3: Animate the widget

When the widget is released, it should spring back to the center.

Add an `Animation<Alignment>` field and an `_runAnimation` method. This
method defines a `Tween` that interpolates between the point the widget was
dragged to, to the point in the center.

```dart diff
  class _DraggableCardState extends State<DraggableCard>
      with SingleTickerProviderStateMixin {
    late AnimationController _controller;
+   late Animation<Alignment> _animation;
    Alignment _dragAlignment = Alignment.center;
```

<?code-excerpt "lib/step3.dart (runAnimation)"?>
```dart
void _runAnimation() {
  _animation = _controller.drive(
    AlignmentTween(begin: _dragAlignment, end: Alignment.center),
  );
  _controller.reset();
  _controller.forward();
}
```

Next, update `_dragAlignment` when the `AnimationController` produces a
value:

```dart diff
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
+   _controller.addListener(() {
+     setState(() {
+       _dragAlignment = _animation.value;
+     });
+   });
  }
```

Next, make the `Align` widget use the `_dragAlignment` field:

<?code-excerpt "lib/step3.dart (align)"?>
```dart
child: Align(alignment: _dragAlignment, child: Card(child: widget.child)),
```

Finally, update the `GestureDetector` to manage the animation controller:

```dart diff
  return GestureDetector(
-   onPanDown: (details) {},
+   onPanDown: (details) {
+     _controller.stop();
+   },
    onPanUpdate: (details) {
      // ...
    },
-   onPanEnd: (details) {},
+   onPanEnd: (details) {
+     _runAnimation();
+   },
    child: Align(
```

## Step 4: Calculate the velocity to simulate a springing motion

The last step is to do a little math, to calculate the velocity of the widget
after it's finished being dragged. This is so that the widget realistically
continues at that speed before being snapped back. (The `_runAnimation` method
already sets the direction by setting the animation's start and end alignment.)

First, import the `physics` package:

<?code-excerpt "lib/main.dart (import)"?>
```dart
import 'package:flutter/physics.dart';
```

The `onPanEnd` callback provides a [DragEndDetails][] object. This object
provides the velocity of the pointer when it stopped contacting the screen. The
velocity is in pixels per second, but the `Align` widget doesn't use pixels. It
uses coordinate values between [-1.0, -1.0] and [1.0, 1.0], where [0.0, 0.0]
represents the center. The `size` calculated in step 2 is used to convert pixels
to coordinate values in this range.

Finally, `AnimationController` has an `animateWith()` method that can be given a
[SpringSimulation][]:

<?code-excerpt "lib/main.dart (runAnimation)"?>
```dart
/// Calculates and runs a [SpringSimulation].
void _runAnimation(Offset pixelsPerSecond, Size size) {
  _animation = _controller.drive(
    AlignmentTween(begin: _dragAlignment, end: Alignment.center),
  );
  // Calculate the velocity relative to the unit interval, [0,1],
  // used by the animation controller.
  final unitsPerSecondX = pixelsPerSecond.dx / size.width;
  final unitsPerSecondY = pixelsPerSecond.dy / size.height;
  final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
  final unitVelocity = unitsPerSecond.distance;

  const spring = SpringDescription(mass: 30, stiffness: 1, damping: 1);

  final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

  _controller.animateWith(simulation);
}
```

Don't forget to call `_runAnimation()`  with the velocity and size:

<?code-excerpt "lib/main.dart (onPanEnd)"?>
```dart
onPanEnd: (details) {
  _runAnimation(details.velocity.pixelsPerSecond, size);
},
```

:::note
Now that the animation controller uses a simulation it's `duration` argument
is no longer required.
:::

## Interactive Example

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter physics simulation hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() {
  runApp(const MaterialApp(home: PhysicsCardDragDemo()));
}

class PhysicsCardDragDemo extends StatelessWidget {
  const PhysicsCardDragDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const DraggableCard(child: FlutterLogo(size: 128)),
    );
  }
}

/// A draggable card that moves back to [Alignment.center] when it's
/// released.
class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, super.key});

  final Widget child;

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// The alignment of the card as it is dragged or being animated.
  ///
  /// While the card is being dragged, this value is set to the values computed
  /// in the GestureDetector onPanUpdate callback. If the animation is running,
  /// this value is set to the value of the [_animation].
  Alignment _dragAlignment = Alignment.center;

  late Animation<Alignment> _animation;

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(begin: _dragAlignment, end: Alignment.center),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(mass: 30, stiffness: 1, damping: 1);

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(alignment: _dragAlignment, child: Card(child: widget.child)),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/animation-physics-card-drag.webp" alt="Demo showing a widget being dragged and snapped back to the center" class="site-mobile-screenshot" />
</noscript>

[Align]: {{site.api}}/flutter/widgets/Align-class.html
[Alignment]: {{site.api}}/flutter/painting/Alignment-class.html
[AnimationController]: {{site.api}}/flutter/animation/AnimationController-class.html
[GestureDetector]: {{site.api}}/flutter/widgets/GestureDetector-class.html
[SingleTickerProviderStateMixin]: {{site.api}}/flutter/widgets/SingleTickerProviderStateMixin-mixin.html
[TickerProvider]: {{site.api}}/flutter/scheduler/TickerProvider-class.html
[MediaQuery]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[DragEndDetails]: {{site.api}}/flutter/gestures/DragEndDetails-class.html
[SpringSimulation]: {{site.api}}/flutter/physics/SpringSimulation-class.html
