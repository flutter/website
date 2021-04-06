---
title: Create a typing indicator
description: How to implement a typing indicator.
prev:
  title: Create a staggered menu animation
  path:  /docs/cookbook/effects/staggered-menu-animation
next:
  title: Create an expandable FAB
  path:  /docs/cookbook/effects/expandable-fab
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

Modern chat apps display indicators when other users
are actively typing responses. These indicators help
prevent rapid and conflicting responses between you
and the other person. In this recipe, you build a
speech bubble typing indicator that animates in and out of view.

The following animation shows the app's behavior:

![The typing indicator is turned on and off]({% asset cookbook/effects/TypingIndicator.gif @path %}){:.site-mobile-screenshot}

## Define the typing indicator widget

The typing indicator exists within its own widget so that
it can be used anywhere in your app. As with any widget
that controls animations, the typing indicator needs to
be a stateful widget. The widget accepts a boolean value 
that determines whether the indicator is visible.
This speech-bubble-typing indicator accepts a color
for the bubbles and two colors for the light and dark
phases of the flashing circles within the large speech bubble.

Define a new stateful widget called `TypingIndicator`.

<!--skip-->
```dart
class TypingIndicator extends StatefulWidget {
 const TypingIndicator({
   Key? key,
   this.showIndicator = false,
   this.bubbleColor = const Color(0xFF646b7f),
   this.flashingCircleDarkColor = const Color(0xFF333333),
   this.flashingCircleBrightColor = const Color(0xFFaec1dd),
 }) : super(key: key);

 final bool showIndicator;
 final Color bubbleColor;
 final Color flashingCircleDarkColor;
 final Color flashingCircleBrightColor;

 @override
 _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
 @override
 Widget build(BuildContext context) {
   // TODO:
   return SizedBox();
 }
}
```

## Make room for the typing indicator

The typing indicator doesn’t occupy any space when it
isn’t displayed. Therefore, the indicator needs to grow
in height when it appears, and shrink in height
when it disappears.

The height of the typing indicator could be the natural
height of the speech bubbles within the typing indicator.
However, the speech bubbles expand with an elastic curve.
This elasticity would be too visually jarring if it quickly 
pushed all the conversation messages up or down. Instead,
the height of the typing indicator animates on its own,
smoothly expanding before the bubbles appear.
When the bubbles disappear, the height smoothly contracts to zero. 
This behavior requires an [explicit animation][] for the
height of the typing indicator.

Define an animation for the height of the typing indicator,
and then apply that animated value to the `SizedBox`
widget within the typing indicator.

<!--skip-->
```dart
class _TypingIndicatorState extends State<TypingIndicator> with TickerProviderStateMixin {

 late AnimationController _appearanceController;
 late Animation<double> _indicatorSpaceAnimation;

 @override
 void initState() {
   super.initState();

   _appearanceController = AnimationController(
     vsync: this,
   );

   _indicatorSpaceAnimation = CurvedAnimation(
     parent: _appearanceController,
     curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
     reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
   ).drive(Tween<double>(
     begin: 0.0,
     end: 60.0,
   ));

   if (widget.showIndicator) {
     _showIndicator();
   }
 }

 @override
 void didUpdateWidget(TypingIndicator oldWidget) {
   super.didUpdateWidget(oldWidget);

   if (widget.showIndicator != oldWidget.showIndicator) {
     if (widget.showIndicator) {
       _showIndicator();
     } else {
       _hideIndicator();
     }
   }
 }

 @override
 void dispose() {
   _appearanceController.dispose();
   super.dispose();
 }

 void _showIndicator() {
   _appearanceController
     ..duration = const Duration(milliseconds: 750)
     ..forward();
 }

 void _hideIndicator() {
   _appearanceController
     ..duration = const Duration(milliseconds: 150)
     ..reverse();
 }

 @override
 Widget build(BuildContext context) {
   return AnimatedBuilder(
     animation: _indicatorSpaceAnimation,
     builder: (context, child) {
       return SizedBox(
         height: _indicatorSpacerAnimation.value,
       );
     },
   );
 }
}
```

The `TypingIndicator` runs an animation forward or backward
depending on whether the incoming `showIndicator` variable
is `true` or `false`, respectively.

The animation that controls the height uses different
animation curves depending on its direction.
When the animation moves forward, it needs to quickly make 
space for the speech bubbles. For this reason,
the forward curve runs the entire height animation within
the first 40% of the overall appearance animation.
When the animation reverses, it needs to give the speech bubbles
enough time to disappear before contracting the height. 
An ease-out curve that uses all the available time is a
good way to accomplish this behavior.

{{site.alert.note}}
  The `AnimatedBuilder` widget rebuilds the `SizedBox`
  widget as the `_indicatorSpaceAnimation` changes.
  The alternative to using `AnimatedBuilder` is to
  invoke `setState()` every time the animation changes, 
  and then rebuild the entire widget tree within `TypingIndicator`. 
  Invoking `setState()` in this manner is acceptable,
  but as other widgets are added to this widget tree,
  rebuilding the entire tree just to change the height 
  of the `SizedBox` widget wastes CPU cycles.
{{site.alert.end}}

