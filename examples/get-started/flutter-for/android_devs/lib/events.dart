import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  // #docregion onPressed
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        developer.log('click');
      },
      child: const Text('Button'),
    );
  }
  // #enddocregion onPressed
}

// #docregion onTap
class SampleTapApp extends StatelessWidget {
  const SampleTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            developer.log('tap');
          },
          child: const FlutterLogo(
            size: 200.0,
          ),
        ),
      ),
    );
  }
}
// #enddocregion onTap

// #docregion SampleApp
class SampleApp extends StatefulWidget {
  const SampleApp({super.key});

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
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
            child: const FlutterLogo(
              size: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
// #enddocregion SampleApp