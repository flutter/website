import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  // #docregion problem
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const Text('Header'),
          ListView(
            children: const <Widget>[
              ListTile(leading: Icon(Icons.map), title: Text('Map')),
              ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
            ],
          ),
        ],
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
    return Center(
      child: Column(
        children: <Widget>[
          const Text('Header'),
          Expanded(
            child: ListView(
              children: const <Widget>[
                ListTile(leading: Icon(Icons.map), title: Text('Map')),
                ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // #enddocregion solution
}
