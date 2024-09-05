import 'dart:developer' as developer;

import 'package:flutter/material.dart';

// #docregion main
void main() {
  runApp(
    MaterialApp(
      home: const MyAppHome(), // becomes the route named '/'
      routes: <String, WidgetBuilder>{
        '/a': (context) => const MyPage(title: 'page A'),
        '/b': (context) => const MyPage(title: 'page B'),
        '/c': (context) => const MyPage(title: 'page C'),
      },
    ),
  );
}
// #enddocregion main

class MyAppHome extends StatelessWidget {
  const MyAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  void goToPage(BuildContext context) {
    // #docregion push-named
    Navigator.of(context).pushNamed('/b');
    // #enddocregion push-named
  }

  Future<void> goToAnotherPage(BuildContext context) async {
    // #docregion await
    Object? coordinates = await Navigator.of(context).pushNamed('/location');
    // #enddocregion await

    if (coordinates is Map) {
      developer.log(coordinates.toString());
    }
  }

  void popLocation(BuildContext context) {
    // #docregion pop-location
    Navigator.of(context).pop({'lat': 43.821757, 'long': -79.226392});
    // #enddocregion pop-location
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}
