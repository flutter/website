import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  const MyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // #docregion HintText
      child: TextField(
        decoration: InputDecoration(hintText: 'This is a hint'),
      ),
      // #enddocregion HintText
    );
  }
}
