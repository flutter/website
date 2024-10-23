// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({super.key, required this.controller})
      :

        // Each animation defined here transforms its value during the subset
        // of the controller's duration defined by the animation's interval.
        // For example the opacity animation transforms its value during
        // the first 10% of the controller's duration.

        opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.100,
              curve: Curves.ease,
            ),
          ),
        ),
        width = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.125,
              0.250,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(begin: 50.0, end: 150.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.250,
              0.375,
              curve: Curves.ease,
            ),
          ),
        ),
        padding = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 16),
          end: const EdgeInsets.only(bottom: 75),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.250,
              0.375,
              curve: Curves.ease,
            ),
          ),
        ),
        borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(4),
          end: BorderRadius.circular(75),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.375,
              0.500,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(
          begin: Colors.indigo[100],
          end: Colors.orange[400],
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.500,
              0.750,
              curve: Curves.ease,
            ),
          ),
        );

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius?> borderRadius;
  final Animation<Color?> color;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            border: Border.all(
              color: Colors.indigo[300]!,
              width: 3,
            ),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class StaggerDemo extends StatefulWidget {
  const StaggerDemo({super.key});

  @override
  State<StaggerDemo> createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because we were disposed.
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 is normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
            child: StaggerAnimation(controller: _controller.view),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: StaggerDemo(),
    ),
  );
}
