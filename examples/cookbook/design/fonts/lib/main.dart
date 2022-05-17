import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion MaterialApp
    return MaterialApp(
      title: 'Custom Fonts',
      // Set Raleway as the default app font.
      theme: ThemeData(fontFamily: 'Raleway'),
      home: const MyHomePage(),
    );
    // #enddocregion MaterialApp
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar uses the app-default Raleway font.
      appBar: AppBar(title: const Text('Custom Fonts')),
      body: const Center(
        // This Text widget uses the RobotoMono font.
        // #docregion Text
        child: Text(
          'Roboto Mono sample',
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
        // #enddocregion Text
      ),
    );
  }
}
