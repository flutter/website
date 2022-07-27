import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  // #docregion Problem
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Unbounded Width of the TextField'),
        ),
        body: Row(
          children: const [
            TextField(),
          ],
        ),
      ),
    );
  }
  // #enddocregion Problem
}

class SolutionWidget extends StatelessWidget {
  const SolutionWidget({super.key});

  @override
  // #docregion Fix
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Unbounded Width of the TextField'),
        ),
        body: Row(
          children: [
            Expanded(child: TextFormField()),
          ],
        ),
      ),
    );
  }
  // #enddocregion Fix
}
