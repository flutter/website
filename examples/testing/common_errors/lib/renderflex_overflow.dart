import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  // #docregion problem
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.message),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title', style: Theme.of(context).textTheme.headlineMedium),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed '
              'do eiusmod tempor incididunt ut labore et dolore magna '
              'aliqua. Ut enim ad minim veniam, quis nostrud '
              'exercitation ullamco laboris nisi ut aliquip ex ea '
              'commodo consequat.',
            ),
          ],
        ),
      ],
    );
  }

  // #enddocregion problem
}

class SolutionWidget extends StatelessWidget {
  const SolutionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion solution
    return const Row(
      children: [
        Icon(Icons.message),
        Expanded(
          child: Column(
            // code omitted
          ),
        ),
      ],
    );
    // #enddocregion solution
  }
}
