import 'package:flutter/material.dart';

// #docregion map
void main() {
  runApp(
    MaterialApp(
      home: const MyAppHome(), // Becomes the route named '/'.
      routes: <String, WidgetBuilder>{
        '/a': (context) => const MyPage(title: 'page A'),
        '/b': (context) => const MyPage(title: 'page B'),
        '/c': (context) => const MyPage(title: 'page C'),
      },
    ),
  );
}
// #enddocregion map

class MyAppHome extends StatefulWidget {
  const MyAppHome({super.key});

  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key, required this.title});
  final String title;

  void navigate(BuildContext context) {
    // #docregion push
    Navigator.of(context).pushNamed('/b');
    // #enddocregion push
  }

  Object? push(BuildContext context) async {
    // #docregion push-await
    Object? coordinates = await Navigator.of(context).pushNamed('/location');
    // #enddocregion push-await

    return coordinates;
  }

  void pop(BuildContext context) {
    // #docregion pop
    Navigator.of(context).pop({'lat': 43.821757, 'long': -79.226392});
    // #enddocregion pop
  }

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
