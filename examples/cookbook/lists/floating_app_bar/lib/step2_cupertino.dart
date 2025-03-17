import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Floating App Bar',
      home: CupertinoPageScaffold(
        // No navigation bar provided to CupertinoPageScaffold,
        // only a body with a CustomScrollView.
        child: CustomScrollView(
          // #docregion SliverAppBar
          slivers: [
            // Add the navigation bar to the CustomScrollView.
            CupertinoSliverNavigationBar(
              // Provide a standard title.
              largeTitle: Text('Floating App Bar'),
            ),
          ],
          // #enddocregion SliverAppBar
        ),
      ),
    );
  }
}
