import 'package:flutter/material.dart';

class OrientationList1 extends StatelessWidget {
  final String title;

  const OrientationList1({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          // #docregion GridViewCount
          return GridView.count(
            // A list with 2 columns
            crossAxisCount: 2,
            // ...
          );
          // #enddocregion GridViewCount
        },
      ),
    );
  }
}

class OrientationList2 extends StatelessWidget {
  final String title;

  const OrientationList2({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      // #docregion OrientationBuilder
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode,
            // or 3 columns in landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          );
        },
      ),
      // #enddocregion OrientationBuilder
    );
  }
}
