import 'package:flutter/material.dart';

// #docregion Toggle
import 'package:flutter/rendering.dart';

void highlightRepaints() {
  debugRepaintRainbowEnabled = true;
}
// #enddocregion Toggle

// #docregion EverythingRepaints
class EverythingRepaintsPage extends StatelessWidget {
  const EverythingRepaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repaint Example')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
// #enddocregion EverythingRepaints

// #docregion AreaRepaints
class AreaRepaintsPage extends StatelessWidget {
  const AreaRepaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repaint Example')),
      body: const Center(
        child: RepaintBoundary(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
// #enddocregion AreaRepaints