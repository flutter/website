```run-dartpad:theme-light:mode-flutter:split-60:width-100%:height-500px:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';

class BouncingBallDemo extends StatefulWidget {
  @override
  _BouncingBallDemoState createState() => _BouncingBallDemoState();
}

class _BouncingBallDemoState extends State<BouncingBallDemo> {
  late double marginTop;
  late double start;
  late double end;
  late double increment;

  void bounce(Timer t) async {
    if (marginTop < end) {
      setState(() {
        marginTop += increment;
      });
    } else {
      t.cancel();
    }
  }

  void interpolate(double start, double end) {
    setState(() {
      increment = (end - start) / 60;
    });
  }

  @override
  void initState() {
    super.initState();
    marginTop = 0;
    start = 0;
    end = 100;
    interpolate(start, end);
    Timer.periodic(const Duration(milliseconds: 16), bounce);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        width: 40.0,
        height: 40.0,
      ),
    );
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