import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion CustomScrollView
    return const MaterialApp(
      title: 'Floating App Bar',
      home: Scaffold(
        // No app bar property provided yet.
        body: CustomScrollView(
          // Add the app bar and list of items as slivers in the next steps.
          slivers: <Widget>[],
        ),
      ),
    );
    // #enddocregion CustomScrollView
  }
}
