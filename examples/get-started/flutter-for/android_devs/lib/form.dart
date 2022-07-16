import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion InputHint
    return const Center(
      child: TextField(
        decoration: InputDecoration(hintText: 'This is a hint'),
      ),
    );
    // #enddocregion InputHint
  }
}
