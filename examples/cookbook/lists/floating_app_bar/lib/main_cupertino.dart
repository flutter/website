// DartPad doesn't support `cupertino_ui` yet,
// so this example imports Cupertino from the Flutter SDK.
// To run locally, depend on `cupertino_ui` and use this import instead:
// import 'package:cupertino_ui/cupertino_ui.dart';
// ignore: deprecated_member_use until DartPad supports cupertino_ui.
import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating Navigation Bar';

    return CupertinoApp(
      title: title,
      home: CupertinoPageScaffold(
        // No navigation bar provided to CupertinoPageScaffold,
        // only a body with a CustomScrollView.
        child: CustomScrollView(
          slivers: [
            // Add the navigation bar to the CustomScrollView.
            const CupertinoSliverNavigationBar(
              // Provide a standard title.
              largeTitle: Text(title),
            ),
            // #docregion SliverList
            // Next, create a SliverList
            SliverList.builder(
              // The builder function returns a CupertinoListTile with a title
              // that displays the index of the current item.
              itemBuilder: (context, index) =>
                  CupertinoListTile(title: Text('Item #$index')),
              // Builds 50 CupertinoListTile
              itemCount: 50,
            ),
            // #enddocregion SliverList
          ],
        ),
      ),
    );
  }
}