## Animate the speech bubbles

The typing indicator displays three speech bubbles.
The first two bubbles are small and round. The third
bubble is oblong and contains a few flashing circles. 
These bubbles are staggered in position from the lower
left of the available space.

Each bubble appears by animating its scale from 0% to 100%,
and each bubble does this at slightly different times so
that it looks like each bubble appears after the one before it.
This is called a [staggered animation][].

Paint the three bubbles in the desired positions from the
lower left. Then, animate the scale of the bubbles
so that the bubbles are staggered whenever the `showIndicator`
property changes.

<!--skip-->
```dart
class _TypingIndicatorState extends State<TypingIndicator> with TickerProviderStateMixin {

 late AnimationController _appearanceController;
 late Animation<double> _indicatorSpaceAnimation;
 late Animation<double> _smallBubbleAnimation;
 late Animation<double> _mediumBubbleAnimation;
 late Animation<double> _largeBubbleAnimation;

 @override
 void initState() {
   super.initState();

   _appearanceController = AnimationController(
     vsync: this,
   );

   _indicatorSpaceAnimation = CurvedAnimation(
     parent: _appearanceController,
     curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
     reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
   ).drive(Tween<double>(
     begin: 0.0,
     end: 60.0,
   ));

   _smallBubbleAnimation = CurvedAnimation(
     parent: _appearanceController,
     curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
     reverseCurve: const Interval(0.0, 0.3, curve: Curves.easeOut),
   );
   _mediumBubbleAnimation = CurvedAnimation(
     parent: _appearanceController,
     curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
     reverseCurve: const Interval(0.2, 0.6, curve: Curves.easeOut),
   );
   _largeBubbleAnimation = CurvedAnimation(
     parent: _appearanceController,
     curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
     reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
   );

   if (widget.showIndicator) {
     _showIndicator();
   }
 }

 @override
 Widget build(BuildContext context) {
   return AnimatedBuilder(
     animation: _indicatorSpaceAnimation,
     builder: (context, child) {
       return SizedBox(
         height: _indicatorSpacerAnimation.value,
         child: child,
       );
     },
     child: Stack(
       children: [
         _buildAnimatedBubble(
           animation: _smallBubbleAnimation,
           left: 8,
           bottom: 8,
           bubble: _buildCircleBubble(8),
         ),
         _buildAnimatedBubble(
           animation: _mediumBubbleAnimation,
           left: 10,
           bottom: 10,
           bubble: _buildCircleBubble(16),
         ),
         _buildAnimatedBubble(
           animation: _largeBubbleAnimation,
           left: 12,
           bottom: 12,
           bubble: _buildStatusBubble(),
         ),
       ],
     ),
   );
 }

 Widget _buildAnimatedBubble({
   required Animation<double> animation,
   required double left,
   required double bottom,
   required Widget bubble,
 }) {
   return Positioned(
     left: left,
     bottom: bottom,
     child: AnimatedBuilder(
       animation: animation,
       builder: (context, child) {
         return Transform.scale(
           scale: animation.value,
           alignment: Alignment.bottomLeft,
           child: child,
         );
       },
       child: bubble,
     ),
   );
 }

 Widget _buildCircleBubble(double size) {
   return Container(
     width: size,
     height: size,
     decoration: BoxDecoration(
       shape: BoxShape.circle,
       color: widget.bubbleColor,
     ),
   ); 
 }

 Widget _buildStatusBubble() {
   return Container(
     width: 85,
     height: 44,
     padding: const EdgeInsets.symmetric(horizontal: 8),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(27),
       color: widget.bubbleColor,
     ),
   );
 }
}
```

## Animate the flashing circles

Within the large speech bubble, the typing indicator
displays three small circles that flash repeatedly.
Each circle flashes at a slightly different time,
giving the impression that a single light source is 
moving behind each circle. This flashing animation
repeats indefinitely.

Introduce a repeating `AnimationController` to
implement the circle flashing.

<!--skip-->
```dart
class _TypingIndicatorState extends State<TypingIndicator> with TickerProviderStateMixin {

 late AnimationController _repeatingController;
 final List<Interval> _dotIntervals = const [
   Interval(0.25, 0.8),
   Interval(0.35, 0.9),
   Interval(0.45, 1.0),
 ];

 @override
 void initState() {
   super.initState();

   // ...

   _repeatingController = AnimationController(
     vsync: this,
     duration: const Duration(milliseconds: 1500),
   );

   if (widget.showIndicator) {
     _showIndicator();
   }
 }

 @override
 void dispose() {
   _appearanceController.dispose();
   _repeatingController.dispose();
   super.dispose();
 }

 void _showIndicator() {
   _appearanceController
     ..duration = const Duration(milliseconds: 750)
     ..forward();
   _repeatingController.repeat();
 }

 void _hideIndicator() {
   _appearanceController
     ..duration = const Duration(milliseconds: 150)
     ..reverse();
  _repeatingController.stop();
 }

 Widget _buildStatusBubble() {
   return Container(
     width: 85,
     height: 44,
     padding: const EdgeInsets.symmetric(horizontal: 8),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(27),
       color: widget.bubbleColor,
     ),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         _buildFlashingCircle(0),
         _buildFlashingCircle(1),
         _buildFlashingCircle(2),
       ],
     ),
   );
 }

 Widget _buildFlashingCircle(int index) {
   return AnimatedBuilder(
     animation: _repeatingController,
     builder: (context, child) {
       final circleFlashPercent =
         _dotIntervals[index].transform(_repeatingController.value);
       final circleColorPercent = sin(pi * circleFlashPercent);

       return Container(
         width: 12,
         height: 12,
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           color: Color.lerp(widget.flashingCircleDarkColor,
             widget.flashingCircleBrightColor, circleColorPercent),
         ),
       );
     },
   );
 }
}
```

