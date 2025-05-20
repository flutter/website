// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ListDemo extends StatelessWidget {
  const ListDemo({super.key, required this.type});

  final ListDemoType type;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('List demo'),
        ),
        body: Scrollbar(
          child: ListView(
            restorationId: 'list_demo_list_view',
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              for (var index = 1; index < 21; index++)
                ListTile(
                  leading: ExcludeSemantics(
                    child: CircleAvatar(child: Text('$index')),
                  ),
                  title: Text('Item $index'),
                  subtitle: type == ListDemoType.twoLine
                      ? const Text('Secondary text')
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ListDemoType { oneLine, twoLine }

void main() {
  runApp(const ListDemo(type: ListDemoType.twoLine));
}
