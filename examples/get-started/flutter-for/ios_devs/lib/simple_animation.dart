import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double turns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // #docregion animated-button
        child: AnimatedRotation(
          duration: const Duration(seconds: 1),
          turns: turns,
          curve: Curves.easeIn,
          child: TextButton(
              onPressed: () {
                setState(() {
                  turns += .125;
                });
              },
              child: const Text('Tap me!')),
        ),
        // #enddocregion animated-button
      ),
    );
  }
}
