// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const owlUrl =
    'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

class FadeInDemo extends StatefulWidget {
  const FadeInDemo({super.key});

  @override
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacityLevel = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image.network(owlUrl),
      TextButton(
        child: const Text(
          'Show Details',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () => setState(() {
          opacityLevel = 1.0;
        }),
      ),
      AnimatedOpacity(
        duration: const Duration(seconds: 3),
        opacity: opacityLevel,
        child: Column(
          children: const [
            Text('Type: Owl'),
            Text('Age: 39'),
            Text('Employment: None'),
          ],
        ),
      )
    ]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: FadeInDemo(),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MyApp(),
  );
}
