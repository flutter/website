import 'package:flutter/material.dart';

// #docregion Map
void main() {
  runApp(MaterialApp(
    home: const MyAppHome(), // Becomes the route named '/'.
    routes: <String, WidgetBuilder>{
      '/a': (BuildContext context) => const MyPage(title: 'page A'),
      '/b': (BuildContext context) => const MyPage(title: 'page B'),
      '/c': (BuildContext context) => const MyPage(title: 'page C'),
    },
  ));
}
// #enddocregion Map

class MyAppHome extends StatefulWidget {
  const MyAppHome({Key? key}) : super(key: key);

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
  const MyPage({Key? key, required this.title}) : super(key: key);
  final String title;

  void navigate(BuildContext context) {
    // #docregion Push
    Navigator.of(context).pushNamed('/b');
    // #enddocregion Push
  }

  Object? push(BuildContext context) async {
    // #docregion PushAwait
    Object? coordinates = await Navigator.of(context).pushNamed('/location');
    // #enddocregion PushAwait

    return coordinates;
  }

  void pop(BuildContext context) {
    // #docregion Pop
    Navigator.of(context).pop({'lat': 43.821757, 'long': -79.226392});
    // #enddocregion Pop
  }

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
