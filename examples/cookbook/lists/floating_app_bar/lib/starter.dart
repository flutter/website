import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion CustomScrollView
    return Scaffold(
      // No appBar property provided, only the body.
      body: CustomScrollView(
          // Add the app bar and list of items as slivers in the next steps.
          slivers: <Widget>[]),
    );
    // #enddocregion CustomScrollView
  }
}