Each circle calculates its color using a sine (`sin`)
function so that the color changes gradually at the
minimum and maximum points. Additionally,
each circle animates its color within a specified interval
that takes up a portion of the overall animation time.
The position of these intervals generates the visual
effect of a single light source moving behind the three dots.

Congratulations! You now have a typing indicator that lets users
know when someone else is typing. The indicator animates in and out,
and displays a repeating animation while the other user is typing.

## Interactive example

Run the app:

* Click the round on/off switch at the bottom
  of the screen to turn the typing indicator bubble
  on and off.

<!--skip-->
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExampleIsTyping(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

const _backgroundColor = Color(0xFF333333);

class ExampleIsTyping extends StatefulWidget {
  const ExampleIsTyping({
    Key? key,
  }) : super(key: key);

  @override
  _ExampleIsTypingState createState() => _ExampleIsTypingState();
}

class _ExampleIsTypingState extends State<ExampleIsTyping> {
  bool _isSomeoneTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Typing Indicator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessages(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: TypingIndicator(
              showIndicator: _isSomeoneTyping,
            ),
          ),
          _buildIsTypingSimulator(),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: 25,
      reverse: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: FakeMessage(isBig: index.isOdd),
        );
      },
    );
  }

  Widget _buildIsTypingSimulator() {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: CupertinoSwitch(
          onChanged: (newValue) {
            setState(() {
              _isSomeoneTyping = newValue;
            });
          },
          value: _isSomeoneTyping,
        ),
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    Key? key,
    this.showIndicator = false,
    this.bubbleColor = const Color(0xFF646b7f),
    this.flashingCircleDarkColor = const Color(0xFF333333),
    this.flashingCircleBrightColor = const Color(0xFFaec1dd),
  }) : super(key: key);

  final bool showIndicator;
  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  late Animation<double> _indicatorSpaceAnimation;

  late Animation<double> _smallBubbleAnimation;
  late Animation<double> _mediumBubbleAnimation;
  late Animation<double> _largeBubbleAnimation;

  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: 0.0,
      end: 60.0,
    ));

    _smallBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _mediumBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );
    _largeBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 750)
      ..forward();
    _repeatingController.repeat();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 150)
      ..reverse();
    _repeatingController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(
          height: _indicatorSpaceAnimation.value,
          child: child,
        );
      },
      child: Stack(
        children: [
          _buildAnimatedBubble(
            animation: _smallBubbleAnimation,
            left: 8,
            bottom: 8,
            bubble: _buildCircleBubble(8),
          ),
          _buildAnimatedBubble(
            animation: _mediumBubbleAnimation,
            left: 10,
            bottom: 10,
            bubble: _buildCircleBubble(16),
          ),
          _buildAnimatedBubble(
            animation: _largeBubbleAnimation,
            left: 12,
            bottom: 12,
            bubble: _buildStatusBubble(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBubble({
    required Animation<double> animation,
    required double left,
    required double bottom,
    required Widget bubble,
  }) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            alignment: Alignment.bottomLeft,
            child: child,
          );
        },
        child: bubble,
      ),
    );
  }

  Widget _buildCircleBubble(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.bubbleColor,
      ),
    );
  }

  Widget _buildStatusBubble() {
    return Container(
      width: 85,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        color: widget.bubbleColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFlashingCircle(0),
          _buildFlashingCircle(1),
          _buildFlashingCircle(2),
        ],
      ),
    );
  }

  Widget _buildFlashingCircle(int index) {
    return AnimatedBuilder(
      animation: _repeatingController,
      builder: (context, child) {
        final circleFlashPercent =
            _dotIntervals[index].transform(_repeatingController.value);
        final circleColorPercent = sin(pi * circleFlashPercent);

        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(widget.flashingCircleDarkColor,
                widget.flashingCircleBrightColor, circleColorPercent),
          ),
        );
      },
    );
  }
}

@immutable
class FakeMessage extends StatelessWidget {
  const FakeMessage({
    Key? key,
    required this.isBig,
  }) : super(key: key);

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
```

[explicit animation]: {{site.api}}/docs/development/ui/animations#tween-animation
[staggered animation]: {{site.api}}/docs/development/ui/animations/staggered-animations
