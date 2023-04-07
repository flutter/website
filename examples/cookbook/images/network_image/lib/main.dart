import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        // #docregion ImageNetwork
        body: Image.network('https://picsum.photos/250?image=9'),
        // #enddocregion ImageNetwork
      ),
    );
  }
}
