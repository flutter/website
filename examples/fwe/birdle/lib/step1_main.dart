import 'package:flutter/material.dart';

// #docregion main
void main() {
  runApp(const MainApp());
}
// #enddocregion main

// #docregion MainApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          // #docregion Text
          child: Text('Hello World!'),
          // #enddocregion Text
        ),
      ),
    );
  }
}
// #enddocregion MainApp
