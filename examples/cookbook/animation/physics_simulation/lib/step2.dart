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
      body: const DraggableCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, super.key});

  final Widget child;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

// #docregion alignment
// #docregion animation
class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;
  // #enddocregion alignment
  // #enddocregion animation

  // #docregion initState
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }
  // #enddocregion initState

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // #docregion build
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // #docregion gesture
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
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
    // #enddocregion gesture
  }
  // #enddocregion build
}
