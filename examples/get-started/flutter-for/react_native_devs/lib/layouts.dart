import 'package:flutter/material.dart';

class ColumnExample extends StatelessWidget {
  const ColumnExample({super.key});

  // #docregion column
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(color: Colors.red, width: 100, height: 100),
          Container(color: Colors.blue, width: 100, height: 100),
          Container(color: Colors.green, width: 100, height: 100),
        ],
      ),
    );
    // #enddocregion column
  }
}

class StackExample extends StatelessWidget {
  const StackExample({super.key});

  // #docregion stack
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0.6, 0.6),
      children: <Widget>[
        const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://avatars3.githubusercontent.com/u/14101776?v=4',
          ),
        ),
        Container(color: Colors.black45, child: const Text('Flutter')),
      ],
    );
    // #enddocregion stack
  }
}
