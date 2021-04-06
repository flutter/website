---
title: Create gradient chat bubbles
description: How to implement gradient chat bubbles.
prev:
  title: Create an expandable FAB
  path:  /docs/cookbook/effects/expandable-fab
next:
  title: Drag a UI element
  path:  /docs/cookbook/effects/drag-a-widget
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

Traditional chat apps display messages in chat bubbles
with solid color backgrounds. Modern chat apps display
chat bubbles with gradients that are based 
on the bubbles’ position on the screen.
In this recipe, you'll modernize the chat UI by implementing
gradient backgrounds for the chat bubbles.

The following animation shows the app's behavior:

![Scrolling the gradient chat bubbles]({% asset cookbook/effects/GradientBubbles.gif @path %}){:.site-mobile-screenshot}

## Understand the challenge

The traditional chat bubble solution probably uses a
`DecoratedBox` or a similar widget to paint a rounded
rectangle behind each chat message. That approach is 
great for a solid color or even for a gradient that
repeats in every chat bubble. However, modern,
full-screen, gradient bubble backgrounds require 
a different approach. The full-screen gradient,
combined with bubbles scrolling up and down the screen,
requires an approach that allows you to make painting 
decisions based on layout information.

Each bubble’s gradient requires knowledge of the
bubble’s location on the screen. This means that
the painting behavior requires access to layout information.
Such painting behavior isn’t possible with typical widgets 
because widgets like `Container` and `DecoratedBox`
make decisions about background colors before layout occurs,
not after. In this case, because you require custom painting
behavior, but you don’t require custom layout behavior 
or custom hit test behavior, a [`CustomPainter`][] is
a great choice to get the job done. 

{{site.alert.note}}
  In cases where you need control over the child layout,
  but you don’t need control over the painting or hit testing,
  consider using a [`Flow`][] widget.

  In cases where you need control over the layout,
  painting, _and_ hit testing, 
  consider defining a custom [`RenderBox`][].
{{site.alert.end}}

## Replace original background widget

Replace the widget responsible for drawing the
background with a new stateless widget called
`BubbleBackground`. Include a `colors` property to 
represent the full-screen gradient that should be
applied to the bubble.

<!--skip-->
```dart
BubbleBackground(
 // The colors of the gradient, which are different
 // depending on which user sent this message.
 colors: message.isMine
   ? [const Color(0xFF6C7689), const Color(0xFF3A364B)]
   : [const Color(0xFF19B7FF), const Color(0xFF491CCB)],
 // The content within the bubble.
 child: DefaultTextStyle.merge(
   style: const TextStyle(
     fontSize: 18.0,
     color: Colors.white,
   ),
   child: Padding(
     padding: const EdgeInsets.all(12.0),
     child: child,
   ),
 ),
),
```

## Create a custom painter

Next, introduce an implementation for `BubbleBackground`
as a stateless widget. For now, define the `build()`
method to return a `CustomPaint` with a `CustomPainter`
called `BubblePainter`. `BubblePainter` is used to paint 
the bubble gradients.

<!--skip-->
```dart
@immutable
class BubbleBackground extends StatelessWidget {
 const BubbleBackground({
   Key? key,
   required this.colors,
   this.child,
 }) : super(key: key);

 final List<Color> colors;
 final Widget? child;

 @override
 Widget build(BuildContext context) {
   return CustomPaint(
     painter: BubblePainter(
       colors: colors,
     ),
     child: child,
   );
 }
}

class BubblePainter extends CustomPainter {
 BubblePainter({
   required List<Color> colors,
 })   : _colors = colors;

 final List<Color> _colors;

 @override
 void paint(Canvas canvas, Size size) {
   // TODO:
 }

 @override
 bool shouldRepaint(BubblePainter oldDelegate) {
   // TODO:
   return false;
 }
}
```

## Provide access to scrolling information

The `CustomPainter` requires the information necessary
to determine where its bubble is within the `ListView`’s bounds,
also known as the `Viewport`. Determining the location requires
a reference to the ancestor `ScrollableState` 
and a reference to the `BubbleBackground`’s
`BuildContext`. Provide each of those to the `CustomPainter`.

