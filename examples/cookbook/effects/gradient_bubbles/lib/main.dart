import 'dart:ui' as ui;

import 'package:flutter/material.dart';

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
        bubbleContext: context,
        scrollable: ScrollableState(),
      ),
      child: child,
    );
  }
}

// #docregion BubblePainter
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
// #enddocregion BubblePainter

class Message {
  Message();

  bool isMine = true;
  String text = 'The quick brown fox jumps over the lazy dog';
  String from = 'Flutter Dev';
}

class MyChat extends StatefulWidget {
  const MyChat({super.key});

  @override
  State<MyChat> createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  Message message = Message();

  @override
  Widget build(BuildContext context) {
    // #docregion BubbleBackground
    return BubbleBackground(
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
          padding: const EdgeInsets.all(12.0),
          child: Text(message.text),
        ),
      ),
    );
    // #enddocregion BubbleBackground
  }
}
