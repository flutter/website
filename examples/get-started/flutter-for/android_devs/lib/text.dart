import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  // #docregion CustomFont
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: const Center(
        child: Text(
          'This is a custom font text',
          style: TextStyle(fontFamily: 'MyCustomFont'),
        ),
      ),
    );
  }
  // #enddocregion CustomFont

}
