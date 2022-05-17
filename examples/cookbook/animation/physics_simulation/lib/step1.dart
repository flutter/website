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
class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // #enddocregion alignment

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Card(
        child: widget.child,
      ),
    );
  }
  // #enddocregion build
}
