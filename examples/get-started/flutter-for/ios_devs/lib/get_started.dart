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
    // Returns a CupertinoApp that, by default,
    // has the look and feel of an iOS app.
    return const CupertinoApp(
      home: HomePage(),
    );
  }
}
// #enddocregion myapp

// #docregion homepage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, World!',
        ),
      ),
    );
  }
}
// #enddocregion homepage
