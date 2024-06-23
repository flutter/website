import 'package:flutter/material.dart';
// #docregion debug-paint-size-enabled
// Add import to the Flutter rendering library.
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(const MyApp());
}
// #enddocregion debug-paint-size-enabled

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('hello');
  }
}
