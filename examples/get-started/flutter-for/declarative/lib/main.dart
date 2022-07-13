import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color red = Colors.red;

    // #docregion declarative
    // Declarative style
    return ViewB(
      color: red,
      child: const ViewC(),
    );
    // #enddocregion declarative
  }
}

class ViewB extends StatelessWidget {
  const ViewB({super.key, required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return const Text('Hello!');
  }
}

class ViewC extends StatelessWidget {
  const ViewC({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('World!');
  }
}
