import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        // #docregion GridView
        body: GridView.count(
          // Create a grid with 2 columns.
          // If you change the scrollDirection to horizontal,
          // this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the list.
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: TextTheme.of(context).headlineSmall,
              ),
            );
          }),
        ),
        // #enddocregion GridView
      ),
    );
  }
}
