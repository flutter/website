// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  final int anInt = 3; // Cannot be null.
  final int? aNullableInt = null; // Can be null.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nullable Fields Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nullable Fields Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('anInt is $anInt.'),
              Text('aNullableInt is $aNullableInt.'),
            ],
          ),
        ),
      ),
    );
  }
}
// #enddocregion MyApp