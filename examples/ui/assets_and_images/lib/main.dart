import 'dart:async' show Future;

import 'package:flutter/material.dart';
// #docregion RootBundle
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}
// #enddocregion RootBundle

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // #docregion BackgroundImage
    return const Image(image: AssetImage('graphics/background.png'));
    // #enddocregion BackgroundImage
  }
}

AssetImage getHeartIconImage() {
  // #docregion PackageImage
  return const AssetImage('icons/heart.png', package: 'my_icons');
  // #enddocregion PackageImage
}
