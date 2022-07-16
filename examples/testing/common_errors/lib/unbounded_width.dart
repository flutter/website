import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({Key? key}) : super(key: key);

  @override
  // #docregion Problem
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unbounded Width of the TextField'),
        ),
        body: Row(
          children: [
            TextField(),
          ],
        ),
      ),
    );
  }
  // #enddocregion Problem
}

class SolutionWidget extends StatelessWidget {
  const SolutionWidget({Key? key}) : super(key: key);

  @override
  // #docregion Fix
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unbounded Width of the TextField'),
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
