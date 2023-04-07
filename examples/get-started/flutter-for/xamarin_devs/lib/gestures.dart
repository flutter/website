import 'dart:developer' as developer;
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  // #docregion ElevatedButton
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        developer.log('click');
      },
      child: const Text('Button'),
    );
  }
  // #enddocregion ElevatedButton
}

// #docregion GestureDetector
class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            developer.log('tap');
          },
          child: const FlutterLogo(size: 200.0),
        ),
      ),
    );
  }
}
// #enddocregion GestureDetector

// #docregion RotatingFlutterDetector
class RotatingFlutterDetector extends StatefulWidget {
  const RotatingFlutterDetector({super.key});

  @override
  State<RotatingFlutterDetector> createState() =>
      _RotatingFlutterDetectorState();
}

class _RotatingFlutterDetectorState extends State<RotatingFlutterDetector>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: RotationTransition(
            turns: curve,
            child: const FlutterLogo(size: 200.0),
          ),
        ),
      ),
    );
  }
}
// #enddocregion RotatingFlutterDetector
