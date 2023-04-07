import 'package:flutter/material.dart';

// #docregion Main
void main() {
  runApp(const MyApp());
}
// #enddocregion Main

// #docregion MyApp
class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Hello World!',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
// #enddocregion MyApp
