// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// #docregion all
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// #docregion my-app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter layout demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        // #docregion centered-text
        body: const Center(
          // #docregion text
          child: Text('Hello World'),
          // #enddocregion text
        ),
        // #enddocregion centered-text
      ),
    );
  }
}
// #enddocregion my-app, all
