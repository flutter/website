import 'package:flutter/material.dart';
// #docregion debugPaintSizeEnabled
//add import to rendering library
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

// #enddocregion debugPaintSizeEnabled

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('hello');
  }
}
