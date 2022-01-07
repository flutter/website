// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const owlUrl =
    'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

class FadeInDemo extends StatefulWidget {
  const FadeInDemo({Key? key}) : super(key: key);

  @override
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image.network(owlUrl),
      TextButton(
          child: const Text(
            'Show Details',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => {}),
      Column(
        children: const [
          Text('Type: Owl'),
          Text('Age: 39'),
          Text('Employment: None'),
        ],
      )
    ]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
