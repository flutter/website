import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// #docregion main
void main() {
  runApp(const MyApp());
}
// #enddocregion main

// #docregion myapp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // the widget returned here is a CupertinoApp
    // that has the look and feel of an iOS app by default
    return CupertinoApp(
      home: const HomePage(),
    );
  }
}
// #enddocregion myapp

// #docregion homepage
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hello, World!',
        ),
      ),
    );
  }
}
// #enddocregion homepage
