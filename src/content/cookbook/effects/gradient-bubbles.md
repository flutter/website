---
title: Create gradient chat bubbles
description: How to implement gradient chat bubbles.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/effects/gradient_bubbles"?>

Traditional chat apps display messages in chat bubbles
with solid color backgrounds. Modern chat apps display
chat bubbles with gradients that are based 
on the bubbles' position on the screen.
In this recipe, you'll modernize the chat UI by implementing
gradient backgrounds for the chat bubbles.

The following animation shows the app's behavior:

![Scrolling the gradient chat bubbles](/assets/images/docs/cookbook/effects/GradientBubbles.gif){:.site-mobile-screenshot}

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

Each bubble's gradient requires knowledge of the
bubble's location on the screen. This means that
the painting behavior requires access to layout information.
Such painting behavior isn't possible with typical widgets 
because widgets like `Container` and `DecoratedBox`
make decisions about background colors before layout occurs,
not after. In this case, because you require custom painting
behavior, but you don't require custom layout behavior 
or custom hit test behavior, a [`CustomPainter`][] is
a great choice to get the job done. 

:::note
In cases where you need control over the child layout,
but you don't need control over the painting or hit testing,
consider using a [`Flow`][] widget.

In cases where you need control over the layout,
painting, _and_ hit testing, 
consider defining a custom [`RenderBox`][].
:::

## Replace original background widget

Replace the widget responsible for drawing the
background with a new stateless widget called
`BubbleBackground`. Include a `colors` property to 
represent the full-screen gradient that should be
applied to the bubble.

<?code-excerpt "lib/bubble_background.dart (BubbleBackground)" replace="/return //g"?>
```dart
BubbleBackground(
  // The colors of the gradient, which are different
  // depending on which user sent this message.
  colors: message.isMine
      ? const [Color(0xFF6C7689), Color(0xFF3A364B)]
      : const [Color(0xFF19B7FF), Color(0xFF491CCB)],
  // The content within the bubble.
  child: DefaultTextStyle.merge(
    style: const TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Text(message.text),
    ),
  ),
);
```

## Create a custom painter

Next, introduce an implementation for `BubbleBackground`
as a stateless widget. For now, define the `build()`
method to return a `CustomPaint` with a `CustomPainter`
called `BubblePainter`. `BubblePainter` is used to paint 
the bubble gradients.

<?code-excerpt "lib/bubble_painter_empty.dart (BubblePainterEmpty)"?>
```dart
@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({
    super.key,
    required this.colors,
    this.child,
  });

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
  }) : _colors = colors;

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
to determine where its bubble is within the `ListView`'s bounds,
also known as the `Viewport`. Determining the location requires
a reference to the ancestor `ScrollableState` 
and a reference to the `BubbleBackground`'s
`BuildContext`. Provide each of those to the `CustomPainter`.

<?code-excerpt "lib/bubble_painter.dart (ScrollableContext)" replace="/painter: //g"?>
```dart
BubblePainter(
  colors: colors,
  bubbleContext: context,
  scrollable: ScrollableState(),
),
```
<!-- this code excerpt adds an extra closing bracket
at the end because the excerpt cuts off the paint method that's required for Custom Painter. -->
<?code-excerpt "lib/bubble_painter.dart (BPWithoutPaint)" replace="/}\n/}\n}\n/g;"?>
```dart
class BubblePainter extends CustomPainter {
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext bubbleContext,
    required List<Color> colors,
  })  : _scrollable = scrollable,
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
and a reference to this bubble's `BuildContext`.
This is all the information that the `CustomPainter` needs to 
paint the full-screen bubble gradients.
Implement the `paint()` method to calculate the position
of the bubble, configure a shader with the given colors, 
and then use a matrix translation to offset the shader
based on the bubble's position within the `Scrollable`.

<?code-excerpt "lib/bubble_background.dart (BubblePainter)"?>
```dart
class BubblePainter extends CustomPainter {
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext bubbleContext,
    required List<Color> colors,
  })  : _scrollable = scrollable,
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

  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = _scrollable.context.findRenderObject() as RenderBox;
    final scrollableRect = Offset.zero & scrollableBox.size;
    final bubbleBox = _bubbleContext.findRenderObject() as RenderBox;

    final origin =
        bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
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

:::note
Each bubble's gradient changes as the user
scrolls because the `BubbleBackground` widget
invokes `Scrollable.of(context)`. This method 
sets up an implicit dependency on the ancestor
`ScrollableState`, which causes the `BubbleBackground`
widget to rebuild every time the user scrolls 
up or down. See the [`InheritedWidget`][] documentation
for more information about these types of dependencies.
:::

## Interactive example

Run the app:

* Scroll up and down to observe the gradient effect.
* Chat bubbles located at the bottom of the screen
  have a darker gradient color than the ones at the top.

<!-- start dartpad -->
<?code-excerpt "lib/main.dart"?>
```dartpad run="true"
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() {
  runApp(const App(home: ExampleGradientBubbles()));
}

