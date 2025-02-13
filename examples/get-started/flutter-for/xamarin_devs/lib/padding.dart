import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  // #docregion padding
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(left: 20, right: 30),
          ),
          onPressed: () {},
          child: const Text('Hello'),
        ),
      ),
    );
  }

  // #enddocregion padding
}