<!--skip-->
```dart
BubbleBackground(
  scrollable: Scrollable.of(context)!,
  bubbleContext: context,
  // ...
),

//-----

class BubblePainter extends CustomPainter {
 BubblePainter({
   required ScrollableState scrollable,
   required BuildContext bubbleContext,
   required List<Color> colors,
 })   : _scrollable = scrollable,
       _bubbleContext = bubbleContext,
       _colors = colors;

 final ScrollableState _scrollable;
 final BuildContext _bubbleContext;
 final List<Color> _colors;

 @override
 bool shouldRepaint(BubblePainter oldDelegate) {
   return oldDelegate._scrollable != _scrollable ||
       oldDelegate._bubbleContext != _bubbleContext ||
       oldDelegate._colors != _colors;
 }
}
```

## Paint a full-screen bubble gradient

The `CustomPainter` now has the desired gradient colors,
a reference to the containing `ScrollableState`,
and a reference to this bubble’s `BuildContext`.
This is all the information that the `CustomPainter` needs to 
paint the full-screen bubble gradients.
Implement the `paint()` method to calculate the position
of the bubble, configure a shader with the given colors, 
and then use a matrix translation to offset the shader
based on the bubble’s position within the `Scrollable`.

<!--skip-->
```dart
class BubblePainter extends CustomPainter {
 @override
 void paint(Canvas canvas, Size size) {
   final scrollableBox = _scrollable.context.findRenderObject() as RenderBox;
   final scrollableRect = Offset.zero & scrollableBox.size;
   final bubbleBox = _bubbleContext.findRenderObject() as RenderBox;

   final origin = bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
   final paint = Paint()
     ..shader = ui.Gradient.linear(
       scrollableRect.topCenter,
       scrollableRect.bottomCenter,
       _colors,
       [0.0, 1.0],
       TileMode.clamp,
       Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
     );
   canvas.drawRect(Offset.zero & size, paint);
 }
}
```

Congratulations! You now have a modern, chat bubble UI.

{{site.alert.note}}
  The recipe doesn’t yet work on the web because
  Flutter doesn’t yet support `Paint` shaders.
  {% comment %}
    For more information, see [Issue xxx][].
    [I can't find the issue on GitHub, I've asked the web team]
  {% endcomment %}
{{site.alert.end}}

{{site.alert.note}}
  Each bubble’s gradient changes as the user
  scrolls because the `BubbleBackground` widget
  invokes `Scrollable.of(context)`. This method 
  sets up an implicit dependency on the ancestor
  `ScrollableState`, which causes the `BubbleBackground`
  widget to rebuild every time the user scrolls 
  up or down. See the [`InheritedWidget`][] documentation
  for more information about these types of dependencies.
{{site.alert.end}}

## Recap

The fundamental challenge when painting based on the
scroll position, or the screen position in general,
is that the painting behavior must occur after the
layout phase is complete. `CustomPaint` is a unique
widget that allows you to execute custom painting
behaviors after the layout phase is complete.
If you execute the painting behaviors after the layout phase, 
then you can base your painting decisions on the layout
information, such as the position of the `CustomPaint`
widget within a `Scrollable` or within the screen.

{{site.alert.note}}
  This recipe doesn't provide an interactive DartPad because
  `Paint` shaders have not yet been implemented for the web.
  You can run this recipe on a mobile or desktop device by
  [cloning the example code][]. See the "Gradient Bubbles"
  example under the “cookbook” directory.
{{site.alert.end}}


[cloning the example code]: {{site.github}}/flutter/codelabs
[`CustomPainter`]: {{site.api}}/flutter/rendering/CustomPainter-class.html
[`Flow`]: {{site.api}}/flutter/widgets/Flow-class.html
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Issue 44152]: {{site.github}}/flutter/flutter/issues/44152
[`RenderBox`]: {{site.api}}/flutter/rendering/RenderBox-class.html

