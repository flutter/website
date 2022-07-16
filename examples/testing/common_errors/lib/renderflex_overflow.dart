import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({Key? key}) : super(key: key);

  @override
  // #docregion Problem
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.message),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title", style: Theme.of(context).textTheme.headline4),
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed"
                  " do eiusmod tempor incididunt ut labore et dolore magna "
                  "aliqua. Ut enim ad minim veniam, quis nostrud "
                  "exercitation ullamco laboris nisi ut aliquip ex ea "
                  "commodo consequat."),
            ],
          ),
        ],
      ),
    );
  }
  // #enddocregion Problem
}

class SolutionWidget extends StatelessWidget {
  const SolutionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // #docregion Fix
      child: Row(
        children: [
          Icon(Icons.message),
          Expanded(
            child: Column(
                // code omitted
                ),
          ),
        ],
      ),
      // #enddocregion Fix
    );
  }
}
