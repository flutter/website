```run-dartpad:theme-light:mode-flutter:split-100:width-100%:height-500px:null_safety-true
{$ begin main.dart $}
import 'dart:async';

import 'package:flutter/material.dart';

class AnimationControllerDemo extends StatefulWidget {
  @override
  _AnimationControllerDemo createState() => _AnimationControllerDemo();
}

class _AnimationControllerDemo extends State<AnimationControllerDemo> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 100,
    );

    controller.addListener(() {
      print(controller.value);
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: AnimationControllerDemo(),
        ),
      ),
    );
  }
}

Future<void> main() async {
  runApp(
    MyApp(),
  );
}
{$ end main.dart $}
```