```run-dartpad:theme-light:mode-flutter:split-60:width-100%:height-500px
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';

class BouncingBallDemo extends StatefulWidget {
  _BouncingBallDemoState createState() => _BouncingBallDemoState();
}

class _BouncingBallDemoState extends State<BouncingBallDemo> with TickerProviderStateMixin {
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController( vsync: this, duration: Duration(seconds: 3));

    controller.addListener(() {
      print("value:${controller.value}");
      setState((){});
    });

    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: controller.value),
        child: Container(
      width: 40.0,
      height: 40.0,
    ));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: BouncingBallDemo(),
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