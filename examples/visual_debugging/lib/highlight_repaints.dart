import 'package:flutter/material.dart';

// #docregion Toggle
import 'package:flutter/rendering.dart';

void highlightRepaints() {
  debugRepaintRainbowEnabled = true;
}
// #enddocregion Toggle

// #docregion EverythingRepaints
class EverythingRepaintsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repaint Example')),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
// #enddocregion EverythingRepaints

// #docregion AreaRepaints
class AreaRepaintsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repaint Example')),
      body: Center(
        child: RepaintBoundary(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
// #enddocregion AreaRepaints