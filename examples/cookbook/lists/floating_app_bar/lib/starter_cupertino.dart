import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion CustomScrollView
    return const CupertinoApp(
      title: 'Floating Navigation Bar',
      home: CupertinoPageScaffold(
        // No navigation bar property provided yet.
        child: CustomScrollView(
          // Add the navigation bar and list of items as slivers in the next steps.
          slivers: <Widget>[],
        ),
      ),
    );
    // #enddocregion CustomScrollView
  }
}
