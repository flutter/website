import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // #docregion text-button
        child: CupertinoButton(
          onPressed: () {
            // This closure is called when your button is tapped.
          },
          child: const Text('Do something'),
        ),
        // #enddocregion text-button
      ),
    );
  }
}
