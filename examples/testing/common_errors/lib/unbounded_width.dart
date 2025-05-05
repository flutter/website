import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  // #docregion problem
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Unbounded Width of the TextField')),
        body: const Row(children: [TextField()]),
      ),
    );
  }

  // #enddocregion problem
}

class SolutionWidget extends StatelessWidget {
  const SolutionWidget({super.key});

  @override
  // #docregion solution
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Unbounded Width of the TextField')),
        body: Row(children: [Expanded(child: TextFormField())]),
      ),
    );
  }

  // #enddocregion solution
}