@immutable
class App extends StatelessWidget {
  const App({super.key, this.home});

  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData.dark(useMaterial3: true),
      home: home,
    );
  }
}

@immutable
class ExampleGradientBubbles extends StatefulWidget {
  const ExampleGradientBubbles({super.key});

  @override
  State<ExampleGradientBubbles> createState() => _ExampleGradientBubblesState();
}

class _ExampleGradientBubblesState extends State<ExampleGradientBubbles> {
  late final List<Message> data;

  @override
  void initState() {
    super.initState();
    data = MessageGenerator.generate(60, 1337);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF4F4F4F),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chat'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          reverse: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final message = data[index];
            return MessageBubble(
              message: message,
              child: Text(message.text),
            );
          },
        ),
      ),
    );
  }
}

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.child,
  });

  final Message message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final messageAlignment =
        message.isMine ? Alignment.topLeft : Alignment.topRight;

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8,
      child: Align(
        alignment: messageAlignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: BubbleBackground(
              colors: [
                if (message.isMine) ...const [
                  Color(0xFF6C7689),
                  Color(0xFF3A364B),
                ] else ...const [
                  Color(0xFF19B7FF),
                  Color(0xFF491CCB),
                ],
              ],
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
          ),
        ),
      ),
    );
  }
}

@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({
    super.key,
    required this.colors,
    this.child,
  });

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        scrollable: Scrollable.of(context),
        bubbleContext: context,
        colors: colors,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext bubbleContext,
    required List<Color> colors,
  })  : _scrollable = scrollable,
        _bubbleContext = bubbleContext,
        _colors = colors,
        super(repaint: scrollable.position);

  final ScrollableState _scrollable;
  final BuildContext _bubbleContext;
  final List<Color> _colors;

  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = _scrollable.context.findRenderObject() as RenderBox;
    final scrollableRect = Offset.zero & scrollableBox.size;
    final bubbleBox = _bubbleContext.findRenderObject() as RenderBox;

    final origin =
        bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
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

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate._scrollable != _scrollable ||
        oldDelegate._bubbleContext != _bubbleContext ||
        oldDelegate._colors != _colors;
  }
}

enum MessageOwner { myself, other }

@immutable
class Message {
  const Message({
    required this.owner,
    required this.text,
  });

  final MessageOwner owner;
  final String text;

  bool get isMine => owner == MessageOwner.myself;
}

class MessageGenerator {
  static List<Message> generate(int count, [int? seed]) {
    final random = Random(seed);
    return List.unmodifiable(List<Message>.generate(count, (index) {
      return Message(
        owner: random.nextBool() ? MessageOwner.myself : MessageOwner.other,
        text: _exampleData[random.nextInt(_exampleData.length)],
      );
    }));
  }

  static final _exampleData = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'In tempus mauris at velit egestas, sed blandit felis ultrices.',
    'Ut molestie mauris et ligula finibus iaculis.',
    'Sed a tempor ligula.',
    'Test',
    'Phasellus ullamcorper, mi ut imperdiet consequat, nibh augue condimentum nunc, vitae molestie massa augue nec erat.',
    'Donec scelerisque, erat vel placerat facilisis, eros turpis egestas nulla, a sodales elit nibh et enim.',
    'Mauris quis dignissim neque. In a odio leo. Aliquam egestas egestas tempor. Etiam at tortor metus.',
    'Quisque lacinia imperdiet faucibus.',
    'Proin egestas arcu non nisl laoreet, vitae iaculis enim volutpat. In vehicula convallis magna.',
    'Phasellus at diam a sapien laoreet gravida.',
    'Fusce maximus fermentum sem a scelerisque.',
    'Nam convallis sapien augue, malesuada aliquam dui bibendum nec.',
    'Quisque dictum tincidunt ex non lobortis.',
    'In hac habitasse platea dictumst.',
    'Ut pharetra ligula libero, sit amet imperdiet lorem luctus sit amet.',
    'Sed ex lorem, lacinia et varius vitae, sagittis eget libero.',
    'Vestibulum scelerisque velit sed augue ultricies, ut vestibulum lorem luctus.',
    'Pellentesque et risus pretium, egestas ipsum at, facilisis lectus.',
    'Praesent id eleifend lacus.',
    'Fusce convallis eu tortor sit amet mattis.',
    'Vivamus lacinia magna ut urna feugiat tincidunt.',
    'Sed in diam ut dolor imperdiet vehicula non ac turpis.',
    'Praesent at est hendrerit, laoreet tortor sed, varius mi.',
    'Nunc in odio leo.',
    'Praesent placerat semper libero, ut aliquet dolor.',
    'Vestibulum elementum leo metus, vitae auctor lorem tincidunt ut.',
  ];
}
```

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

[cloning the example code]: {{site.github}}/flutter/codelabs
[`CustomPainter`]: {{site.api}}/flutter/rendering/CustomPainter-class.html
[`Flow`]: {{site.api}}/flutter/widgets/Flow-class.html
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Issue 44152]: {{site.repo.flutter}}/issues/44152
[`RenderBox`]: {{site.api}}/flutter/rendering/RenderBox-class.html
