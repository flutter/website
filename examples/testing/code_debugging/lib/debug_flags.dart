import 'package:flutter/material.dart';
// #docregion debugPaintSizeEnabled
//add import to rendering library
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

// #enddocregion debugPaintSizeEnabled

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('hello');
  }
}
