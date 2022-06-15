import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({Key? key}) : super(key: key);

  @override
  // #docregion Problem
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('Header'),
          ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Map'),
              ),
              ListTile(
                leading: Icon(Icons.subway),
                title: Text('Subway'),
              ),
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
  // #docregion Fix
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('Header'),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Map'),
                ),
                ListTile(
                  leading: Icon(Icons.subway),
                  title: Text('Subway'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // #enddocregion Fix
}
