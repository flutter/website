// #docregion Theme
import 'package:flutter/material.dart';

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.red),
      ),
      home: const SampleAppPage(),
    );
  }
}
// #enddocregion Theme

class SampleAppPage extends StatelessWidget {
  const SampleAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}
